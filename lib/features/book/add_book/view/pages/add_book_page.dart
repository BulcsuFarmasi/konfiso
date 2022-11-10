import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_page_state_notifier.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_state.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_in_progress.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_search.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_success.dart';
import 'package:konfiso/shared/widgets/callback.dart';

class AddBookPage extends ConsumerStatefulWidget {
  const AddBookPage({super.key});

  static const routeName = '/add-book';

  @override
  ConsumerState<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends ConsumerState<AddBookPage>
    with TickerProviderStateMixin {
  late AnimationController spaceAnimationController;
  late Tween<double> spaceTween;
  late Animation<double> spaceAnimation;
  late AnimationController heightAnimationController;
  late Tween<double> heightTween;
  late Animation<double> heightAnimation;
  final searchHeight = 64;
  final spacerHeight = 20.0;

  @override
  void initState() {
    super.initState();
    spaceAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    heightAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    final spaceCurvedAnimation = CurvedAnimation(
        parent: spaceAnimationController, curve: Curves.easeInOut);
    final heightCurvedAnimation = CurvedAnimation(
        parent: heightAnimationController, curve: Curves.easeInOut);
    spaceTween = Tween<double>(begin: 0, end: 0);
    spaceAnimation = spaceTween.animate(spaceCurvedAnimation);
    heightTween = Tween<double>(begin: 0, end: 0);
    heightAnimation = heightTween.animate(heightCurvedAnimation);
  }

  void _startSpaceAnimation() {
    spaceAnimationController.forward();
  }

  void _startHeightAnimation() {
    heightAnimationController.forward();
  }

  void _setPageHeight(double bodyHeight) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        spaceTween.begin = bodyHeight / 2 - searchHeight / 2;
        heightTween.end = bodyHeight - searchHeight - spacerHeight;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen(addBookPageStateNotifierProvider, (_, AddBookPageState next) {
    //   next.maybeMap(
    //       successful: (_) {
    //         heightAnimationController.forward();
    //       },
    //       orElse: () => null);
    // });
    return Scaffold(
      appBar: AppBar(
        title: Text(Intl.message('Add a Book')),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (_, BoxConstraints boxConstraints) => Callback(
          callback: () => _setPageHeight(boxConstraints.maxHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                AnimatedBuilder(
                    animation: spaceAnimation,
                    builder: (BuildContext context, _) =>
                        SizedBox(height: spaceAnimation.value)),
                AddBookSearch(
                  startedTyping: _startSpaceAnimation,
                  keyBoardDisappeared: _startHeightAnimation,
                ),
                SizedBox(
                  height: spacerHeight,
                ),
                Consumer(
                  builder: (_, WidgetRef ref, __) {
                    final state = ref.watch(addBookPageStateNotifierProvider);
                    return state.maybeMap(
                        inProgress: (_) => const AddBookInProgress(),
                        successful: (success) => SizedBox(
                              height: heightAnimation.value,
                              child: AddBookSuccess(
                                books: success.books,
                              ),
                            ),
                        error: (_) => Container(),
                        orElse: () => Container());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
