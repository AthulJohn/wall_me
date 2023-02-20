import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wall_me/logic/data_cleaning/get_functions.dart';
import 'package:wall_me/logic/data_cleaning/put_functions.dart';
import 'package:wall_me/logic/models/workshop/singlenote_model.dart';

part 'sitedata_state.dart';

class SitedataCubit extends Cubit<SitedataState> {
  SitedataCubit() : super(const SitedataInitial());

  void loadSiteData(String siteUrl) async {
    emit(const SitedataLoading());
    List<SingleNote> notes = [];
    try {
      notes = await FetchFunctions.fetchSiteCleanData(siteUrl);

      emit(SitedataSuccess(siteUrl, notes));
    } catch (e) {
      emit(SitedataError(e.toString()));
    }
  }

  void publishNote(String siteUrl, List<SingleNote> notes) async {
    emit(const SitedataLoading());
    try {
      await SendFunctions.sendSiteCleanData(siteUrl, notes);

      emit(SiteSendSuccess(siteUrl));
    } catch (e) {
      emit(SitedataError(e.toString()));
    }
  }
}
