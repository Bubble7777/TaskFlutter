import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Progress Indicator'),
            centerTitle: true,
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600.0) {
                return RowLayout();
              } else {
                return ColumnLayout();
              }
            },
          )),
    );
  }
}

class RowLayout extends StatefulWidget {
  @override
  _RowLayoutState createState() => _RowLayoutState();
}

class _RowLayoutState extends State<RowLayout>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  final _formkey = GlobalKey<FormState>();
  int _valueForm;
  double _result;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 15),
    );
    animationController.addListener(() {
      setState(() {});
    });

    animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = animationController.value * 100;
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/bg.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset("assets/images/bg.jpg", fit: BoxFit.fill),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 85,
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: LiquidLinearProgressIndicator(
                        borderRadius: 20.0,
                        value: animationController.value,
                        valueColor: AlwaysStoppedAnimation(Colors.amber),
                        center: Text(
                          '${percentage.toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        direction: Axis.horizontal,
                        backgroundColor: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 175,
                      width: 175,
                      child: LiquidCircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(Colors.lightGreenAccent),
                        value: animationController.value,
                        center: Text(
                          '${percentage.toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Colors.black,
                          ),
                        ),
                        borderColor: Colors.black,
                        borderWidth: 1.0,
                        direction: Axis.vertical,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          validator: (value) =>
                              validateNumber(value) ? null : 'Введите число',
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Введите от 0 до 100",
                              hintStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.black45,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 3.0))),
                          inputFormatters: [
                            // FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter(
                                RegExp(r'^[()\d -]{1,15}$'),
                                allow: true),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState.validate()) {
                                setState(() {
                                  if (_valueForm is int)
                                    _result =
                                        (percentage.round() + _valueForm) / 2;
                                });
                              }
                            },
                            child: Text('Посчитать',
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                        Text(
                          _result == null
                              ? 'Введите число'
                              : 'Среднее число = $_result',
                          style: TextStyle(fontSize: 30.0),
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateNumber(String value) {
    _valueForm = int.parse(value);
    if (value.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}

class ColumnLayout extends StatefulWidget {
  @override
  _ColumnLayoutState createState() => _ColumnLayoutState();
}

class _ColumnLayoutState extends State<ColumnLayout>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  final _formkey = GlobalKey<FormState>();
  int _valueForm;
  double _result;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 15),
    );
    animationController.addListener(() {
      setState(() {});
    });

    animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = animationController.value * 100;
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/bg.jpg"),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 85,
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: LiquidLinearProgressIndicator(
                borderRadius: 20.0,
                value: animationController.value,
                valueColor: AlwaysStoppedAnimation(Colors.amber),
                center: Text(
                  '${percentage.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                direction: Axis.horizontal,
                backgroundColor: Colors.grey.shade300,
              ),
            ),
            Container(
              height: 175,
              width: 175,
              child: LiquidCircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.lightGreenAccent),
                value: animationController.value,
                center: Text(
                  '${percentage.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
                borderColor: Colors.black,
                borderWidth: 1.0,
                direction: Axis.vertical,
              ),
            ),
            Container(
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (value) =>
                            validateNumber(value) ? null : 'Введите число',
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Введите от 0 до 100",
                            hintStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.black45,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(150.0)),
                                borderSide: BorderSide(
                                    color: Colors.black, width: 2.0))),
                        inputFormatters: [
                          // FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter(
                              RegExp(r'^[()\d -]{1,15}$'),
                              allow: true),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              setState(() {
                                if (_valueForm is int)
                                  _result =
                                      (percentage.round() + _valueForm) / 2;
                              });
                            }
                          },
                          child: Text('Посчитать',
                              style: TextStyle(
                                color: Colors.white,
                              ))),
                      Text(
                        _result == null
                            ? 'Введите число'
                            : 'Среднее число = $_result',
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  bool validateNumber(String value) {
    _valueForm = int.parse(value);
    if (value.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
