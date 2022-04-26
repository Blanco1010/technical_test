part of 'api_bloc_bloc.dart';

class ApiBlocState extends Equatable {
  final LatLng? location;
  final Map<MarkerId, Marker>? markers;
  final Map<String, ResponseBranchOfficesById> branchOffices;

  ApiBlocState({
    this.location,
    branchOffices,
    markers,
  })  : markers = markers ?? const {},
        branchOffices = branchOffices ?? {};

  ApiBlocState copyWith({
    Map<MarkerId, Marker>? markers,
    Map<String, ResponseBranchOfficesById>? branchOffices,
    LatLng? location,
  }) =>
      ApiBlocState(
        markers: markers ?? this.markers,
        branchOffices: branchOffices ?? this.branchOffices,
        location: location ?? this.location,
      );

  @override
  List<Object?> get props => [markers, branchOffices, location];
}
