import 'package:flutter/material.dart';
import 'package:sse_showcase/widgets/standard_app_bar.dart';

class StandardHttpExampleScreen extends StatelessWidget {
  const StandardHttpExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: StandardAppBar(
        title: 'Standard HTTP Example',
      ),
      body: Center(
        child: Text('Standard HTTP Example Screen'),
      ),
    );
  }
}
