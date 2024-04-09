import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Custom widget to get parent permission
class GetParentPermission extends StatefulWidget {
  const GetParentPermission({super.key});

  @override
  State<GetParentPermission> createState() => _GetParentPermissionState();
}

// State class for GetParentPermission widget
class _GetParentPermissionState extends State<GetParentPermission> {
  // List of words representing numbers from 0 to 9
  List<String> oneToNine = [
    "Không",
    "Một",
    "Hai",
    "Ba",
    "Bốn",
    "Năm",
    "Sáu",
    "Bảy",
    "Tám",
    "Chín"
  ];

  // Lists to manage the current challenge and user input
  List<int> number = [];
  List<String> numberWord = [];
  List<int?> ansNumber = [];
  int currentIndex = 0;

  // Method to check if the user input matches the challenge
  checkSuccess() {
    if (currentIndex == 3) {
      if (listEquals(number, ansNumber)) {
        // If input matches, pop the screen with a success flag
        Navigator.pop(context, true);
      } else {
        // If input does not match, reset the challenge
        setNumber();
      }
    } else {
      currentIndex++;
    }
  }

  // Method to set a new random number challenge
  setNumber() {
    currentIndex = 0;
    number = [];
    numberWord = [];
    ansNumber = [];
    for (int i = 0; i < 4; i++) {
      int num = Random().nextInt(9);
      number.add(num);
      numberWord.add(oneToNine[num]);
      ansNumber.add(null);
    }
    if (mounted) setState(() {});
  }

  // Initialize the state by setting a new challenge
  @override
  void initState() {
    setNumber();
    super.initState();
  }

  // Build the UI for the GetParentPermission widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xfff7f5ec),
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  // Close the screen with a failure flag
                  Navigator.pop(context, false);
                },
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.blue,
                  size: 30,
                ))
          ],
        ),
        backgroundColor: const Color(0xfff7f5ec),
        body: OrientationBuilder(
          builder: (context, orientation) {
            // Different layout for landscape and portrait orientations
            if (orientation == Orientation.landscape) {
              return SafeArea(
                child: Stack(
                  children: [
                    // Left side of the landscape layout
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          // Left Column
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Parent permission message and current challenge
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomButton(
                                      buttonSize: 50,
                                      onTap: () {
                                        // Speak a message to ask for parent's permission
                                      },
                                      child: const Icon(Icons.volume_up_rounded),
                                    ),
                                    const Column(
                                      children: [
                                        Text(
                                          "   Hỏi bố mẹ của bạn",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Để tiếp tục, Ấn:",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                // Display the current challenge
                                Text(
                                  numberWord.join(" , "),
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                  ),
                                ),
                                // Display user input placeholders
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < 4; i++)
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  (ansNumber[i] ?? '').toString(),
                                                  style: const TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 20,
                                                    height: 2,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Container(
                                                  height: 2.5,
                                                  width: 30,
                                                  color: Colors.blue,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Right Column
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Buttons for user input
                                for (int i = 0; i < 3; i++)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      for (int j = 1; j < 4; j++)
                                        IgnorePointer(
                                          ignoring: currentIndex > 3,
                                          child: CustomButton(
                                            child: Text(
                                              "${(i * 3) + j}",
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                ansNumber[currentIndex] = (i * 3) + j;
                                                checkSuccess();
                                              });
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                // Buttons for '0' and 'back'
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    IgnorePointer(
                                      ignoring: currentIndex > 3,
                                      child: CustomButton(
                                        child: const Text(
                                          "0",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            ansNumber[currentIndex] = 0;
                                            checkSuccess();
                                          });
                                        },
                                      ),
                                    ),
                                    IgnorePointer(
                                      ignoring: currentIndex > 3,
                                      child: CustomButton(
                                        width: 120,
                                        child: const Icon(
                                          Icons.arrow_back,
                                          color: Colors.blue,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            if (currentIndex > 0) {
                                              currentIndex--;
                                              ansNumber[currentIndex] = null;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // Portrait layout
              return SafeArea(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Top part of portrait layout
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Parent permission message and current challenge
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomButton(
                                      buttonSize: 50,
                                      onTap: () {},
                                      child: const Icon(Icons.volume_up_rounded),
                                    ),
                                    const Column(
                                      children: [
                                        Text(
                                          "   Hỏi bố mẹ của bạn",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Để tiếp tục, Ấn:",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                // Display the current challenge
                                Text(
                                  numberWord.join(" , "),
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                  ),
                                ),
                                // Display user input placeholders
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < 4; i++)
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  (ansNumber[i] ?? '').toString(),
                                                  style: const TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 20,
                                                    height: 2,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Container(
                                                  height: 2.5,
                                                  width: 30,
                                                  color: Colors.blue,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Bottom part of portrait layout
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Buttons for user input
                                for (int i = 0; i < 3; i++)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      for (int j = 1; j < 4; j++)
                                        IgnorePointer(
                                          ignoring: currentIndex > 3,
                                          child: CustomButton(
                                            child: Text(
                                              "${(i * 3) + j}",
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                ansNumber[currentIndex] = (i * 3) + j;
                                                checkSuccess();
                                              });
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                // Buttons for '0' and 'back'
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    IgnorePointer(
                                      ignoring: currentIndex > 3,
                                      child: CustomButton(
                                        child: const Text(
                                          "0",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            ansNumber[currentIndex] = 0;
                                            checkSuccess();
                                          });
                                        },
                                      ),
                                    ),
                                    IgnorePointer(
                                      ignoring: currentIndex > 3,
                                      child: CustomButton(
                                        width: 120,
                                        child: const Icon(
                                          Icons.arrow_back,
                                          color: Colors.blue,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            if (currentIndex > 0) {
                                              currentIndex--;
                                              ansNumber[currentIndex] = null;
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}

// Custom button widget
class CustomButton extends StatelessWidget {
  final Widget child;
  final double buttonSize;
  final double? width;
  final Function() onTap;

  const CustomButton({
    super.key,
    this.buttonSize = 60,
    required this.child,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: buttonSize,
        width: width ?? buttonSize,
        decoration: BoxDecoration(
          color: const Color(0xfff7f5ec),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 0, 53, 97),
              blurRadius: 0.5,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: child,
      ),
    );
  }
}
