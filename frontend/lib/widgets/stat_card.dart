import 'package:flutter/material.dart';
import 'dart:math' as math;

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtext;
  final IconData icon;
  final double progress;
  final bool isWaterCard;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtext,
    required this.icon,
    required this.progress,
    this.isWaterCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFD6F5F0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: Colors.black),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          isWaterCard
              ? Column(
                  children: [
                    const Icon(Icons.water_drop, size: 40, color: Colors.white),
                    Text(value, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(subtext, style: const TextStyle(fontSize: 12)),
                  ],
                )
              : SizedBox(
                  height: 60,
                  width: 60,
                  child: CustomPaint(
                    painter: _HalfCirclePainter(progress),
                    child: Center(
                      child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
          if (!isWaterCard)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                subtext,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
        ],
      ),
    );
  }
}

class _HalfCirclePainter extends CustomPainter {
  final double progress;
  const _HalfCirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const startAngle = math.pi;
    const sweepAngle = math.pi;

    canvas.drawArc(rect, startAngle, sweepAngle, false, backgroundPaint);
    canvas.drawArc(rect, startAngle, sweepAngle * progress, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
