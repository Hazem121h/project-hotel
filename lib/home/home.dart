import 'package:flutter/material.dart';
import 'package:flutter_new_hotel/help/d.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> ho = [];
  double _currentSliderValue = 20;
  List color = [
    Colors.red.shade900,
    Colors.orange.shade400,
    Colors.green.shade400,
    Colors.green.shade600,
    Colors.green.shade800
  ];
  List rating = ['0+', "7+", "7.5+", '8+', "8.5+"];
  List image = [
    'assets/star1.PNG',
    "assets/star2.PNG",
    "assets/star3.PNG",
    'assets/star4.PNG',
    "assets/star5.PNG"
  ];
  List<dynamic> sort_list = [
    {"name": "Our recommendation", "stat": true},
    {"name": "Rating & Recommended", "stat": false},
    {"name": "Price & Recommended", "stat": false},
    {"name": "Distance & Recommended", "stat": false},
    {"name": "Rating only", "stat": false},
    {"name": "Price only", "stat": false},
    {"name": "Distance only", "stat": false},
  ];

  Future<void> getData() async {
    print("-------------------");
    final dio = Dio();
    final response = await dio.get('https://www.hotelsgo.co/test/hotels');
    ho = response.data;
    print(ho.length);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          titleSpacing: 00.0,

          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
          ),
          elevation: 0.00,
          backgroundColor: Colors.white,
          leadingWidth: double.infinity,

          leading: Row(
            children: [
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () => filter(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.tune,
                            color: Colors.lightBlue,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Filter',
                            style: TextStyle(
                                color: Colors.lightBlue, fontSize: 15),
                          )
                        ],
                      ),
                    )),
              ),
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () => sort(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sort_rounded,
                            color: Colors.lightBlue,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Sort',
                            style: TextStyle(
                                color: Colors.lightBlue, fontSize: 15),
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
          // title: Text(widget.title),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => hotel(index),
          itemCount: ho.length,
        ));
  }

  Widget hotel(int index) {
    return Card(
        margin: EdgeInsets.all(9),
        color: Colors.white,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // color: Colors.yellow,

              height: 150,
              width: double.infinity,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                image: DecorationImage(
                    image: NetworkImage(ho[index]['image']), fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  RatingBar.builder(
                    initialRating: double.parse(ho[index]['starts'].toString()),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 15,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  Text('  Hotel'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                ho[index]['name'].toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.green),
                      child: Text(
                        ho[index]['review_score'].toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(ho[index]['review']),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.location_on,
                    size: 15,
                  ),
                  Text(ho[index]['address']),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Row(children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 20,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Text(
                                'Our lowest price',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "\$" + ho[index]['price'].toString(),
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Renaissane'),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'View Deal',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ))
                  ]),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                alignment: Alignment.topRight,
                child: Text(
                  "More Price",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            )
          ],
        ));
  }

  sort() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => Scaffold(
            appBar: AppBar(
              leading: SizedBox(),
              backgroundColor: Colors.white,
              title: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Sort by",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      )),
                )
              ],
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    InkWell(
                      onTap: () {
                        sort_list[index]["stat"] = true;
                        for (int i = 0; i < sort_list.length; i++) {
                          if (i != index) {
                            sort_list[i]["stat"] = false;
                          }
                        }
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              sort_list[index]['name'],
                              style: TextStyle(fontSize: 15),
                            )),
                            sort_list[index]['stat']
                                ? Icon(Icons.done)
                                : SizedBox(
                                    width: 10,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    )
                  ],
                ),
                itemCount: sort_list.length,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget sort_by(int index) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            sort_list[index]["stat"] = true;
            for (int i = 0; i < sort_list.length; i++) {
              if (i != index) {
                sort_list[i]["stat"] = false;
              }
            }
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: Text(sort_list[index]['name'])),
                sort_list[index]['stat']
                    ? Icon(Icons.done)
                    : SizedBox(
                        width: 10,
                      ),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }

//-------------------------------------------------------------------

  filter() {
    showModalBottomSheet(
      enableDrag: true,
      backgroundColor: Colors.transparent,

      //isScrollControlled: true,

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => Scaffold(
            bottomNavigationBar: InkWell(
              onTap: () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Container(
                  color: Colors.blue.shade800,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'Show results',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              leading: InkWell(
                  onTap: () => 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Reset',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                            color: Colors.grey.shade400,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              backgroundColor: Colors.white,
              title: Container(
                alignment: Alignment.center,
                child: Text(
                  "Filter",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      )),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text("PRICE PER NIGHT",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                              width: 60,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black),
                              ),
                              alignment: Alignment.center,
                              child:
                                  Text(_currentSliderValue.toString() + " \$")),
                        ),
                      ],
                    ),
                    Slider(
                      value: _currentSliderValue,
                      min: 20,
                      max: 540,
                      divisions: 10,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text("\$ 20")),
                        )),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                              alignment: Alignment.centerRight,
                              child: Text("\$ 540+")),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text("RATING",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10),
                          child: Container(
                              alignment: Alignment.center,
                              width: 40,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: color[index],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(rating[index].toString())),
                        ),
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text("HOTEL CLASS",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 10, top: 10),
                          child: Container(
                              alignment: Alignment.center,
                              width: 45,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset(
                                fit: BoxFit.fill,
                                image[index].toString(),
                              )),
                        ),
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text("DISTANCE FROM",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.grey,
                      indent: 15,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Location",
                                style: TextStyle(fontSize: 15),
                              )),
                        )),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: InkWell(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'City Center',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.grey,
                      indent: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
