import 'package:flutter_app2/main.dart';
import 'package:flutter_app2/utils.dart';
import 'package:flutter/material.dart';

class TextTilePage extends StatefulWidget {
  @override
  _TextTilePageState createState() => _TextTilePageState();
}

class _TextTilePageState extends State<TextTilePage> {
  static final double radius = 20;

  UniqueKey keyTile;
  bool isExpanded = false;

  void expandTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      isExpanded = false;
      keyTile = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(color: Colors.black, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => isExpanded ? shrinkTile() : expandTile(),
                      child: buildImage(),
                    ),
                    buildText(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildImage() => Image.network(
        'https://cdn-se.mynilead.com/7443e506688afa4e5278e952a09f1d31/assets/img/anh-9875_1545748351_medium.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: 400,
      );

  Widget buildText(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: keyTile,
          initiallyExpanded: isExpanded,
          childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
          title: Text('🛠 Gara Didioto Đà Nẵng',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          children: [
            ListTile(
              title: Text('🏠 171 Tôn Đức Thắng, Quận Hải Châu, Đà Nẵng.', style: TextStyle(fontSize: 20, height: 1.4, color: Colors.black87), ),
            ),
            ListTile(
                title: Text('📞 02363 768 035.', style: TextStyle(fontSize: 20, height: 1.4, color: Colors.black87)))
          ],
          onExpansionChanged: (isExpanded) => Utils.showSnackBar(
            context,
            text: isExpanded ? 'Expand Tile' : 'Shrink Tile',
            color: isExpanded ? Colors.green : Colors.red,
          ),
        ),
      );
}
