import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/book/add_book/controller/add_book_page_state_notifier.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_error.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_in_progress.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_search.dart';
import 'package:konfiso/features/book/add_book/view/widgets/add_book_success.dart';
import 'package:konfiso/shared/widgets/app/view/app.dart';
import 'package:konfiso/shared/widgets/callback.dart';

class AddBookPage extends ConsumerStatefulWidget {
  const AddBookPage({super.key});

  static const routeName = '/add-book';

  @override
  ConsumerState<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends ConsumerState<AddBookPage> with TickerProviderStateMixin, RouteAware {
  late AnimationController _spaceAnimationController;
  late Tween<double> spaceTween;
  late Animation<double> spaceAnimation;
  final searchHeight = 64;
  final spacerHeight = 20.0;

  @override
  void initState() {
    super.initState();
    _spaceAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    final spaceCurvedAnimation = CurvedAnimation(parent: _spaceAnimationController, curve: Curves.easeInOut);
    spaceTween = Tween<double>(begin: 0, end: 0);
    spaceAnimation = spaceTween.animate(spaceCurvedAnimation);
  }

  @override
  void dispose() {
    _spaceAnimationController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    super.didPush();
    Future(() {
      ref.read(addBookPageStateNotifierProvider.notifier).restoreToInitial();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void _startSpaceAnimation() {
    _spaceAnimationController.forward();
  }

  void _setBodyHeight(double bodyHeight) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        spaceTween.begin = bodyHeight / 2 - searchHeight / 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addABook),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (_, BoxConstraints boxConstraints) => Callback(
          callback: () => _setBodyHeight(boxConstraints.maxHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                AnimatedBuilder(
                    animation: spaceAnimation,
                    builder: (BuildContext context, _) => SizedBox(height: spaceAnimation.value)),
                AddBookSearch(
                  startedTyping: _startSpaceAnimation,
                ),
                SizedBox(
                  height: spacerHeight,
                ),
                Consumer(
                  builder: (_, WidgetRef ref, __) {
                    final state = ref.watch(addBookPageStateNotifierProvider);
                    return state.maybeMap(
                        inProgress: (_) => const AddBookInProgress(),
                        successful: (success) => AddBookSuccess(
                              books: success.books,
                              searchTerm: success.searchTerm,
                            ),
                        error: (_) => const AddBookError(),
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
