import 'package:flutter/material.dart';
import 'package:apartment_app/apartment/apartment_model.dart';
import 'package:apartment_app/apartment/apartment_views/apartment_details.dart';
import 'package:apartment_app/shared/shared_theme/responsive.dart';
import 'package:apartment_app/shared/shared_theme/shared_fonts.dart';
import 'package:apartment_app/shared/shared_widget/apartment_widget.dart';
import 'package:apartment_app/shared/shared_widget/fav_widget.dart';

class ApartHoriWidget extends StatefulWidget {
  SpaceModel space;
  ApartHoriWidget(this.space, {super.key});

  @override
  State<ApartHoriWidget> createState() => _ApartHoriWidgetState();
}

class _ApartHoriWidgetState extends State<ApartHoriWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ApartementDetails(widget.space)));
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: customDecoration(false),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,//horiSpaceWidgetImage(screenWidth),
              height: 125,
              
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                      image: NetworkImage(
                          '${widget.space.spaceImgs[0]}'),
                      fit: BoxFit.fill)),
              alignment: Alignment.topLeft,
              child: FavWidget(widget.space, 20),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${widget.space.spaceName}  ',
                          style: SharedFonts.subBlackFont),
                      Text('${widget.space.spacePrice}\n${widget.space.rentType} ', style: SharedFonts.orangeFont),
                    ],
                  ),
                  rowSection('Address ${widget.space.spaceLocation}', Icons.location_on),
                  screenWidth <= 330
                      ? rowSection('${widget.space.spaceBeds} Beds', Icons.bed)
                      : SizedBox(),
                  Row(
                    children: [
                      screenWidth <= 330
                          ? SizedBox()
                          : rowSection('${widget.space.spaceBeds} Beds', Icons.bed),
                      rowSection('${widget.space.spaceBathRoom} Bathroom', Icons.bathroom),
                      rowSection('${widget.space.spaceArea}M', Icons.social_distance),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
