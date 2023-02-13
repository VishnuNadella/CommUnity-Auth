import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../components/loading.dart';
import "./result_screen.dart";
import "../mongodb.dart";

class Scanner extends StatefulWidget {
  static String id = "/scan";
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String scannerData = "";
  late String scannerStatus;
  late String Status;
  bool loading = false;
  String _dropdownValue = "day1";
  List<String> dropDownOptions = [
    "day1",
    "day2",
    "day3",
    "day4",
    "day5",
    "day6",
  ];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    scannerData = "";
    Status = "Please Scan to check status";
    scannerStatus = Status;
  }

  // void dropDownCallback(String? day) {
  //   if (day is String) {
  //     setState(() {
  //       _dropdownValue = day;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    String? selectedValue = "";
    return loading
        ? Loading()
        : Scaffold(
            body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownButton(
                  items: dropDownOptions
                      .map<DropdownMenuItem<String>>((String mascot) {
                    return DropdownMenuItem<String>(
                        child: Text(mascot), value: mascot);
                  }).toList(),
                  value: _dropdownValue,
                  onChanged: (String? day) {
                    if (day is String) {
                      setState(() {
                        _dropdownValue = day;
                      });
                    }
                  },
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    height: 300,
                    width: 300,
                    child: MobileScanner(
                        allowDuplicates: false,
                        onDetect: (barcode, args) async {
                          if (barcode.rawValue == null) {
                            debugPrint('Failed to scan Barcode');
                          } else {
                            final String code = barcode.rawValue!;

                            if (code != "") {
                              // var response = await CrudOps()
                              //     .get("/cert")
                              //     .catchError((err) {});
                              // debugPrint("The response is: $response");
                              // if (response == null) return;
                              // else {
                              //   Status = "Scanned";
                              // }
                              setState(() {
                                scannerData = code;
                                scannerStatus = Status;
                              });
                            }
                            debugPrint('Barcode found! $scannerData');
                          }
                        }),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),

                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black45),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
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
                  onPressed: () async {
                    if (scannerData != "") {
                      setState(() {
                        loading = true;
                      });
                      var req_scan_data = scannerData;

                      List<String> req_data = await searchInDb(req_scan_data, _dropdownValue);
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => Result(
                            name: req_data[1],
                            status: req_data[0],
                          ),
                        ),
                      );
                      setState(
                        () {
                          scannerData = "";
                          loading = false;
                        },
                      );
                    } else {}
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Text('Authenticate'),
                  ),
                ),

                // Update the below containers
                const SizedBox(
                  height: 48.0,
                ),
                Container(
                  height: 100,
                  width: 300,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    color: Colors.black12,
                  ),
                  child: Center(
                    child: Text(
                      'User Phone and ID: $scannerData',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // Container(child: Text('Checking Status: $scannerStatus')),
              ],
            ),
          ));
  }
}
