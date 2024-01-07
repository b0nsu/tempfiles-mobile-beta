import 'package:flutter_bloc/flutter_bloc.dart';

class ExpireTimeCubit extends Cubit<int> {
  ExpireTimeCubit(Object object) : super(180);

  void updateExpireTime(int expireTime) {
    final currentExpireTime = state;
    final newExpireTime = currentExpireTime + expireTime;
    emit(newExpireTime);
  }
}
