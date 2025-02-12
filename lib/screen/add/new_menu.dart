import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hewa/config/palette.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'recipe_step_1.dart';
import 'package:hewa/utilities/ingred_helper.dart';
import 'package:hewa/models/ingred_model.dart';

class NewMenu extends StatefulWidget {
  @override
  _NewMenuState createState() => _NewMenuState();
}

List<String> ingredients = [];
List<IngredModel> ingredModel = [];

class _NewMenuState extends State<NewMenu> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        print(pickedFile);
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  String _confirmedIngredient = 'Select Ingredient';
  String _selectedIngredient = '';

  List<Widget> getPickerItems() {
    List<Widget> items = [];
    for (var ingredients in ingredients) {
      items.add(Text(ingredients));
    }
    return items;
  }

  void _showPicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              width: double.infinity,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 30,
                children: getPickerItems(),
                onSelectedItemChanged: (value) {
                  setState(() {
                    _selectedIngredient = ingredients[value];
                  });
                },
              ),
            ));
  }

  Future<Null> readSQLite() async {
    var object = await IngredHelper().readlDataFromSQLite();
    print('object length ==> ${object.length}');
    ingredients.clear();
    for (var model in object) {
      print(model);
      ingredModel.add(model);
      ingredients.add(model.name!);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readSQLite();
  }

  @override
  Widget build(BuildContext context) {
    print(_image);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[BackButton()],
              ),
              SingleChildScrollView(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50)),
                  child: Container(
                    width: double.infinity,
                    color: Palette.roseBud,
                    child: Column(children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        'Create new menu',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                            child: Container(
                              color: Color(0xffF4F6F6),
                              width: double.infinity,
                              child: Container(
                                  margin: EdgeInsets.only(
                                      top: 30, left: 40, right: 40, bottom: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('Menu')),
                                      SizedBox(height: 10),
                                      TextField(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              filled: true,
                                              hintText: 'Menu',
                                              fillColor: Colors.white)),
                                      SizedBox(height: 10),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('Description')),
                                      SizedBox(height: 10),
                                      TextField(
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              filled: true,
                                              hintText: 'Description',
                                              fillColor: Colors.white)),
                                      SizedBox(height: 10),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('Add Image')),
                                      Column(children: <Widget>[
                                        SizedBox(height: 10),
                                        Row(
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                getImage();
                                              },
                                              child: _image != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Container(
                                                        width: 120,
                                                        height: 120,
                                                        color: Colors.white,
                                                        child:
                                                            Image.file(_image!),
                                                      ))
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Container(
                                                        width: 120,
                                                        height: 120,
                                                        color: Colors.white,
                                                        child: Icon(Icons.add),
                                                      )),
                                            ),
                                            //     SizedBox(width: 10),
                                            //     ClipRRect(
                                            //         borderRadius:
                                            //             BorderRadius.circular(10),
                                            //         child: Container(
                                            //           width: 120,
                                            //           height: 120,
                                            //           color: Colors.blue,
                                            //         )),
                                            //   ],
                                            // ),
                                            // SizedBox(height: 20),
                                            // Row(
                                            //   children: <Widget>[
                                            //     ClipRRect(
                                            //         borderRadius:
                                            //             BorderRadius.circular(10),
                                            //         child: Container(
                                            //           width: 120,
                                            //           height: 120,
                                            //           color: Colors.blue,
                                            //         )),
                                            //     SizedBox(width: 10),
                                            //     ClipRRect(
                                            //         borderRadius:
                                            //             BorderRadius.circular(10),
                                            //         child: Container(
                                            //           width: 120,
                                            //           height: 120,
                                            //           color: Colors.blue,
                                            //         )),
                                          ],
                                        )
                                      ]),
                                      SizedBox(height: 10),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('Main ingredient')),
                                      SizedBox(height: 10),
                                      CupertinoButton(
                                        child: Text(
                                          '$_confirmedIngredient',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _selectedIngredient =
                                                ingredients[0];
                                          });
                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (context) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffffffff),
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            color: Color(
                                                                0xff999999),
                                                            width: 0.0,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          CupertinoButton(
                                                              child: Text(
                                                                  'Cancel'),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              }),
                                                          CupertinoButton(
                                                            child:
                                                                Text('confirm'),
                                                            onPressed: () {
                                                              setState(() {
                                                                _confirmedIngredient =
                                                                    _selectedIngredient;
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 16.0,
                                                              vertical: 5.0,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 320,
                                                      color: Colors.white,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Expanded(
                                                              child:
                                                                  CupertinoPicker(
                                                            itemExtent: 32,
                                                            backgroundColor:
                                                                Colors.white,
                                                            onSelectedItemChanged:
                                                                (value) {
                                                              setState(() {
                                                                _selectedIngredient =
                                                                    ingredients[
                                                                        value];
                                                              });
                                                            },
                                                            children:
                                                                getPickerItems(),
                                                          )),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                );
                                              });
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      // Align(
                                      //     alignment: Alignment.centerLeft,
                                      //     child: Text('ข้อมูลโภชนาการ')),
                                      // SizedBox(height: 10),
                                      // TextField(
                                      //     decoration: InputDecoration(
                                      //         border: OutlineInputBorder(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     20)),
                                      //         filled: true,
                                      //         hintText: 'แคลอรี',
                                      //         fillColor: Colors.white)),
                                      // SizedBox(height: 10),
                                      // TextField(
                                      //     decoration: InputDecoration(
                                      //         border: OutlineInputBorder(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     20)),
                                      //         filled: true,
                                      //         hintText: 'โปรตีน',
                                      //         fillColor: Colors.white)),
                                      // SizedBox(height: 10),
                                      // TextField(
                                      //     decoration: InputDecoration(
                                      //         border: OutlineInputBorder(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     20)),
                                      //         filled: true,
                                      //         hintText: 'คาร์โบไฮเดรต',
                                      //         fillColor: Colors.white)),
                                      // SizedBox(height: 10),
                                      // TextField(
                                      //     decoration: InputDecoration(
                                      //         border: OutlineInputBorder(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     20)),
                                      //         filled: true,
                                      //         hintText: 'ไขมัน',
                                      //         fillColor: Colors.white)),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            TextButton(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text('Next'),
                                                    Icon(
                                                        Icons.arrow_forward_ios)
                                                  ],
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          child: RecipeStep1(),
                                                          type:
                                                              PageTransitionType
                                                                  .rightToLeft));
                                                })
                                          ])
                                    ],
                                  )),
                            ),
                          ))
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
