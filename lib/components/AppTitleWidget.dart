import 'package:flutter/material.dart';

class AppTitleWidget extends StatelessWidget {
  String title;
  String subtitle;
  Function onBackPressed;
  AppTitleWidget(
      {Key key, String title, String subtitle, Function onBackPressed})
      : super(key: key) {
    this.title = title;
    this.subtitle = subtitle;
    this.onBackPressed = onBackPressed;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 30,
        ),
        IconButton(
          icon: Icon(Icons.arrow_back),
          alignment: Alignment.topLeft,
          onPressed: () {
            if (onBackPressed == null) {
              Navigator.pop(context);
            } else {
              onBackPressed();
            }
          },
        ),
        Container(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text('$title',
              style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'RaleWay',
                  fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            '${subtitle == null ? '' : subtitle}',
            style: TextStyle(fontSize: 12),
          ),
        )
      ],
    );
  }
}
