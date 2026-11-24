import 'package:flutter/material.dart';

void main() => runApp(const CoinovaaApp());

class CoinovaaApp extends StatelessWidget {
  const CoinovaaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final id = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("Coinovaa", style: TextStyle(fontSize: 32, color: Colors.amber, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(controller: id, decoration: const InputDecoration(labelText: "ID", border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder())),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(double.infinity, 50)),
            onPressed: () {
              if (id.text.trim() == 'riyad5052' && password.text.trim() == 'riyad505252') {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdminDashboard()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wrong ID or Password")));
              }
            },
            child: const Text("Login", style: TextStyle(color: Colors.black)),
          ),
        ]),
      ),
    );
  }
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});
  Widget card(BuildContext context, String title, String sub, IconData icon, Widget page) {
    return Card(
      color: const Color(0xFF1E1E1E),
      child: ListTile(
        leading: Icon(icon, color: Colors.amber, size: 32),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        subtitle: Text(sub),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage())),
          )
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(12), children: [
        const Text("Welcome, riyad5052", style: TextStyle(fontSize: 24, color: Colors.amber, fontWeight: FontWeight.bold)),
        const Text("Full Admin Access"),
        const SizedBox(height: 12),
        card(context, "Manage Users", "View, block and review user accounts", Icons.people, const UsersPage()),
        card(context, "Coin Management", "Review coin adjustments", Icons.monetization_on, const CoinPage()),
        card(context, "Video & Tasks", "Manage earning content", Icons.video_library, const VideoPage()),
        card(context, "Referral Settings", "Configure referral rules", Icons.group_add, const ReferralPage()),
        card(context, "Withdraw Requests", "Review bKash, Nagad and Rocket requests", Icons.account_balance_wallet, const WithdrawPage()),
        card(context, "Transactions", "Review transaction records", Icons.receipt, const TransactionsPage()),
        card(context, "App Settings", "Manage minimum withdrawal: 200 TK", Icons.settings, const SettingsPage()),
      ]),
    );
  }
}

class SimplePage extends StatelessWidget {
  final String title;
  final List<String> items;
  const SimplePage({super.key, required this.title, required this.items});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.black),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(items[index]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Approved")));
                    },
                    child: const Text("Approve"),
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Rejected / Blocked")));
                    },
                    child: const Text("Reject", style: TextStyle(color: Colors.red)),
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

class UsersPage extends StatelessWidget { const UsersPage({super.key}); @override Widget build(BuildContext context) => const SimplePage(title: "Manage Users", items: ["User: rakib123 - 500 Coin - Active", "User: sakib99 - 1200 Coin - Active", "User: mim_01 - 0 Coin - New"]); }
class CoinPage extends StatelessWidget { const CoinPage({super.key}); @override Widget build(BuildContext context) => const SimplePage(title: "Coin Management", items: ["rakib123 requested +100 Coin", "sakib99 requested +500 Coin"]); }
class VideoPage extends StatelessWidget { const VideoPage({super.key}); @override Widget build(BuildContext context) => const SimplePage(title: "Video & Tasks", items: ["Video 1: https://youtube.com/... - 10 Coin", "Task: Follow Page - 20 Coin", "Video 2: Watch 1 min - 15 Coin"]); }
class ReferralPage extends StatelessWidget { const ReferralPage({super.key}); @override Widget build(BuildContext context) => const SimplePage(title: "Referral Settings", items: ["Refer Bonus: 50 Coin", "Refer Commission: 10%", "Min Refer: 5 Friends"]); }
class WithdrawPage extends StatelessWidget { const WithdrawPage({super.key}); @override Widget build(BuildContext context) => const SimplePage(title: "Withdraw Requests", items: ["rakib123 - bKash 017XX - 500 TK", "sakib99 - Nagad 018XX - 1000 TK", "mim_01 - Rocket 019XX - 300 TK"]); }
class TransactionsPage extends StatelessWidget { const TransactionsPage({super.key}); @override Widget build(BuildContext context) => const SimplePage(title: "Transactions", items: ["rakib123 - Earn Video - +10 Coin", "sakib99 - Withdraw - 1000 TK", "mim_01 - Refer Bonus - +50 Coin"]); }
class SettingsPage extends StatelessWidget { const SettingsPage({super.key}); @override Widget build(BuildContext context) => const SimplePage(title: "App Settings", items: ["Minimum Withdraw: 200 TK", "App Version: 1.1.0", "Maintenance: OFF"]); }
