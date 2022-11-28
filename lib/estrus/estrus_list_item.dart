import 'package:flutter/material.dart';

class EstrusListItem extends StatefulWidget {
  List<Map<String, dynamic>> mapList = [];
  final callback;

  EstrusListItem({Key? key,required this.mapList,required this.callback}) : super(key: key);
  @override
  State<EstrusListItem> createState() => _EstrusListItemState();
}

class _EstrusListItemState extends State<EstrusListItem> {
  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.mapList.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap:() {},
                child: Container(
                    alignment: Alignment.center, //align center vertical
                    margin:const EdgeInsets.all(6),
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: OutlinedButton(
                      onPressed: () {
                        widget.callback(widget.mapList[index]['id'], widget.mapList[index]['result'], widget.mapList[index]['lastdate']);
                      },
                      child: Text("모돈번호 :${widget.mapList[index]["id"]}"), ),

                    // Text(
                    //   // "ID:${widget.mapList[index]["id"]} state : ${widget.mapList[index]["result"]}",
                    //   "모돈번호 :${widget.mapList[index]["id"]}",
                    //   style: const TextStyle(fontSize:17 ),
                    // ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}