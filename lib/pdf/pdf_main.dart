import 'package:flutter/material.dart';
import 'list_courses.dart';

class PdfsMainPage extends StatefulWidget {
  @override
  _PdfsMainPageState createState() => _PdfsMainPageState();
}

class _PdfsMainPageState extends State<PdfsMainPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("PDFs"),
              background: Image.asset(
                'images/background.jpg',
                fit: BoxFit.fill,),
            ),
          ),
          SliverFillRemaining(
            child: new ListView.builder(
              itemBuilder: (BuildContext context, int index)=> PdfMainPage(listOfTiles[index]),
              itemCount: listOfTiles.length,
            ),
          ),
        ],

      )
      
    );
  }
}



class PdfMainPage extends StatelessWidget {
  PdfMainPage(this.myTile);
  final MyTile myTile;
 
  

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: _buildTiles(myTile));
  }
  Widget _buildTiles(MyTile t){
    if(t.children.isEmpty){
      return new ListTile(title: new Text(t.title),);
    }
    return new ExpansionTile(
      leading: Icon(Icons.book),
      key: new PageStorageKey<MyTile>(t),
      title: new Text(t.title),
      children: t.children.map(_buildTiles).toList(),
    );
  }
}