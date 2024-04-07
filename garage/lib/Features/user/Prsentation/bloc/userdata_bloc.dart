import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'userdata_event.dart';
part 'userdata_state.dart';

class UserdataBloc extends Bloc<UserdataEvent, UserdataState> {
  UserdataBloc() : super(UserdataInitial()) {
    on<UserdataEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
