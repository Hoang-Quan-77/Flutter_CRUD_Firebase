import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController _controllerID = TextEditingController();
  TextEditingController _controllerBirthdate = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  int groupValue = 0;
  String sex = 'Male';

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('students');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add an item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _controllerID,
                decoration:
                    InputDecoration(hintText: 'Enter the identity number'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter identity number ';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _controllerBirthdate,
                decoration: InputDecoration(hintText: 'Enter the birthdate'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter birthdate';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text('Choose your sex'),
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 0,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value ?? 0;
                            sex = 'Male';
                          });
                        },
                      ),
                      Text('Male')
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value ?? 0;
                            sex = 'Female';
                          });
                        },
                      ),
                      Text('Female')
                    ],
                  ),
                ],
              ),
              TextFormField(
                controller: _controllerAddress,
                decoration: InputDecoration(hintText: 'Enter the address'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }

                  return null;
                },
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        String id = _controllerID.text;
                        String birthdate = _controllerBirthdate.text;
                        String address = _controllerAddress.text;

                        //Create a Map of data
                        Map<String, String> dataToSend = {
                          'mssv': id,
                          'ngaySinh': birthdate,
                          'address': address,
                          'sex': sex,
                        };
                        //Add a new item
                        _reference.add(dataToSend);
                      }
                    },
                    child: Text('Submit')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
