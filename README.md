# Getting started with the Robotframework-AppiumLibrary - RoboCon 2021 Workshop

## General Information

This [repo](https://github.com/jg8481/Getting-Started-Robotframework-AppiumLibrary-RoboCon-2021) contains all of the examples that will be covered in the "Getting started with the Robotframework-AppiumLibrary" online workshop. The core audience for this workshop are beginners but there's also content mentioned below that could be interesting to more advanced testers as well. A lot of the examples kept in this repo were heavily influenced by the [Robot-Framework-Lone-Tester-Strategies-RoboCon-2019](https://github.com/jg8481/Robot-Framework-Lone-Tester-Strategies-RoboCon-2019) and [Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019](https://github.com/jg8481/Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019) work and experiments I have done in the past. More information about this RoboCon 2021 workshop can be found here... https://robocon.io/#workshops

Bonus Content: There are some possibly interesting extras in the repo that I did not mention in the original workshop bio. They are...
- Parallel running Appium + Grahpwalker example (written in a single `.robot` file) uing PaBot.
- Parallel running Android adb shell CPU monitoring example using PaBot and the top Linux CLI tool.
- Several adb shell + Robotframework-AppiumLibrary examples.
- Some video capture examples.

The following are the basic technical requirements to run the examples during the workshop.
- Python 3 (this workshop was created using Python 3.9.2) -> https://www.python.org/downloads/
- NodeJS 14 (this workshop was created using Node 14.16.0) -> https://nodejs.org/en/ or use https://github.com/nvm-sh/nvm
- Java 11 (this workshop was created using OpenJDK 11.0.10) -> https://www.java.com/en/
- Appium (the server, found on NPM) -> http://appium.io/docs/en/about-appium/getting-started/?lang=en#getting-started
- Android Studio (available for Windows, MacOS, Linux users etc.) - https://developer.android.com/studio
- XCode (only available for MacOS users) - https://developer.apple.com/xcode/
- Robot Framework and Robotframework-AppiumLibrary -> https://robotframework.org
- PaBot (this workshop was created using version 1.10.1) -> https://github.com/mkorpela/pabot
- Charles Proxy -> https://www.charlesproxy.com/documentation/proxying
- Graphwalker -> https://github.com/GraphWalker/graphwalker-project
- Appium Desktop -> https://github.com/appium/appium-desktop
- wget -> https://www.gnu.org/software/wget/
- cURL -> https://curl.se/
- jq -> https://stedolan.github.io/jq/
- git -> https://git-scm.com/

After installing the basic technical requirements on your machine (depending on the OS: Windows, MacOS, Linux etc.) please run the following on your machine.
```
git clone https://github.com/jg8481/Getting-Started-Robotframework-AppiumLibrary-RoboCon-2021.git
cd ./Getting-Started-Robotframework-AppiumLibrary-RoboCon-2021
```
Set up an `.env` file using the provided `template.env` file.

## Workshop Examples

There will be presentation slides explaining the following in more detail and I will assist everyone with running them.

1. Workshop-Part-One: Simple automation workflows for IOS apps and automation workflows for Android apps + adb shell.
```
>> Following commands need to run first before any other examples in Workshop-Part-One. <<
bash ./start-specific-appium-example-workflows-for-workshop.sh All-Appium-Tests-Teardown &&
bash ./start-specific-appium-example-workflows-for-workshop.sh Appium-No-Proxy-Test-Setup

>> Each command runs a group of examples for Workshop-Part-One. <<
bash ./start-specific-appium-example-workflows-for-workshop.sh Robot-Framework-Android-Apps-And-Adb-Tests Android_Adb
bash ./start-specific-appium-example-workflows-for-workshop.sh Robot-Framework-Android-Apps-And-Adb-Tests Android_App_Recording_Screen_Capture
bash ./start-specific-appium-example-workflows-for-workshop.sh Robot-Framework-IOS-App-Tests
bash ./start-specific-appium-example-workflows-for-workshop.sh Robot-Framework-IOS-And-Android-Mobile-Browsers-Test-Examples

```

2. Workshop-Part-Two: PaBot, Charles Proxy, Graphwalker, and adb shell CPU usage monitoring workflows.
```
>> Following commands need to run first before any other examples in Workshop-Part-Two. <<
bash ./start-specific-appium-example-workflows-for-workshop.sh All-Appium-Tests-Teardown &&
bash ./start-specific-appium-example-workflows-for-workshop.sh Appium-Charles-Proxy-Test-Setup

>> Each command runs a group of examples for Workshop-Part-Two. <<
bash ./start-specific-appium-example-workflows-for-workshop.sh Robot-Framework-Charles-Proxy-IOS-And-Android-Mobile-Browsers-Test-Example
bash ./start-specific-appium-example-workflows-for-workshop.sh Robot-Framework-Parallel-IOS-Android-Tests
```

The Workshop Examples use a lot of Bash scripting for setting up Appium and running Robot Framework. If you have a Windows operating system, the following options may work for you...
- Windows 10 users can check out the "Windows Subsystem for Linux" -> https://docs.microsoft.com/en-us/windows/wsl/
- Consider downloading Git for Windows -> https://git-scm.com/download/win and https://gitforwindows.org/
- There's also CygWin -> https://www.cygwin.com/
- It's possible to run the Android Workshop Examples from a Linux virtual machine running on Windows.
- As a last resort, you can copy the commands and run them individually from your Windows machine.

## Big thank you to the following people and groups.

- Pekka Klarck
- Ed Manlove
- Serhat Bolsu
- Antti Karjalainen
- René Rohner
- James Bach
- Jonathon Bach
- Michael Bolton
- Cem Kaner
- Kristian Karl
- Mikko Korpela
- Bryan Oakley
- Shiva Prasad Adirala
- The Appium development team
- The Graphwalker development team
- The entire Robot Framework community and its contributors

Their contributions to the testing community helped me a lot with this workshop and my day-to-day work.
