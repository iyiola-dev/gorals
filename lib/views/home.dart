import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gorals/core/models/gorals_model.dart';
import 'package:gorals/core/service/goralApi.dart';
import 'package:http/http.dart';
import 'package:json_table/json_table.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoralApi goralApi = GoralApi();
  Start start;
  StaffRoster staffRoster;
  Valid valid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: FutureBuilder<Gorals>(
          future: goralApi.getgorals(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(18),
                    child: SingleChildScrollView(
                        child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'data',
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),

                          /* Text(
                            'Hospital ID: ${datum[1]}',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(datum[index].staffRoster.monday.toString()), */
                          /* JsonTable(datum, tableHeaderBuilder: (String header) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5),
                                  color: Colors.grey[300]),
                              child: Text(
                                header,
                                textAlign: TextAlign.center,
                              ),
                            );
                          }, tableCellBuilder: (value) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5,
                                      color: Colors.grey.withOpacity(0.5))),
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                              ),
                            );
                          }), */
                        ],
                      ),
                    ))),
              );
            } else if (snapshot.hasError) {
              return AlertDialog(
                content: Column(
                  children: <Widget>[
                    Text("${snapshot.error}"),
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("close"))
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
