//Nouvelle page d'acceuil

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ChaMaxAdr/imagesNewStartPage.dart';
import 'package:ChaMaxAdr/classNewStart.dart';
import 'package:ChaMaxAdr/about_widget.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List<Product> _products = [];
  PageController _pageController;
  double _currentPage = 0;
  String _productCategory = 'Boutique VBA';

  AnimationController _animationController;
  Animation<Offset> _searchOffsetAnimation;
  Animation<Offset> _cartOffsetAnimation;
  Animation<double> _LogoOffsetAnimation;
  Animation<Offset> _productBackgroundOffsetAnimation;
  Animation<Offset> _productOffsetAnimation;

  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {
          _currentPage = _pageController.page;
        });
      });

    // Initialize products
    final product1 = Product(
      title: 'Robot \nSteamPunk',
      subtitle: 'Le magnifique robot',
      price: '3000 jetons',
      category: 'Robot',
      imageUrl: AssetConstants.robot,
    );
    final product2 = Product(
      title: 'Cube\nLe Rubix de cube',
      subtitle: 'Le cube magique',
      price: '200 jetons',
      category: 'Rubiks Cube',
      imageUrl: AssetConstants.cube,
    );
    final product3 = Product(
      title: 'Chasseur automatique\nDrone',
      subtitle: 'OVNI',
      price: '5000 jetons',
      category: 'Drone de combat',
      imageUrl: AssetConstants.drone,
    );
    final product4 = Product(
      title: 'La maison\nen lego',
      subtitle: 'Construction',
      price: '500 jetons',
      category: 'Maison',
      imageUrl: AssetConstants.lego,
    );

    _products.addAll([product1, product2, product3, product4]);

    // Prepare animations
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );

    _LogoOffsetAnimation = Tween<double>(
      begin: -1000,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linearToEaseOut,
      ),
    );

    // Prepare entrance animation
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: AppBar(
        leading: Icon(
          Icons.search,
          color: Colors.black,
        ),
        backgroundColor: Color(0xFFF3F3F3),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 12),
            icon: Icon(
              Icons.info,
              color: Colors.black,
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AboutWidget(),
            ),
          ),
        ],
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget child) {
            return Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: size.height * 0.60,
                      width: size.width,
                      child: PageView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: _products.length,
                        controller: _pageController,
                        itemBuilder: (BuildContext context, int index) {
                          _productCategory = _products[index].category;

                          if (index == _currentPage.floor()) {
                            return PageItemView(
                              product: _products[index],
                              index: index,
                              page: _currentPage,
                              alignment: FractionalOffset.centerRight,
                            );
                          } else if (index == _currentPage.floor() + 1) {
                            return PageItemView(
                              product: _products[index],
                              index: index,
                              page: _currentPage,
                              alignment: FractionalOffset.centerLeft,
                            );
                          } else {
                            return PageItemView(
                              product: _products[index],
                              index: index,
                              page: _currentPage,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Transform.translate(
                  offset: Offset(
                    size.width / 2 - 25,
                    _LogoOffsetAnimation.value,
                  ),
                  child: Container(
                    height: 100,
                    width: 50,
                    child: Image.network(AssetConstants.logoApp),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 48,
                      left: 32,
                      right: 32,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back,
                          size: 16,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isAnimated = !_isAnimated;
                            });

                            if (_isAnimated) {
                              _animationController.forward();
                            } else {
                              _animationController.reverse();
                            }
                          },
                          child: Text(
                            _productCategory.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class PageItemView extends StatefulWidget {
  final double _defaultItemHeight = 500;
  final double _defaultPerspective = 0.002;
  final double _defaultAngle = pi / 2;
  final double _defaultProductAngle = -1;
  final Alignment _defaultAlignment = FractionalOffset.center;

  final double itemHeight;
  final Product product;
  final int index;
  final double page;
  final double perspective;
  final double angle;
  final double productAngle;
  final Alignment alignment;

  const PageItemView({
    Key key,
    @required this.product,
    @required this.index,
    @required this.page,
    this.itemHeight,
    this.perspective,
    this.angle,
    this.productAngle,
    this.alignment,
  })  : assert(index != null, 'index must not be null!'),
        assert(index != null, 'page must not be null!'),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PageItemViewState();
  }
}

class _PageItemViewState extends State<PageItemView> {
  double get _itemHeight => widget.itemHeight ?? widget._defaultItemHeight;
  Alignment get _alignment => widget.alignment ?? widget._defaultAlignment;
  Product get _product => widget.product;
  int get _index => widget.index ?? 0;
  double get _page => widget.page ?? 0;
  double get _perspective => widget.perspective ?? widget._defaultPerspective;
  double get _angle => widget.angle ?? widget._defaultAngle;
  double get _productAngle => widget.angle ?? widget._defaultProductAngle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _alignment != null
              ? Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, _perspective)
              ..scale(1 - lerpDouble(0, -0.25, _index - _page))
              ..rotateY(_angle * (_page - _index)),
            alignment: _alignment,
            child: _buildBackground(_itemHeight),
          )
              : _buildBackground(_itemHeight),
          Transform.translate(
            offset: Offset(0, -20),
            child: Transform.rotate(
              angle: _productAngle * (_page - _index),
              child: Container(
                height: 160,
                child: Center(
                  child: Transform.rotate(
                    angle: 276,
                    child: Image.network(_product.imageUrl),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(double height) {
    return Container(
      height: height,
      width: 250,
      margin: const EdgeInsets.all(32),
      // TODO: Apparently, box shadow is slow in this transition. Action item: Investigate and file an issue
      // boxShadow: [
      //   BoxShadow(
      //     offset: Offset(0, 0),
      //     color: Color(0xFFE3E3E3),
      //     blurRadius: 30,
      //   ),
      // ],
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Container(
              height: height,
              color: Colors.white,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Text(
                  _product.title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: Text(
                      _product.subtitle.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  Container(
                    height: 48,
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _product.price.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        // https://github.com/flutter/flutter/issues/55031
                        Opacity(
                          opacity: 0.99,
                          child: Container(
                            height: 48,
                            width: 48,
                            color: Color(0xFF232323),
                            child: Icon(
                              Icons.add,
                              color: Colors.white30,
                            ),
                          ),
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
    );
  }
}
