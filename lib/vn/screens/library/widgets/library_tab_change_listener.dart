import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/app_storage.dart';
import '../../../models/vndb_label.dart';
import '../../../providers/vn_providers.dart';

class LibraryTabChangeListener extends ConsumerStatefulWidget {
  const LibraryTabChangeListener({
    super.key,
    required this.activeLabels,
    required this.child,
  });

  final List<VndbLabel> activeLabels;
  final Widget child;

  @override
  ConsumerState<LibraryTabChangeListener> createState() {
    return LibraryTabChangeListenerState();
  }
}

class LibraryTabChangeListenerState
    extends ConsumerState<LibraryTabChangeListener> {
  TabController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newController = DefaultTabController.of(context);

    if (_controller != newController) {
      _controller?.removeListener(_onTabChanged);
      _controller = newController;
      _controller?.addListener(_onTabChanged);
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onTabChanged);
    super.dispose();
  }

  void _onTabChanged() {
    if (_controller != null && !_controller!.indexIsChanging) {
      final index = _controller!.index;

      if (index >= 0 && index < widget.activeLabels.length) {
        final labelId = widget.activeLabels[index].id;

        AppStorage.mainBox.put('settings_last_library_label_id', labelId);
        ref.read(activeLibraryTabIdProvider.notifier).update(labelId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
