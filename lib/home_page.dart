import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kosmeality/api.dart';
import 'package:kosmeality/api_response.dart';
import 'package:kosmeality/lipstick.dart';
import 'package:kosmeality/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Lipstick> lipsticks = [];
  static const platform = const MethodChannel("viewcontroller");

  void getLipsticks() async {
    ApiResponse response = await Api().getRequest('/lipsticks');
    List<Lipstick> lipsticksTemp = <Lipstick>[];
    print('laaa');
    for (int i = 0; i < response.data.length; i++) {
      lipsticksTemp.add(Lipstick.fromJson(response.data[i]));
    }
    setState(() {
      lipsticks = lipsticksTemp;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLipsticks();
    });
  }

  Future<void> _testLipstick(Lipstick lipstick) async {
    print('$lipstick');
    try {
      await platform.invokeMethod('testLipstick', <String, dynamic>{
        'name': lipstick.name,
        'id': lipstick.sId,
        'color': lipstick.color,
        'serie': lipstick.serie,
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: GridView.builder(
          itemCount: lipsticks.length,
          padding: EdgeInsets.all(8),
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            childAspectRatio: 2,
            mainAxisSpacing: 1,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GridTile(
              child: InkWell(
                focusColor: HexColor.fromHex(lipsticks[index].color),
                highlightColor: HexColor.fromHex(lipsticks[index].color),
                onTap: () {
                  _testLipstick(lipsticks[index]);
                },
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          lipsticks[index].name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Série : ${lipsticks[index].serie}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          height: 23,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              style: BorderStyle.solid,
                              color: Colors.black12,
                            ),
                            color: HexColor.fromHex(lipsticks[index].color),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )

        // body: ListView.separated(
        //   separatorBuilder: (context, index) => Divider(
        //     endIndent: 30,
        //     indent: 30,
        //     color: Colors.black12,
        //   ),
        //   itemCount: lipsticks.length,
        //   itemBuilder: (context, index) => Padding(
        //     padding: EdgeInsets.all(16.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: <Widget>[
        //         Text(
        //           lipsticks[index].name,
        //           style: TextStyle(
        //             fontSize: 18,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         Text(lipsticks[index].serie),
        //         Text("Lipstick : ${lipsticks[index].color}"),
        //       ],
        //     ),
        //   ),
        // ),
        );
    ;
  }
}
