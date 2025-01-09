import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopdicator/features/graph/presentation/bloc/orders_bloc.dart';

import 'metrics_page.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({super.key});

  void _navigateToMetrics(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const MetricsPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
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
      body: BlocConsumer<OrdersBloc, OrdersState>(
        bloc: OrdersBloc.get(context)..add(GetOrdersEvent()),
        listener: (context, state) {
          if (state.isLoaded) {
            OrdersBloc.get(context).add(GetGraphPoints());
          } else if (state.isError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? 'Something went wrong')),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0 + MediaQuery.of(context).viewInsets.top,
                      ),
                      child: LineChart(
                        LineChartData(
                          minY: 0,
                          minX: 1,
                          backgroundColor: Colors.white,
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: true,
                            verticalInterval: 1,
                            horizontalInterval: 1,
                            getDrawingHorizontalLine: (value) => const FlLine(
                              color: Colors.grey,
                              strokeWidth: 1,
                            ),
                            getDrawingVerticalLine: (value) => const FlLine(
                              color: Colors.grey,
                              strokeWidth: 1,
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: state.getSpots(),
                              isCurved: true,
                              color: Colors.deepPurple,
                              barWidth: 4,
                              dotData: const FlDotData(show: true),
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.deepPurple.withOpacity(0.3),
                                    Colors.transparent
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ],
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 70,
                                getTitlesWidget: (value, meta) {
                                  if (value.toInt() == value) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: RotatedBox(
                                        quarterTurns: 3,
                                        child: Text(
                                          state.getMonthName(value.toInt()),
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                interval: 1,
                                showTitles: true,
                                reservedSize: 35,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: const Border(
                              bottom: BorderSide(color: Colors.black, width: 1),
                              left: BorderSide(color: Colors.black, width: 1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _navigateToMetrics(context);
                  },
                  onVerticalDragUpdate: (details) {
                    if (details.primaryDelta! < -10) {
                      _navigateToMetrics(context);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 10.0 + MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: SizedBox(
                      height: 100,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.keyboard_arrow_up, size: 50, color: Theme.of(context).primaryColor),
                            const SizedBox(height: 8),
                            Text(
                              'Swipe up to view metrics',
                              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
