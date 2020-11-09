import 'package:hive/hive.dart';
import 'package:ineedorder/model/plan.dart';

class PlanProcess {
  Future addPlan(Plan plan) async {
    Box box;

    box = Hive.box<Plan>("${plan.day}");
    box.add(plan);
    List<Plan> plans = getPlans(plan.day);
    print("befor: ${plans.length}");
    await box.clear();
    print("after: ${plans.length}");
    plans = sortByTime(plans);
    print("afterx2: ${plans.length}");
    for (Plan p in plans) {
      box.add(p);
    }
    print("afterx3: ${plans.length}");
  }

  void deletePlan(Plan plan, int index) {
    Box box;

    box = Hive.box<Plan>("${plan.day}");
    box.deleteAt(index);
  }

  void checkPlan(Plan plan, int index) async {
    deletePlan(plan, index);
    plan.isCheck = true;
    await addPlan(plan);
  }

  List<Plan> getPlans(int day) {
    Box box = Hive.box<Plan>("$day");
    List<Plan> plans = [];
    for (int i = 0; i < box.length; i++) {
      plans.add(box.getAt(i));
    }
    return plans;
  }

  List<Plan> sortByTime(List<Plan> plans) {
    plans.sort((a, b) {
      int aValue = (a.hour * 60) + a.minute;
      int bValue = (b.hour * 60) + b.minute;
      return aValue.compareTo(bValue);
    });
    for (Plan p in plans) {
      print(p.hour);
    }
    return plans;
  }
}
