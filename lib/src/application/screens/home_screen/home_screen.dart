import 'package:finance/gen/assets.gen.dart';
import 'package:finance/src/models/user_info.dart';
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
    final userRepository = ref.watch(userRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.grey.shade800),
        elevation: 0.5,
        centerTitle: true,
        title: const AppTitle(),
      ),
      drawer: const Drawer(child: Menu()),
      body: _signedIn
          ? Center(
              child: StreamBuilder<UserInfo>(
                stream: userRepository.userInfoStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.hasData) {
                    final userInfo = snapshot.data!;
                    return Text(userInfo.toString());
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            )
          : const Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
