import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/entities/Estrus.dart';
import 'package:flutter_web/estrus/estrus_chart.dart';
import 'package:flutter_web/estrus/estrus_list_item.dart';
import 'package:get/get_rx/get_rx.dart';

class EstrusPage extends StatefulWidget {
  EstrusPage({Key? key}) : super(key: key);
  List<Map<String, dynamic>> mapList = [];
  @override
  State<EstrusPage> createState() => _EstrusPageState();
}

class _EstrusPageState extends State<EstrusPage> {
  var estrus = <Estrus>[].obs;
  int id = 0;
  String probability = '';
  String lastdate = '';

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset : false,
      body:SingleChildScrollView(
          scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              SingleChildScrollView(
                child:Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Container(
                            alignment: Alignment.topCenter,
                            color: Colors.white,
                            child: _buildEstrusList(),
                          )),
                    ),

                    Expanded(
                      flex: 5,
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Container(
                            alignment: const Alignment(0.0, 0.0),
                            color: Colors.amber,
                            child: EstrusChart(id: id,probability: probability,lastdate: lastdate,),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEstrusList() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return Container();
        }
        return
          EstrusListItem(mapList: widget.mapList, callback: (index, val,date) => setState(() {
            id = index;
            probability = val;
            lastdate = date;
          })
          );
      },
      future: estrusList(),
    );
  }

  Future<void> estrusList() async{
    const api = 'https://www.dfxsoft.com/api/getEstrus';
    final dio = Dio();
    Response response = await dio.get(api);
    if(response.statusCode == 200) {
      if(response.data.isNotEmpty) {
        widget.mapList.clear();
        List<dynamic> result = response.data;
        estrus.assignAll(result.map((data) => Estrus.fromJson(data)).toList());
        estrus.refresh();
        for(int i=0; i<estrus.length; i++){
          widget.mapList.add({"id": estrus[i].id, "result": estrus[i].result.toString(),"lastdate": estrus[i].lastdate.toString()});
        }
      }else{
        print("db empty");
      }
    }
  }
}