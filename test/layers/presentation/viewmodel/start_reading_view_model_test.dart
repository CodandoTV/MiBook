import 'package:flutter_test/flutter_test.dart';
import 'package:mibook/core/utils/strings.dart';
import 'package:mibook/layers/domain/usecases/start_reading.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_ui.dart';
import 'package:mibook/layers/presentation/screens/startreading/start_reading_event.dart';
import 'package:mibook/layers/presentation/screens/startreading/start_reading_state.dart';
import 'package:mibook/layers/presentation/screens/startreading/start_reading_view_model.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<IStartReading>()])
import 'start_reading_view_model_test.mocks.dart';

void main() {
  late MockIStartReading startReading;
  late StartReadingViewModel sut;
  final fakeBook = BookDetailsUI(
    id: 'id',
    kind: 'kind',
    title: 'title',
    authors: 'authors',
    description: 'description',
    thumbnail: 'thumbnail',
    pageCount: 100,
  );

  setUp() {
    startReading = MockIStartReading();
    sut = StartReadingViewModel(startReading, fakeBook);
  }

  group('test StartReadingViewModel', () {
    setUp();
    test(
      'given progress > 1.0, when add didEditProgressEvent, should state have input error message',
      () async {
        sut.add(DidEditProgressEvent(progress: 200));

        await expectLater(
          sut.stream,
          emits(
            predicate<StartReadingState>(
              (state) =>
                  state.inputErrorMessage == progressErrorMessage &&
                  state.progress == 0.0,
            ),
          ),
        );
      },
    );

    test(
      'given progress <= 1.0, when add didEditProgressEvent, should state have progress',
      () async {
        sut.add(DidEditProgressEvent(progress: 50));

        await expectLater(
          sut.stream,
          emits(
            predicate<StartReadingState>(
              (state) =>
                  state.inputErrorMessage == null && state.progress == 0.5,
            ),
          ),
        );
      },
    );

    test(
      'didClickConfirmEvent',
      () async {
        sut.emit(
          StartReadingState(
            inputErrorMessage: null,
            progress: 0.5,
            shouldNavigateBack: false,
          ),
        );

        sut.add(DidClickConfirmEvent());

        await expectLater(
          sut.stream,
          emits(
            predicate<StartReadingState>(
              (state) => state.shouldNavigateBack,
            ),
          ),
        );
      },
    );

    test(
      'didFinishBookEvent',
      () async {
        sut.emit(
          StartReadingState(
            inputErrorMessage: null,
            progress: 0.5,
            shouldNavigateBack: false,
          ),
        );

        sut.add(DidClickFinishBookEvent());

        await expectLater(
          sut.stream,
          emits(
            predicate<StartReadingState>(
              (state) => state.shouldNavigateBack,
            ),
          ),
        );
      },
    );
  });
}
