import 'package:flutter/material.dart';
import 'package:zineapp2023/theme/color.dart';


class ChatDescription extends StatelessWidget {
  const ChatDescription({
    required this.roomName,
    required this.data,
    super.key,
  });

  final String roomName;
  final dynamic data;

  @override
  Widget build(BuildContext context) {

    // print(data);

    return Scaffold(
      backgroundColor: backgroundGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: textColor,
          iconSize: 35,
          padding: const EdgeInsets.all(20),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(30.0),
                    child: Image.asset(
                      "assets/images/timeline/${roomName.toLowerCase()}.png",
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      color: textColor.withOpacity(0.9),
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,20.0,0,0,),
              child: Text(
                roomName,
                style: const TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0,10,0,10),
              child: Text(
                "${data.length} Active Members",
                style: const TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),

            Expanded(
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: Colors.grey,
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  "assets/images/dp/${data[index].dp}.png",
                                  height: 45,
                                  width: 45,
                                  fit: BoxFit.cover,
                                  // color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].name,
                                style: TextStyle(
                                    fontSize:
                                    MediaQuery.of(context).textScaleFactor *
                                        15,
                                    fontWeight: FontWeight.bold,
                                    color: textDarkBlue),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                data[index].email,
                                style: TextStyle(
                                    fontSize:
                                    MediaQuery.of(context).textScaleFactor *
                                        12.5,
                                    color: textDarkBlue),
                              )
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 16, 16, 0),
                            child: Text(
                              data[index].type=='admin'?"Zine Member":"",
                              style: TextStyle(
                                  color: textColor,
                                  fontSize:
                                  MediaQuery.of(context).textScaleFactor *
                                      13),
                            ),
                          )
                        ],
                      ),
                    )
                  );
                },
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}


