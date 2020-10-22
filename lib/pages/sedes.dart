import 'dart:html';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags/flutter_tags.dart';

//--- variables ------
bool darkMode = false;
const double filtrobtspace = 6.0;

class Sedes extends StatefulWidget {
  Sedes({Key key}) : super(key: key);

  @override
  _SedesState createState() => _SedesState();
}

class _SedesState extends State<Sedes> with SingleTickerProviderStateMixin {
  final List<String> _list = [
    '0',
    'SDK',
    'plugin updates',
    'Facebook',
    '哔了狗了QP又不够了',
    'Kirchhoff',
    'Italy',
    'France',
    'Spain',
    '美',
    'Dart',
    'SDK',
    'Foo',
    'Select',
    'lorem ip',
    'Stanley Illidge',
    'Star',
    'Flutter Selectable Tags',
    '1',
    'Hubble',
    '2',
    'Input flutter tags',
    'A B C',
    '8',
    'Android Studio developer',
    'welcome to the jungle',
    'Gauss',
  ];

  bool _symmetry = false;
  bool _removeButton = true;
  bool _singleItem = false;
  bool _startDirection = false;
  bool _horizontalScroll = false;
  bool _withSuggesttions = false;
  int _count = 0;
  int _column = 0;
  double _fontSize = 14;

  String _itemCombine = 'withTextBefore';

  String _onPressed = '';

  List _icon = [Icons.home, Icons.language, Icons.headset];

  void initState() {
    super.initState();
    _items = _list.toList();
  }

