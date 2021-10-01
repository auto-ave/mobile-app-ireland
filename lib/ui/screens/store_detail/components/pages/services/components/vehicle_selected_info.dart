import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:themotorwash/blocs/global_vehicle_type/bloc/global_vehicle_type_bloc.dart';
import 'package:themotorwash/data/models/vehicle_model.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';

class VehicleSelectedInfo extends StatelessWidget {
  final GlobalVehicleTypeSelected vehicleState;
  final Function onChangePressed;
  const VehicleSelectedInfo({
    Key? key,
    required this.vehicleState,
    required this.onChangePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: kPrimaryColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 8,
                offset: Offset(0, 0))
          ],
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SELECTED VEHICLE',
                  style: kStyle12.copyWith(
                      color: Color(0xff696969), letterSpacing: 1.8),
                ),
                kverticalMargin8,
                SelectedVehicleWidget(
                    vehicleModel: vehicleState.vehicleTypeModel)
              ],
            ),
          ),
          kHorizontalMargin16,
          CommonTextButton(
              onPressed: () => onChangePressed(),
              child: FittedBox(
                child: Text(
                  'Change',
                  style: kStyle12.copyWith(color: Colors.white),
                ),
              ),
              backgroundColor: kPrimaryColor)
        ],
      ),
    );
  }
}

class SelectedVehicleWidget extends StatelessWidget {
  final VehicleModel vehicleModel;
  const SelectedVehicleWidget({
    Key? key,
    required this.vehicleModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text.rich(
            TextSpan(children: [
              TextSpan(
                text: vehicleModel.brand,
                style: kStyle16.copyWith(color: Colors.black),
              ),
              TextSpan(
                text: ' ${vehicleModel.model}',
                style: kStyle16PrimaryColor,
              ),
            ]),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        kHorizontalMargin8,
        CachedNetworkImage(
            placeholder: (_, __) {
              return ShimmerPlaceholder();
            },
            width: 65,
            imageUrl: vehicleModel.image!),
      ],
    );
  }
}