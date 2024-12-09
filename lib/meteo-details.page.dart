import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class MeteoDetailsPage extends StatefulWidget {
  final String city;

  MeteoDetailsPage(this.city);

  @override
  State<MeteoDetailsPage> createState() => _MeteoDetailsPageState();
}

class _MeteoDetailsPageState extends State<MeteoDetailsPage> {
  var meteoData;

  @override
  void initState() {
    super.initState();
    getMeteoData(widget.city);
  }

  void getMeteoData(String city) {
    print("Fetching weather data for the city: $city");
    String url =
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=API_KEY";
    http.get(Uri.parse(url)).then((response) {
      setState(() {
        meteoData = json.decode(response.body);
        print(meteoData);
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Data for ${widget.city}'),
      ),
      body: meteoData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: (meteoData['list']?.length ?? 0),
              itemBuilder: (context, index) {
                var weatherItem = meteoData['list'][index];
                var weatherDate = DateTime.fromMillisecondsSinceEpoch(
                  weatherItem['dt'] * 1000,
                );
                return Card(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.transparent],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Weather Icon (ensure images are available)
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                "images/${weatherItem['weather'][0]['main'].toString().toLowerCase()}.png",
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Date Display
                                Text(
                                  DateFormat('E, dd/MM/yyyy')
                                      .format(weatherDate),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Time and Weather Condition
                                Text(
                                  "${DateFormat('HH:mm').format(weatherDate)} | ${weatherItem['weather'][0]['main']}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Temperature Display
                        Text(
                          "${(weatherItem['main']['temp'] - 273.15).round()} °C",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
