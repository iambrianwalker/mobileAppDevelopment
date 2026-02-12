import 'package:flutter/material.dart';

void main() => runApp(const ValentineApp());

class ValentineApp extends StatelessWidget {
  const ValentineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ValentineHome(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}

class ValentineHome extends StatefulWidget {
  const ValentineHome({super.key});

  @override
  State<ValentineHome> createState() => _ValentineHomeState();
}

class _ValentineHomeState extends State<ValentineHome>with SingleTickerProviderStateMixin{
  final List<String> emojiOptions = ['Sweet Heart', 'Party Heart'];
  String selectedEmoji = 'Sweet Heart';
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scale = Tween(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cupid\'s Canvas')),
      body: 
      Column(
        children: [
          const SizedBox(height: 16),
          DropdownButton<String>(
            value: selectedEmoji,
            items: emojiOptions
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {
              setState(() => selectedEmoji = value ?? selectedEmoji);
            _controller.forward().then((_) => _controller.reverse());
            }
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: ScaleTransition(
                scale: _scale,
                child:CustomPaint(
                    size: const Size(300, 300),
                    painter: HeartEmojiPainter(type: selectedEmoji),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () {
              _controller.forward().then((_) => _controller.reverse());
            },
            child: const Text('Pulse ❤️'),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class HeartEmojiPainter extends CustomPainter {
  HeartEmojiPainter({required this.type});
  final String type;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..style = PaintingStyle.fill;

    // Heart base
    final heartPath = Path()
      ..moveTo(center.dx, center.dy + 60)
      ..cubicTo(center.dx + 110, center.dy - 10, center.dx + 60, center.dy - 120, center.dx, center.dy - 40)
      ..cubicTo(center.dx - 60, center.dy - 120, center.dx - 110, center.dy - 10, center.dx, center.dy + 60)
      ..close();

    paint.color = type == 'Party Heart' ? const Color(0xFFF48FB1) : const Color(0xFFE91E63);
    canvas.drawPath(heartPath, paint);

    // Face features (starter)
    final eyePaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(center.dx - 10, center.dy - 30), 20, eyePaint);
    canvas.drawCircle(Offset(center.dx + 10, center.dy - 30), 20, eyePaint);
    
    final iris = Paint()..color = Colors.red;
    canvas.drawCircle(Offset(center.dx + 10,center.dy - 30), 5, iris);
    canvas.drawCircle(Offset(center.dx - 10, center.dy - 30), 5, iris);

    final mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawArc(Rect.fromCircle(center: Offset(center.dx, center.dy + 20), radius: 30), 0, 3.14, false, mouthPaint);

    // Party hat placeholder (expand for confetti)
    if (type == 'Party Heart') {
      final hatPaint = Paint()..color = const Color(0xFFFFD54F);
      final hatPath = Path()
        ..moveTo(center.dx, center.dy - 110)
        ..lineTo(center.dx - 40, center.dy - 40)
        ..lineTo(center.dx + 40, center.dy - 40)
        ..close();
      canvas.drawPath(hatPath, hatPaint);

      final con1 = Paint()..color = Colors.blue;
      final con2 = Paint()..color = Colors.red;
      final con3 = Paint()..color = Colors.purple;
      
      final confettiData = [
        {'offset': Offset(center.dx - 50, center.dy - 80), 'size': 8.0, 'paint': con1, 'shape': 'rect'},
        {'offset': Offset(center.dx + 40, center.dy - 70), 'size': 10.0, 'paint': con2, 'shape': 'circle'},
        {'offset': Offset(center.dx - 30, center.dy - 50), 'size': 6.0, 'paint': con3, 'shape': 'rect'},
        {'offset': Offset(center.dx + 20, center.dy - 40), 'size': 12.0, 'paint': con1, 'shape': 'circle'},
        {'offset': Offset(center.dx, center.dy - 60), 'size': 7.0, 'paint': con2, 'shape': 'rect'},
      ];

      for(var piece in confettiData){
        final offset = piece['offset'] as Offset;
        final size = piece['size'] as double;
        final paint = piece['paint'] as Paint;
        final shape = piece['shape'] as String;

        if(shape == 'circle'){
          canvas.drawCircle(offset, size / 2, paint);
        } else {
          canvas.drawRect(Rect.fromCenter(center: offset, width: size, height: size/2), paint);
        }
      }

      
    }
  }

  @override
  bool shouldRepaint(covariant HeartEmojiPainter oldDelegate) => oldDelegate.type != type;
}