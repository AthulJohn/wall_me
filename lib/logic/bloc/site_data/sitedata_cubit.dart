import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wall_me/data%20layer/image_upload.dart';
import 'package:wall_me/logic/data_cleaning/get_functions.dart';
import 'package:wall_me/logic/data_cleaning/put_functions.dart';
import 'package:wall_me/logic/models/workshop/singlenote_model.dart';

import '../../../constants/global_variables.dart';
import '../../models/workshop/image_component_model.dart';

part 'sitedata_state.dart';

class SitedataCubit extends Cubit<SitedataState> {
  SitedataCubit() : super(const SitedataInitial());

  void loadSiteData(String siteUrl) async {
    emit(const SitedataLoading());
    Map<String, dynamic>? rawSiteData = {};
    List<SingleNote>? notes = [];
    try {
      rawSiteData = await FetchFunctions.fetchSiteCleanData(siteUrl);
      notes = rawSiteData["notes"];
      if (notes == null) {
        emit(SitedataError(rawSiteData["status"].toString()));
      } else {
        emit(SitedataSuccess(siteUrl, notes, siteDomain + siteUrl));
      }
    } catch (e) {
      emit(SitedataError(e.toString()));
    }
  }

  void publishNote(String siteUrl, List<SingleNote> notes) async {
    emit(const SitedataLoading());
    try {
      int index = 1;
      var futures = FutureGroup<String>();

      emit(ImageUploading(siteUrl, index));
      for (int j = 0; j < notes.length; j++) {
        if (notes[j].imageComponents.isNotEmpty) {
          for (int i = 0; i < notes[j].imageComponents.length; i++) {
            if (notes[j].imageComponents[i].url.startsWith("blob")) {
              futures.add(ImageUploder.uploadImage(
                  siteUrl, notes[j].imageComponents[i], notes[j].noteid, i));
            }
            index++;
          }
        }
      }
      futures.close();
      index = 0;
      await futures.future.then((value) {
        for (int j = 0; j < notes.length; j++) {
          if (notes[j].imageComponents.isNotEmpty) {
            for (int i = 0; i < notes[j].imageComponents.length; i++) {
              if (notes[j].imageComponents[i].url.startsWith("blob")) {
                notes[j].imageComponents[i].url = value[index];
              }
              index++;
            }
          }
        }
      });
      emit(const SitedataLoading());
      await SendFunctions.sendSiteCleanData(siteUrl, notes);

      emit(SiteSendSuccess(siteUrl, siteDomain + siteUrl));
    } catch (e) {
      emit(SitedataError(e.toString()));
    }
  }
}
