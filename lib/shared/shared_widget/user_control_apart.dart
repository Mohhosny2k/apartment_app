import 'package:apartment_app/apartment/apartment_controller.dart';
import 'package:apartment_app/apartment/apartment_model.dart';
import 'package:apartment_app/apartment/apartment_views/edit_apartmene.dart';
import 'package:apartment_app/shared/shared_theme/shared_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserControlApart extends StatefulWidget {
  double iconSize;
  SpaceModel spaceModel;
   UserControlApart(this.spaceModel, this.iconSize, {super.key});

  @override
  State<UserControlApart> createState() => _UserControlApartState();
}

class _UserControlApartState extends State<UserControlApart> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            BlocProvider.of<ApartmentController>(context)
                .deleteApartment(widget.spaceModel);
          },
          icon: Icon(Icons.delete),
          color: SharedColors.orangeColor,
          iconSize: widget.iconSize,
        ),
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditApartment(widget.spaceModel)));
          },
          icon: Icon(Icons.edit),
          color: SharedColors.orangeColor,
          iconSize: widget.iconSize,
        ),
      ],
    );
  }
}
