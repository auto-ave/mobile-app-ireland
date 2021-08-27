// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:themotorwash/blocs/global_location/global_location_bloc.dart';
// import 'package:themotorwash/data/models/location_model.dart';

// part 'location_functions_event.dart';
// part 'location_functions_state.dart';

// class LocationFunctionsBloc
//     extends Bloc<LocationFunctionsEvent, LocationFunctionsState> {
//   final GlobalLocationBloc _globalLocationBloc;
//   LocationFunctionsBloc({required GlobalLocationBloc globalLocationBloc})
//       : _globalLocationBloc = globalLocationBloc,
//         super(LocationFunctionsInitial());

//   @override
//   Stream<LocationFunctionsState> mapEventToState(
//     LocationFunctionsEvent event,
//   ) async* {
//     // TODO: implement mapEventToState
//     if (event is GetListOfCities) {
//       yield* _mapGetListOfCitiesToState();
//     } else if (event is GetCurrentUserLocation) {
//       yield* _mapGetCurrentUserLocationToState();
//     }
//   }

//   Stream<LocationFunctionsState> _mapGetListOfCitiesToState() async* {}

  
// }
