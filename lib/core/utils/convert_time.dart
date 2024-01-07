String convertTime(int time) {
  final days = time ~/ (24 * 60);
  final hours = (time % (24 * 60)) ~/ 60;
  final minutes = time % 60;

  return ('$days일 $hours시간 $minutes분');
}
