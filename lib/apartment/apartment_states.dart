abstract class ApartmentState {}

class ApartmentInitialState extends ApartmentState {}

class GetSpaceLoadingState extends ApartmentState {}
class GetSpaceSuccessState extends ApartmentState {}
class GetSpaceErrorState extends ApartmentState {}

class GetUserSpaceLoadingState extends ApartmentState {}
class GetUserSpaceSuccessState extends ApartmentState {}
class GetUserSpaceErrorState extends ApartmentState {}

class IsFavErrorState extends ApartmentState {}//handel
class IsFavSuccessState extends ApartmentState {}

class GetFavSuccessState extends ApartmentState {}//wishlist
class GetFavErrorState extends ApartmentState {}
class GetFavLoadingState extends ApartmentState {}

class AddApartmentSuccessState extends ApartmentState {}
class AddApartmentErrorState extends ApartmentState {}

class EditApartmentSuccessState extends ApartmentState {}
class EditApartmentErrorState extends ApartmentState {}

class DeleteApartmentLoadingState extends ApartmentState {}
class DeleteApartmentSuccessState extends ApartmentState {}
class DeleteApartmentErrorState extends ApartmentState {}

class FindNearbyLoadingState extends ApartmentState {}
class FindNearbyState extends ApartmentState {}

class GetRecommandedLoadingState extends ApartmentState {}
class GetRecommandedSucessState extends ApartmentState {}
class GetRecommandedErrorState extends ApartmentState {}
