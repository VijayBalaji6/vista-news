import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vista_news/modules/news/saved_news/bloc/saved_news_bloc.dart';
import 'package:vista_news/repositories/news_db_repository.dart';

class MockNewsDbRepository extends Mock implements NewsDbRepository {}

void main() {
  group('SavedNewsBloc', () {
    late SavedNewsBloc savedNewsBloc;
    late MockNewsDbRepository mockNewsDbRepository;

    setUp(() {
      mockNewsDbRepository = MockNewsDbRepository();
      savedNewsBloc = SavedNewsBloc(mockNewsDbRepository);
    });

    test('initial state is SavedNewsLoadingState', () {
      expect(savedNewsBloc.state, equals(SavedNewsLoadingState()));
    });

    blocTest<SavedNewsBloc, SavedNewsState>(
      'Test event fetching saved news is successful',
      build: () {
        when(() => mockNewsDbRepository.getAllSavedNews())
            .thenAnswer((_) async => []);

        return SavedNewsBloc(mockNewsDbRepository);
      },
      act: (bloc) => bloc.add(FetchSavedNews()),
      expect: () => [
        SavedNewsLoadingState(),
        const SavedNewsLoadedState(newsArticles: []),
      ],
    );

    blocTest<SavedNewsBloc, SavedNewsState>(
      'Test event fetching saved news fails',
      build: () {
        when(() => mockNewsDbRepository.getAllSavedNews())
            .thenThrow(Exception('Failed to fetch news'));

        return SavedNewsBloc(mockNewsDbRepository);
      },
      act: (bloc) => bloc.add(FetchSavedNews()),
      expect: () => [
        SavedNewsLoadingState(),
        const SavedNewsErrorState(
            errorMessage: 'Exception: Failed to fetch news'),
      ],
    );
  });
}
