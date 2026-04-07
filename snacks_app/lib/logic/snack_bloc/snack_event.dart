import 'package:equatable/equatable.dart';

abstract class SnackEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchSnacks extends SnackEvent {}

class RefreshSnacks extends SnackEvent {}
