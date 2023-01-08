import 'package:apartment_app/apartment/apartment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apartment_app/apartment/apartment_controller.dart';
import 'package:apartment_app/apartment/category_model.dart';
import 'package:apartment_app/apartment/category_states.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryController extends Cubit<CategoryStates> {
  CategoryController() : super(InitialCategoryState()) {
    getCategories();
  }
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  List<SpaceModel> _filteredCategories = [];
  List<SpaceModel> get filteredCategories => _filteredCategories;

  Future<void> getCategories() async {
    _categories.clear();
    emit(GetCategoriesLoadingState());
    try {
      http.Response res =
          await http.get(Uri.parse('$domainAddress/category.json'));
      Map data = json.decode(res.body);
      if (res.statusCode == 200) {
        data.forEach((key, value) {
          _categories.add(CategoryModel(
              categoryId: key,
              categoryName: value['categoryName'],
              categoryImage: value['categoryImage']));
        });
        emit(CategoriesGotState());
      } else {
        emit(GetCategoriesErrorState());
      }
    } catch (e) {
      emit(GetCategoriesErrorState());
    }
  }

  void filterCategory(CategoryModel categoryModel, List<SpaceModel> spaces) {
    _filteredCategories.clear();
    emit(FilterCategoryLoadingState());
    for (SpaceModel space in spaces) {
      if (space.categoryId == categoryModel.categoryId) {
        _filteredCategories.add(space);
      }
    }
    emit(FilterCategoryState());
  }
}
