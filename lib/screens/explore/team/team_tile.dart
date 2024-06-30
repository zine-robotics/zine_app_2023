import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';

import '../../../theme/color.dart';

class TeamTile extends StatefulWidget {
  final String year;
  final String name;
  final String id;
  final String image;
  final String bio;
  final String linkedin;

  const TeamTile({
    super.key,
    required this.year,
    required this.image,
    required this.name,
    required this.id,
    required this.bio,
    required this.linkedin,
  });

  @override
  State<TeamTile> createState() => _TeamTileState();
}

class _TeamTileState extends State<TeamTile> {
  bool expanded = true;
  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 500);
    return Consumer<DashboardVm>(builder: (context, dashboardVm, _) {
      return InkWell(
          onTap: () => setState(() => expanded = !expanded),
          child: Card(
              child: AnimatedContainer(
            duration: duration,
            height: expanded ? 100 : 220,
            child: Stack(
              children: [
                AnimatedPositioned(
                    curve: Curves.easeInOut,
                    top: 13,
                    left: expanded ? 100 : 13,
                    duration: duration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                              fontSize: 18.0,
                              color: textDarkBlue,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          widget.id,
                          style: const TextStyle(
                              fontSize: 12.0,
                              color: textColor,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    )),
                AnimatedPositioned(
                  curve: Curves.easeInOut,
                  duration: duration,
                  bottom: 13.0,
                  left: 13.0,
                  child: AnimatedContainer(
                    duration: duration,
                    height: expanded ? 75 : 130,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          fit: BoxFit.cover,
                          'assets/images/${widget.year}/${widget.image}.webp',
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 13.0,
                  top: 27.0,
                  child: AnimatedRotation(
                    duration: duration,
                    turns: expanded ? 0 : 1.0 / 4.0,
                    child: const Icon(Icons.keyboard_arrow_down_sharp),
                  ),
                ),
                Positioned(
                  top: 70,
                  right: 13,
                  width: 230,
                  child: AnimatedContainer(
                    height: expanded ? 0 : 160,
                    duration: duration,
                    child: Column(
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            widget.bio,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                clipBehavior: Clip.hardEdge,
                                onPressed: () {
                                  final email = Uri(
                                      scheme: 'https', path: widget.linkedin);
                                  dashboardVm.launchUrl(email);
                                },
                                child: const Icon(FontAwesomeIcons.linkedin),
                              ),
                              ElevatedButton(
                                clipBehavior: Clip.hardEdge,
                                child: const Icon(Icons.email),
                                onPressed: () {
                                  final email =
                                      Uri(scheme: 'mailto', path: widget.id);
                                  dashboardVm.launchUrl(email);
                                },
                                // label: const Icon(Icons.email),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )));
    });
  }
}
