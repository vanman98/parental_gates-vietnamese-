#   parental_gates
A parental gate is a feature incorporated into apps in the Kids category to ensure that children cannot access commerce-related activities or external online content without the awareness and consent of their parent or guardian. The App Store Review Guidelines mandate the use of parental gates for these apps. To enhance their effectiveness, a recommended approach involves randomizing the questions and answers in the gate, preventing children from memorizing the responses. This safeguards the child's online experience, ensuring that they engage safely within the app. It's important to note that the parental gate requirement primarily focuses on preventing unauthorized access to certain features and content and is distinct from securing parental consent for collecting personal data from children, which is governed by separate regulations.


<img src="https://raw.githubusercontent.com/deep260201/parental_gates/main/Screenshort/varticle_scree.png" width="300" height="650">
<img src="https://raw.githubusercontent.com/deep260201/parental_gates/main/Screenshort/horizontel_scree.png" width="650" height="300">


## Reference
 https://developer.apple.com/app-store/kids-apps/
## A Flutter plugin for [Parental Gates](https://developer.apple.com/app-store/kids-apps/).
| Android | iOS | MacOS | Web | Linux | Windows |
| :-----: | :-: | :---: | :-: | :---: | :-----: |
|   :white_check_mark:    | :white_check_mark:  |  :white_check_mark:   | :white_check_mark:  |  :white_check_mark:   |   :white_check_mark:    |
## Usage
To use this plugin, add ` parental_gates` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).
```dart
dependencies:
    parental_gates: ^0.0.1
```
## Example
import package in project file
```dart
import 'package:  parental_gates/  parental_gates.dart';
```
Call Function
```dart
ElevatedButton(
  onPressed: () {
    Permission.getPermission(
      context: context,
        onSuccess: () {
          print("True");
        },
        onFail: () {
          print("false");
        },
    );
  },
  child: Text("validate")
),
```
