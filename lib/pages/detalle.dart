import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:charts_flutter/flutter.dart';

class DetalleRoute extends StatelessWidget {
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: <Widget>[
            Container(
              child: new Card(
                child: new Center(
                  child: new Sparkline(data: data),
                ),
              ),
              decoration: new BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black,
                    blurRadius: 20
                  )
                ]
              ),
            ),
            Container(
              child: new Card(
                child: new Center(
                  child: new Sparkline(
                      data: data,
                      lineColor: Colors.lightGreen[500],
                      fillMode: FillMode.below,
                      fillColor: Colors.lightGreen[200],
                      pointsMode: PointsMode.all,
                      pointSize: 5.0,
                      pointColor: Colors.amber
                  ),
                ),
              ),
              decoration: new BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black,
                    blurRadius: 20,
                  )
                ]
              ),
              height: 200,
            ),
            Container(
              child: new Card(
                child: new AnimatedCircularChart(
                  key: new GlobalKey<AnimatedCircularChartState>(),
                  size: const Size(200.0, 200.0),
                  initialChartData: <CircularStackEntry>[
                    new CircularStackEntry(
                      <CircularSegmentEntry>[
                        new CircularSegmentEntry(
                          33.33,
                          Colors.blue[400],
                          rankKey: 'completed',
                        ),
                        new CircularSegmentEntry(
                          66.67,
                          Colors.blueGrey[600],
                          rankKey: 'remaining',
                        ),
                      ],
                      rankKey: 'progress',
                    ),
                  ],
                  chartType: CircularChartType.Radial,
                  percentageValues: true,
                  holeLabel: '1/3',
                  labelStyle: new TextStyle(
                    color: Colors.blueGrey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ),
              decoration: new BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black,
                    blurRadius: 20,
                  )
                ]
              ),
              height: 200,
            ),
            Container(
              color: Colors.blue,
              child: FlutterLogo(
                size: 60.0,
              ),
            ),
            Container(
              color: Colors.purple,
              child: FlutterLogo(
                size: 60.0,
              ),
            ),

          ]
      ),
    );
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}