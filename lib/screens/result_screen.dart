import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  Result({required this.name, required this.status});
  final String name;
  final String status; // 3=> True, Duplicate, Invalid / Non Existent
  static String id = "/result";
  String scannerData = "";
  @override
  void initState() {
    scannerData = name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 360,
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              color: (status == "true"? Color.fromARGB(255, 104, 230, 109) : status == "false"? Color.fromARGB(255, 252, 92, 92): status == "none"? Color.fromARGB(255, 251, 211, 92):Color.fromARGB(255, 92, 181, 253)),
            ),
            child: Center(
              child: Text(
                (status == "true"? 'Welcome $name': status == "false"? 'Duplicate $name' : status == "none"? "No id exists": "None"),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Update the below containers
          const SizedBox(
            height: 48.0,
          ),

          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) { 
                    return Colors.black.withOpacity(0.04);
                  }
                  if (states.contains(MaterialState.focused) ||
                      states.contains(MaterialState.pressed)) {
                    return Colors.black.withOpacity(0.12);
                  }
                  return null; // Defer to the widget's default.
                },
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Text('Next'),
            ),
          ),
          // Container(child: Text('Checking Status: $scannerStatus')),
        ],
      ),
    ));
  }
}
