import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:themotorwash/blocs/global_vehicle_type/bloc/global_vehicle_type_bloc.dart';
import 'package:themotorwash/blocs/vehicle_details_reg/bloc/vehicle_details_reg_bloc.dart';
import 'package:themotorwash/blocs/vehicle_type_functions/vehicle_type_functions_bloc.dart';
import 'package:themotorwash/data/local/local_data_service.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/profile/profile_screen.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';
import 'package:themotorwash/ui/widgets/or_divider_widget.dart';
import 'package:themotorwash/utils/utils.dart';

class VehicleSelectOptions extends StatefulWidget {
  VehicleSelectOptions({Key? key}) : super(key: key);

  @override
  State<VehicleSelectOptions> createState() => _VehicleSelectOptionsState();
}

class _VehicleSelectOptionsState extends State<VehicleSelectOptions> {
  late final VehicleDetailsRegBloc _vehicleDetailsRegBloc;
  final TextEditingController _vehicleNumberController =
      TextEditingController();
  late VehicleTypeFunctionsBloc _vehicleTypeFunctionsBloc;
  late GlobalVehicleTypeBloc _globalVehicleTypeBloc;
  late LocalDataService _localDataService;
  bool showColor = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _globalVehicleTypeBloc =
        BlocProvider.of<GlobalVehicleTypeBloc>(context, listen: false);
    _localDataService = GetIt.instance.get<LocalDataService>(
        instanceName: LocalDataService.getItInstanceName);
    _vehicleTypeFunctionsBloc = VehicleTypeFunctionsBloc(
        globalVehicleTypeBloc: _globalVehicleTypeBloc,
        localDataService: _localDataService);
    _vehicleDetailsRegBloc = VehicleDetailsRegBloc(
        repository: RepositoryProvider.of<Repository>(context));
    _vehicleNumberController.addListener(() {
      if (_vehicleNumberController.text.isNotEmpty) {
        showColor = true;
      } else {
        showColor = false;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _vehicleDetailsRegBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              'Enter your vehicle Registration number',
              style: SizeConfig.kStyle20W500,
            ),
          ),
          SizeConfig.kverticalMargin32,
          Row(
            children: [
              Image.asset('assets/icons/irl-num.png'),
              Expanded(
                child: CommonTextField(
                  autoFocus: true,
                  fieldController: _vehicleNumberController,
                  inputBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.zero,
                          bottomLeft: Radius.zero,
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      borderSide: BorderSide(color: SizeConfig.kGreyTextColor)),
                  hintText: 'YOUR VEHICLE NUMBER',
                  hintStyle: SizeConfig.kStyle16Bold
                      .copyWith(color: SizeConfig.kGreyTextColor),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  filled: false,
                ),
              ),
            ],
          ),
          SizeConfig.kverticalMargin16,
          BlocConsumer<VehicleDetailsRegBloc, VehicleDetailsRegState>(
            bloc: _vehicleDetailsRegBloc,
            listener: (context, state) {
              // TODO: implement listener
              if (state is VehicleDetailsRegLoaded) {
                _vehicleTypeFunctionsBloc.add(
                    SelectVehicleType(vehicleTypeModel: state.vehicleModel));
                Navigator.pop(context);
              }
              if (state is VehicleDetailsRegError) {
                showSnackbar(context,
                    'Something went wrong. Please check your vehicle number');
              }
            },
            builder: (context, state) {
              return SizedBox(
                width: 100.w,
                height: 10.w,
                child: CommonTextButton(
                    onPressed: () {
                      if (!(state is VehicleDetailsRegLoading) &&
                          _vehicleNumberController.text.isNotEmpty) {
                        _vehicleDetailsRegBloc.add(GetVehicleDetailsByRegNo(
                            vehicleNum: _vehicleNumberController.text));
                      }
                    },
                    child: (state is VehicleDetailsRegLoading)
                        ? SizedBox.square(
                            dimension: 6.w,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1.5,
                            ),
                          )
                        : Text('Submit',
                            style: SizeConfig.kStyle16W500
                                .copyWith(color: Colors.white)),
                    backgroundColor: showColor
                        ? SizeConfig.kPrimaryColor
                        : SizeConfig.kGreyTextColor,
                    buttonSemantics: 'Submit Vehicle Number Button'),
              );
            },
          ),
          // SizeConfig.kverticalMargin32,r
          // SizeConfig.kverticalMargin32,
          // ORWithDividerWidget(
          //   dividerColor: SizeConfig.kGreyTextColor,
          // ),
          // SizeConfig.kverticalMargin32,
          // SizedBox(
          //   width: 100.w,
          //   child: CommonTextButton(
          //       onPressed: () {},
          //       child: Text('Select vehicle manually',
          //           style: SizeConfig.kStyle14W500.copyWith(
          //               color: SizeConfig.kGreyTextColor,
          //               decoration: TextDecoration.underline)),
          //       backgroundColor: Colors.white,
          //       buttonSemantics: 'Select vehicle manually Button'),
          // )
        ],
      ),
    );
  }
}
