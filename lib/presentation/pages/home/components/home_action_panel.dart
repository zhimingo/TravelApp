import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:travel/route/routes.dart';

class HomeActionPanel extends StatelessWidget {
  const HomeActionPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              GlobalRoute.router.navigateTo(
                context,
                '/spotPool',
                transition: TransitionType.cupertino,
              );
            },
            child: Column(
              children: <Widget>[
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/suggest_view.png')),
                  ),
                ),
                SizedBox(height: 4.0),
                Text('景点'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              GlobalRoute.router.navigateTo(
                context,
                '/travelNote',
                transition: TransitionType.cupertino,
              );
            },
            child: Column(
              children: <Widget>[
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/suggest_guide.png')),
                  ),
                ),
                SizedBox(height: 4.0),
                Text('游记'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              GlobalRoute.router.navigateTo(
                context,
                '/comment',
                transition: TransitionType.cupertino,
              );
            },
            child: Column(
              children: <Widget>[
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/suggest_qa.png')),
                  ),
                ),
                SizedBox(height: 4.0),
                Text('讨论'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
               GlobalRoute.router.navigateTo(
                context,
                '/spotMap',
                transition: TransitionType.cupertino,
              );
            },
            child: Column(
              children: <Widget>[
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/suggest_food.png')),
                  ),
                ),
                SizedBox(height: 4.0),
                Text('美食'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
