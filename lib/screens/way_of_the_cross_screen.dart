import 'dart:convert';
import 'package:catholic_daily/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/station.dart'; // For loading JSON from assets

class WayOfTheCrossScreen extends StatefulWidget {
  const WayOfTheCrossScreen({super.key});

  @override
  State<WayOfTheCrossScreen> createState() => _WayOfTheCrossScreenState();
}

class _WayOfTheCrossScreenState extends State<WayOfTheCrossScreen> {
  List<Station> stations = [];
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    loadStations();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> loadStations() async {
    final String data = await rootBundle.loadString('lib/data/way_of_the_cross.json');
    final List<dynamic> jsonResult = json.decode(data);
    setState(() {
      stations = jsonResult.map((s) => Station.fromJson(s)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (stations.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text("Way of the Cross"),
        backgroundColor: AppColors.appBarBackground,
      ),
      body: Stack(
        children: [

          PageView.builder(
            controller: _controller,
            itemCount: stations.length,
            itemBuilder: (context, index) {
              final s = stations[index];

              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            s.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    Text(
                      s.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    if (s.adoration.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      const Text("ADORATION", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(s.adoration),
                    ],

                    if (s.scripture.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      const Text("SCRIPTURE", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(s.scripture),
                    ],

                    if (s.meditation.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      const Text("MEDITATION", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(s.meditation),
                    ],

                    if (s.prayer.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      const Text("PRAYER", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(s.prayer),
                    ],
                  ],
                ),
              );
            },
          ),

          Positioned(
            left: 8,
            top: MediaQuery.of(context).size.height * 0.45,
            child: TweenAnimationBuilder(
              tween: Tween(begin: -4.0, end: 4.0),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(value, 0),
                  child: child,
                );
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey.withOpacity(0.6),
              ),
            ),
          ),

          Positioned(
            right: 8,
            top: MediaQuery.of(context).size.height * 0.45,
            child: TweenAnimationBuilder(
              tween: Tween(begin: 4.0, end: -4.0),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(value, 0),
                  child: child,
                );
              },
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.withOpacity(0.6),
              ),
            ),
          ),

          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Column(
              children: [

                SmoothPageIndicator(
                  controller: _controller,
                  count: stations.length,
                  effect: WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 6),

                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    int page = 0;
                    if (_controller.hasClients && _controller.page != null) {
                      page = _controller.page!.round();
                    }
                    return Text(
                      "Station ${page + 1} of ${stations.length}",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}