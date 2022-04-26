part of 'api_bloc_bloc.dart';

@immutable
abstract class ApiBlocEvent extends Equatable {
  const ApiBlocEvent();

  @override
  List<Object> get props => [];
}

class ApiBlocInitialEvent extends ApiBlocEvent {}

class OnAddLocationEvent extends ApiBlocEvent {
  final LatLng latLng;
  final Map<MarkerId, Marker> markers;

  const OnAddLocationEvent(this.latLng, this.markers);
}

class OnLoadingByLatLngEvent extends ApiBlocEvent {
  final Map<MarkerId, Marker> markers;

  const OnLoadingByLatLngEvent(this.markers);
}

class OnLoadingById extends ApiBlocEvent {
  final Map<String, ResponseBranchOfficesById> branchOffices;

  const OnLoadingById(this.branchOffices);
}

class OnNewUserLocationEvent extends ApiBlocEvent {
  final LatLng newUserLatLng;

  const OnNewUserLocationEvent(this.newUserLatLng);
}
