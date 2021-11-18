//API link
//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=186583e14e3d486fae1f4f306c9b55d3
abstract class NewsStates {}

class AppNewsInitialState extends NewsStates {}

class AppNewsBottomNavBarState extends NewsStates {}

class AppNewsGetBusinessLoadingState extends NewsStates {}

class AppNewsGetBusinessSuccessState extends NewsStates {}

class AppNewsGetBusinessErrorState extends NewsStates {
  final String? error;

  AppNewsGetBusinessErrorState(this.error);
}

class AppNewsGetSportsLoadingState extends NewsStates {}

class AppNewsGetSportsSuccessState extends NewsStates {}

class AppNewsGetSportsErrorState extends NewsStates {
  final String? error;

  AppNewsGetSportsErrorState(this.error);
}

class AppNewsGetScienceLoadingState extends NewsStates {}

class AppNewsGetScienceSuccessState extends NewsStates {}

class AppNewsGetScienceErrorState extends NewsStates {
  final String? error;

  AppNewsGetScienceErrorState(this.error);
}

class AppNewsGetGeneralLoadingState extends NewsStates {}

class AppNewsGetGeneralSuccessState extends NewsStates {}

class AppNewsGetGeneralErrorState extends NewsStates {
  final String? error;

  AppNewsGetGeneralErrorState(this.error);
}

class AppNewsChangeAppModeState extends NewsStates {}

class AppNewsGetSearchLoadingState extends NewsStates {}

class AppNewsGetSearchSuccessState extends NewsStates {}

class AppNewsGetSearchErrorState extends NewsStates {
  final String? error;

  AppNewsGetSearchErrorState(this.error);
}
