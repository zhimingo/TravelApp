import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:travel/presentation/blocs/answer_pool/answer_pool_bloc.dart';
import 'package:travel/presentation/blocs/current_user/current_user_bloc.dart';
import 'package:travel/presentation/blocs/question_detail/question_detail_bloc.dart';
import 'package:travel/route/routes.dart';

import './components/components.dart';

class QuestionDetail extends StatefulWidget {
  QuestionDetail({Key key}) : super(key: key);

  @override
  _QuestionDetailState createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  AnswerPoolBloc _answerPoolBloc;

  @override
  void initState() {
    super.initState();
    _answerPoolBloc = BlocProvider.of<AnswerPoolBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 247, 249, 1.0),
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            GlobalRoute.router.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: BlocBuilder<QuestionDetailBloc, QuestionDetailState>(
        builder: (context, state) {
          if (state is QuestionDetailLoading) {
            return Center(
              child: Text('Loading....'),
            );
          } else if (state is QuestionDetailLoaded) {
            final currentState = context.bloc<CurrentUserBloc>().state;
            int userId;
            if (currentState is CurrentUserLoaded) {
              userId = currentState.currentUser.userId;
            }
            int boundary = 0;
            int offset = 15;
            bool hasNext = false;
            final answerCurrentState = context.bloc<AnswerPoolBloc>().state;
            if (answerCurrentState is AnswerPoolLoaded) {
              boundary = answerCurrentState.page.boundary;
              offset = answerCurrentState.page.offset;
              hasNext = answerCurrentState.page.hasNext;
            }
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: false,
              enablePullUp: true,
              footer: ClassicFooter(),
              onLoading: () {
                if (hasNext) {
                  _answerPoolBloc.add(LoadMoreAnswerCovers(
                    questionId: state.questionDetail.questionId,
                    userId: userId,
                    boundary: boundary,
                    offset: offset,
                  ));
                } else {
                   _answerPoolBloc.add(RefreshAnswerCovers(
                    questionId: state.questionDetail.questionId,
                    userId: userId,
                    boundary: 0,
                    offset: boundary + offset,
                  ));
                }
              },
              child: ListView(
                children: <Widget>[
                  QuestionDetailPanel(
                    questionDetail: state.questionDetail,
                  ),
                  AnswerCoverCardPool(
                    question: state.questionDetail.title,
                    refreshController: _refreshController,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('加载失败了'),
            );
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<QuestionDetailBloc, QuestionDetailState>(
        builder: (context, state) {
          if (state is QuestionDetailLoaded) {
            return BottomActionPanel(
              isCollect: state.questionDetail.isCollect,
              collectNum: 10,
              question: state.questionDetail.questionId,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
