import 'package:flutter/material.dart';
import 'package:capitalsense/features/admin_page.dart';
import 'package:capitalsense/widgets/animated_background.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedTab = 0;

  Widget _buildCurrentTab() {
    switch (_selectedTab) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildPlaceholderTab("Strategy & Simulations");
      case 2:
        return _buildPlaceholderTab("Audit & Records");
      case 3:
        return const AdminProfileScreen();
      default:
        return _buildOverviewTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedGradientBackground(
        child: _buildCurrentTab(),
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _selectedTab == 0
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF0F5B44),
              onPressed: () {},
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildOverviewTab() {
    return Column(
      children: [
        _buildAppBar(),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.92),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummarySection(),
                  const SizedBox(height: 30),
                  _buildForecastSection(),
                  const SizedBox(height: 30),
                  _buildCriticalAlerts(),
                  const SizedBox(height: 30),
                  _buildRecentHistory(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderTab(String title) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.construction, size: 50, color: Color(0xFF0F5B44)),
            const SizedBox(height: 20),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Under Development", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Welcome Back,", style: TextStyle(color: Colors.white70, fontSize: 14)),
                Text("Finance Manager", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.notifications_active, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _buildMetricCard("TOTAL CASH", "₹ 12.45L", Icons.account_balance_wallet, const Color(0xFF0F5B44)),
        ),
        const SizedBox(width: 15),
        Expanded(
          flex: 1,
          child: _buildMetricCard("RUNWAY", "4.2mo", Icons.timer, Colors.orange.shade800),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 12),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildForecastSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("30-Day Forecast", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0B3B2E))),
            TextButton(onPressed: () {}, child: const Text("View Full", style: TextStyle(color: Color(0xFF0F5B44)))),
          ],
        ),
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: const Center(child: Icon(Icons.show_chart, size: 40, color: Color(0xFF0B3B2E))),
        ),
      ],
    );
  }

  Widget _buildCriticalAlerts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Critical Obligations", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0B3B2E))),
        const SizedBox(height: 15),
        _buildAlertItem("Office Rent - May", "7 Days Late", "₹ 45,000", Colors.red),
        _buildAlertItem("Employee Salaries", "Due in 3 Days", "₹ 2,40,000", Colors.orange),
      ],
    );
  }

  Widget _buildAlertItem(String title, String status, String amount, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: statusColor.withOpacity(0.1), child: Icon(Icons.warning, color: statusColor, size: 18)),
          const SizedBox(width: 15),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), Text(status, style: TextStyle(color: statusColor, fontSize: 12))])),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRecentHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Recent Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0B3B2E))),
        const SizedBox(height: 15),
        _buildHistoryItem("Vendor Payment", "Reliance Ind.", "₹ 1,20,000", Colors.green),
        _buildHistoryItem("Tax Submission", "TXN#2291", "- ₹ 12,400", Colors.grey),
      ],
    );
  }

  Widget _buildHistoryItem(String type, String sub, String val, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(val.contains("-") ? Icons.arrow_upward : Icons.arrow_downward, color: color, size: 20),
          const SizedBox(width: 15),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(type, style: const TextStyle(fontWeight: FontWeight.bold)), Text(sub, style: const TextStyle(color: Colors.black54, fontSize: 12))])),
          Text(val, style: TextStyle(fontWeight: FontWeight.bold, color: val.contains("-") ? Colors.black : Colors.green)),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.dashboard, "Dashboard", 0),
            _navItem(Icons.analytics, "Strategy", 1),
            const SizedBox(width: 40),
            _navItem(Icons.receipt_long, "Audit", 2),
            _navItem(Icons.settings, "Admin", 3),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int idx) {
    bool isSelected = _selectedTab == idx;
    return InkWell(
      onTap: () => setState(() => _selectedTab = idx),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF0F5B44) : Colors.grey, size: 24),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? const Color(0xFF0F5B44) : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
              ),
            ),
          ],
        ),
      ),
    );
  }
}
