import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ineedorder/core/plan_process.dart';
import 'package:ineedorder/model/plan.dart';
import 'package:ineedorder/util/extension/context_extension.dart';
import 'package:numberpicker/numberpicker.dart';

import '../const_param.dart';

class DetailView extends StatefulWidget {
  final String day;
  final int index;

  const DetailView({Key key, this.day, this.index}) : super(key: key);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.withOpacity(1),
        onPressed: () {
          _settingModalBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      body: Hero(
        tag: "${widget.index}",
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.velocity.pixelsPerSecond.distance > 300) {
              Navigator.pop(context);
            }
          },
          onVerticalDragEnd: (details) {
            Navigator.pop(context);
          },
          child: Material(
            color: Colors.blue,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff000000),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://picsum.photos/600/${widget.index + 5}00"),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Color(0x88000000), BlendMode.dstOut)),
              ),
              child: SafeArea(
                child: cardContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column cardContent() {
    List<Plan> plans = PlanProcess().getPlans(widget.index);
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 0.3, color: Colors.white))),
              child: Text(
                widget.day,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        Expanded(
            flex: 9,
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: plans.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: context.dynamicHeight(0.15),
                  width: context.dynamicWidth(1),
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actions: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: IconSlideAction(
                          caption: 'Check',
                          color: Colors.green,
                          icon: Icons.check,
                          onTap: () => {
                            PlanProcess().checkPlan(plans[index], index),
                            setState(() {})
                          },
                        ),
                      ),
                    ],
                    secondaryActions: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () => {
                            PlanProcess().deletePlan(plans[index], index),
                            setState(() {})
                          },
                        ),
                      ),
                    ],
                    child: Stack(children: [
                      Align(
                        alignment: Alignment.center,
                        child: Card(
                            color: Color(ConstParam.colors[index % 5])
                                .withOpacity(0.5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 20,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(CupertinoIcons.time,
                                          color: Colors.white),
                                      SizedBox(
                                        height: context.dynamicHeight(0.01),
                                      ),
                                      Text(
                                        "${plans[index].hour}.${plans[index].minute}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 100,
                                  child: Container(
                                    alignment: Alignment(-0.2, 0),
                                    child: Text(
                                      "${plans[index].planContent}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Positioned(
                          top: 10,
                          right: 10,
                          child: plans[index].isCheck
                              ? CircleAvatar(
                                  backgroundColor: Colors.teal,
                                  radius: 14,
                                  child: Icon(Icons.check))
                              : SizedBox.shrink())
                    ]),
                  ),
                );
              },
            )),
      ],
    );
  }

  void _settingModalBottomSheet(BuildContext context) {
    var pageController = PageController(initialPage: 0);
    Plan plan =
        new Plan(hour: 12, minute: 30, planContent: "", day: widget.index);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              height: context.dynamicHeight(0.6),
              child: PageView(
                  controller: pageController,
                  physics:
                      ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                  children: [
                    setTime(setState, pageController, plan),
                    Column(
                      children: [
                        Expanded(
                          flex: 10,
                          child: ListTile(
                            leading:
                                Icon(CupertinoIcons.pen, color: Colors.teal),
                            title: Text("Planımız Nedir"),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Divider(
                            height: 2,
                          ),
                        ),
                        Expanded(
                            flex: 75,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  plan.planContent = value;
                                },
                                onSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                },
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.purple)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.teal)),
                                    contentPadding: EdgeInsets.all(10)),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            )),
                        Expanded(
                          flex: 15,
                          child: Align(
                              alignment: Alignment(0.96, 0),
                              child: FloatingActionButton(
                                  backgroundColor: Colors.teal,
                                  child: Icon(
                                    CupertinoIcons.check_mark,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    PlanProcess().addPlan(plan);
                                    setState(() {});
                                    Navigator.pop(context);
                                  })),
                        ),
                        Spacer(
                          flex: 2,
                        )
                      ],
                    ),
                  ]));
        });
  }

  Widget setTime(
      StateSetter setState, PageController pageController, Plan plan) {
    return StatefulBuilder(
      builder: (context, setState) => Column(
        children: [
          Expanded(
            flex: 10,
            child: ListTile(
              leading: Icon(
                Icons.access_time,
                color: Colors.teal,
              ),
              title: Text("Zamanı Ayarla"),
            ),
          ),
          Expanded(
            flex: 10,
            child: Divider(
              height: 2,
            ),
          ),
          Expanded(
            flex: 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Saat"),
                    NumberPicker.integer(
                        initialValue: plan.hour,
                        minValue: 0,
                        maxValue: 23,
                        onChanged: (value) {
                          setState(() {
                            plan.hour = value;
                          });
                        }),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dakika"),
                    NumberPicker.integer(
                        initialValue: plan.minute,
                        minValue: 0,
                        maxValue: 59,
                        onChanged: (value) {
                          setState(() {
                            plan.minute = value;
                          });
                        }),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 15,
            child: Align(
                alignment: Alignment(0.96, 0),
                child: FloatingActionButton(
                    backgroundColor: Colors.teal,
                    child: Icon(CupertinoIcons.right_chevron),
                    onPressed: () {
                      pageController.animateToPage(1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOutSine);
                    })),
          ),
          Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }
}
