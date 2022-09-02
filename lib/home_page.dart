import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box? myBox;
  Box? myBox1;
  @override
  void initState() {
    myBox = Hive.box('myBox');
    myBox1 = Hive.box('myBox1');
    super.initState();
  }

  admin_details() {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
            elevation: 10,
            backgroundColor: Colors.white,
            content: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Md. Khaled Hassan',
                    style: GoogleFonts.roboto(
                        color: Color(0xff707070),
                        fontWeight: FontWeight.bold,
                        fontSize: 23),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'App Developer',
                    style: GoogleFonts.roboto(
                        color: Color(0xff707070).withOpacity(0.6),
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'www.khaledhassan.me',
                    style: GoogleFonts.roboto(
                        color: Colors.blue.withOpacity(0.6),
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
                ],
              ),
            ));
      },
    );
  }

  add_todo() {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
            elevation: 10,
            backgroundColor: Colors.white,
            content: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: todolist,
                    decoration: InputDecoration(
                        hintText: "Enter Your ToDo",
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          var todo = todolist.text;
                          var date =
                              DateFormat.E().add_jm().format(DateTime.now());
                          if (todo.isNotEmpty) {
                            myBox!.add(todo);
                            myBox1!.add(date);
                            todolist.clear();
                            Navigator.of(context).pop();
                          } else {}
                        });
                      },
                      child: Text('ADD')),
                ],
              ),
            ));
      },
    );
  }

  update_todo(index) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
            elevation: 10,
            backgroundColor: Colors.white,
            content: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: update_todolist,
                    decoration: InputDecoration(
                        hintText: "Enter Your ToDo",
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (update_todolist.text.isNotEmpty) {
                          myBox!.putAt(index, update_todolist.text);
                          todolist.clear();
                          Navigator.of(context).pop();
                        } else {}
                      },
                      child: Text('Update')),
                ],
              ),
            ));
      },
    );
  }

  delete_todo(index) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
            elevation: 10,
            backgroundColor: Colors.white,
            content: Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Are you sure?',
                    style: GoogleFonts.roboto(
                        color: Color(0xff707070),
                        fontWeight: FontWeight.bold,
                        fontSize: 23),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.roboto(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.normal,
                                fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(color: Colors.black)),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              myBox!.deleteAt(index);
                              myBox1!.deleteAt(index);
                              Navigator.of(context).pop();
                            });
                          },
                          child: Text(
                            'Ok',
                            style: GoogleFonts.roboto(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.normal,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }

  TextEditingController todolist = TextEditingController();
  TextEditingController update_todolist = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffcfcfc),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            add_todo();
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 15),
            child: InkWell(
              onTap: () {
                admin_details();
              },
              child: SvgPicture.asset(
                'images/menu.svg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, top: 20, bottom: 15, right: 20),
              child: Text(
                'ToDoBee',
                style: GoogleFonts.roboto(
                    color: Color(0xff707070),
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
            )
          ],
        ),
        body: myBox!.keys.toList().length != 0
            ? Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 20, right: 20, bottom: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: Hive.box('myBox').listenable(),
                          builder: (context, box, widget) {
                            return ListView.builder(
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: myBox!.keys.toList().length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, top: 5, bottom: 10),
                                  child: InkWell(
                                    onTap: () async {
                                      update_todolist.text =
                                          myBox!.getAt(index).toString();
                                      update_todo(index);
                                    },
                                    child: Container(
                                        height: 70,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  offset: Offset(0.0, 1.0),
                                                  blurRadius: 2.0)
                                            ],
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 12,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                                  .primaries[
                                                              Random().nextInt(
                                                                  Colors
                                                                      .primaries
                                                                      .length)],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          RichText(
                                                              text: TextSpan(
                                                            text: myBox!
                                                                .getAt(index)
                                                                .toString(),
                                                            style: GoogleFonts.roboto(
                                                                color: Color(
                                                                    0xff707070),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14),
                                                          )),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            myBox1!
                                                                .getAt(index)
                                                                .toString(),
                                                            style: GoogleFonts.roboto(
                                                                color: Color(
                                                                        0xff707070)
                                                                    .withOpacity(
                                                                        0.6),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 8),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            softWrap: false,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      setState(() {
                                                        delete_todo(index);
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                      size: 20,
                                                    ),
                                                  )),

                                              // Row(
                                              //   children: [
                                              //     Container(
                                              //       height: 10,
                                              //       width: 10,
                                              //       decoration: BoxDecoration(
                                              //           color: Colors.primaries[
                                              //               Random().nextInt(
                                              //                   Colors.primaries
                                              //                       .length)],
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(20)),
                                              //     ),
                                              //     SizedBox(
                                              //       width: 10,
                                              //     ),
                                              //     Container(
                                              //       child: Column(
                                              //         mainAxisAlignment:
                                              //             MainAxisAlignment
                                              //                 .center,
                                              //         crossAxisAlignment:
                                              //             CrossAxisAlignment
                                              //                 .start,
                                              //         children: [
                                              //           RichText(
                                              //               text: TextSpan(
                                              //             text: myBox!
                                              //                 .getAt(index)
                                              //                 .toString(),
                                              //             style: GoogleFonts.roboto(
                                              //                 color: Color(
                                              //                     0xff707070),
                                              //                 fontWeight:
                                              //                     FontWeight
                                              //                         .normal,
                                              //                 fontSize: 14),
                                              //           )),
                                              //           // Text(
                                              //           //   myBox!
                                              //           //       .getAt(index)
                                              //           //       .toString(),
                                              //           //   style: GoogleFonts.roboto(
                                              //           //       color: Color(
                                              //           //           0xff707070),
                                              //           //       fontWeight:
                                              //           //           FontWeight
                                              //           //               .normal,
                                              //           //       fontSize: 14),
                                              //           //   maxLines: 1,
                                              //           //   overflow:
                                              //           //       TextOverflow.fade,
                                              //           //   softWrap: false,
                                              //           // ),
                                              //           SizedBox(
                                              //             height: 5,
                                              //           ),
                                              //           Text(
                                              //             myBox1!
                                              //                 .getAt(index)
                                              //                 .toString(),
                                              //             style: GoogleFonts.roboto(
                                              //                 color: Color(
                                              //                         0xff707070)
                                              //                     .withOpacity(
                                              //                         0.6),
                                              //                 fontWeight:
                                              //                     FontWeight
                                              //                         .normal,
                                              //                 fontSize: 8),
                                              //             maxLines: 1,
                                              //             overflow:
                                              //                 TextOverflow
                                              //                     .fade,
                                              //             softWrap: false,
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              // InkWell(
                                              //   onTap: () async {
                                              //     setState(() {
                                              //       delete_todo(index);
                                              //     });
                                              //   },
                                              //   child: Icon(
                                              //     Icons.close,
                                              //     color: Colors.red,
                                              //     size: 20,
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        )),
                                  ),
                                );
                              },
                            );
                          })
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 20, right: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'images/to_do.svg',
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Add a task to get started',
                            style: GoogleFonts.roboto(
                                color: Color(0xff707070).withOpacity(0.6),
                                fontWeight: FontWeight.normal,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }
}
