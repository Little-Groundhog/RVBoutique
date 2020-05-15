import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ChaMaxAdr/camera_screen.dart';
import 'package:ChaMaxAdr/model_bloc.dart';
import 'package:ChaMaxAdr/model_event.dart';
import 'package:ChaMaxAdr/strings.dart' as strings;

class CodeBoutique extends StatelessWidget{
  final TextEditingController code = new TextEditingController();
  String modelLoad;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      contentTextStyle: TextStyle(
        color: Colors.black54,
        fontSize: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      content: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InkWell(
              child: Text(strings.demandeCode, textAlign: TextAlign.center),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: GestureDetector(
                child: TextField(
                  controller: code,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Code boutique..."),
                ),
              ),
            ),
            FlatButton(
              child: Text("GO !",
                  style: TextStyle(fontSize: 30),
              ),
              onPressed: (){
                // ignore: unnecessary_statements
                verif;
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (builder) => CameraScreen(
                      selectedModel: strings.petiteVoiturePrefab,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void verif(){
    if(code.text == strings.cubeCode){
      modelLoad = "strings.cubePrefab";
      print (modelLoad);
    }
    if(code.text == strings.petiteVoitureCode){

      modelLoad = "strings.petiteVoiturePrefab";
    }
    if(code.text == strings.brainCode){

      modelLoad = "strings.brainPrefab";
    }
  }
}