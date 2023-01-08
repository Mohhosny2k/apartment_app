

abstract class CategoryStates {}

class InitialCategoryState extends CategoryStates {}

class CategoriesGotState extends CategoryStates {}
class GetCategoriesErrorState extends CategoryStates {}
class GetCategoriesLoadingState extends CategoryStates {}

class FilterCategoryState extends CategoryStates {}
class FilterCategoryLoadingState extends CategoryStates {}
