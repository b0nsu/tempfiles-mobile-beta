import 'package:flutter_bloc/flutter_bloc.dart';

class SliderCubit extends Cubit<int> {
  SliderCubit(Object object) : super(50);

  void updateSliderValue(int value) {
    emit(value);
  }
}
