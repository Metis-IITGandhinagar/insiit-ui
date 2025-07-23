
import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:intl/intl.dart';

import '../model/events.dart';

class EventDetailsPage extends StatefulWidget {
  final Events? event;

  const EventDetailsPage({super.key, required this.event});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'No date provided';
    }
    try {
      final DateTime date = DateTime.parse(dateString);
      return DateFormat('EEEE, MMMM d, y').format(date);
    } catch (e) {
      return dateString;
    }
  }

  String _formatTime(String? dateString, String? timeString) {
    if (timeString == null || timeString.isEmpty) {
      return 'No time provided';
    }
    final datePart =
        dateString ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
    try {
      final DateTime dateTime = DateTime.parse('$datePart $timeString');
      return DateFormat.jm().format(dateTime);
    } catch (e) {
      return timeString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            expandedHeight: 250,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.event?.name ?? 'Event Details',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    shadows: [Shadow(blurRadius: 8.0, color: Colors.black54)],
                  ),
                ),
                background: Container(
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(1),
                      ],
                    ),
                  ),
                  child: Image.network(
                    widget.event?.image ??
                        "https://placehold.co/600x400/black/white?text=No%20Image",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        alignment: Alignment.center,
                        child: const Text(
                          'Image Not Available',
                          style: TextStyle(color: Colors.black54),
                        ),
                      );
                    },
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    surfaceTintColor: Theme.of(context).colorScheme.primary,
                    elevation: 0,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            icon: Icons.location_on_outlined,
                            text: widget.event?.location ??
                                'No location provided',
                          ),
                          _buildDetailRow(
                            icon: Icons.calendar_today_outlined,
                            text: _formatDate(widget.event?.date),
                          ),
                          _buildDetailRow(
                              icon: Icons.access_time_outlined,
                              text: _formatTime(
                                      widget.event?.date, widget.event?.time) +
                                  ' Onwards'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Description section using MarkdownViewer
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),

                  SingleChildScrollView(
                      child: MarkdownBlock(
                          data: widget.event?.description ??
                              'No description available.')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(text,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
