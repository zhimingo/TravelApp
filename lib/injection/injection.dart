import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/core/http/http.dart';
import 'package:travel/data/datasources/local/authorization_local_datasource.dart';
import 'package:travel/data/datasources/local/search_local_datasource.dart';
import 'package:travel/data/datasources/local/user_local_datasource.dart';
import 'package:travel/data/datasources/remote/answer_remote_datasource.dart';
import 'package:travel/data/datasources/remote/authorzation_remote_datasource.dart';
import 'package:travel/data/datasources/remote/collect_remote_datasource.dart';
import 'package:travel/data/datasources/remote/cr_remote_datasource.dart';
import 'package:travel/data/datasources/remote/login_remote_datasources.dart';
import 'package:travel/data/datasources/remote/moment_remote_datasource.dart';
import 'package:travel/data/datasources/remote/question_remote_datasource.dart';
import 'package:travel/data/datasources/remote/spot_filter_remote_datasource.dart';
import 'package:travel/data/datasources/remote/spot_remote_datasource.dart';
import 'package:travel/data/datasources/remote/thumbup_remote_datasource.dart';
import 'package:travel/data/datasources/remote/topic_remote_datasource.dart';
import 'package:travel/data/datasources/remote/user_remote_datasource.dart';
import 'package:travel/data/repositories/answer_repository.dart';
import 'package:travel/data/repositories/authorzation_repository.dart';
import 'package:travel/data/repositories/collect_repository.dart';
import 'package:travel/data/repositories/cr_repository.dart';
import 'package:travel/data/repositories/login_repository.dart';
import 'package:travel/data/repositories/moment_repository.dart';
import 'package:travel/data/repositories/question_respository.dart';
import 'package:travel/data/repositories/search_repository.dart';
import 'package:travel/data/repositories/spot_filter_repository.dart';
import 'package:travel/data/repositories/spot_repository.dart';
import 'package:travel/data/repositories/thumbup_repository.dart';
import 'package:travel/data/repositories/topic_repository.dart';
import 'package:travel/data/repositories/user_repository.dart';
import 'package:travel/entity/app_info.dart';
import 'package:travel/presentation/blocs/answer_detail/answer_detail_bloc.dart';
import 'package:travel/presentation/blocs/answer_pool/answer_pool_bloc.dart';
import 'package:travel/presentation/blocs/authorization/authorization_bloc.dart';
import 'package:travel/presentation/blocs/collect/collect_bloc.dart';
import 'package:travel/presentation/blocs/comment_cover_pool/comment_cover_pool_bloc.dart';
import 'package:travel/presentation/blocs/current_user/current_user_bloc.dart';
import 'package:travel/presentation/blocs/hot_topic/hot_topic_bloc.dart';
import 'package:travel/presentation/blocs/login/login_bloc.dart';
import 'package:travel/presentation/blocs/moment_detail/moment_detail_bloc.dart';
import 'package:travel/presentation/blocs/moment_pool/moment_pool_bloc.dart';
import 'package:travel/presentation/blocs/question_detail/question_detail_bloc.dart';
import 'package:travel/presentation/blocs/question_pool/question_pool_bloc.dart';
import 'package:travel/presentation/blocs/search_history/search_history_bloc.dart';
import 'package:travel/presentation/blocs/sms_form/sms_form_bloc.dart';
import 'package:travel/presentation/blocs/spot_pool/spot_pool_bloc.dart';
import 'package:travel/presentation/blocs/thumbup/thumbup_bloc.dart';
import 'package:travel/presentation/blocs/topic_detail/topic_detail_bloc.dart';
import 'package:travel/presentation/blocs/topic_pool/topic_pool_bloc.dart';
import 'package:travel/service/answer_service.dart';
import 'package:travel/service/authorization_service.dart';
import 'package:travel/service/collect_service.dart';
import 'package:travel/service/cr_service.dart';
import 'package:travel/service/login_service.dart';
import 'package:travel/service/moment_service.dart';
import 'package:travel/service/question_service.dart';
import 'package:travel/service/search_service.dart';
import 'package:travel/service/spot_service.dart';
import 'package:travel/service/thumbup_service.dart';
import 'package:travel/service/topic_service.dart';
import 'package:travel/service/user_service.dart';

GetIt getIt = GetIt.instance;

Future<void> init() async {
  //bloc factory:
  registerBloc();
  //http local
  await registerSharedPreferences();
  bool isOK = await initApiUrl();
  if (isOK) {
    registerHttp();
  }
  //特殊情况
  registerCurrentUser();
  //local datasource
  registerLocalDataSource();
  //remote datasource
  registerRemoteDataSource();
  //repository
  registerRepository();
  //service
  registerService();
}

