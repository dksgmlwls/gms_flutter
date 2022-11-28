import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
class EstrusChart extends StatefulWidget {
  const EstrusChart( {Key? key,required this.id, required this.probability, required this.lastdate}):super(key: key);
  final int id;
  final String probability;
  final String lastdate;

  @override
  EstrusChartState createState(){
    return EstrusChartState();
  }
}

class EstrusChartState extends State<EstrusChart>{
  Map<String,double> data = {};
  bool _loadChart = false;

  @override
  void initState() {
    super.initState();
  }

  final List<Color> _colors =[
    Colors.redAccent,
    Colors.lightBlue,
  ];

  @override
  Widget build(BuildContext context) {
    if(widget.probability != '') {
      _loadChart = true;
      data.addAll({
        '발정':double.parse(widget.probability),
        '미발정':(100 - double.parse(widget.probability)),
      });
    }
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body:SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text("Sow id : ${widget.id}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
              ),
              Container(
                child: _loadChart? PieChart(
                  dataMap: data,
                  colorList: _colors,
                  animationDuration: const Duration(milliseconds: 1500),
                  chartLegendSpacing: 0.0,
                  chartRadius: MediaQuery.of(context).size.width / 2.7,
                  chartType: ChartType.disc,
                ):const SizedBox(
                ),
              ),

              const SizedBox(
                height: 0,
              ),
              Text(widget.lastdate.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),


    );
  }
}