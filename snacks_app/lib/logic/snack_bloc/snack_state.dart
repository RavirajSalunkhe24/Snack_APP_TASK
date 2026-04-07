import 'package:equatable/equatable.dart';
import '../../data/models/snack_model.dart';

abstract class SnackState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SnackInitial extends SnackState {}

class SnackLoading extends SnackState {}

class SnackLoaded extends SnackState {
  final List<Snack> snacks;

  SnackLoaded(this.snacks);

  @override
  List<Object?> get props => [snacks];
}

class SnackEmpty extends SnackState {}

class SnackError extends SnackState {
  final String message;

  SnackError(this.message);

  @override
  List<Object?> get props => [message];
}
