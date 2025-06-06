import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const  NewsAggregator());
}
class NewsAggregator extends StatelessWidget {
  const NewsAggregator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '**NEWS AGGREGATOR**',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
    );
  }
}



