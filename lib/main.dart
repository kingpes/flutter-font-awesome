import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './icons.dart';

void main() {
  runApp(FontAwesomeApp());
}

class FontAwesomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FontAwesomeHome(),
    );
  }
}

class FontAwesomeHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FontAwesomeHomeState();
}

class FontAwesomeHomeState extends State<FontAwesomeHome> {
  var _searchTerm = "";
  var _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final listIcons = icons
        .where((icon) =>
            _searchTerm.isEmpty ||
            icon.title.toLowerCase().contains(_searchTerm.toLowerCase()))
        .toList();
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: _isSearching ? _searchBar(context) : _titleBar(),
      body: GridView.builder(
        itemCount: listIcons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
        ),
        itemBuilder: (context, index) {
          final icon = listIcons[index];
          return InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(tag: icon, child: Icon(icon.iconData)),
                Container(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(icon.title),
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<Null>(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        child: SizedBox.expand(
                          child: Hero(
                            tag: icon,
                            child: Icon(
                              icon.iconData,
                              size: 100.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.black54,
        items: [
          BottomNavigationBarItem(title: Text("Home"), icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              title: Text("Post"), icon: Icon(Icons.cloud_upload)),
          BottomNavigationBarItem(title: Text("Page"), icon: Icon(Icons.pages))
        ],
      ),
    );
  }

  AppBar _titleBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(FontAwesomeIcons.home),
        onPressed: () {},
      ),
      title: Text("Font Awesome Flutter"),
      actions: [
        IconButton(
            icon: Icon(FontAwesomeIcons.search),
            onPressed: () {
              ModalRoute.of(context).addLocalHistoryEntry(
                LocalHistoryEntry(
                  onRemove: () {
                    setState(() {
                      _searchTerm = "";
                      _isSearching = false;
                    });
                  },
                ),
              );

              setState(() {
                _isSearching = true;
              });
            })
      ],
    );
  }

  AppBar _searchBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(FontAwesomeIcons.arrowLeft),
        onPressed: () {
          setState(
            () {
              Navigator.pop(context);
              _isSearching = false;
              _searchTerm = "";
            },
          );
        },
      ),
      title: TextField(
        onChanged: (text) => setState(() => _searchTerm = text),
        autofocus: true,
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
