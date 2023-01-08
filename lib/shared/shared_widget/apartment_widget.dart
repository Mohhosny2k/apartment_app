import 'package:apartment_app/shared/shared_widget/user_control_apart.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/apartment/apartment_model.dart';
import 'package:apartment_app/apartment/apartment_views/apartment_details.dart';
import 'package:apartment_app/shared/shared_theme/shared_colors.dart';
import 'package:apartment_app/shared/shared_theme/shared_fonts.dart';
import 'package:apartment_app/shared/shared_widget/fav_widget.dart';

class ApartmentWidget extends StatefulWidget {
  final bool isDetials;
  SpaceModel space;
  ApartmentWidget(this.space, this.isDetials, {super.key});

  @override
  State<ApartmentWidget> createState() => _ApartmentWidgetState();
}

class _ApartmentWidgetState extends State<ApartmentWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isDetials == false
          ? () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ApartementDetails(widget.space)));
            }
          : () {},
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        margin: EdgeInsets.all(10.0),
        decoration: customDecoration(widget.isDetials),
        child: Column(
          children: [
            Container(
                height: 195,
                margin: EdgeInsets.only(bottom: 7.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                    image: DecorationImage(
                        image: NetworkImage('${widget.space.spaceImgs[0]}'),
                        fit: BoxFit.fill)),
                alignment: Alignment.topRight,
                child:
                    widget.isDetials == false ? showTopWidget() : SizedBox()),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('  ${widget.space.spaceName}',
                        style: SharedFonts.subBlackFont),
                    Text(
                        '\$${widget.space.spacePrice}/${widget.space.rentType}  ',
                        style: SharedFonts.orangeFont)
                  ],
                ),
                rowSection(
                    'Address ${widget.space.spaceLocation}', Icons.location_on),
                Row(
                  children: [
                    rowSection('${widget.space.spaceBeds} Beds', Icons.bed),
                    rowSection('${widget.space.spaceBathRoom} Bathroom',
                        Icons.bathroom),
                    rowSection(
                        '${widget.space.spaceArea}M', Icons.social_distance),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget showTopWidget() {
    if (widget.space.userId == 1) {
      return UserControlApart(widget.space, 20.0);
    } else {
      return FavWidget(widget.space, 30);
    }
  }
}

Padding rowSection(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
    child: Row(
      children: [
        Icon(icon, color: SharedColors.greyColor, size: 12),
        Text(' $title', style: SharedFonts.subGreyFont)
      ],
    ),
  );
}

BoxDecoration customDecoration(bool isDetails) {
  return BoxDecoration(
      color: isDetails == false ? Colors.white : Colors.transparent,
      borderRadius: BorderRadius.circular(20.0));
}
