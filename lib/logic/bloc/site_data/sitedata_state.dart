part of 'sitedata_cubit.dart';

abstract class SitedataState extends Equatable {
  const SitedataState(this.siteUrl, this.notes, [this.completeUrl = '']);
  final List<SingleNote> notes;
  final String siteUrl, completeUrl;

  @override
  List<Object> get props => [notes, siteUrl, completeUrl];
}

class SitedataInitial extends SitedataState {
  const SitedataInitial() : super("", const []);
}

class SitedataLoading extends SitedataState {
  const SitedataLoading() : super("", const []);
}

class SitedataSuccess extends SitedataState {
  const SitedataSuccess(
      String siteUrl, List<SingleNote> notes, String completeUrl)
      : super(siteUrl, notes, completeUrl);
}

class ImageUploading extends SitedataState {
  const ImageUploading(String siteUrl, this.index) : super(siteUrl, const []);

  @override
  List<Object> get props => [notes, siteUrl, index];
  final int index;
}

class SiteSendSuccess extends SitedataState {
  const SiteSendSuccess(String siteUrl, String completeUrl)
      : super(siteUrl, const [], completeUrl);
}

class SitedataError extends SitedataState {
  final String errorText;
  const SitedataError(this.errorText) : super("", const []);
}
