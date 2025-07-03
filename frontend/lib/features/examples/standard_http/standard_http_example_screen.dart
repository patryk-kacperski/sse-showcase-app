import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sse_showcase/features/examples/standard_http/standard_http_example_cubit.dart';
import 'package:sse_showcase/features/examples/standard_http/standard_http_example_state.dart';
import 'package:sse_showcase/services/sse_service/sse_service.dart';
import 'package:sse_showcase/widgets/standard_app_bar.dart';
import 'package:sse_showcase/widgets/standard_list_tile.dart';

class StandardHttpExampleScreen extends StatelessWidget {
  const StandardHttpExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StandardHttpExampleCubit(sseService: SseService())..startStreaming(),
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
    return BlocBuilder<StandardHttpExampleCubit, StandardHttpExampleState>(
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
                    context.read<StandardHttpExampleCubit>().refreshData();
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

  final StandardHttpExampleState state;

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
      StandardHttpExampleReceivingData(numbers: final numbers) => Column(
        children: [
          const Text(
            'Streaming Numbers:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: numbers.length,
              itemBuilder: (context, index) {
                return StandardListTile(
                  leading: const Icon(Icons.numbers),
                  title: Text(
                    'Number: ${numbers[index].value}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  subtitle: Text('Received ${index + 1} of 10'),
                );
              },
            ),
          ),
        ],
      ),
      StandardHttpExampleCompleted(numbers: final numbers) => Column(
        children: [
          const Text(
            'Streaming Completed!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: numbers.length,
              itemBuilder: (context, index) {
                return StandardListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text(
                    'Number: ${numbers[index].value}',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ),
        ],
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
                context.read<StandardHttpExampleCubit>().refreshData();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    };
  }
}
