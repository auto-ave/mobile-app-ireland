import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:themotorwash/blocs/global_vehicle_type/bloc/global_vehicle_type_bloc.dart';
import 'package:themotorwash/blocs/vehicle_type_functions/vehicle_type_functions_bloc.dart';
import 'package:themotorwash/blocs/vehicle_type_list/bloc/vehicle_type_list_bloc.dart';
import 'package:themotorwash/data/local/local_data_service.dart';
import 'package:themotorwash/data/models/vehicle_type.dart';
import 'package:themotorwash/data/models/vehicle_wheel.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/main.dart';
import 'package:themotorwash/theme_constants.dart';

class VehicleTypeSelectionBottomSheet extends StatefulWidget {
  final PageController pageController;

  const VehicleTypeSelectionBottomSheet(
      {Key? key, required this.pageController})
      : super(key: key);

  @override
  _VehicleTypeSelectionBottomSheetState createState() =>
      _VehicleTypeSelectionBottomSheetState();
}

class _VehicleTypeSelectionBottomSheetState
    extends State<VehicleTypeSelectionBottomSheet> {
  late VehicleTypeFunctionsBloc _vehicleTypeFunctionsBloc;
  late GlobalVehicleTypeBloc _globalVehicleTypeBloc;
  late LocalDataService _localDataService;
  late VehicleTypeListBloc _vehicleTypeListBloc;
  late VehicleWheel selectedWheel;

  @override
  void initState() {
    super.initState();
    _globalVehicleTypeBloc =
        BlocProvider.of<GlobalVehicleTypeBloc>(context, listen: false);
    _localDataService = GetIt.instance.get<LocalDataService>(
        instanceName: LocalDataService.getItInstanceName);
    _vehicleTypeFunctionsBloc = VehicleTypeFunctionsBloc(
        globalVehicleTypeBloc: _globalVehicleTypeBloc,
        localDataService: _localDataService);
    _vehicleTypeListBloc = VehicleTypeListBloc(
        repository: RepositoryProvider.of<Repository>(context));
    _vehicleTypeListBloc.add(LoadVehicleTypeList());
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).padding.top);
    return BlocBuilder<VehicleTypeListBloc, VehicleTypeListState>(
      bloc: _vehicleTypeListBloc,
      builder: (context, state) {
        if (state is VehicleTypeListLoaded) {
          return Padding(
            padding: EdgeInsets.only(
              top: 32,
            ),
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {});
              },
              physics: NeverScrollableScrollPhysics(),
              controller: widget.pageController,
              itemBuilder: (ctx, index) {
                if (index == 0) {
                  List<VehicleWheel> wheels = state.wheels;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select your vehicle type',
                          style: kStyle20W500,
                        ),
                        kverticalMargin16,
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (ctx, index) {
                              VehicleWheel wheel = wheels[index];
                              return VehicleWheelWidget(
                                  wheel: wheel,
                                  onTap: (wheelTapped) {
                                    setState(() {
                                      selectedWheel = wheelTapped;
                                      widget.pageController.animateToPage(1,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    });
                                  });
                            },
                            itemCount: state.wheels.length,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                List<VehicleTypeModel> vehicles =
                    state.vehicleTypes.where((element) {
                  print(element.wheel + " " + selectedWheel.wheel);
                  return (element.wheel == selectedWheel.wheel);
                }).toList();
                print(vehicles.length.toString() + "hello");
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select ${selectedWheel.wheel} type',
                        style: kStyle20W500,
                      ),
                      kverticalMargin16,
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {
                                _vehicleTypeFunctionsBloc.add(SelectVehicleType(
                                    vehicleTypeModel: vehicles[index]));
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        CachedNetworkImage(
                                            imageUrl: vehicles[index].image!),
                                        Text('${vehicles[index].model}')
                                      ],
                                    ),
                                    kHorizontalMargin16,
                                    Text(vehicles[index].description ??
                                        'Null broder')
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: vehicles.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: 2,
            ),
          );
        }
        if (state is LoadingVehicleTypeList) {
          return Expanded(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        }
        return Container();
      },
    );
  }
}

class VehicleWheelWidget extends StatelessWidget {
  final VehicleWheel wheel;
  final Function(VehicleWheel wheel) onTap;
  const VehicleWheelWidget({Key? key, required this.wheel, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(wheel),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(imageUrl: wheel.imageUrl),
          Text(wheel.wheel)
        ],
      ),
    );
  }
}
