import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme/app_theme.dart';
import '../../../models/visual_novel.dart';
import '../../../providers/vn_providers.dart';

Future<void> showVnLabelsSheet(
  BuildContext context,
  VisualNovel vn,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return VnDetailLabelsSheet(vn: vn);
    },
  );
}

class VnDetailLabelsSheet extends ConsumerStatefulWidget {
  const VnDetailLabelsSheet({
    super.key,
    required this.vn,
  });

  final VisualNovel vn;

  @override
  ConsumerState<VnDetailLabelsSheet> createState() {
    return VnDetailLabelsSheetState();
  }
}

class VnDetailLabelsSheetState extends ConsumerState<VnDetailLabelsSheet> {
  List<int>? tempLabels;

  void _ensureTempLabels(VnUlistState ulistState) {
    if (tempLabels != null) {
      return;
    }

    if (ulistState.entry != null) {
      tempLabels = List<int>.from(ulistState.entry!.labels);
    } else if (!ulistState.isLoading) {
      tempLabels = <int>[];
    }
  }

  void _save(VnUlistState ulistState) {
    if (tempLabels != null) {
      final originalLabels = ulistState.entry?.labels ?? const <int>[];
      final hasChanged =
          originalLabels.length != tempLabels!.length ||
          !originalLabels.every(tempLabels!.contains);

      if (hasChanged) {
        ref
            .read(userUlistProvider.notifier)
            .updateLabels(widget.vn.id, tempLabels!, vn: widget.vn);
      }
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final labelsAsync = ref.watch(ulistLabelsProvider);
    final ulistState = ref.watch(vnUlistProvider(widget.vn.id));
    final theme = Theme.of(context);

    _ensureTempLabels(ulistState);

    final currentSelected = tempLabels ?? const <int>[];

    return Material(
      color: context.appBackground,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.only(
          top: 16.0,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: context.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'My Labels',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Flexible(
              child: labelsAsync.when(
                data: (allLabels) {
                  final filteredLabels = allLabels
                      .where((label) {
                        return label.label != null && label.label!.isNotEmpty;
                      })
                      .where((label) => label.id != 0 && label.id != 7)
                      .where((label) {
                        final lowerLabel = label.label!.toLowerCase();

                        return lowerLabel != 'no label' &&
                            lowerLabel != 'voted';
                      })
                      .toList();

                  if (filteredLabels.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 32.0,
                        horizontal: 20.0,
                      ),
                      child: Text(
                        'No labels found.',
                        style: TextStyle(color: context.appTextMuted),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredLabels.length,
                    itemBuilder: (context, index) {
                      final label = filteredLabels[index];
                      final isSelected = currentSelected.contains(label.id);

                      return CheckboxListTile(
                        activeColor: context.appAccentTeal,
                        checkColor: context.colorScheme.onPrimary,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        title: Text(
                          label.label ?? '',
                          style: TextStyle(
                            color: context.appTextPrimary,
                            fontSize: 15,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        value: isSelected,
                        onChanged: (val) {
                          HapticFeedback.lightImpact();

                          setState(() {
                            if (val == true) {
                              tempLabels!.add(label.id);
                            } else {
                              tempLabels!.remove(label.id);
                            }
                          });
                        },
                      );
                    },
                  );
                },
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (err, stack) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 32.0,
                    horizontal: 20.0,
                  ),
                  child: Text(
                    'Failed to load labels: $err',
                    style: TextStyle(
                      color: context.colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appAccentTeal,
                  foregroundColor: context.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  elevation: 0,
                ),
                onPressed: () => _save(ulistState),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
