import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'UpdateStudentPage.dart';
class ListStudentPage extends StatefulWidget {
  const ListStudentPage({Key? key}) : super(key: key);

  @override
  _ListStudentPageState createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> studentsStream = FirebaseFirestore.instance.collection('students').snapshots();

  deleteUser(id){
    print("User Delete $id");
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream: studentsStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){

      if(snapshot.hasError){
        print("Something went wrong");
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }
      final List storedocs = [];

      snapshot.data!.docs.map((DocumentSnapshot document) {
        Map a =  document.data() as Map<String, dynamic>;
        storedocs.add(a);
      }).toList();


      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Table(
            border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{
              1:FixedColumnWidth(140),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                  children: [
                    TableCell(child: Container(
                      color: Colors.greenAccent,
                      child: Center(
                        child: Text(
                          "Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),),
                    TableCell(child: Container(
                      color: Colors.greenAccent,
                      child: Center(
                        child: Text(
                          "Email", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),),
                    TableCell(child: Container(
                      color: Colors.greenAccent,
                      child: Center(
                        child: Text(
                          "Action", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),)
                  ]
              ),
              for (var i  = 0; i< storedocs.length; i++)...[
              TableRow(
                  children: [
                    TableCell(
                      child: Center(
                        child: Text(
                          storedocs[i]['name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          storedocs[i]['email'], style: TextStyle(fontSize: 16,),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateStudentPage()));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.orange,
                            ),
                          ),
                          IconButton(
                            onPressed: ()=>{ print(storedocs)},
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),

                  ]
              )]
            ],
          ),
        ),
      );

    });
    

  }
}
