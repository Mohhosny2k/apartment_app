import 'package:apartment_app/apartment/apartment_controller.dart';
import 'package:apartment_app/apartment/apartment_states.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/shared/shared_theme/shared_colors.dart';
import 'package:apartment_app/shared/shared_theme/shared_fonts.dart';
import 'package:apartment_app/shared/shared_widget/apartment_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserApartment extends StatefulWidget {
  const UserApartment({super.key});

  @override
  State<UserApartment> createState() => _UserApartmentState();
}

class _UserApartmentState extends State<UserApartment> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApartmentController, ApartmentState>(
        builder: (context, state) {
      ApartmentController controller =
          BlocProvider.of<ApartmentController>(context);
      return Scaffold(
        backgroundColor: SharedColors.backGroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('My Apartments', style: SharedFonts.primaryBlackFont),
          iconTheme: IconThemeData(color: SharedColors.orangeColor, size: 20.0),
        ),
        body: Column(
          children: [
            SafeArea(
              top: true,
              child: ListTile(
                title: Text('${controller.allUserSpaces.length} Items',
                    style: SharedFonts.primaryBlackFont),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: controller.allUserSpaces.length,
                itemBuilder: (context, index) =>
                    ApartmentWidget(controller.allUserSpaces[index], false),
              ),
            )
          ],
        ),
      );
    });
  }
}
