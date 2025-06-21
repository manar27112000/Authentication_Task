part of 'home_cubit.dart';

abstract class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoadingState extends HomeState {}
final class HomeErrorState extends HomeState {final String error;

  HomeErrorState({required this.error});}
final class HomeSuccessState extends HomeState {
  final List<HomeModel> homeModel;
  final bool isGridView;
  HomeSuccessState({required this.homeModel,required this.isGridView,});
}
