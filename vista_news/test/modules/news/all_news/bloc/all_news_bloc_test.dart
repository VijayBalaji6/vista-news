import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vista_news/models/news/news.dart';
import 'package:vista_news/modules/news/all_news/bloc/all_news_bloc.dart';
import 'package:vista_news/repositories/news_repository.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

final News mockNewsData = News();
void main() {
  late MockNewsRepository mockNewsRepository;
  late AllNewsBloc allNewsBloc;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    allNewsBloc = AllNewsBloc(mockNewsRepository);
  });

  tearDown(() {
    allNewsBloc.close();
  });

  group('FavNewsBloc', () {
    test('initial state is FavNewsLoadingState', () {
      expect(allNewsBloc.state, AllNewsLoadingState());
    });

    blocTest<AllNewsBloc, AllNewsState>(
      'Test event fetch all news is successful',
      build: () {
        when(() => mockNewsRepository.fetchAllNews())
            .thenAnswer((_) async => mockNewsData);

        return allNewsBloc;
      },
      act: (bloc) => bloc.add(FetchAllNews()),
      expect: () => [
        isA<AllNewsLoadingState>(),
        isA<AllNewsLoadedState>()
            .having((state) => state.userNews, 'userNews', isA<News>()),
      ],
    );

    blocTest<AllNewsBloc, AllNewsState>(
      'Test event fetch All news is failed',
      build: () {
        when(() => mockNewsRepository.fetchAllNews())
            .thenThrow(Exception('Failed to fetch'));
        return allNewsBloc;
      },
      act: (bloc) => bloc.add(FetchAllNews()),
      expect: () => [
        AllNewsLoadingState(),
        const AllNewsErrorState(errorMessage: 'Failed to fetch'),
      ],
    );
  });
}
