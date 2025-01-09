part of '../pages/metrics_page.dart';

class AnimatedBoxWidget extends StatelessWidget {
  final String title, value;
  final int index;
  final Animation<double> animation;

  const AnimatedBoxWidget({
    super.key,
    required this.animation,
    required this.value,
    required this.title,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.orange.shade400,
      Colors.teal.shade400,
      Colors.pink.shade400,
      Colors.blue.shade400,
    ];
    final darkColors = [
      Colors.orange.shade800,
      Colors.teal.shade800,
      Colors.pink.shade800,
      Colors.blue.shade800,
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        double padding = constraints.maxWidth > 600 ? 24.0 : 16.0;
        double fontSize = constraints.maxWidth > 600 ? 20.0 : 18.0;

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, (1 - animation.value) * -100),
              child: AnimatedOpacity(
                opacity: animation.value,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [colors[index], darkColors[index]],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
