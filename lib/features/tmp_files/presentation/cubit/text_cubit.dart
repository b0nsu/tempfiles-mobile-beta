import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextState extends Equatable {
  final String text;

  const TextState(this.text);

  @override
  List<Object> get props => [text];
}

class TextCubit extends Cubit<TextState> {
  TextCubit(Object object) : super(const TextState(''));

  void setText(String newText) {
    emit(TextState(newText));
  }
}
