import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await dotenv.load(fileName: ".env");
  
  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const StreamNetApp());
}

class StreamNetApp extends StatelessWidget {
  const StreamNetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreamNet Analyst',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // If running on a very narrow screen (like a phone emulator), we'll want a scrollable column.
    // For wider screens, Row layout is better. We'll use a responsive approach.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Stream Analyst Tool'),
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return buildDesktopLayout(context);
          } else {
            return buildMobileLayout(context);
          }
        },
      ),
    );
  }

  Widget buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: const [
                Expanded(child: TopologyGrid()),
                SizedBox(width: 16),
                Expanded(child: CostComparisonChart()),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Expanded(
            flex: 1,
            child: HardwareLimitsIndicator(),
          ),
        ],
      ),
    );
  }

  Widget buildMobileLayout(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        SizedBox(height: 300, child: TopologyGrid()),
        SizedBox(height: 16),
        SizedBox(height: 300, child: CostComparisonChart()),
        SizedBox(height: 16),
        SizedBox(height: 200, child: HardwareLimitsIndicator()),
      ],
    );
  }
}

class TopologyGrid extends StatelessWidget {
  const TopologyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.hub, size: 64, color: Colors.blueAccent),
            const SizedBox(height: 16),
            Text('Topology Grid', style: Theme.of(context).textTheme.headlineSmall),
            const Text('Network map loading...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class CostComparisonChart extends StatelessWidget {
  const CostComparisonChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bar_chart, size: 64, color: Colors.greenAccent),
            const SizedBox(height: 16),
            Text('Cost Comparison Chart', style: Theme.of(context).textTheme.headlineSmall),
            const Text('Cloud Egress vs PCaaS Edge', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class HardwareLimitsIndicator extends StatelessWidget {
  const HardwareLimitsIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.memory, size: 64, color: Colors.orangeAccent),
            const SizedBox(height: 16),
            Text('Hardware Limits Indicator', style: Theme.of(context).textTheme.headlineSmall),
            const Text('NVDEC 25W Thermal Check', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
