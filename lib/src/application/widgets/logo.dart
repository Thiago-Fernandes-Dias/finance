part of 'widgets.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 40,
        ),
        children: [
          TextSpan(text: 'C', style: TextStyle(color: Colors.blue)),
          TextSpan(text: '\$', style: TextStyle(color: Colors.red)),
          TextSpan(text: '5', style: TextStyle(color: Colors.yellow)),
          TextSpan(text: '0', style: TextStyle(color: Colors.green)),
          TextSpan(text: ' ', style: TextStyle(color: Colors.green)),
          TextSpan(text: 'Finance', style: TextStyle(color: Colors.red)),
        ]
      ),
    );
  }
}