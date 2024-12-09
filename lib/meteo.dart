import 'package:flutter/material.dart';
import 'meteo-details.page.dart';

class MeteoPage extends StatelessWidget {
  TextEditingController txt_city = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(title: Text('Page Meteo')),
        appBar: AppBar(title: Text('Chercher météo')),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: txt_city,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_city_sharp),
                  hintText: "tape a city",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
                onPressed: () {
                  _GetMeteoData(context);
                },
                child: Text('Voir météo', style: TextStyle(fontSize: 22)),
              ),
            ),
          ],
        ));
  }

  void _GetMeteoData(BuildContext context) {
    String v = txt_city.text;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MeteoDetailsPage(v)));
    txt_city.text = "";
  }
}
