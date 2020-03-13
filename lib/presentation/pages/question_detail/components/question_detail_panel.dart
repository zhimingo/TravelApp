import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class QuestionDetailPanel extends StatelessWidget {
  final TextStyle _numberStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 17.0,
  );
  final TextStyle _textStyle = TextStyle(
    fontSize: 16.0,
  );
  QuestionDetailPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '厦门有哪些惊艳了味蕾的古早味美食？',
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            constraints: BoxConstraints(
              minHeight: 20.0,
            ),
            child: Text(
              '去过厦门的人，你们有哪些实用的建议给我呀？谢谢大家了',
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildTag('厦门'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '24523',
                    style: _numberStyle,
                  ),
                  Text(
                    '浏览',
                    style: _textStyle,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    '·',
                    style: _textStyle,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    '3423',
                    style: _numberStyle,
                  ),
                  Text(
                    '回答',
                    style: _textStyle,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 18.0,
                backgroundImage: ExtendedNetworkImageProvider(
                    'https://travel-1257167414.cos.ap-shanghai.myqcloud.com/avatar.jpg'),
              ),
              SizedBox(width: 5.0),
              Text(
                '问于 2016-07-01',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black45,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildTag(String name) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 200.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.grey[300],
        ),
      ),
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 3.0,
        bottom: 3.0,
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
    );
  }
}