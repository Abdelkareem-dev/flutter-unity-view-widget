# flutter_unity_widget

[![version][version-badge]][package]
[![MIT License][license-badge]][license]
[![PRs Welcome][prs-badge]](http://makeapullrequest.com)

[![Watch on GitHub][github-watch-badge]][github-watch]
[![Star on GitHub][github-star-badge]][github-star]

Flutter unity 3D widget for embedding unity in flutter. Add a Flutter widget to show unity. Works on Android, iOS in progress.

## Installation
 First depend on the library by adding this to your packages `pubspec.yaml`:

```yaml
dependencies:
  flutter_unity_widget: ^0.1.3+3
```

Now inside your Dart code you can import it.

```dart
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
```
<br />

## Preview

![gif](https://github.com/snowballdigital/flutter-unity-view-widget/blob/master/2019_03_28_19_23_37.gif?raw=true)

<br />

## Setup Project
For this, there is also a video tutorial, which you can find a [here](https://www.youtube.com/watch?v=exNPmv_7--Q).

### Add Unity Project

1. Create an unity project, Example: 'UnityDemoApp'.
2. Create a folder named `unity` in flutter project folder.
2. Move unity project folder to `unity` folder.

Now your project files should look like this.

```
.
├── android
├── ios
├── lib
├── test
├── unity
│   └── <Your Unity Project>    // Example: UnityDemoApp
├── pubspec.yml
├── README.md
```

### Configure Player Settings

1. First Open Unity Project.

2. Click Menu: File => Build Settings => Player Settings

3. Change `Product Name` to Name of the Xcode project, You can find it follow `ios/${XcodeProjectName}.xcodeproj`.

   **Android Platform**:
    1. Make sure your `Graphics APIs` are set to OpenGLES3 with a fallback to OpenGLES2 (no Vulkan)
   
    2. Change `Scripting Backend` to IL2CPP.

    3. Mark the following `Target Architectures` :
        - ARMv7        ✅
        - ARM64        ✅
        - x86          ✅


   **IOS Platform**:
    1. Other Settings find the Rendering part, uncheck the `Auto   Graphics API` and select only `OpenGLES2`.
    2. Depending on where you want to test or run your app, (simulator or physical device), you should select the appropriate SDK on `Target SDK`.
      <br />


      <img src="https://raw.githubusercontent.com/snowballdigital/flutter-unity-view-widget/master/Screenshot%202019-03-27%2007.31.55.png" width="400" />

<br />

### Add Unity Build Scripts and Export

Copy [`Build.cs`](https://github.com/f111fei/react-native-unity-demo/blob/master/unity/Cube/Assets/Scripts/Editor/Build.cs) and [`XCodePostBuild.cs`](https://github.com/f111fei/react-native-unity-demo/blob/master/unity/Cube/Assets/Scripts/Editor/XCodePostBuild.cs) to `unity/<Your Unity Project>/Assets/Scripts/Editor/`

Open your unity project in Unity Editor. Now you can export unity project with `Flutter/Export Android` or `Flutter/Export IOS` menu.

<img src="https://github.com/snowballdigital/flutter-unity-view-widget/blob/master/Screenshot%202019-03-27%2008.13.08.png?raw=true" width="400" />

Android will export unity project to `android/UnityExport`.

IOS will export unity project to `ios/UnityExport`.

<br />

 **Android Platform Only**

  1. After exporting the unity game, open Android Studio and and add the `Unity Classes` Java `.jar` file as a module to the unity project. You just need to do this once if you are exporting from the same version of Unity everytime. The `.jar` file is located in the ```<Your Flutter Project>/android/UnityExport/lib``` folder
  2. Next open `build.gradle` of `flutter_unity_widget` module and replace the dependencies with
```gradle
    dependencies {
        implementation project(':UnityExport') // The exported unity project
        implementation project(':unity-classes') // the unity classes module you added from step 1
    }
```
  3. Next open `build.gradle` of `UnityExport` module and replace the dependencies with
```gradle
    dependencies {
        implementation project(':unity-classes') // the unity classes module you added from step 1
    }
```
  4. Next open `build.gradle` of `UnityExport` module and remove these
```gradle
    bundle {
        language {
            enableSplit = false
        }
        density {
            enableSplit = false
        }
        abi {
            enableSplit = true
        }
    }
```

  **iOS Platform Only**

There are a few issues with the exported iOS project which need to be fixed first.
1. After exporting the unity game, add the following to the ios/Runner/Info.plist:
```
<key>io.flutter.embedded_views_preview</key>
<true/>
```
2. In ios/Flutter, add the following UnityConfig.xcconfig file:
```
UNITY_SCRIPTING_BACKEND = il2cpp;
GCC_PREFIX_HEADER = $(SRCROOT)/UnityExport/Classes/Prefix.pch;

HEADER_SEARCH_PATHS = $(inherited) "$(SRCROOT)/UnityExport/Classes" "$(SRCROOT)/UnityExport/Classes/Unity" "$(SRCROOT)/UnityExport/Classes/Native" "$(SRCROOT)/UnityExport/Libraries" "$(SRCROOT)/UnityExport/Libraries/libil2cpp/include" ${PODS_HEADER_PATHS};

LIBRARY_SEARCH_PATHS = $(inherited) "$(SRCROOT)/UnityExport/Libraries" "$(SRCROOT)/UnityExport/Libraries/libil2cpp/include" ${PODS_LIBRARY_PATHS};

// If using .net 4.0 in Unity, append -DNET_4_0 to OTHER_CFLAGS
OTHER_CFLAGS = $(inherited) -DINIT_SCRIPTING_BACKEND=1 -fno-strict-overflow -DRUNTIME_IL2CPP=1 -DNET_4_0;

OTHER_LDFLAGS = $(inherited) -lc++ -weak-lSystem -weak_framework CoreMotion -weak_framework GameKit -weak_framework iAd -framework AVFoundation -framework AudioToolbox -framework CFNetwork -framework CoreGraphics -framework CoreLocation -framework CoreMedia -framework CoreVideo -framework Foundation -framework MediaPlayer -framework MediaToolbox -framework Metal -framework OpenAL -framework OpenGLES -framework QuartzCore -framework SystemConfiguration -framework UIKit -liconv.2 -liPhone-lib -lil2cpp ${PODS_LIBRARIES};

CLANG_CXX_LANGUAGE_STANDARD = c++0x;
CLANG_CXX_LIBRARY = libc++;
CLANG_ENABLE_MODULES = NO;
CLANG_WARN_BOOL_CONVERSION = NO;
CLANG_WARN_CONSTANT_CONVERSION = NO;
CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES;
CLANG_WARN_EMPTY_BODY = NO;
CLANG_WARN_ENUM_CONVERSION = NO;
CLANG_WARN_INT_CONVERSION = NO;
CLANG_WARN_OBJC_ROOT_CLASS = YES;
CLANG_WARN_UNREACHABLE_CODE = NO;
CLANG_WARN__DUPLICATE_METHOD_MATCH = NO;
GCC_C_LANGUAGE_STANDARD = c99;
GCC_ENABLE_OBJC_EXCEPTIONS = NO;
GCC_ENABLE_CPP_RTTI = NO;
GCC_PRECOMPILE_PREFIX_HEADER = YES;
GCC_THUMB_SUPPORT = NO;
GCC_USE_INDIRECT_FUNCTION_CALLS = NO;
GCC_WARN_64_TO_32_BIT_CONVERSION = NO;
GCC_WARN_64_TO_32_BIT_CONVERSION[arch=*64] = YES;
GCC_WARN_ABOUT_RETURN_TYPE = YES;
GCC_WARN_UNDECLARED_SELECTOR = NO;
GCC_WARN_UNINITIALIZED_AUTOS = NO;
GCC_WARN_UNUSED_FUNCTION = NO;

ENABLE_BITCODE = NO;

COPY_PHASE_STRIP = YES;
STRIP_INSTALLED_PRODUCT = NO;

DEAD_CODE_STRIPPING = YES;
```
3. Update the existing xcconfigs (Debug and Release, unless you also have flavors, handle accordingly), to include the UnityConfig.xcconfig:
```
#include "Generated.xcconfig"
#include "UnityConfig.xcconfig"
```
4. Remove some files generated by Unity that cause issues when building for iOS;
```
TODO
```
5. Add the following to ios/Pods/Target Support Files/flutter_unity_widget/flutter_unity_widget.xcconfig:
```
HEADER_SEARCH_PATHS = $(inherited) "${PODS_ROOT}/../UnityExport/Classes" "${PODS_ROOT}/../UnityExport/Classes/Unity" "$${PODS_ROOT}/../Classes/Native" "${PODS_ROOT}/../UnityExport/Libraries" "${PODS_ROOT}/../UnityExport/Libraries/libil2cpp/include" ${PODS_HEADER_PATHS};
LIBRARY_SEARCH_PATHS = $(inherited) "${PODS_ROOT}/../UnityExport/Libraries" "${PODS_ROOT}/../UnityExport/Libraries/libil2cpp/include" ${PODS_LIBRARY_PATHS};
```

<br />
 
### Add UnityMessageManager Support

Copy [`UnityMessageManager.cs`](https://github.com/snowballdigital/flutter-unity-view-widget/blob/master/example/Unity/Assets/UnityMessageManager.cs) to your unity project.

Copy this folder [`JsonDotNet`](https://github.com/snowballdigital/flutter-unity-view-widget/tree/master/example/Unity/Assets/JsonDotNet) to your unity project.

Copy [`link.xml`](https://github.com/snowballdigital/flutter-unity-view-widget/blob/master/example/Unity/Assets/link.xml) to your unity project.

<br />

## Examples
### Simple Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class UnityDemoScreen extends StatefulWidget {

  UnityDemoScreen({Key key}) : super(key: key);

  @override
  _UnityDemoScreenState createState() => _UnityDemoScreenState();
}

class _UnityDemoScreenState extends State<UnityDemoScreen>{
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  UnityWidgetController _unityWidgetController;

  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: WillPopScope(
          onWillPop: () {
            // Pop the category page if Android back button is pressed.
          },
          child: Container(
            color: colorYellow,
            child: UnityWidget(
              onUnityViewCreated: onUnityCreated,
            ),
          ),
        ),
      ),
    );
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }
}
```
<br />

### Communicating with and from Unity

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class UnityDemoScreen extends StatefulWidget {

  UnityDemoScreen({Key key}) : super(key: key);

  @override
  _UnityDemoScreenState createState() => _UnityDemoScreenState();
}

class _UnityDemoScreenState extends State<UnityDemoScreen>{
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  UnityWidgetController _unityWidgetController;
  bool paused = false;


  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Unity Flutter Demo'),
        ),
        body: Container(
            child: Stack(
          children: <Widget>[
            UnityWidget(
              onUnityViewCreated: onUnityCreated,
            ),
            Positioned(
              bottom: 40.0,
              left: 80.0,
              right: 80.0,
              child: MaterialButton(
                onPressed: () {

                  if(paused) {
                    _unityWidgetController.resume();
                    setState(() {
                      paused = false;
                    });
                  } else {
                    _unityWidgetController.pause();
                    setState(() {
                      paused = true;
                    });
                  }
                },
                color: Colors.blue[500],
                child: Text(paused ? 'Start Game' : 'Pause Game'),
              ),
            ),
          ],
        )),
      ),
    );
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }
}

```

## API
 - pause()

## Known issues and their fix
 - Android Export gradle issues
 - iOS not working

[version-badge]: https://img.shields.io/pub/v/flutter_unity_widget.svg?style=flat-square
[package]: https://pub.dartlang.org/packages/flutter_unity_widget/versions/0.1.2
[license-badge]: https://img.shields.io/github/license/snowballdigital/flutter-unity-view-widget.svg?style=flat-square
[license]: https://github.com/snowballdigital/flutter-unity-view-widget/blob/master/LICENSE
[prs-badge]: https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square
[prs]: http://makeapullrequest.com
[github-watch-badge]: https://img.shields.io/github/watchers/snowballdigital/flutter-unity-view-widget.svg?style=social
[github-watch]: https://github.com/snowballdigital/flutter-unity-view-widget/watchers
[github-star-badge]: https://img.shields.io/github/stars/snowballdigital/flutter-unity-view-widget.svg?style=social
[github-star]: https://github.com/snowballdigital/flutter-unity-view-widget/stargazers
