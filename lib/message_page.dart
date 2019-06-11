import 'package:flutter/material.dart';


class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Message"),

        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context){
              return[
                PopupMenuItem(child: Text("Clear chat"),),
                PopupMenuItem(child: Text("Block"),),
                PopupMenuItem(child: Text("View profile"),),
              ];
            },
          ),
        ],
      ),
      body: new Center(
        child: new Text(
          "Messages",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 32.0
          ),
        ),
      ),
    );
  }
}