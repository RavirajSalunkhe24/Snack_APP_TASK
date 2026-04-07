import 'package:flutter_bloc/flutter_bloc.dart';
import 'snack_event.dart';
import 'snack_state.dart';
import '../../data/services/snack_service.dart';

class SnackBloc extends Bloc<SnackEvent, SnackState> {
  final SnackService service;

  SnackBloc(this.service) : super(SnackInitial()) {
    on<FetchSnacks>((event, emit) async {
      emit(SnackLoading());

      try {
        final snacks = await service.fetchSnacks();

        if (snacks.isEmpty) {
          emit(SnackEmpty());
        } else {
          emit(SnackLoaded(snacks));
        }
      } catch (e) {
        emit(SnackError(e.toString()));
      }
    });

    on<RefreshSnacks>((event, emit) async {
      try {
        final snacks = await service.fetchSnacks();

        if (snacks.isEmpty) {
          emit(SnackEmpty());
        } else {
          emit(SnackLoaded(snacks));
        }
      } catch (e) {
        emit(SnackError(e.toString()));
      }
    });
  }
}
