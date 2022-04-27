import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:muzik/app_colors.dart' as AppColors;
import 'package:muzik/popularBooks.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late List popularBooks;
  late ScrollController _scrollController;
  late TabController _tabController;
  @override
  ReadJsonData() async {
    final jsondata = await rootBundle.rootBundle.load('json/popularBooks.json');
    popularBooks = await json.decode(jsondata.toString());
    print(popularBooks);
    return popularBooks.map((e) => PopularBooks.fromJson(e)).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      ReadJsonData();
    });
  }

  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageIcon(
                      AssetImage('assets/images/icons8-menu-rounded-50.png'),
                      size: 24,
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.notifications),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      'Popular Books',
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 180,
                child: Stack(children: [
                  Positioned(
                    top: 0,
                    left: -20,
                    right: 0,
                    child: Container(
                      height: 180,
                      child: PageView.builder(
                          controller: PageController(viewportFraction: 0.8),
                          itemCount: popularBooks.length,
                          itemBuilder: (_, index) {
                            return Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image:
                                        AssetImage(popularBooks[index]['img']),
                                    fit: BoxFit.fill,
                                  )),
                            );
                          }),
                    ),
                  )
                ]),
              ),
              Expanded(
                  child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context, bool isScroll) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: Container(
                          margin: const EdgeInsets.all(0),
                          child: TabBar(
                            indicatorPadding: EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: EdgeInsets.all(0),
                            controller: _tabController,
                            isScrollable: true,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 7,
                                    offset: Offset(0, 0),
                                  )
                                ]),
                            tabs: [
                              Container(
                                width: 120,
                                height: 50,
                                child: Text('New',
                                    style: TextStyle(color: Colors.white)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 7,
                                        offset: Offset(0, 0),
                                      )
                                    ]),
                              ),
                              Container(
                                width: 120,
                                height: 50,
                                child: Text('New',
                                    style: TextStyle(color: Colors.white)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 7,
                                        offset: Offset(0, 0),
                                      )
                                    ]),
                              ),
                              Container(
                                width: 120,
                                height: 50,
                                child: Text('New',
                                    style: TextStyle(color: Colors.white)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 7,
                                        offset: Offset(0, 0),
                                      )
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  children: [
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text('Content'),
                      ),
                    ),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text('Content'),
                      ),
                    ),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text('Content'),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
