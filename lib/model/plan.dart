import 'package:hive/hive.dart';
part "plan.g.dart";

@HiveType(typeId: 0)
class Plan {
  @HiveField(0)
  int hour;

  @HiveField(1)
  int minute;

  @HiveField(2)
  String planContent;

  @HiveField(3)
  int day;

  @HiveField(4)
  bool isCheck;

  Plan(
      {this.hour,
      this.minute,
      this.planContent,
      this.day,
      this.isCheck = false});
}
