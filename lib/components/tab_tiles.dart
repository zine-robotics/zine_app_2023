import 'package:flutter/cupertino.dart';

class WhiteTabTile extends StatelessWidget {

  final String label;

  const WhiteTabTile({required this.label,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class BlueTabTile extends StatelessWidget {

  final String label;

  const BlueTabTile({required this.label,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}



