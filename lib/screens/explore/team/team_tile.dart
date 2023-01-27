import 'package:flutter/material.dart';

class TeamTile extends StatelessWidget {
  final String name;
  final String id;
  final String photo;

  const TeamTile({
    Key? key,
    required this.photo,
    required this.name,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(15.0,15.0,15.0,0) ,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),//or 15.0
          child: Container(
            height: 50.0,
            width: 50.0,
            color: Colors.blue,
            child: Icon(Icons.volume_up, color: Colors.white, size: 20.0),
          ),
        ),
        title: Text(name),
        subtitle: Text(id),
      ),
    );
  }
}
