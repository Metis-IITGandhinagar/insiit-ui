import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:provider/provider.dart';

import '../model/outlet.dart';
import '../provider/cart_provider.dart';
import 'outlet_page.dart';

class OutletCard extends StatefulWidget {
  final Outlet outlet;

  const OutletCard({super.key, required this.outlet});

  @override
  State<OutletCard> createState() => _OutletCardState();
}

class _OutletCardState extends State<OutletCard> {
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _checkIfOpen();
  }

  void _checkIfOpen() {
    try {

      final dateFormat = DateFormat("h:mm a");
      final now = DateTime.now();

      final openTimeParsed = dateFormat.parse(widget.outlet.openTime);
      final closeTimeParsed = dateFormat.parse(widget.outlet.closeTime);

      var openDateTime = DateTime(now.year, now.month, now.day,
          openTimeParsed.hour, openTimeParsed.minute);
      var closeDateTime = DateTime(now.year, now.month, now.day,
          closeTimeParsed.hour, closeTimeParsed.minute);

      if (closeDateTime.isBefore(openDateTime)) {
        closeDateTime = closeDateTime.add(const Duration(days: 1));
        // If current time is before the opening time, we might need to check yesterday's schedule
        if (now.isBefore(openDateTime)) {
          openDateTime = openDateTime.subtract(const Duration(days: 1));
          closeDateTime = closeDateTime.subtract(const Duration(days: 1));
        }
      }

      setState(() {
        _isOpen = now.isAfter(openDateTime) && now.isBefore(closeDateTime);
      });
    } catch (e) {
      setState(() {
        _isOpen = false;
      });
      print("Error parsing time: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OutletPage(outlet: widget.outlet)
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Card(
          color: Theme.of(context).colorScheme.onSecondary,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Image.network(
                  widget.outlet.image,
                  fit: BoxFit.cover,
                 
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                        child: Icon(Icons.broken_image,
                            size: 40,
                            color:
                                Theme.of(context).colorScheme.surfaceBright));
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Outlet Name
                    Text(
                      widget.outlet.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Timing and Status
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: _isOpen
                              ? Colors.green.shade600
                              : Colors.red.shade600,
                          size: 12,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _isOpen ? 'Open' : 'Closed',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _isOpen
                                ? Colors.green.shade700
                                : Colors.red.shade700,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '• ${widget.outlet.openTime} - ${widget.outlet.closeTime}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
