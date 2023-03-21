import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zineapp2023/models/events.dart';
import 'package:zineapp2023/utilities/DateTime.dart';

class EventCard extends StatefulWidget {
  final Events event;

  EventCard({required this.event});

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var event = widget.event;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        width: _isExpanded
            ? MediaQuery.of(context).size.width * 0.9
            : MediaQuery.of(context).size.width * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.event.name.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (_isExpanded)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    event.name.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    ' | ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    getDate(event.timeDate as Timestamp),
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    ' | ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    getTime(event.timeDate as Timestamp),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
