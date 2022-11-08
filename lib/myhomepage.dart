// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print

import 'dart:convert';

import 'package:corona_tracker/allcountry.dart';
import 'package:corona_tracker/model/demo.dart';
import 'package:corona_tracker/model/india.dart';
import 'package:corona_tracker/model/tcases.dart';
import 'package:corona_tracker/statistic.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String urll = "https://api.rootnet.in/covid19-in/stats/latest";
  late Future<List> datas;

  Future<List> gettData() async {
    var response = await Dio().get(urll);
    return response.data['data']['summary'];
  }
   
  Future showcard (String total,confirmedCasesIndian,discharged,deaths) async
  {
     await showDialog(
        context: context,
        builder: (BuildContext contect)
        {
          return AlertDialog(
            backgroundColor: Color(0xFF363636),
            shape: RoundedRectangleBorder(),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                
                    Text("Total Cases :$total",style: TextStyle(fontSize: 25,color : Colors.blue),),
                    Text("ConfirmedCasesIndian :$confirmedCasesIndian",style: TextStyle(fontSize: 25,color : Colors.white),),
                    Text("Discharged :$discharged",style: TextStyle(fontSize: 25,color : Colors.green),),
                    Text("Total Deaths :$deaths",style: TextStyle(fontSize: 25,color : Colors.red),),


                    
                  
                ],
              ),
            ),
          );
        }
      );
  } 

  final String url = "https://disease.sh/v3/covid-19/all";
  Future<Tcases> getJsonData() async {
    var response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final convertDataJson = jsonDecode(response.body);
      // print(convertDataJson);
      return Tcases.fromJson(convertDataJson);
    } else {
      throw Exception('Try to  Reload Page');
    }
  }

  @override
  void initState() {
    super.initState();
    getJsonData();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          title: const Text('COVID-19 Tracker'),
          elevation: 0,
          backgroundColor:Color.fromARGB(255, 56, 55, 55),),
      backgroundColor: Color(0xFF292929),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.only(top: 20)),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Stay',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Card(
                    color: Color(0xFFfe9900),
                    child: Text('Home',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            
            const Padding(padding: EdgeInsets.only(top: 40.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF152238),
                    side: const BorderSide(
                      color: Color(0xFFfe9900),
                    ),
                  ),
                  onPressed: () {
                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => Demo(),));
                  },
                  child: const Text(
                    'Worldwide statistics',
                    style: TextStyle(
                        color: Color(0xFFfe9900),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF152238),
                    side: const BorderSide(
                      color: Color(0xFFfe9900),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Demo(),));
                  },
                  child: const Text(
                    'India statistics',
                    style: TextStyle(
                        color: Color(0xFFfe9900),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40,),
            FutureBuilder<Tcases>(
              future: getJsonData(),
              builder: (context, AsyncSnapshot<Tcases?> snapshot) {
                if (snapshot.hasData) {
                  final covid = snapshot.data;
                  return Column(
                    children: <Widget>[
                      Card(
                        color: Color.fromARGB(255, 56, 55, 55),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "${covid!.cases} ",
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${covid.deaths}",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${covid.recovered}",
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Card(
                        color: Color.fromARGB(255, 56, 55, 55) ,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const <Widget>[
                              Text(
                                "Total Cases ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Deaths",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Recoveries",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 30.0)),
            SizedBox(height: 30,),
            Container(
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    child: Container(
                      color: Color.fromARGB(255, 56, 55, 55),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(padding: EdgeInsets.only(top: 20.0)),
                            const Image(
                              image: AssetImage("images/india.png"),
                              height: 90,
                              width: 90,
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => India(),));
                              },
                              child: const Text(
                                "Statewise Statistics",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFfe9900),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    
                    child: Container(
                      color: Color.fromARGB(255, 56, 55, 55),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(padding: EdgeInsets.only(top: 20.0)),
                            const Image(
                              image: AssetImage("images/world.png"),
                              height: 90,
                              width: 90,
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                            TextButton(
                              onPressed: () {
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => AllCountry(),));
                              },
                              child: const Text(
                                "Countrywise Statistics",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFfe9900),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
