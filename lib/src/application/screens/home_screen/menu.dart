part of 'home_screen.dart';

class Menu extends ConsumerWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 3,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Padding(
                  padding: EdgeInsets.all(constraints.maxHeight * .15),
                  child: Row(
                    children: [
                      const AspectRatio(aspectRatio: .2),
                      Assets.png.harvardLogo.image(fit: BoxFit.fitHeight),
                      const AspectRatio(aspectRatio: .2),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Expanded(child: FittedBox(child: Text('This is'))),
                            AspectRatio(aspectRatio: 100),
                            Expanded(child: FittedBox(child: Text('CS50')))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const AspectRatio(aspectRatio: 9),
          ListTile(
            title: const Text('Quote'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Buy'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Sell'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('History'),
            onTap: () {},
          ),
          const Spacer(),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              final userRepository = ref.read(userRepositoryProvider);
              userRepository.logout();
              context.go('/sign-in');
            },
          ),
        ],
      ),
    );
  }
}
