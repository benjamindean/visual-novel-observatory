import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeDoubleTapNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void increment() {
    state = state + 1;
  }
}

final homeDoubleTapProvider = NotifierProvider<HomeDoubleTapNotifier, int>(
  HomeDoubleTapNotifier.new,
);

class SearchDoubleTapNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void increment() {
    state = state + 1;
  }
}

final searchDoubleTapProvider = NotifierProvider<SearchDoubleTapNotifier, int>(
  SearchDoubleTapNotifier.new,
);

class LibraryDoubleTapNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void increment() {
    state = state + 1;
  }
}

final libraryDoubleTapProvider =
    NotifierProvider<LibraryDoubleTapNotifier, int>(
      LibraryDoubleTapNotifier.new,
    );

class ActiveLibraryTabIdNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void update(int? val) {
    state = val;
  }
}

final activeLibraryTabIdProvider =
    NotifierProvider<ActiveLibraryTabIdNotifier, int?>(
      ActiveLibraryTabIdNotifier.new,
    );
