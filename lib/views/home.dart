import 'package:flutter/material.dart';
import 'package:gorals/core/models/gorals_model.dart';
import 'package:gorals/core/service/goralApi.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoralApi goralApi = GoralApi();
  Start start;
  Valid valid;
  Data data;
  Gorals model;

  List<TableRow> returnData(List<Shifts> shift, StaffRoster staffRoster,
      {String identity}) {
    List<TableRow> lt = [];
    var rosterMap = staffRoster.toJson();
    for (var i = 0; i < shift.length; i++) {
      var item = shift[i];
      lt.add(TableRow(children: [
        Text("${item.start[0].hour} - ${item.stop[0].hour}"),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...rosterMap[identity]["${i + 1}"].map((e) => Text("$e")).toList()
          ],
        ),
      ]));
    }
    return lt;
  }

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
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ListView.builder(
                          itemCount: model.data.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var content = model.data[index];

                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Table(
                                border: TableBorder.all(),
                                columnWidths: {0: FractionColumnWidth(.2)},
                                children: [
                                  ...content.openingDays.map(
                                    (e) {
                                      return TableRow(children: [
                                        Text("$e"),
                                        Table(
                                          border: TableBorder.all(),
                                          children: [
                                            ...returnData(content.shifts,
                                                content.staffRoster,
                                                identity: e)
                                          ],
                                        ),
                                      ]);
                                    },
                                  ).toList()
                                ],
                              ),
                            );
                          },
                        )
                      ],
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
