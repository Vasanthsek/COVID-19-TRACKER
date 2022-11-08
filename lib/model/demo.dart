// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:corona_tracker/model/ticases.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final String url = "https://api.rootnet.in/covid19-in/stats/latest";

  @override
  void initState() {
    super.initState();

    getJsonData();
  }

  Future<Ticases> getJsonData() async {
    var response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final convertDataJson = jsonDecode(response.body)['data']['summary'];

      return Ticases.fromJson(convertDataJson);
    } else {
      throw Exception('Try to  Reload Page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Indian COVID-19 statistics'),
          backgroundColor:Color.fromARGB(255, 56, 55, 55),
        ),
        backgroundColor: Color(0xFF292929),
       //  Color.fromARGB(255, 139, 138, 138),
        body: Container(
            child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                
                Padding(padding: EdgeInsets.all(10.0)),
                FutureBuilder<Ticases>(
                    future: getJsonData(),
                    builder: (context, AsyncSnapshot<Ticases?> SnapShot) {
                      if (SnapShot.hasData) {
                        print(SnapShot.data);
                        final covid = SnapShot.data;
                        return Padding(
                          padding:  EdgeInsets.all(10),
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ReusableRow(title: 'Total Cases', value: covid!.total.toString()),
                                ReusableRow(title: 'Confirmed Cases Indian', value: covid.confirmedCasesIndian.toString()),
                                ReusableRow(title: 'Confirmed Cases Foreign', value: covid.confirmedCasesForeign.toString()),
                                ReusableRow(title: 'Discharged', value: covid.discharged.toString()),
                                ReusableRow(title: 'Deaths', value: covid.deaths.toString()),
                               
                                ReusableRow(title: 'Confirmed But Location Unidentified', value: covid.confirmedButLocationUnidentified.toString()),
          
                              ],
                            ),
                          ),
                        );
                      } else if (SnapShot.hasError) {
                        return Text(SnapShot.error.toString());
                      }

                      return CircularProgressIndicator();
                    }),
              ]),
        )));
  }

 
}

 class ReusableRow extends StatelessWidget {
  String title, value ;
   ReusableRow({Key? key , required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10 , right: 10 , top: 10 , bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),

              Text(value)
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}
