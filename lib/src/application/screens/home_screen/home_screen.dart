import 'package:finance/gen/assets.gen.dart';
import 'package:finance/src/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part 'menu.dart';
part 'app_title.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _signedIn = false;

  @override
  void initState() {
    super.initState();
    final userRepository = ref.read(userRepositoryProvider);
    _signedIn = userRepository.signedIn;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_signedIn) {
        context.go('sign-in');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.grey.shade800),
        elevation: 0.5,
        centerTitle: true,
        title: const AppTitle(),
      ),
      drawer: const Drawer(child: Menu()),
      body: _signedIn ? Container() : const Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
