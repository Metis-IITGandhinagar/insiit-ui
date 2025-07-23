import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class QuickLinks extends StatefulWidget {
  const QuickLinks({Key? key}) : super(key: key);

  @override
  State<QuickLinks> createState() => QuickLinksState();
}

class QuickLinksState extends State<QuickLinks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Quick Links"),
      ),
      body: ListView(
        children: [
          _buildLinkTile(
            icon: Icons.settings_outlined,
            title: "Maintenance Portal",
            subtitle: "For all maintenance requests, use the online portal",
            url: "http://maintenance.iitgn.ac.in",
          ),
          _buildLinkTile(
            icon: Icons.local_hospital_outlined,
            title: "Hospital Center Reservation System",
            subtitle: "For booking appointments with doctors",
            url: "https://hcrs.iitgn.ac.in/slotbooking/",
          ),
          _buildLinkTile(
            icon: Icons.security_outlined,
            title: "Campus Security (24x7)",
            subtitle:
                "Security supervisor hotline: 7567935473 (available 24x7)",
          ),
          _buildLinkTile(
            icon: Icons.hotel_outlined,
            subtitle: "For booking guest house rooms",
            title: "Guest House Booking",
            url: "https://guesthouse.iitgn.ac.in/booking.php",
          ),
          _buildLinkTile(
            icon: Icons.school_outlined,
            subtitle: "For all academic requests",
            title: "Academics Request System",
            url: "https://academics.iitgn.ac.in/request/",
          ),
        ],
      ),
    );
  }

  Widget _buildLinkTile({
    required IconData icon,
    required String title,
    required String subtitle,
    String? url,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        if (url != null && url.isNotEmpty) {
          _launchURL(url);
        }
      },
      trailing: url != null && url.isNotEmpty
          ? IconButton(
              icon: Icon(Icons.open_in_new),
              onPressed: () {
                _launchURL(url);
              },
            )
          : null,
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
