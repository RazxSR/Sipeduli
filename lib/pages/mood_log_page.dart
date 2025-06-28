// lib/pages/mood_log_page.dart
import 'package:flutter/material.dart';
import 'package:sipeduli/utils/app_colors.dart';
import 'package:sipeduli/widgets/mood_button.dart';
import 'package:fl_chart/fl_chart.dart'; // Import fl_chart

// This is the full page, used when navigating directly to Mood Log
class MoodLogPage extends StatelessWidget {
  const MoodLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood Log'), centerTitle: true),
      body: const MoodLogContent(), // Use the public content widget here
    );
  }
}

// This widget contains only the content of the Mood Log, without an AppBar
class MoodLogContent extends StatefulWidget {
  const MoodLogContent({super.key});

  @override
  State<MoodLogContent> createState() => _MoodLogContentState();
}

class _MoodLogContentState extends State<MoodLogContent> {
  int? _selectedMood; // To store the selected mood

  // Dummy data for the mood graph
  List<FlSpot> _moodData = [
    const FlSpot(0, 5),
    const FlSpot(1, 6),
    const FlSpot(2, 7),
    const FlSpot(3, 6.5),
    const FlSpot(4, 8),
    const FlSpot(5, 7.5),
    const FlSpot(6, 9),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Added BouncingScrollPhysics for a smoother scrolling feel
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mood',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            '7.5', // This can be the average mood from historical data
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryPurple,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                'Last 30 days ',
                style: TextStyle(fontSize: 16, color: AppColors.darkGrey),
              ),
              Icon(Icons.arrow_upward, color: Colors.green, size: 18),
              Text('+1%', style: TextStyle(fontSize: 16, color: Colors.green)),
            ],
          ),
          const SizedBox(height: 20),
          // Mood Graph
          Container(
            height: 150,
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.lightGrey),
            ),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(
                      color: AppColors.lightGrey,
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return const FlLine(
                      color: AppColors.lightGrey,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        // Example day labels
                        switch (value.toInt()) {
                          case 0:
                            return const Text(
                              'Mon',
                              style: TextStyle(fontSize: 10),
                            );
                          case 1:
                            return const Text(
                              'Tue',
                              style: TextStyle(fontSize: 10),
                            );
                          case 2:
                            return const Text(
                              'Wed',
                              style: TextStyle(fontSize: 10),
                            );
                          case 3:
                            return const Text(
                              'Thu',
                              style: TextStyle(fontSize: 10),
                            );
                          case 4:
                            return const Text(
                              'Fri',
                              style: TextStyle(fontSize: 10),
                            );
                          case 5:
                            return const Text(
                              'Sat',
                              style: TextStyle(fontSize: 10),
                            );
                          case 6:
                            return const Text(
                              'Sun',
                              style: TextStyle(fontSize: 10),
                            );
                          default:
                            return const Text('');
                        }
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        // Example mood scale labels
                        if (value == 0 || value == 5 || value == 10) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 10),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: AppColors.lightGrey, width: 1),
                ),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 10,
                lineBarsData: [
                  LineChartBarData(
                    spots: _moodData,
                    isCurved: true,
                    color: AppColors.primaryPurple,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your average mood',
                    style: TextStyle(fontSize: 16, color: AppColors.darkGrey),
                  ),
                  Text(
                    '7.5',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Most common mood',
                    style: TextStyle(fontSize: 16, color: AppColors.darkGrey),
                  ),
                  Text(
                    '7',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            'Log new mood',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          // Mood selection buttons
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(10, (index) {
              final moodValue = index + 1;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMood = moodValue;
                    // Add new mood to graph data (simple example)
                    // This is for demo only, you need to save this data persistently
                    _moodData.add(
                      FlSpot(_moodData.length.toDouble(), moodValue.toDouble()),
                    );
                    // Limit data points to prevent graph from getting too long
                    if (_moodData.length > 7) {
                      _moodData = _moodData.sublist(_moodData.length - 7);
                      // Adjust x-values to stay within 0-6
                      for (int i = 0; i < _moodData.length; i++) {
                        _moodData[i] = FlSpot(i.toDouble(), _moodData[i].y);
                      }
                    }
                  });
                },
                child: MoodButton(
                  value: moodValue,
                  isSelected:
                      _selectedMood == moodValue, // Pass selected status
                ),
              );
            }),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (_selectedMood != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Mood saved successfully!')),
                );
                // Here you would save _selectedMood to SharedPreferences or a local database
                // For demo, we just show a SnackBar
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select a mood.')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
