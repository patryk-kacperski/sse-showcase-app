import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sse_showcase/features/examples/standard_http/standard_http_cubit.dart';
import 'package:sse_showcase/features/examples/standard_http/standard_http_state.dart';
import 'package:sse_showcase/services/sse_service/sse_service.dart';
import 'package:sse_showcase/widgets/standard_app_bar.dart';

class StandardHttpExampleScreen extends StatelessWidget {
  const StandardHttpExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StandardHttpCubit(
        sseService: SseService(),
      )..startStreaming(),
      child: const Scaffold(
        appBar: StandardAppBar(
          title: 'Standard HTTP Example',
        ),
        body: _StandardHttpContent(),
      ),
    );
  }
}

class _StandardHttpContent extends StatelessWidget {
  const _StandardHttpContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StandardHttpCubit, StandardHttpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _StandardHttpStateContent(state: state),
              ),
              if (state is StandardHttpCompleted)
                ElevatedButton(
                  onPressed: () {
                    context.read<StandardHttpCubit>().refreshData();
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
  final StandardHttpState state;

  const _StandardHttpStateContent({required this.state});

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      StandardHttpInitial() => const Center(
          child: Text(
            'Ready to start streaming...',
            style: TextStyle(fontSize: 18),
          ),
        ),
      StandardHttpLoading() => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Connecting to stream...',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      StandardHttpReceivingData(numbers: final numbers) => Column(
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
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.numbers),
                      title: Text(
                        'Number: ${numbers[index].value}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text('Received ${index + 1} of 10'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      StandardHttpCompleted(numbers: final numbers) => Column(
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
                  return Card(
                    child: ListTile(
                      leading:
                          const Icon(Icons.check_circle, color: Colors.green),
                      title: Text(
                        'Number: ${numbers[index].value}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      StandardHttpError(message: final message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                color: Colors.red,
                size: 64,
              ),
              const SizedBox(height: 16),
              const Text(
                'Error occurred:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
                  context.read<StandardHttpCubit>().refreshData();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
    };
  }
}
