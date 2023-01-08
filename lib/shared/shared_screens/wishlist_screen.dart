import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apartment_app/apartment/apartment_controller.dart';
import 'package:apartment_app/apartment/apartment_states.dart';
import 'package:apartment_app/shared/shared_theme/shared_colors.dart';
import 'package:apartment_app/shared/shared_theme/shared_fonts.dart';
import 'package:apartment_app/shared/shared_widget/apartment_widget.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApartmentController, ApartmentState>(
        builder: (context, state) {
      ApartmentController controller =
          BlocProvider.of<ApartmentController>(context);
      if (state is GetFavErrorState) {
        return Center(
          child: Text('Some thing went wrong',
              style: SharedFonts.primaryBlackFont),
        );
      } else {
        return Scaffold(
          backgroundColor: SharedColors.backGroundColor,
          body: Column(
            children: [
              SafeArea(
                top: true,
                child: ListTile(
                  title: Text('${controller.wishlistSpaces.length} Items',
                      style: SharedFonts.primaryBlackFont),
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: controller.wishlistSpaces.length,
                  itemBuilder: (context, index) =>
                      ApartmentWidget(controller.wishlistSpaces[index], false),
                ),
              )
            ],
          ),
        );
      }
    });
  }
}
