import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sse_showcase/features/examples/wikimedia/wikimedia_cubit.dart';
import 'package:sse_showcase/features/examples/wikimedia/wikimedia_state.dart';
import 'package:sse_showcase/services/sse_service/sse_service.dart';
import 'package:sse_showcase/widgets/standard_app_bar.dart';
import 'package:sse_showcase/widgets/standard_list_tile.dart';
import 'package:sse_showcase/widgets/standard_titled_list_view.dart';

class WikimediaScreen extends StatelessWidget {
  const WikimediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WikimediaCubit(sseService: context.read<SseService>())
            ..startStreaming(),
      child: const Scaffold(
        appBar: StandardAppBar(title: 'Wikimedia Recent Changes'),
        body: SafeArea(child: _WikimediaContent()),
      ),
    );
  }
}

class _WikimediaContent extends StatelessWidget {
  const _WikimediaContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WikimediaCubit, WikimediaState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _WikimediaStateContent(state: state),
              ),
            ),
            _WikimediaControlButton(state: state),
          ],
        );
      },
    );
  }
}

class _WikimediaStateContent extends StatelessWidget {
  const _WikimediaStateContent({required this.state});

  final WikimediaState state;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      WikimediaInitial() => const Center(
        child: Text(
          'Ready to start streaming...',
          style: TextStyle(fontSize: 18),
        ),
      ),
      WikimediaReceivingData(events: final events) =>
        events.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text(
                      'Waiting for events...',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              )
            : StandardTitledListView(
                title: 'Recent Changes (${events.length}):',
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return StandardListTile(
                    title: Text(
                      _formatChangeMessage(event),
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                },
              ),
      WikimediaStopped(events: final events) => StandardTitledListView(
        title: 'Recent Changes (${events.length}) - Stopped:',
        titleStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.orange,
        ),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return StandardListTile(
            title: Text(
              _formatChangeMessage(event),
              style: const TextStyle(fontSize: 14),
            ),
          );
        },
      ),
      WikimediaError(message: final message) => Center(
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
                context.read<WikimediaCubit>().restartStreaming();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    };
  }

  String _formatChangeMessage(dynamic event) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(
      event.timestamp * 1000,
    );
    final formattedDate = DateFormat('MMM d, yyyy HH:mm:ss').format(dateTime);

    return 'User ${event.user} made an edit on the article ${event.title} on $formattedDate with comment "${event.comment}"';
  }
}

class _WikimediaControlButton extends StatelessWidget {
  const _WikimediaControlButton({required this.state});

  final WikimediaState state;

  @override
  Widget build(BuildContext context) {
    final isStreaming = state is WikimediaReceivingData;
    final isStopped = state is WikimediaStopped;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isStreaming || isStopped
            ? () {
                if (isStreaming) {
                  context.read<WikimediaCubit>().stopStreaming();
                } else {
                  context.read<WikimediaCubit>().restartStreaming();
                }
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isStreaming ? Colors.red : Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          isStreaming ? 'Stop Streaming' : 'Restart Streaming',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
