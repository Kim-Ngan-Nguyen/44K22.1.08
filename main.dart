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
        body: ListView(
          children: <Widget>[
             ListTile(
              dense: true,
              leading: Icon(Icons.home_repair_service_sharp,
              color: Colors.blue[800], size: 35),
              title: Text('Garage Didioto Đà Nẵng',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
              subtitle: Text('171 Tôn Đức Thắng, Quận Hải Châu, Đà Nẵng',
                  style: TextStyle(fontSize: 15.0)),
              onTap: () {
                print('onTap');
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.home_repair_service_sharp,
                  color: Colors.blue[800], size: 35),
              title: Text('Garage Ô tô Tín Bình Auto',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
              subtitle: Text('Lô 15D25 Lê Văn Linh, Phường Khuê Trung, Quận Cẩm Lệ, Đà Nẵng',
                  style: TextStyle(fontSize: 15.0)),
              onTap: () {
                print('onTap');
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.home_repair_service_sharp,
                  color: Colors.blue[800], size: 35),
              title: Text('Garage Ô tô Hoàng Trang',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
              subtitle: Text('366 Nguyễn Tất Thành, Thanh Bình, Quận Thanh Khê, Đà Nẵng',
              style: TextStyle(fontSize: 15.0)),
              onTap: () {
                print('onTap');
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.home_repair_service_sharp,
                  color: Colors.blue[800], size: 35),
              title: Text('Garage Ô tô Đà Nẵng',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
              subtitle: Text(' Lô 149 Hoàng Thị Loan, Hòa Minh, Liên Chiểu, Đà Nẵng',
                  style: TextStyle(fontSize: 15.0)),
              onTap: () {
                print('onTap');
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.home_repair_service_sharp,
                  color: Colors.blue[800], size: 35),
              title: Text('Garage Hoánh Thành Workshop',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
              subtitle: Text(' Lô 68 Bùi Tá Hán, Ngũ Hành Sơn, Đà Nẵng',
                  style: TextStyle(fontSize: 15.0)),
              onTap: () {
                print('onTap');
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.home_repair_service_sharp,
                  color: Colors.blue[800], size: 35),
              title: Text('Garage Ô tô Nguyễn Thận Lợi',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
              subtitle: Text(' 779 Ngô Quyền, Quận Sơn Trà, Đà Nẵng',
                  style: TextStyle(fontSize: 15.0)),
              onTap: () {
                print('onTap');
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.home_repair_service_sharp,
                  color: Colors.blue[800], size: 35),
              title: Text('Garage Ô tô Hà Thư',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
              subtitle: Text(' 43 Trịnh Quang Xuân, Hoà Châu, Hòa Vang, Đà Nẵng',
                  style: TextStyle(fontSize: 15.0)),
              onTap: () {
                print('onTap');
              },
            ),
          ],
        ),
      ),
    );
  }
}