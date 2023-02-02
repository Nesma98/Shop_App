part of 'search_cubit.dart';

@immutable
abstract class SearchStates {}

class SearchInitialStates extends SearchStates {}

class SearchLoadingStates extends SearchStates {}

class SearchSuccessStates extends SearchStates {}

class SearchErrorStates extends SearchStates {}
