import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sse_showcase/features/examples/shapes_and_colors/shapes_and_colors_cubit.dart';
import 'package:sse_showcase/features/examples/shapes_and_colors/shapes_and_colors_state.dart';
import 'package:sse_showcase/features/examples/shapes_and_colors/shape_painter.dart';
import 'package:sse_showcase/services/sse_service/sse_service.dart';
import 'package:sse_showcase/widgets/standard_app_bar.dart';

class ShapesAndColorsScreen extends StatelessWidget {
  const ShapesAndColorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShapesAndColorsCubit(sseService: context.read<SseService>())
            ..startStreaming(),
      child: const Scaffold(
        appBar: StandardAppBar(title: 'Shapes and Colors'),
        body: SafeArea(child: _ShapesAndColorsContent()),
      ),
    );
  }
}

class _ShapesAndColorsContent extends StatelessWidget {
  const _ShapesAndColorsContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShapesAndColorsCubit, ShapesAndColorsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _ShapesAndColorsStateContent(state: state)),
            ],
          ),
        );
      },
    );
  }
}

class _ShapesAndColorsStateContent extends StatelessWidget {
  const _ShapesAndColorsStateContent({required this.state});

  final ShapesAndColorsState state;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      ShapesAndColorsInitial() => const Center(
        child: Text(
          'Ready to start streaming...',
          style: TextStyle(fontSize: 18),
        ),
      ),
      ShapesAndColorsLoading() => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Connecting to stream...', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
      ShapesAndColorsReceivingData(
        shape: final shape,
        size: final size,
        color: final color,
      ) =>
        Center(
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 400),
            tween: Tween<double>(end: size.toDouble()),
            builder: (context, animatedSize, child) {
              return TweenAnimationBuilder<Color?>(
                duration: const Duration(milliseconds: 400),
                tween: ColorTween(end: color),
                builder: (context, animatedColor, child) {
                  return SizedBox(
                    width: animatedSize,
                    height: animatedSize,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      },
                      child: CustomPaint(
                        key: ValueKey(shape),
                        painter: ShapePainter(
                          shape: shape,
                          size: animatedSize,
                          color: animatedColor ?? color,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ShapesAndColorsError(message: final message) => Center(
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
                context.read<ShapesAndColorsCubit>().refreshData();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    };
  }
}
