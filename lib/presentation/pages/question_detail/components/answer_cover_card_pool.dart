import 'package:flutter/material.dart';
import 'package:travel/entity/answer_cover.dart';
import 'answer_cover_card.dart';

class AnswerCoverCardPool extends StatelessWidget {
  final List<AnswerCover> answerCovers;
  const AnswerCoverCardPool({Key key, this.answerCovers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.grey[100],
            width: MediaQuery.of(context).size.width,
            height: 45.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '默认排序',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Icon(Icons.sort),
                    SizedBox(width: 5.0),
                  ],
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: answerCovers.length,
            itemBuilder: (context, index) => AnswerCoverCard(
              answerCover: answerCovers[index],
            ),
          ),
        ],
      ),
    );
  }
}
