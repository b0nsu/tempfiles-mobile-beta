import 'package:bloc/bloc.dart';

class CheckBoxCubit extends Cubit<Set<CheckBoxState>> {
  Set<CheckBoxState> initialState = {};

  CheckBoxCubit(Object object) : super({});

  void toggleCheckBox(CheckBoxState checkBox) {
    final currentState = state;
    currentState.contains(checkBox)
        ? currentState.remove(checkBox)
        : currentState.add(checkBox);
    emit(currentState.toSet());
  }

  void saveInitialState() {
    initialState = state.toSet();
  }

  void cancelChanges() {
    emit(initialState.toSet());
  }
}

enum CheckBoxState {
  checkbox1,
  checkbox2,
  checkbox3,
}