Future<void> registerSharedPreferences() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
}

Future<bool> initApiUrl() async {
  SharedPreferences store = getIt.get<SharedPreferences>();
  AppInfo appInfo = AppInfo(
    appVersion: "1.0",
    api: [
      Api(
        apiVersion: "1.0",
        type: "mock",
        host: "http://rap2api.taobao.org",
        prefix: "/app/mock/236828/travel/api/v1",
      ),
    ],
  );
  if (!store.containsKey("AppInfo")) {
    return await store.setString("AppInfo", json.encode(appInfo.toJson()));
  } else {
    return true;
  }
}

registerHttp() {
  getIt.registerSingleton<Dio>(Http.initHttpConfig());
}

void registerBloc() {
  getIt.registerFactory(
    () => LoginBloc(
      authorizationService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => AuthorizationBloc(
      authorizationService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => CurrentUserBloc(
      userService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => MomentPoolBloc(
      momentService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => HotTopicBloc(
      topicService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => TopicPoolBloc(
      topicService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => MomentDetailBloc(
      momentService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => QuestionPoolBloc(
      questionService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => AnswerPoolBloc(
      answerService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => QuestionDetailBloc(
      questionService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => TopicDetailBloc(
      topicService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => SpotPoolBloc(
      spotService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => SearchHistoryBloc(
      searchService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => SmsFormBloc(
      loginService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => AnswerDetailBloc(
      answerService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => ThumbupBloc(
      thumbUpService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => CollectBloc(
      collectService: getIt(),
    ),
  );
  getIt.registerFactory(
    () => CommentCoverPoolBloc(
      crService: getIt(),
    ),
  );
}

registerRepository() {
  getIt.registerLazySingleton(
    () => AuthorizationRepository(
      authorizationLocal: getIt(),
      authorizationRemote: getIt(),
      userLocal: getIt(),
      userRemote: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => MomentRepository(
      remote: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => TopicRepository(
      remote: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => QuestionRepository(
      remote: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => AnswerRepository(
      remote: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => SpotRepository(
      remote: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => SpotFilterRespository(
      remote: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => LoginRepository(
      remote: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => ThumbUpRepository(
      remote: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => CollectRepository(
      remote: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => CRRepository(
      remote: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => SearchRepository(
      local: getIt(),
    ),
  );
}

registerService() {
  getIt.registerLazySingleton(
    () => AuthorizationService(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => MomentService(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => TopicService(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => QuestionService(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => AnswerService(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => SpotService(
      spotRepo: getIt(),
      filterRepo: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => SearchService(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => LoginService(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => ThumbUpService(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => CollectService(
      repository: getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => CRService(
      repository: getIt(),
    ),
  );
}

registerRemoteDataSource() {
  getIt.registerLazySingleton(
    () => AuthorizationRemoteDataSource(http: getIt()),
  );
  getIt.registerLazySingleton(
    () => UserRemoteDataSource(http: getIt()),
  );
  getIt.registerLazySingleton(
    () => MomentRemoteDataSource(http: getIt()),
  );
  getIt.registerLazySingleton(
    () => TopicRemoteDataSource(http: getIt()),
  );
  getIt.registerLazySingleton(
    () => QuestionRemoteDataSource(http: getIt()),
  );
  getIt.registerLazySingleton(
    () => AnswerRemoteDataSource(http: getIt()),
  );
  getIt.registerLazySingleton(
    () => SpotRemoteDataSource(http: getIt()),
  );
  getIt.registerLazySingleton(
    () => SpotFilterRemoteDataSource(http: getIt()),
  );
  getIt.registerLazySingleton(
    () => LoginRemoteDataSource(http: getIt()),
  );
  getIt.registerLazySingleton(
    () => ThumbUpRemoteDatasource(http: getIt()),
  );
  getIt.registerLazySingleton(
    () => CollectRemoteDatasource(http: getIt()),
  );
  getIt.registerLazySingleton(
    () => CRRemoteDatasource(http: getIt()),
  );
}

registerLocalDataSource() {
  getIt.registerLazySingleton(
    () => AuthorizationLocalDataSource(sharedPreferences: getIt()),
  );
   getIt.registerLazySingleton(
    () => SearchLocalDataSource(sharedPreferences: getIt()),
  );
}

registerCurrentUser() {
  getIt.registerSingleton<UserLocalDataSource>(
    UserLocalDataSource(sharedPreferences: getIt()),
  );
  getIt.registerSingleton<UserRepository>(UserRepository(userLocal: getIt()));
  getIt.registerSingleton<UserService>(UserService(userRepository: getIt()));
}
