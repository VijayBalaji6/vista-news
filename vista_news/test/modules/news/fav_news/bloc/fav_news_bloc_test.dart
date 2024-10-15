import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vista_news/models/news/news.dart';
import 'package:vista_news/modules/news/fav_news/bloc/fav_news_bloc.dart';
import 'package:vista_news/repositories/news_repository.dart';

// Mock class for NewsRepository
class MockNewsRepository extends Mock implements NewsRepository {}

final News mockNewsData = News();
void main() {
  late MockNewsRepository mockNewsRepository;
  late FavNewsBloc favNewsBloc;

  setUp(() {
    mockNewsRepository = MockNewsRepository();
    favNewsBloc = FavNewsBloc(mockNewsRepository);
  });

  tearDown(() {
    favNewsBloc.close();
  });

  group('FavNewsBloc', () {
    test('initial state is FavNewsLoadingState', () {
      expect(favNewsBloc.state, FavNewsLoadingState());
    });

    blocTest<FavNewsBloc, FavNewsState>(
      'Test event fetch fetchFavNews is successful',
      build: () {
        when(() => mockNewsRepository.fetchFavNews('sports'))
            .thenAnswer((_) async => mockNewsData);
        when(() => mockNewsRepository.fetchFavNews('health'))
            .thenAnswer((_) async => mockNewsData);

        return favNewsBloc;
      },
      act: (bloc) => bloc.add(FetchFavNews()),
      expect: () => [
        isA<FavNewsLoadingState>(),
        isA<FavNewsLoadedState>()
            .having((state) => state.userNews, 'userNews', isA<News>()),
      ],
    );

    blocTest<FavNewsBloc, FavNewsState>(
      'Test event fetch fetchFavNews is failed',
      build: () {
        when(() => mockNewsRepository.fetchFavNews('Sports'))
            .thenThrow(Exception('Failed to fetch'));
        return favNewsBloc;
      },
      act: (bloc) => bloc.add(FetchFavNews()),
      expect: () => [
        FavNewsLoadingState(),
        const FavNewsErrorState(errorMessage: 'Failed to fetch'),
      ],
    );
  });
}
