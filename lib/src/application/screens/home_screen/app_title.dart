part of 'home_screen.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'C',
        style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.red, fontSize: 18),
        children: [
          const TextSpan(text: '\$', style: TextStyle(color: Colors.yellow)),
          const TextSpan(text: '5', style: TextStyle(color: Colors.blue)),
          const TextSpan(text: '0', style: TextStyle(color: Colors.green)),
          TextSpan(text: ' Finance', style: TextStyle(color: Colors.grey.shade800))
        ],
      ),
    );
  }
}
