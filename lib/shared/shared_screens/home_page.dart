import 'package:apartment_app/apartment/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apartment_app/apartment/apartment_controller.dart';
import 'package:apartment_app/apartment/apartment_states.dart';
import 'package:apartment_app/apartment/apartment_views/search_result.dart';
import 'package:apartment_app/apartment/category_controller.dart';
import 'package:apartment_app/apartment/category_states.dart';
import 'package:apartment_app/shared/shared_theme/responsive.dart';
import 'package:apartment_app/shared/shared_theme/shared_colors.dart';
import 'package:apartment_app/shared/shared_theme/shared_fonts.dart';
import 'package:apartment_app/shared/shared_widget/apartement_hori_widget.dart';
import 'package:apartment_app/shared/shared_widget/apartment_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<ApartmentController>(context)
        .findNearby(BlocProvider.of<MapController>(context).latLng);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return BlocBuilder<ApartmentController, ApartmentState>(
      builder: (context, state) {
        if (state is GetSpaceLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetSpaceErrorState) {
          return Center(
            child: Text('Some thing went wrong',
                style: SharedFonts.primaryBlackFont),
          );
        } else {
          return RefreshIndicator(
            strokeWidth: 2.0,
            color: SharedColors.orangeColor,
            onRefresh: () {
              BlocProvider.of<CategoryController>(context).getCategories();
              return BlocProvider.of<ApartmentController>(context).getSpaces();
            },
            child: Scaffold(
              backgroundColor: SharedColors.backGroundColor,
              body: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  categorySection(),
                  titleSection('Recommended'),
                  Container(
                    height: responsiveHomeContainer(screenSize.height),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: BlocProvider.of<ApartmentController>(context)
                            .recommmanded
                            .length,
                        itemBuilder: (context, index) => ApartmentWidget(
                            BlocProvider.of<ApartmentController>(context)
                                .recommmanded[index],
                            false)),
                  ),
                  titleSection('All Apartment'),
                  Container(
                    height: responsiveHomeContainer(screenSize.height),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: BlocProvider.of<ApartmentController>(context)
                          .allSpaces
                          .length,
                      itemBuilder: (context, index) => ApartmentWidget(
                          BlocProvider.of<ApartmentController>(context)
                              .allSpaces[index],
                          false),
                    ),
                  ),
                  titleSection('Nearby to you'),
                  state is FindNearbyLoadingState
                      ? Center(child: CircularProgressIndicator())
                      : nearbyWidgets()
                ],
              ),
            ),
          );
        }
      },
    );
  }

  ListTile titleSection(String title) {
    return ListTile(
      title: Text(title, style: SharedFonts.primaryBlackFont),
      trailing: Text('More', style: SharedFonts.subGreyFont),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => SearchResult(title)));
      },
    );
  }

  categorySection() {
    return BlocBuilder<CategoryController, CategoryStates>(
      builder: (context, state) {
        CategoryController categoryController =
            BlocProvider.of<CategoryController>(context);
        if (state is GetCategoriesLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetCategoriesErrorState) {
          return Center(
              child: Text('Some thing went wrong',
                  style: SharedFonts.primaryBlackFont));
        } else {
          return Container(
              height: 120,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryController.categories.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        BlocProvider.of<CategoryController>(context)
                            .filterCategory(
                                categoryController.categories[i],
                                BlocProvider.of<ApartmentController>(context)
                                    .allSpaces);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SearchResult(categoryController
                                    .categories[i].categoryName)));
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 0, 10.0),
                        child: Column(
                          children: [
                            Container(
                              height: 65.0,
                              width: 65.0,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 7.0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(categoryController
                                        .categories[i].categoryImage),
                                  ),
                                  color: Colors.white,
                                  shape: BoxShape.circle),
                            ),
                            Text(categoryController.categories[i].categoryName,
                                style: SharedFonts.primaryGreyFont)
                          ],
                        ),
                      ),
                    );
                  }));
        }
      },
    );
  }

  Column nearbyWidgets() {
    List<Widget> lisst = [];
    for (int i = 0;
        i <
            BlocProvider.of<ApartmentController>(context)
                .nearbyApartment
                .length;
        i++) {
      lisst.add(ApartHoriWidget(
          BlocProvider.of<ApartmentController>(context).nearbyApartment[i]));
    }
    return Column(children: lisst);
  }
}
