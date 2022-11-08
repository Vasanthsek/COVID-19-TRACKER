// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';

class AllCountry extends StatefulWidget {
  const AllCountry({Key? key}) : super(key: key);

  @override
  State<AllCountry> createState() => _AllCountryState();
}

class _AllCountryState extends State<AllCountry> {
  Future showcard(String ind, recover, death) async {
    await showDialog(
        context: context,
        builder: (BuildContext contect) {
          return AlertDialog(
            backgroundColor: Color(0xFF363636),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    
                    "Total Cases :$ind",
                    style: TextStyle(fontSize: 25, color: Colors.blue),
                  ),
                  
                  Text(
                    "Total Recoveries :$recover",
                    style: TextStyle(fontSize: 25, color: Colors.green),
                  ),
                  Text(
                    "Total Deaths :$death",
                    style: TextStyle(fontSize: 25, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        });
  }

  final String url = "https://api.apify.com/v2/key-value-stores/tVaYRsPHLjNdNBu7S/records/LATEST?disableRedirect=true";
  late Future<List> datas;

  Future<List> getData() async {
    var response = await Dio().get(url);
    print(response.data);
    return response.data;
    
  }

  @override
  void initState() {
    super.initState();
    datas = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
          title: Text('Countrywise Statistics'),
          backgroundColor: Color.fromARGB(255, 56, 55, 55),
         // Color(0xFF152238)
          ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
            future: datas,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data);
                return GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0),
                  itemCount: 44,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      // height: 50.0,
                      // width: 50.0,
                      child: GestureDetector(
                        onTap: () => showcard(
                            snapshot.data[index]['infected']
                                .toString(),
                                  
                            snapshot.data[index]['recovered'].toString(),
                            snapshot.data[index]['deceased'].toString()),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Card(
                            child: Container(
                              color: Color(0xFF292929),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  
                                  
                                  Padding(padding: EdgeInsets.only(top: 5.0)),
                                  Image(
                                    image: AssetImage("images/cases.png"),
                                    height: 100,
                                    width: 100,
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 5.0)),
                                  Text(
                                    snapshot.data[index]['country'],textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
