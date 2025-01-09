import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopdicator/features/graph/presentation/bloc/orders_bloc.dart';
import 'package:shopdicator/features/graph/presentation/pages/graph_page.dart';

part '../widgets/animated_box_widget.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToGraphPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const GraphPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, -1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            _navigateToGraphPage(context);
          }
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.0 + MediaQuery.of(context).viewInsets.top),
              child: GestureDetector(
                onTap: () {
                  _navigateToGraphPage(context);
                },
                child: SizedBox(
                  height: 100,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.keyboard_arrow_down, size: 50, color: Theme.of(context).primaryColor),
                        const SizedBox(height: 8),
                        Text(
                          'Swipe down to view detailed chart',
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<OrdersBloc, OrdersState>(
                builder: (context, state) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                      double aspectRatio = constraints.maxWidth > 600 ? 1.5 : 1.0;

                      List<Widget> statsWidgets = [
                        AnimatedBoxWidget(
                          title: 'Count',
                          animation: _animation,
                          value: state.orders?.length.toString() ?? '',
                          index: 0,
                        ),
                        AnimatedBoxWidget(
                          title: 'Total price',
                          animation: _animation,
                          value: OrdersBloc.get(context).getTotalPrice().toString(),
                          index: 1,
                        ),
                        AnimatedBoxWidget(
                          title: 'Avg price',
                          animation: _animation,
                          value: OrdersBloc.get(context).getAveragePrice().toString(),
                          index: 2,
                        ),
                        AnimatedBoxWidget(
                          title: 'Total returns',
                          animation: _animation,
                          value: OrdersBloc.get(context).getTotalReturns().toString(),
                          index: 3,
                        ),
                      ];

                      return GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: aspectRatio,
                        padding: const EdgeInsets.all(16.0),
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        children: statsWidgets,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
