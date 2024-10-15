import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({super.key});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  // Load ảnh từ asset
  Future<void> _loadImage() async {
    final ByteData data = await rootBundle.load('assets/images/neu.png');
    final ui.Codec codec =
        await ui.instantiateImageCodec(data.buffer.asUint8List());
    final ui.FrameInfo fi = await codec.getNextFrame();
    setState(() {
      _image = fi.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: (_image == null)
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.all(10),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: const Color.fromARGB(255, 255, 202, 202)),
                  child: CustomPaint(
                    size: Size(double.infinity, 600),
                    painter: RPSCustomPainter(_image!),
                  ),
                ),
              ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  final ui.Image backgroundImage;
  RPSCustomPainter(this.backgroundImage);
  @override
  void paint(Canvas canvas, Size size) {
    // Tính toán tỷ lệ phóng to cho BoxFit.fill
    double scaleX = size.width / backgroundImage.width;
    double scaleY = size.height / backgroundImage.height;
    double scale =
        scaleX > scaleY ? scaleX : scaleY; // Chọn tỷ lệ lớn hơn để lấp đầy

    // Tính toán để căn giữa ảnh
    double dx = (size.width - backgroundImage.width * scale) / 2;
    double dy = (size.height - backgroundImage.height * scale) / 2;

    // Tạo một đối tượng Matrix4 để áp dụng tỷ lệ và căn giữa
    Matrix4 matrix = Matrix4.identity()
      ..scale(scale, scale) // Phóng to ảnh
      ..translate(dx / scale, dy / scale); // Dịch ảnh để căn giữa

    // Tạo Paint với ImageShader
    Paint paint_fill_0 = Paint()
      ..style = PaintingStyle.fill
      ..shader = ImageShader(
        backgroundImage,
        TileMode.clamp,
        TileMode.clamp,
        matrix.storage, // Sử dụng ma trận để căn chỉnh
      );

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(0, size.height - 200);
    path_0.arcToPoint(
      Offset(40, size.height - 160), // Điểm kết thúc
      radius: Radius.circular(40), // Bán kính của đường tròn
      largeArc: false, // Sử dụng cung nhỏ
      clockwise: false,
    );
    path_0.arcToPoint(
      Offset(80, size.height - 120), // Điểm kết thúc
      radius: Radius.circular(40), // Bán kính của đường tròn
      largeArc: false, // Sử dụng cung nhỏ
      clockwise: true,
    );
    path_0.lineTo(80, size.height - 40);
    path_0.arcToPoint(
      Offset(120, size.height), // Điểm kết thúc
      radius: Radius.circular(40), // Bán kính của đường tròn
      largeArc: false, // Sử dụng cung nhỏ
      clockwise: false,
    );
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
