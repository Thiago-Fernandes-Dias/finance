part of 'home_screen.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).size.width * paddingFactor;
    return AspectRatio(
      aspectRatio: 5,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: const FractionallySizedBox(
          heightFactor: .75,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(
              'Portfolio',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