  List _items;
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double searchWidth = size.width * 0.8;
    return Stack(
      children: [
        Positioned(
          top: 15,
          left: 80,
          right: searchWidth,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            // autofocus: true,
            autocorrect: true,
            onChanged: (value) => {
              setState(() {
                // Filtrar los estudiantes de la tabla
              })
            },
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              /* prefixIcon: Icon(
                Icons.account_box,
                size: 20.0,
              ), */
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  debugPrint('222');
                },
              ),
              isDense: true, // Added this
              contentPadding: EdgeInsets.only(left: 18, top: 0, bottom: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: "Buscar",
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: size.width * 0.8,
          right: 0,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: filtrobtspace * 9, right: filtrobtspace),
                        child: Text("Stanley M. Illidge A."),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        elevation: 4.0,
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        child: Ink.image(
                          image: AssetImage('images/monica.png'),
                          fit: BoxFit.contain,
                          width: 45.0,
                          height: 45.0,
                          child: InkWell(
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        /* Positioned(
          top: 70,
          left: 80,
          right: searchWidth,
          child: Container(
            decoration: BoxDecoration(
              color: darkMode ? Colors.grey[850] : Colors.grey[300],
              // borderRadius: BorderRadius.all(Radius.circular(50)),
              borderRadius: BorderRadius.circular(10),
              boxShadow: false
                  ? null
                  : [
                      BoxShadow(
                          color: darkMode ? Colors.black54 : Colors.grey,
                          offset: Offset(4.0, 4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                      BoxShadow(
                          color: darkMode ? Colors.grey[800] : Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                    ],
            ),
            height: 200,
            /* child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      HeaderWidget("Header 1"),
                      HeaderWidget("Header 2"),
                      HeaderWidget("Header 3"),
                      HeaderWidget("Header 4"),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      BodyWidget(Colors.blue),
                      BodyWidget(Colors.red),
                      BodyWidget(Colors.green),
                      BodyWidget(Colors.orange),
                      BodyWidget(Colors.blue),
                      BodyWidget(Colors.red),
                    ],
                  ),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  delegate: SliverChildListDelegate(
                    [
                      BodyWidget(Colors.blue),
                      BodyWidget(Colors.green),
                      BodyWidget(Colors.yellow),
                      BodyWidget(Colors.orange),
                      BodyWidget(Colors.blue),
                      BodyWidget(Colors.red),
                    ],
                  ),
                ),
              ],
            ), */
          ),
        ), */
        Positioned(
          top: 70,
          left: 80,
          right: size.width * 0.6,
          child: Container(
            decoration: BoxDecoration(
              color: darkMode ? Colors.grey[850] : Colors.grey[200],
              // borderRadius: BorderRadius.all(Radius.circular(50)),
              borderRadius: BorderRadius.circular(10),
              boxShadow: false
                  ? null
                  : [
                      BoxShadow(
                          color: darkMode ? Colors.black54 : Colors.grey,
                          offset: Offset(4.0, 4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                      BoxShadow(
                          color: darkMode ? Colors.grey[800] : Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0),
                    ],
            ),
            height: 400,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: CustomSliverDelegate(
                    expandedHeight: 40,
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      /* Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey[300], width: 0.5))),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: ExpansionTile(
                          title: Text("Settings"),
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: _removeButton,
                                          onChanged: (a) {
                                            setState(() {
                                              _removeButton = !_removeButton;
                                            });
                                          }),
                                      Text('Remove Button')
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _removeButton = !_removeButton;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: _symmetry,
                                          onChanged: (a) {
                                            setState(() {
                                              _symmetry = !_symmetry;
                                            });
                                          }),
                                      Text('Symmetry')
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _symmetry = !_symmetry;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                DropdownButton(
                                  hint: _column == 0
                                      ? Text("Not set")
                                      : Text(_column.toString()),
                                  items: _buildItems(),
                                  onChanged: (a) {
                                    setState(() {
                                      _column = a;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: _horizontalScroll,
                                          onChanged: (a) {
                                            setState(() {
                                              _horizontalScroll =
                                                  !_horizontalScroll;
                                            });
                                          }),
                                      Text('Horizontal scroll')
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _horizontalScroll = !_horizontalScroll;
                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: _singleItem,
                                          onChanged: (a) {
                                            setState(() {
                                              _singleItem = !_singleItem;
                                            });
                                          }),
                                      Text('Single Item')
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _singleItem = !_singleItem;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text('Font Size'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Slider(
                                      value: _fontSize,
                                      min: 6,
                                      max: 30,
                                      onChanged: (a) {
                                        setState(() {
                                          _fontSize = (a.round()).toDouble();
                                        });
                                      },
                                    ),
                                    Text(_fontSize.toString()),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      //color: Colors.blueGrey,
                                      child: IconButton(
                                        padding: EdgeInsets.all(0),
                                        //color: Colors.white,
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          setState(() {
                                            _count++;
                                            _items.add(_count.toString());
                                            //_items.removeAt(3); _items.removeAt(10);
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      //color: Colors.grey,
                                      child: IconButton(
                                        padding: EdgeInsets.all(0),
                                        //color: Colors.white,
                                        icon: Icon(Icons.refresh),
                                        onPressed: () {
                                          setState(() {
                                            _items = _list.toList();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ), */
                      Padding(
                        padding: EdgeInsets.all(8),
                      ),
                      _tags1,
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Divider(
                              color: Colors.blueGrey,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(_onPressed),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget get _tags1 {
    return Tags(
      key: _tagStateKey,
      symmetry: _symmetry,
      columns: _column,
      horizontalScroll: _horizontalScroll,
      //verticalDirection: VerticalDirection.up, textDirection: TextDirection.rtl,
      heightHorizontalScroll: 60 * (_fontSize / 14),
      itemCount: _items.length,
      itemBuilder: (index) {
        final item = _items[index];

        return ItemTags(
          key: Key(index.toString()),
          index: index,
          title: item,
          pressEnabled: true,
          activeColor: Colors.blueGrey[600],
          singleItem: _singleItem,
          splashColor: Colors.green,
          combine: ItemTagsCombine.withTextBefore,
          image: index > 0 && index < 5
              ? ItemTagsImage(
                  //image: AssetImage("img/p$index.jpg"),
                  child: Image.network(
                  "http://www.clipartpanda.com/clipart_images/user-66327738/download",
                  width: 16 * _fontSize / 14,
                  height: 16 * _fontSize / 14,
                ))
              : (1 == 1
                  ? ItemTagsImage(
                      image: NetworkImage(
                          "https://d32ogoqmya1dw8.cloudfront.net/images/serc/empty_user_icon_256.v2.png"),
                    )
                  : null),
          icon: (item == '0' || item == '1' || item == '2')
              ? ItemTagsIcon(
                  icon: _icon[int.parse(item)],
                )
              : null,
          removeButton: _removeButton
              ? ItemTagsRemoveButton(
                  onRemoved: () {
                    setState(() {
                      _items.removeAt(index);
                    });
                    return true;
                  },
                )
              : null,
          textScaleFactor:
              utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
          textStyle: TextStyle(
            fontSize: _fontSize,
          ),
          onPressed: (item) => print(item),
        );
      },
    );
  }

  // Position for popup menu
  Offset _tapPosition;

  TagsTextField get _textField {
    return TagsTextField(
      autofocus: false,
      //width: double.infinity,
      //padding: EdgeInsets.symmetric(horizontal: 10),
      textStyle: TextStyle(
        fontSize: _fontSize,
        //height: 1
      ),
      enabled: true,
      constraintSuggestion: true,
      suggestions: _withSuggesttions
          ? [
              "One",
              "two",
              "android",
              "Dart",
              "flutter",
              "test",
              "tests",
              "androids",
              "androidsaaa",
              "Test",
              "suggest",
              "suggestions",
              "互联网",
              "last",
              "lest",
              "炫舞时代"
            ]
          : null,
      onSubmitted: (String str) {
        setState(() {
          _items.add(str);
        });
      },
    );
  }

  List<DropdownMenuItem> _buildItems() {
    List<DropdownMenuItem> list = [];

    int count = 19;

    list.add(
      DropdownMenuItem(
        child: Text("Not set"),
        value: 0,
      ),
    );

    for (int i = 1; i < count; i++)
      list.add(
        DropdownMenuItem(
          child: Text(i.toString()),
          value: i,
        ),
      );

    return list;
  }

  List<DropdownMenuItem> _buildItems2() {
    List<DropdownMenuItem> list = [];

    list.add(DropdownMenuItem(
      child: Text("onlyText"),
      value: 'onlyText',
    ));

    list.add(DropdownMenuItem(
      child: Text("onlyIcon"),
      value: 'onlyIcon',
    ));
    list.add(DropdownMenuItem(
      child: Text("onlyImage"),
      value: 'onlyImage',
    ));
    list.add(DropdownMenuItem(
      child: Text("imageOrIconOrText"),
      value: 'imageOrIconOrText',
    ));
    list.add(DropdownMenuItem(
      child: Text("withTextBefore"),
      value: 'withTextBefore',
    ));
    list.add(DropdownMenuItem(
      child: Text("withTextAfter"),
      value: 'withTextAfter',
    ));

    return list;
  }
}

class HeaderWidget extends StatelessWidget {
  final String text;

  HeaderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(text),
      color: Colors.grey[200],
    );
  }
}

class BodyWidget extends StatelessWidget {
  final Color color;

  BodyWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: color,
      alignment: Alignment.center,
    );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;

  CustomSliverDelegate({
    @required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // final appBarSize = expandedHeight - shrinkOffset;
    // final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    // final proportion = 2 - (expandedHeight / appBarSize);
    // final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return Stack(
      children: [
        AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          elevation: 4.0,
          title: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            // autofocus: true,
            autocorrect: true,
            onChanged: (value) => {print('onChanged')},
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
                size: 20.0,
              ),
              /* suffixIcon: IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  debugPrint('222');
                },
              ), */
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: "Incluir",
            ),
          ),
        ),
        /* SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
            child: AppBar(
              backgroundColor: Colors.green,
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
              elevation: 0.0,
              title: Opacity(
                  opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                  child: Text("Test")),
            ),
          ), */
        /* Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * percent),
                child: Card(
                  elevation: 20.0,
                  child: Center(
                    child: Text("Header"),
                  ),
                ),
              ),
            ),
          ), */
      ],
    );
    /* return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          AppBar(
            backgroundColor: Colors.green,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            elevation: 0.0,
            title: Text("Test"),
          ),
          /* SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
            child: AppBar(
              backgroundColor: Colors.green,
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
              elevation: 0.0,
              title: Opacity(
                  opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                  child: Text("Test")),
            ),
          ), */
          /* Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * percent),
                child: Card(
                  elevation: 20.0,
                  child: Center(
                    child: Text("Header"),
                  ),
                ),
              ),
            ),
          ), */
        ],
      ),
    ); */
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
/* import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_tags/flutter_tags.dart';

class Sedes extends StatefulWidget {
  Sedes({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SedesState createState() => _SedesState();
}

class _SedesState extends State<Sedes> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  final List<String> _list = [
    '0',
    'SDK',
    'plugin updates',
    'Facebook',
    '哔了狗了QP又不够了',
    'Kirchhoff',
    'Italy',
    'France',
    'Spain',
    '美',
    'Dart',
    'SDK',
    'Foo',
    'Select',
    'lorem ip',
    'Stanley Illidge',
    'Star',
    'Flutter Selectable Tags',
    '1',
    'Hubble',
    '2',
    'Input flutter tags',
    'A B C',
    '8',
    'Android Studio developer',
    'welcome to the jungle',
    'Gauss',
  ];

  bool _symmetry = false;
  bool _removeButton = true;
  bool _singleItem = false;
  bool _startDirection = false;
  bool _horizontalScroll = false;
  bool _withSuggesttions = false;
  int _count = 0;
  int _column = 0;
  double _fontSize = 14;

  String _itemCombine = 'withTextBefore';

  String _onPressed = '';

  List _icon = [Icons.home, Icons.language, Icons.headset];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollViewController = ScrollController();

    _items = _list.toList();
  }

  List _items;

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  @override
  Widget build(BuildContext context) {
    //List<Item> lst = _tagStateKey.currentState?.getAllItem; lst.forEach((f) => print(f.title));
    return Scaffold(
      body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text("flutter tags"),
                centerTitle: true,
                pinned: true,
                expandedHeight: 0,
                floating: true,
                forceElevated: boxIsScrolled,
                bottom: TabBar(
                  isScrollable: false,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: TextStyle(fontSize: 18.0),
                  tabs: [
                    Tab(text: "Demo 1"),
                    Tab(text: "Demo 2"),
                  ],
                  controller: _tabController,
                ),
              )
            ];
          },
          body: Padding(
            padding: const EdgeInsets.only(left: 60.0),
            child: TabBarView(
              controller: _tabController,
              children: [
                CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey[300], width: 0.5))),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: ExpansionTile(
                              title: Text("Settings"),
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Row(
                                        children: <Widget>[
                                          Checkbox(
                                              value: _removeButton,
                                              onChanged: (a) {
                                                setState(() {
                                                  _removeButton =
                                                      !_removeButton;
                                                });
                                              }),
                                          Text('Remove Button')
                                        ],
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _removeButton = !_removeButton;
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                    ),
                                    GestureDetector(
                                      child: Row(
                                        children: <Widget>[
                                          Checkbox(
                                              value: _symmetry,
                                              onChanged: (a) {
                                                setState(() {
                                                  _symmetry = !_symmetry;
                                                });
                                              }),
                                          Text('Symmetry')
                                        ],
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _symmetry = !_symmetry;
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                    ),
                                    DropdownButton(
                                      hint: _column == 0
                                          ? Text("Not set")
                                          : Text(_column.toString()),
                                      items: _buildItems(),
                                      onChanged: (a) {
                                        setState(() {
                                          _column = a;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Row(
                                        children: <Widget>[
                                          Checkbox(
                                              value: _horizontalScroll,
                                              onChanged: (a) {
                                                setState(() {
                                                  _horizontalScroll =
                                                      !_horizontalScroll;
                                                });
                                              }),
                                          Text('Horizontal scroll')
                                        ],
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _horizontalScroll =
                                              !_horizontalScroll;
                                        });
                                      },
                                    ),
                                    GestureDetector(
                                      child: Row(
                                        children: <Widget>[
                                          Checkbox(
                                              value: _singleItem,
                                              onChanged: (a) {
                                                setState(() {
                                                  _singleItem = !_singleItem;
                                                });
                                              }),
                                          Text('Single Item')
                                        ],
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _singleItem = !_singleItem;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text('Font Size'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Slider(
                                          value: _fontSize,
                                          min: 6,
                                          max: 30,
                                          onChanged: (a) {
                                            setState(() {
                                              _fontSize =
                                                  (a.round()).toDouble();
                                            });
                                          },
                                        ),
                                        Text(_fontSize.toString()),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          //color: Colors.blueGrey,
                                          child: IconButton(
                                            padding: EdgeInsets.all(0),
                                            //color: Colors.white,
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              setState(() {
                                                _count++;
                                                _items.add(_count.toString());
                                                //_items.removeAt(3); _items.removeAt(10);
                                              });
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          //color: Colors.grey,
                                          child: IconButton(
                                            padding: EdgeInsets.all(0),
                                            //color: Colors.white,
                                            icon: Icon(Icons.refresh),
                                            onPressed: () {
                                              setState(() {
                                                _items = _list.toList();
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                          ),
                          _tags1,
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: <Widget>[
                                Divider(
                                  color: Colors.blueGrey,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Text(_onPressed),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey[300], width: 0.5))),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: ExpansionTile(
                          title: Text("Settings"),
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: _withSuggesttions,
                                          onChanged: (a) {
                                            setState(() {
                                              _withSuggesttions =
                                                  !_withSuggesttions;
                                            });
                                          }),
                                      Text('Suggestions')
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _withSuggesttions = !_withSuggesttions;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20),
                                ),
                                DropdownButton(
                                  hint: Text(_itemCombine),
                                  items: _buildItems2(),
                                  onChanged: (val) {
                                    setState(() {
                                      _itemCombine = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: _horizontalScroll,
                                          onChanged: (a) {
                                            setState(() {
                                              _horizontalScroll =
                                                  !_horizontalScroll;
                                            });
                                          }),
                                      Text('Horizontal scroll')
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _horizontalScroll = !_horizontalScroll;
                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: _startDirection,
                                          onChanged: (a) {
                                            setState(() {
                                              _startDirection =
                                                  !_startDirection;
                                            });
                                          }),
                                      Text('Start Direction')
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _startDirection = !_startDirection;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text('Font Size'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Slider(
                                      value: _fontSize,
                                      min: 6,
                                      max: 30,
                                      onChanged: (a) {
                                        setState(() {
                                          _fontSize = (a.round()).toDouble();
                                        });
                                      },
                                    ),
                                    Text(_fontSize.toString()),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                      ),
                      _tags2,
                      Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Divider(
                                color: Colors.blueGrey,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text(_onPressed),
                              ),
                            ],
                          )),
                    ])),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget get _tags1 {
    return Tags(
      key: _tagStateKey,
      symmetry: _symmetry,
      columns: _column,
      horizontalScroll: _horizontalScroll,
      //verticalDirection: VerticalDirection.up, textDirection: TextDirection.rtl,
      heightHorizontalScroll: 60 * (_fontSize / 14),
      itemCount: _items.length,
      itemBuilder: (index) {
        final item = _items[index];

        return ItemTags(
          key: Key(index.toString()),
          index: index,
          title: item,
          pressEnabled: true,
          activeColor: Colors.blueGrey[600],
          singleItem: _singleItem,
          splashColor: Colors.green,
          combine: ItemTagsCombine.withTextBefore,
          image: index > 0 && index < 5
              ? ItemTagsImage(
                  //image: AssetImage("img/p$index.jpg"),
                  child: Image.network(
                  "http://www.clipartpanda.com/clipart_images/user-66327738/download",
                  width: 16 * _fontSize / 14,
                  height: 16 * _fontSize / 14,
                ))
              : (1 == 1
                  ? ItemTagsImage(
                      image: NetworkImage(
                          "https://d32ogoqmya1dw8.cloudfront.net/images/serc/empty_user_icon_256.v2.png"),
                    )
                  : null),
          icon: (item == '0' || item == '1' || item == '2')
              ? ItemTagsIcon(
                  icon: _icon[int.parse(item)],
                )
              : null,
          removeButton: _removeButton
              ? ItemTagsRemoveButton(
                  onRemoved: () {
                    setState(() {
                      _items.removeAt(index);
                    });
                    return true;
                  },
                )
              : null,
          textScaleFactor:
              utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
          textStyle: TextStyle(
            fontSize: _fontSize,
          ),
          onPressed: (item) => print(item),
        );
      },
    );
  }

  // Position for popup menu
  Offset _tapPosition;

  Widget get _tags2 {
    //popup Menu
    final RenderBox overlay = Overlay.of(context).context?.findRenderObject();

    ItemTagsCombine combine = ItemTagsCombine.onlyText;

    switch (_itemCombine) {
      case 'onlyText':
        combine = ItemTagsCombine.onlyText;
        break;
      case 'onlyIcon':
        combine = ItemTagsCombine.onlyIcon;
        break;
      case 'onlyIcon':
        combine = ItemTagsCombine.onlyIcon;
        break;
      case 'onlyImage':
        combine = ItemTagsCombine.onlyImage;
        break;
      case 'imageOrIconOrText':
        combine = ItemTagsCombine.imageOrIconOrText;
        break;
      case 'withTextAfter':
        combine = ItemTagsCombine.withTextAfter;
        break;
      case 'withTextBefore':
        combine = ItemTagsCombine.withTextBefore;
        break;
    }

    return Tags(
      key: Key("2"),
      symmetry: _symmetry,
      columns: _column,
      horizontalScroll: _horizontalScroll,
      verticalDirection:
          _startDirection ? VerticalDirection.up : VerticalDirection.down,
      textDirection: _startDirection ? TextDirection.rtl : TextDirection.ltr,
      heightHorizontalScroll: 60 * (_fontSize / 14),
      textField: _textField,
      itemCount: _items.length,
      itemBuilder: (index) {
        final item = _items[index];

        return GestureDetector(
          child: ItemTags(
            key: Key(index.toString()),
            index: index,
            title: item,
            pressEnabled: false,
            activeColor: Colors.green[400],
            combine: combine,
            image: index > 0 && index < 5
                ? ItemTagsImage(image: AssetImage("img/p$index.jpg"))
                : (1 == 1
                    ? ItemTagsImage(
                        image: NetworkImage(
                            "https://image.flaticon.com/icons/png/512/44/44948.png"))
                    : null),
            icon: (item == '0' || item == '1' || item == '2')
                ? ItemTagsIcon(
                    icon: _icon[int.parse(item)],
                  )
                : null,
            removeButton: ItemTagsRemoveButton(
              backgroundColor: Colors.green[900],
              onRemoved: () {
                setState(() {
                  _items.removeAt(index);
                });
                return true;
              },
            ),
            textScaleFactor:
                utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
            textStyle: TextStyle(
              fontSize: _fontSize,
            ),
          ),
          onTapDown: (details) => _tapPosition = details.globalPosition,
          onLongPress: () {
            showMenu(
                    //semanticLabel: item,
                    items: <PopupMenuEntry>[
                  PopupMenuItem(
                    child: Text(item, style: TextStyle(color: Colors.blueGrey)),
                    enabled: false,
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.content_copy),
                        Text("Copy text"),
                      ],
                    ),
                  ),
                ],
                    context: context,
                    position: RelativeRect.fromRect(
                        _tapPosition & Size(40, 40),
                        Offset.zero &
                            overlay
                                .size) // & RelativeRect.fromLTRB(65.0, 40.0, 0.0, 0.0),
                    )
                .then((value) {
              if (value == 1) Clipboard.setData(ClipboardData(text: item));
            });
          },
        );
      },
    );
  }

  TagsTextField get _textField {
    return TagsTextField(
      autofocus: false,
      //width: double.infinity,
      //padding: EdgeInsets.symmetric(horizontal: 10),
      textStyle: TextStyle(
        fontSize: _fontSize,
        //height: 1
      ),
      enabled: true,
      constraintSuggestion: true,
      suggestions: _withSuggesttions
          ? [
              "One",
              "two",
              "android",
              "Dart",
              "flutter",
              "test",
              "tests",
              "androids",
              "androidsaaa",
              "Test",
              "suggest",
              "suggestions",
              "互联网",
              "last",
              "lest",
              "炫舞时代"
            ]
          : null,
      onSubmitted: (String str) {
        setState(() {
          _items.add(str);
        });
      },
    );
  }

  List<DropdownMenuItem> _buildItems() {
    List<DropdownMenuItem> list = [];

    int count = 19;

    list.add(
      DropdownMenuItem(
        child: Text("Not set"),
        value: 0,
      ),
    );

    for (int i = 1; i < count; i++)
      list.add(
        DropdownMenuItem(
          child: Text(i.toString()),
          value: i,
        ),
      );

    return list;
  }

  List<DropdownMenuItem> _buildItems2() {
    List<DropdownMenuItem> list = [];

    list.add(DropdownMenuItem(
      child: Text("onlyText"),
      value: 'onlyText',
    ));

    list.add(DropdownMenuItem(
      child: Text("onlyIcon"),
      value: 'onlyIcon',
    ));
    list.add(DropdownMenuItem(
      child: Text("onlyImage"),
      value: 'onlyImage',
    ));
    list.add(DropdownMenuItem(
      child: Text("imageOrIconOrText"),
      value: 'imageOrIconOrText',
    ));
    list.add(DropdownMenuItem(
      child: Text("withTextBefore"),
      value: 'withTextBefore',
    ));
    list.add(DropdownMenuItem(
      child: Text("withTextAfter"),
      value: 'withTextAfter',
    ));

    return list;
  }
}
 */
