import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math' as math;

import 'package:flutter_web/entities/Estrus.dart';
import 'package:get/get_rx/get_rx.dart';

class EstrusBarchartScroll extends StatefulWidget {
  EstrusBarchartScroll({Key? key}) : super(key: key);

  @override
  EstrusBarchartScrollState createState(){
    return EstrusBarchartScrollState();
    }
  }

class EstrusBarchartScrollState extends State<EstrusBarchartScroll>{
  var estrus = <Estrus>[].obs;
  static final List<EstrusBarChartData> barchartdata=[];
  @override
  void initState() {
    super.initState();
    estrusList();
  }
  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<EstrusBarChartData,String>> series =[
      charts.Series(
          data:barchartdata,
          id: "Estrus",
          domainFn: (EstrusBarChartData pops,_)=> pops.id,
          measureFn: (EstrusBarChartData pops,_)=> pops.population,
          colorFn: (EstrusBarChartData pops,_)=> charts.ColorUtil.fromDartColor(pops.barColor),
          labelAccessorFn: (EstrusBarChartData pops, _) =>'${pops.barLabel}',
      )
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SingleChildScrollView',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Estrus Probability Bar Chart'),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(5),
              bottom: Radius.circular(5),
            ),
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: SingleChildScrollView(

              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: charts.BarChart(
                      series,
                      vertical: false,
                      animate: true,
                      barRendererDecorator: new charts.BarLabelDecorator<String>(
                          labelAnchor: charts.BarLabelAnchor.end,
                        insideLabelStyleSpec: charts.TextStyleSpec(
                          color: charts.Color.white,
                          fontSize: 30,
                        ),
                      ),
                      domainAxis: new charts.OrdinalAxisSpec(
                          renderSpec: new charts.SmallTickRendererSpec(
                            // Tick and Label styling here.
                              labelStyle: new charts.TextStyleSpec(
                                  fontSize: 25, // size in Pts.
                                  color: charts.MaterialPalette.black),
                              // Change the line colors to match text color.
                              lineStyle: new charts.LineStyleSpec(
                                  color: charts.MaterialPalette.black)
                          )
                      ),
                      primaryMeasureAxis: new charts.NumericAxisSpec(
                          renderSpec: new charts.GridlineRendererSpec(
                            // Tick and Label styling here.
                              labelStyle: new charts.TextStyleSpec(
                                  fontSize: 20, // size in Pts.
                                  color: charts.MaterialPalette.black),

                              // Change the line colors to match text color.
                              lineStyle: new charts.LineStyleSpec(
                                  color: charts.MaterialPalette.black))),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ),
      ),
    );
  }


  Future<void> estrusList() async{
    const api = 'https://www.dfxsoft.com/api/getEstrus';
    final dio = Dio();
    Response response = await dio.get(api);
    if(response.statusCode == 200) {

      // Iterable jsonList = json.decode(response.data);
      // for (var element in jsonList) {
      //   barchartdata.add(EstrusBarChartData(element["id"].toString(), double.parse(element["result"]), Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),double.parse(element["result"]),));
      // }

      List<dynamic> result = response.data;
      estrus.assignAll(result.map((data) => Estrus.fromJson(data)).toList());
      estrus.refresh();
      for(int i=0; i<estrus.length; i++){
        barchartdata.add(EstrusBarChartData(estrus[i].id.toString(), double.parse(estrus[i].result.toString()), Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),double.parse(estrus[i].result.toString()),));
      }
    }
  }
}

class EstrusBarChartData {
  final String id;
  final double population;
  final Color barColor;
  final double barLabel;
  EstrusBarChartData(this.id, this.population,this.barColor,this.barLabel);
}
