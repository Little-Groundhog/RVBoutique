import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ChaMaxAdr/camera_screen.dart';
import 'package:ChaMaxAdr/model_bloc.dart';
import 'package:ChaMaxAdr/model_event.dart';
import 'package:ChaMaxAdr/about_widget.dart';
import 'package:ChaMaxAdr/strings.dart' as strings;

class StartingPage extends StatefulWidget {
  const StartingPage({Key key}) : super(key: key);

  @override
  _StartingPageState createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  final _bloc = ModelBloc();
  TextEditingController texteEntre = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          'Rencontrer un ami',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AboutWidget(),
            ),
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: _bloc.selectedModel,
          initialData: strings.cubePrefab,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
//                  Expanded(
//                    child: GridView.count(
//                      crossAxisCount: 2,
//                      padding: EdgeInsets.all(5.0),
//                      crossAxisSpacing: 8.0,
//                      mainAxisSpacing: 8.0,
//                      children: <Widget>[
//                        customContainer(
//                          strings.dronePrefab,
//                          size,
//                          snapshot.data == strings.dronePrefab,
//                        ),
//                        customContainer(
//                          strings.brainPrefab,
//                          size,
//                          snapshot.data == strings.brainPrefab,
//                        ),
//                      ],
//                    ),
//                  ),
                  TextField(//TODO pour chopper le contenu du texte texteEntre.text
                    controller: texteEntre,
                    obscureText: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Code obtenu dans la boutique',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  FlatButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Text(
                        strings.load.toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.amber,
                        ),
                      ),
                      onPressed: () => checkCode()
                  ),
                  FlatButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Text(
                      strings.start.toUpperCase(),
                      style: TextStyle(
                        fontSize: 100,
                        color: Colors.blueGrey,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (builder) => CameraScreen(
                          selectedModel: snapshot.data,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
Widget zoneTexte(BuildContext context){//TODO pour chopper le contenu du texte texteEntre.text
  return GestureDetector(
    child:TextField(
      controller: texteEntre,
      obscureText: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Code obtenu dans la boutique',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    ),
  );
}

void checkCode(){
  if(texteEntre.text == strings.cubeCode){
    CubeModelSelectEvent();
    // ignore: unnecessary_statements
    () => Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (builder) => CameraScreen(
          selectedModel: strings.cubePrefab,
        ),
      ),
    );
  }
  if(texteEntre.text == strings.petiteVoitureCode){
    petiteVoitureModelSelectEvent();
    // ignore: unnecessary_statements
    () => Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (builder) => CameraScreen(
          selectedModel: strings.petiteVoiturePrefab,
        ),
      ),
    );
  }
  if(texteEntre.text == strings.brainCode){
    petiteVoitureModelSelectEvent();
    // ignore: unnecessary_statements
    () => Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (builder) => CameraScreen(
          selectedModel: strings.brainPrefab,
        ),
      ),
    );
  }
}
//  Widget customContainer(String image, Size size, bool border) {
//    return GestureDetector(
//      child: AnimatedContainer(
//        duration: Duration(milliseconds: 200),
//        width: size.width * 7 / 10,
//        height: size.width * 7 / 10,
//        decoration: BoxDecoration(
//          color: Colors.transparent,
//          borderRadius: BorderRadius.circular(300),
//          border: border
//              ? Border.all(
//                  color: Colors.blueGrey,
//                  width: 6,
//                )
//              : null,
//        ),
//        child: ClipRRect(
//          borderRadius: BorderRadius.circular(500),
//          child: Image.asset(
//            "assets/" + image + ".png",
//            fit: BoxFit.contain,
//          ),
//        ),
//      ),
//      onTap: () => _bloc.modelSink.add(
//        image == strings.dronePrefab
//            ? DroneModelSelectEvent()
//            : BrainModelSelectEvent()
//      ),
//    );
//  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
