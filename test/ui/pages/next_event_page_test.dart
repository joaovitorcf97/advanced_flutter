import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/subjects.dart';

import '../../helpers/fakes.dart';

final class NextEventViewModel {
  final List<NextEventPlayerViewModel> goalkeepers;

  const NextEventViewModel({
    this.goalkeepers = const [],
  });
}

final class NextEventPlayerViewModel {
  final String name;

  const NextEventPlayerViewModel({
    required this.name,
  });
}

final class NextEventPage extends StatefulWidget {
  final NextEventPresenter presenter;
  final String groupId;

  const NextEventPage({
    super.key,
    required this.presenter,
    required this.groupId,
  });

  @override
  State<NextEventPage> createState() => _NextEventPageState();
}

class _NextEventPageState extends State<NextEventPage> {
  @override
  void initState() {
    widget.presenter.loadNextEvent(groupId: widget.groupId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<NextEventViewModel>(
        stream: widget.presenter.nextEventStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading event'));
          }

          return ListView(
            children: [
              const Text('DENTRO - GOLEIROS'),
              Text('${snapshot.data?.goalkeepers.length ?? 0}'),
              ...snapshot.data!.goalkeepers.map(
                (player) => Text(
                  player.name,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

abstract class NextEventPresenter {
  Stream<NextEventViewModel> get nextEventStream;
  void loadNextEvent({required String groupId});
}

final class NextEventPresenterSpy implements NextEventPresenter {
  int loadCallsCount = 0;
  String? groupId;
  var nextEventSubject = BehaviorSubject<NextEventViewModel>();

  @override
  Stream<NextEventViewModel> get nextEventStream => nextEventSubject.stream;

  void emitNextEvent([NextEventViewModel? viewModel]) {
    nextEventSubject.add(viewModel ?? const NextEventViewModel());
  }

  void emitError() {
    nextEventSubject.addError(Error());
  }

  @override
  void loadNextEvent({required String groupId}) {
    loadCallsCount++;
    this.groupId = groupId;
  }
}

void main() {
  late NextEventPresenterSpy presenter;
  late String groupId;
  late Widget sut;

  setUp(() {
    presenter = NextEventPresenterSpy();
    groupId = anyString();
    sut = MaterialApp(home: NextEventPage(presenter: presenter, groupId: groupId));
  });

  testWidgets('should load event data on page init', (tester) async {
    await tester.pumpWidget(sut);
    expect(presenter.loadCallsCount, 1);
    expect(presenter.groupId, groupId);
  });

  testWidgets('should presenter spinner while data is loading', (tester) async {
    await tester.pumpWidget(sut);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should hide spinner on load success', (tester) async {
    await tester.pumpWidget(sut);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    presenter.emitNextEvent();
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('should hide spinner on load error', (tester) async {
    await tester.pumpWidget(sut);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    presenter.emitError();
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('should presenter goalkeepers section', (tester) async {
    await tester.pumpWidget(sut);
    presenter.emitNextEvent(
      NextEventViewModel(
        goalkeepers: [
          NextEventPlayerViewModel(name: 'Rodrigo'),
          NextEventPlayerViewModel(name: 'Rafel'),
          NextEventPlayerViewModel(name: 'Pedro'),
        ],
      ),
    );
    await tester.pump();
    expect(find.text('DENTRO - GOLEIROS'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('Rodrigo'), findsOneWidget);
    expect(find.text('Rafel'), findsOneWidget);
    expect(find.text('Pedro'), findsOneWidget);
  });
}
