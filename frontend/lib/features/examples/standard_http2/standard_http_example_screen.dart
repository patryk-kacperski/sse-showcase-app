import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sse_showcase/features/examples/standard_http2/standard_http_example_cubit.dart';
import 'package:sse_showcase/features/examples/standard_http2/standard_http_example_state.dart';
import 'package:sse_showcase/services/sse_service/sse_service.dart';
import 'package:sse_showcase/widgets/standard_app_bar.dart';
import 'package:sse_showcase/widgets/standard_list_tile.dart';
import 'package:sse_showcase/widgets/standard_titled_list_view.dart';

class StandardHttpExampleScreen2 extends StatelessWidget {
  const StandardHttpExampleScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StandardHttpExampleCubit2(sseService: context.read<SseService>())
            ..startStreaming(),
      child: const Scaffold(
        appBar: StandardAppBar(title: 'Standard HTTP Example'),
        body: SafeArea(child: _StandardHttpContent()),
      ),
    );
  }
}

class _StandardHttpContent extends StatelessWidget {
  const _StandardHttpContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StandardHttpExampleCubit2, StandardHttpExampleState2>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _StandardHttpStateContent(state: state)),
              if (state is StandardHttpExampleCompleted)
                ElevatedButton(
                  onPressed: () {
                    context.read<StandardHttpExampleCubit2>().refreshData();
                  },
                  child: const Text('Refresh'),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _StandardHttpStateContent extends StatelessWidget {
  const _StandardHttpStateContent({required this.state});

  final StandardHttpExampleState2 state;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      StandardHttpExampleInitial() => const Center(
        child: Text(
          'Ready to start streaming...',
          style: TextStyle(fontSize: 18),
        ),
      ),
      StandardHttpExampleLoading() => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Connecting to stream...', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
      StandardHttpExampleReceivingData(numbers: final numbers) =>
        StandardTitledListView(
          title: 'Streaming Numbers:',
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return StandardListTile(
              leading: const Icon(Icons.numbers),
              title: Text(
                'Number: ${numbers[index]}',
                style: const TextStyle(fontSize: 18),
              ),
            );
          },
        ),
      StandardHttpExampleCompleted(numbers: final numbers) =>
        StandardTitledListView(
          title: 'Streaming Completed!',
          titleStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return StandardListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: Text(
                'Number: ${numbers[index]}',
                style: const TextStyle(fontSize: 18),
              ),
            );
          },
        ),
      StandardHttpExampleError(message: final message) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 64),
            const SizedBox(height: 16),
            const Text(
              'Error occurred:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<StandardHttpExampleCubit2>().refreshData();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    };
  }
}
