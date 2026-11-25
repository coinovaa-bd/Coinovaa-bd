import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() => runApp(CoinovaaApp());
class CoinovaaApp extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData(scaffoldBackgroundColor: Color(0xFF0F172A)), home: LauncherScreen());
  }
}
class LauncherScreen extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return Scaffold(body: Padding(padding: EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('COINOVAA', style: TextStyle(color: Colors.amber, fontSize: 38, fontWeight: FontWeight.bold)),
      Text('Earn Real Rewards', style: TextStyle(color: Colors.white70)),
      SizedBox(height: 40),
      SizedBox(width: double.infinity, height: 55, child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UserLogin())), style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), child: Text('Open User App', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
      SizedBox(height: 12),
      SizedBox(width: double.infinity, height: 55, child: OutlinedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminLogin())), child: Text('Admin Login', style: TextStyle(color: Colors.white)))),
    ])));
  }
}
class UserLogin extends StatefulWidget { @override _UserLoginState createState() => _UserLoginState(); }
class _UserLoginState extends State<UserLogin> {
  final idC = TextEditingController(); final pwC = TextEditingController(); String err = '';
  void login() async {
    if (idC.text.trim().length < 4) { setState(() => err = 'ID 4 অক্ষরের দাও'); return; }
    if (pwC.text.trim().length < 4) { setState(() => err = 'Password 4 অক্ষরের দাও'); return; }
    final p = await SharedPreferences.getInstance(); await p.setString('user_id', idC.text.trim());
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserHome(userId: idC.text.trim())));
  }
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('User Login / Sign Up'), backgroundColor: Color(0xFF0F172A)), body: Padding(padding: EdgeInsets.all(20), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('নতুন ID বানাও বা Login করো', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(height: 20),
      TextField(controller: idC, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'তোমার ID', filled: true, fillColor: Colors.white10, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
      SizedBox(height: 12),
      TextField(controller: pwC, obscureText: true, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'Password', filled: true, fillColor: Colors.white10, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
      if (err.isNotEmpty) Padding(padding: EdgeInsets.only(top: 10), child: Text(err, style: TextStyle(color: Colors.redAccent))),
      SizedBox(height: 20),
      SizedBox(width: double.infinity, height: 52, child: ElevatedButton(onPressed: login, style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), child: Text('LOGIN / SIGN UP', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
    ])));
  }
}
class AdminLogin extends StatefulWidget { @override _AdminLoginState createState() => _AdminLoginState(); }
class _AdminLoginState extends State<AdminLogin> {
  final idC = TextEditingController(); final pwC = TextEditingController(); String err = '';
  void login() {
    if (idC.text.trim() == 'riyad5052' && pwC.text.trim() == 'riyad505252') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AdminHome()));
    } else { setState(() => err = 'সঠিক Admin ID দিন।'); }
  }
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Admin Login'), backgroundColor: Color(0xFF0F172A)), body: Padding(padding: EdgeInsets.all(20), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Welcome Admin', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)), SizedBox(height: 20),
      TextField(controller: idC, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'Admin ID', filled: true, fillColor: Colors.white10, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
      SizedBox(height: 12),
      TextField(controller: pwC, obscureText: true, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'Password', filled: true, fillColor: Colors.white10, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
      if (err.isNotEmpty) Padding(padding: EdgeInsets.only(top: 10), child: Text(err, style: TextStyle(color: Colors.redAccent))),
      SizedBox(height: 20),
      SizedBox(width: double.infinity, height: 52, child: ElevatedButton(onPressed: login, style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), child: Text('LOGIN', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
    ])));
  }
}
class UserHome extends StatefulWidget { final String userId; UserHome({required this.userId}); @override _UserHomeState createState() => _UserHomeState(); }
class _UserHomeState extends State<UserHome> {
  double balance = 0;
  @override void initState() { super.initState(); _load(); }
  _load() async { final p = await SharedPreferences.getInstance(); setState(() => balance = p.getDouble('balance_${widget.userId}') ?? 0); }
  _save() async { final p = await SharedPreferences.getInstance(); await p.setDouble('balance_${widget.userId}', balance); }
  void watch() { setState(() => balance += 5); _save(); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('+5 Coins!'))); }
  void withdraw() {
    if (balance < 500) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('500 Coins লাগবে'))); return; }
    showDialog(context: context, builder: (_) => AlertDialog(title: Text('Withdraw'), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(decoration: InputDecoration(labelText: 'bKash / Nagad Number')), TextField(decoration: InputDecoration(labelText: 'Amount'))]), actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')), ElevatedButton(onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Withdraw Request পাঠানো হয়েছে!'))); }, child: Text('Send'))]));
  }
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Coinovaa - ${widget.userId}'), backgroundColor: Color(0xFF0F172A)), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
      Container(width: double.infinity, padding: EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(16)), child: Column(children: [Text('Your Balance'), Text('${balance.toStringAsFixed(0)} Coins', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)), Text('ID: ${widget.userId}')])),
      SizedBox(height: 16),
      ListTile(tileColor: Colors.white10, title: Text('Watch Video - Earn 5 Coins', style: TextStyle(color: Colors.white)), trailing: ElevatedButton(onPressed: watch, child: Text('WATCH'))),
      SizedBox(height: 12),
      ListTile(tileColor: Colors.white10, title: Text('Withdraw - Min 500 Coins', style: TextStyle(color: Colors.white)), trailing: ElevatedButton(onPressed: withdraw, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: Text('WITHDRAW'))),
    ])));
  }
}
class AdminHome extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Admin Panel - riyad5052'), backgroundColor: Color(0xFF0F172A)), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
      Container(width: double.infinity, padding: EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(16)), child: Column(children: [Text('Admin Dashboard'), Text('Welcome, riyad5052', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))])),
      SizedBox(height: 16),
      ListTile(tileColor: Colors.white10, title: Text('Total Users', style: TextStyle(color: Colors.white))),
      SizedBox(height: 10),
      ListTile(tileColor: Colors.white10, title: Text('Withdraw Requests', style: TextStyle(color: Colors.white))),
    ])));
  }
}
