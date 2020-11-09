import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ineedorder/const_param.dart';
import 'package:ineedorder/core/plan_process.dart';
import 'package:ineedorder/model/plan.dart';
import 'package:ineedorder/util/extension/context_extension.dart';
import 'package:ineedorder/view/detail_view.dart';
import 'package:ineedorder/widget/page_animation/fade_route.dart';

class HomeView extends StatelessWidget {
  int currentIndex = 0;
  final List<String> days = [
    "Pazartesi",
    "Salı",
    "Çarşamba",
    "Perşembe",
    "Cuma",
    "Cumartesi",
    "Pazar"
  ];

  var swiperController = new SwiperController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff5f6fa),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "I Need Order",
                  style: TextStyle(
                    color: Color(0xff2f3542),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Card(
                      child: Hero(
                        tag: "${index}",
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xff000000),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://picsum.photos/600/${index + 5}00"),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Color(0x88000000), BlendMode.dstOut)),
                            ),
                            child: cardContent(index, context),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                onTap: (index) {
                  Navigator.push(
                    context,
                    FadeRoute(
                      page: DetailView(
                        day: days[index],
                        index: index,
                      ),
                    ),
                  );
                },
                loop: true,
                itemCount: 7,
                itemWidth: context.dynamicWidth(1),
                itemHeight: context.dynamicHeight(0.74),
                scrollDirection: Axis.vertical,
                layout: SwiperLayout.STACK,
                controller: swiperController,
              ),
            )
          ]),
        ));
  }

  Column cardContent(int index, BuildContext context) {
    List<Plan> plans = PlanProcess().getPlans(index);
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
                days[index],
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
              physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
              padding: EdgeInsets.all(16),
              itemCount: plans.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: context.dynamicWidth(0.27),
                  width: context.dynamicWidth(0.27),
                  child: Card(
                      color:
                          Color(ConstParam.colors[index % 5]).withOpacity(0.3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.time, color: Colors.white),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "${plans[index].hour}.${plans[index].minute}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 75,
                            child: Container(
                              alignment: Alignment(-0.2, 0),
                              child: Text(
                                "${plans[index].planContent}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      )),
                );
              },
            )),
      ],
    );
  }
}
