import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final title = 'Các cơ sở Garage gần nhất';

    return MaterialApp(
        title: title,
        home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: ExpansionTile(
              childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
              leading: Icon(Icons.add_business_rounded, size: 35,),
              title: Text(
                ' Garage Didioto Đà Nẵng',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              children: [
                ListTile(
                  title: Text('🏠 171 Tôn Đức Thắng, Quận Hải Châu, Đà Nẵng.', style: TextStyle(fontSize: 20, height: 1.4, color: Colors.black87), ),
                ),
                ListTile(
                    title: Text('📞 02363 768 035.', style: TextStyle(fontSize: 20, height: 1.4, color: Colors.black87))),
                ExpansionTile(
                  title: Text('🛠 Dịch vụ', style: TextStyle(fontSize: 20, height: 1.4),textAlign: TextAlign.left),
                  children: [
                    ListTile(
                        title: Text('✅ Sửa chữa ô tô lưu động mọi lúc mọi nơi.', style: TextStyle(fontSize: 20, height: 1.4,color: Colors.black87)),
                        subtitle: Text('✅ Dịch vụ cứu hộ 24/24.', style: TextStyle(fontSize: 20, height: 1.4, color: Colors.black87))),
                    ListTile(
                        title: Text('✅ Bảo dưỡng – dịch vụ khám xe định kỳ.', style: TextStyle(fontSize: 20, height: 1.4, color: Colors.black87)),
                        subtitle: Text('✅ Thay nhớt máy, cầu, hộp số, dầu thắng, trợ lực lái.', style: TextStyle(fontSize: 20, height: 1.4, color: Colors.black87))),
                    ListTile(
                        title: Text('✅ Sửa chữa hệ thống điện, điện lạnh.', style: TextStyle(fontSize: 20, height: 1.4, color: Colors.black87)),
                        subtitle: Text('✅ Trang trí nội thất: Bọc sàn – May ghế – Ốp trần.', style: TextStyle(fontSize: 20, height: 1.4, color: Colors.black87)))

                  ],
                )
              ]
          ),

        )
    );
  }
}
