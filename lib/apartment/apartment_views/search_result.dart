import 'package:apartment_app/apartment/category_controller.dart';
import 'package:apartment_app/apartment/category_states.dart';
import 'package:flutter/material.dart';
import 'package:apartment_app/shared/shared_theme/shared_colors.dart';
import 'package:apartment_app/shared/shared_theme/shared_fonts.dart';
import 'package:apartment_app/shared/shared_widget/apartment_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResult extends StatefulWidget {
  final String appBarTitle;

  const SearchResult(this.appBarTitle, {super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryController, CategoryStates>(
      builder: (context, state) {
        CategoryController categoryController =
            BlocProvider.of<CategoryController>(context);
          return Scaffold(
            backgroundColor: SharedColors.backGroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title:
                  Text(widget.appBarTitle, style: SharedFonts.primaryBlackFont),
              iconTheme:
                  IconThemeData(color: SharedColors.orangeColor, size: 20.0),
            ),
            body: state is FilterCategoryLoadingState ? Center(child: CircularProgressIndicator()) :
            categoryController.filteredCategories.isEmpty ? Center(
              child: Text('No Spaces for this Category',
                  style: SharedFonts.primaryBlackFont),
            ) :
             Column(
              children: [
                SafeArea(
                  top: true,
                  child: ListTile(
                    title: Text(
                        '${categoryController.filteredCategories.length} Items',
                        style: SharedFonts.primaryBlackFont),
                    trailing: IconButton(
                      icon: Icon(Icons.tune),
                      color: SharedColors.orangeColor,
                      iconSize: 20,
                      onPressed: () {},
                    ),
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount: categoryController.filteredCategories.length,
                    itemBuilder: (context, index) => ApartmentWidget(
                        categoryController.filteredCategories[index], false),
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}
