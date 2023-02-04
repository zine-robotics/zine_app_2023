import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../components/gradient.dart';
import '../../../providers/dictionary.dart';
import '../../../theme/color.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  // Future<void> loadData() async {
  @override
  Widget build(BuildContext context) {
    return Consumer<Language>(
      builder: (context,dict,_) {
        return Scaffold(
          backgroundColor: backgroundGrey,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            toolbarHeight: MediaQuery.of(context).size.height * 0.08,
            title: const Text(
              "Projects",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: mainGrad //need to replace with made component
                  ),
            ),
          ),
          body: Builder(
            builder: (context) {
              return CarouselSlider(
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.82,
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5)),
                items: dict.projectScreen.projects!
                    .mapIndexed(
                      (index, item) => Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: ListView(
                            shrinkWrap: true,
                            // direction: Axis.vertical,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                child: Image.asset(
                                  'assets/images/projects/project${index + 1}.png',
                                  semanticLabel: "image",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // direction: Axis.horizontal,
                                  children: [
                                    Text(
                                      item.name!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: textColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      item.description!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        wordSpacing: 1.0
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        );
      }
    );
  }
}