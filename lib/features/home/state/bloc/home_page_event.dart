part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class GetHomePageData extends HomePageEvent {
  final String userEmail;

  const GetHomePageData({required this.userEmail});
}
