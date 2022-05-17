#!/bin/bash
clear

if [ "$1" == "Robot-Framework-Android-Apps-And-Adb-Tests" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Robot Framework Android Apps and Adb Tests ]]]]------------------------------------"
  echo
  echo "This will run specific Android apps and adb shell tests based on a Robot Framework tag. Some tests will create screenshots and video recordings."
  echo
  echo "ATTENTION: This example requires Python 3."
  echo
  pip3 install virtualenv --user --force-reinstall > /dev/null 2>&1
  virtualenv -p python3 venv > /dev/null 2>&1
  source venv/bin/activate
  pip3 install -r ./Workshop-Examples/Tests/Workshop-Part-One/Resources/requirements.txt > /dev/null 2>&1
  #### The following command will run tests based on a tag name given through the terminal. For example "bash ./start-specific-appium-example-workflows-for-workshop.sh Robot-Framework-Android-Apps-And-Adb-Tests Android_Adb_PS_Command".
  #### Please keep one of these robot commands commented.
  robot --include "$2" --report NONE --log appium-android-apps-and-adb-log.html --output appium-android-apps-and-adb-output.xml -N "Robot Framework Appium Android Apps Test Run" -d ./Workshop-Examples/Results/Android-Apps-Test-Runs ./Workshop-Examples/Tests/Workshop-Part-One/Android-Device-App-Examples.robot
  #### The following command will run all of the tests tagged with "All_Android_Tests" in the Android-Device-App-Examples.robot file. Another way to run it is "bash ./start-specific-appium-example-workflows-for-workshop.sh Robot-Framework-Android-Apps-And-Adb-Tests All_Android_Tests".
  #### Please keep one of these robot commands commented.
  #robot --include All_Android_Tests --report NONE --log appium-android-log.html --output appium-android-output.xml -N "Robot Framework Appium Android Apps Test Run" -d ./Workshop-Examples/Results/Android-Apps-Test-Runs ./Workshop-Examples/Tests/Workshop-Part-One/Android-Device-App-Examples.robot
  exit
fi

if [ "$1" == "Robot-Framework-IOS-App-Tests" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Robot Framework IOS App Tests ]]]]------------------------------------"
  echo
  echo "This will run IOS app tests. Screenshots and video recordings will be created during this test run. The screen recording tests may not work properly, because of possible issues mentioned below."
  echo
  echo "https://github.com/appium/python-client/issues/266"
  echo
  echo "ATTENTION: This example requires Python 3."
  echo
  pip3 install virtualenv --user --force-reinstall > /dev/null 2>&1
  virtualenv -p python3 venv > /dev/null 2>&1
  source venv/bin/activate
  pip3 install -r ./Workshop-Examples/Tests/Workshop-Part-One/Resources/requirements.txt > /dev/null 2>&1
  robot --report NONE --log appium-ios-app-log.html --output appium-ios-app-output.xml -N "Robot Framework Appium IOS App Test Run" -d ./Workshop-Examples/Results/IOS-Apps-Test-Runs ./Workshop-Examples/Tests/Workshop-Part-One/IOS-Device-App*.robot
  exit
fi

if [ "$1" == "Robot-Framework-IOS-And-Android-Mobile-Browsers-Test-Examples" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Robot Framework IOS And Android Mobile Browsers Test Example ]]]]------------------------------------"
  echo
  echo "This will run mobile browser tests on IOS and Android."
  echo
  echo "ATTENTION: This example requires Python 3."
  echo
  pip3 install virtualenv --user --force-reinstall > /dev/null 2>&1
  virtualenv -p python3 venv > /dev/null 2>&1
  source venv/bin/activate
  pip3 install -r ./Workshop-Examples/Tests/Workshop-Part-One/Resources/requirements.txt > /dev/null 2>&1
  robot --report NONE --log appium-ios-and-android-mobile-browsers-log.html --output appium-ios-and-android-mobile-browsers-output.xml -N "Robot Framework Appium IOS And Android Mobile Browsers Test Run" -d ./Workshop-Examples/Results/IOS-Android-Mobile-Browsers-Test-Runs ./Workshop-Examples/Tests/Workshop-Part-One/IOS-Device-Safari-Examples.robot ./Workshop-Examples/Tests/Workshop-Part-One/Android-Device-Chrome-Examples.robot
  exit
fi

if [ "$1" == "Robot-Framework-Charles-Proxy-IOS-And-Android-Mobile-Browsers-Test-Example" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Robot Framework Charles Proxy IOS And Android Mobile Browsers Test Example ]]]]------------------------------------"
  echo
  echo "This will run Robot Framework and Appium on IOS and Android devices while performing a Charles Proxy Session Recording."
  echo
  echo "ATTENTION: This example requires Python 3."
  echo
  pip3 install virtualenv --user --force-reinstall > /dev/null 2>&1
  virtualenv -p python3 venv > /dev/null 2>&1
  source venv/bin/activate
  pip3 install -r ./Workshop-Examples/Tests/Workshop-Part-Two/Resources/requirements.txt > /dev/null 2>&1
  robot --report NONE --log appium-charles-proxy-ios-and-android-mobile-web-browsers-log.html --output appium-charles-proxy-ios-and-android-mobile-web-browsers-output.xml -N "Robot Framework Appium Charles Proxy IOS And Android Mobile Browsers Test Run" -d ./Workshop-Examples/Results/Charles-Proxy-IOS-Android-Test-Runs ./Workshop-Examples/Tests/Workshop-Part-Two/Charles-Proxy*.robot
  exit
fi

if [ "$1" == "Robot-Framework-Parallel-IOS-Android-Tests" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo "------------------------------------[[[[ Robot Framework Mobile Device Parallel Test Example ]]]]------------------------------------"
  echo
  echo "This will use PaBot, Robot Framework, Graphwalker (model-based testing tool), and Appium to run three different tests in parallel. Two different mobile device tests and an adb shell top monitoring test are running at the same time."
  echo
  echo "ATTENTION: This example requires Python 3."
  echo
  rm -rf ./Workshop-Examples/.pabotsuitenames
  rm -rf ./Workshop-Examples/Results/pabot_results
  pip3 install virtualenv --user --force-reinstall > /dev/null 2>&1
  virtualenv -p python3 venv > /dev/null 2>&1
  source venv/bin/activate
  pip3 install -r ./Workshop-Examples/Tests/Workshop-Part-Two/Resources/requirements.txt > /dev/null 2>&1
  pabot --verbose --variable USER_DEFINED_MONITORING_ITERATIONS:350 --variable USER_DEFINED_IOS_TEST_ITERATIONS:2 --report NONE --log appium-ios-android-monitoring-pabot-test-runs-log.html --output appium-ios-android-monitoring-pabot-test-runs-output.xml -N "Appium Run" -d ./Workshop-Examples/Results/Parallel-IOS-Android-Test-Runs ./Workshop-Examples/Tests/Workshop-Part-Two/PaBot-IOS*.robot ./Workshop-Examples/Tests/Workshop-Part-Two/PaBot-*.robot
  #pabot --variable USER_DEFINED_MONITORING_ITERATIONS:"$2" --variable USER_DEFINED_IOS_TEST_ITERATIONS:"$3" --report NONE --log appium-ios-android-monitoring-pabot-test-runs-log.html --output appium-ios-android-monitoring-pabot-test-runs-output.xml -N "Appium Run" -d ./Workshop-Examples/Results/Parallel-IOS-Android-Test-Runs ./Workshop-Examples/Tests/Workshop-Part-Two/PaBot-IOS*.robot ./Workshop-Examples/Tests/Workshop-Part-Two/PaBot-*.robot
  #robot --variable USER_DEFINED_MONITORING_ITERATIONS:"$2" --report NONE --log appium-ios-android-pabot-test-runs-log.html --output appium-ios-android-pabot-test-runs-output.xml -N "Appium Run" -d ./Workshop-Examples/Results/Parallel-IOS-Android-Test-Runs ./Workshop-Examples/Tests/Workshop-Part-Two/PaBot-Android-A*.robot
  robot --include "Performance_Graph" --report NONE --log measure-memory-usage.html --output measure-memory-usage.xml -N "Memory Usage" -d ./Workshop-Examples/Results/Parallel-IOS-Android-Test-Runs ./Workshop-Examples/Tests/Workshop-Part-Two/PaBot-Android-A*.robot > /dev/null 2>&1
  exit
fi

if [ "$1" == "Appium-No-Proxy-Test-Setup" ]; then
  path=$(pwd)
  npm install -g appium
  brew install ffmpeg
  brew install wget
  brew install jq
  rm -rf ./Workshop-Examples/.pabotsuitenames
  rm -rf ./Workshop-Examples/Results/pabot_results
  rm -rf ./Workshop-Examples/Results/Android-CPU-Memory-Usage-Logs/*.png
  rm -rf ./Workshop-Examples/Results/Android-CPU-Memory-Usage-Logs/*.html
  rm -rf ./Workshop-Examples/Results/Android-CPU-Memory-Usage-Logs/*.xml
  rm -rf ./Workshop-Examples/Results/Android-CPU-Memory-Usage-Logs/*.ffmpeg
  rm -rf ./Workshop-Examples/Results/Android-CPU-Memory-Usage-Logs/*.mp4
  rm -rf ./Workshop-Examples/Results/Android-CPU-Memory-Usage-Logs/*.txt
  rm -rf ./Workshop-Examples/Results/Android-Apps-Test-Runs/*.png
  rm -rf ./Workshop-Examples/Results/Android-Apps-Test-Runs/*.html
  rm -rf ./Workshop-Examples/Results/Android-Apps-Test-Runs/*.xml
  rm -rf ./Workshop-Examples/Results/Android-Apps-Test-Runs/*.ffmpeg
  rm -rf ./Workshop-Examples/Results/Android-Apps-Test-Runs/*.mp4
  rm -rf ./Workshop-Examples/Results/Android-Apps-Test-Runs/*.txt
  rm -rf ./Workshop-Examples/Results/IOS-Apps-Test-Runs/*.png
  rm -rf ./Workshop-Examples/Results/IOS-Apps-Test-Runs/*.html
  rm -rf ./Workshop-Examples/Results/IOS-Apps-Test-Runs/*.xml
  rm -rf ./Workshop-Examples/Results/IOS-Apps-Test-Runs/*.ffmpeg
  rm -rf ./Workshop-Examples/Results/IOS-Apps-Test-Runs/*.mp4
  rm -rf ./Workshop-Examples/Results/IOS-Apps-Test-Runs/*.txt
  rm -rf $path/Workshop-Examples/Shared-Resources/Wikipedia.apk
  rm -rf $path/Workshop-Examples/Shared-Resources/appium_output_log.txt
  rm -rf $path/Workshop-Examples/Shared-Resources/appium_server_PID*.txt
  rm -rf $path/Workshop-Examples/Shared-Resources/android_emulator_PID.txt
  rm -rf $path/Workshop-Examples/Tests/Workshop-Part-Two/AppiumGraphwalkerPath.csv
  rm -rf ./bugreport-*.zip
  wget -O $path/Workshop-Examples/Shared-Resources/Wikipedia.apk https://www.browserstack.com/app-automate/sample-apps/android/WikipediaSample.apk
  echo "------------------------------------[[[[ Appium No Proxy Test Setup ]]]]------------------------------------"
  echo
  echo "The following will set up a Robot Framework Appium without connecting to any proxies. This setup allows uninterupted access to the internet for all Appium connected devices."
  ####
  #### Copy and paste the following line for every new Android emulator device you want to add to every test setup. The following does not use Charles Proxy.
  ## "$HOME"/Library/Android/sdk/emulator/emulator -avd REPLACE_THIS_WITH_THE_NAME_OF_YOUR_ANDROID_EMULATOR -netdelay none -netspeed full > $path/Workshop-Examples/Shared-Resources/appium_output_log.txt 2>&1 & echo $!> $path/Workshop-Examples/Shared-Resources/android_emulator_PID.txt
  #### Copy and paste the following line for every new Android emulator device you want to add to every test setup. The following uses Charles Proxy.
  ## "$HOME"/Library/Android/sdk/emulator/emulator -avd REPLACE_THIS_WITH_THE_NAME_OF_YOUR_ANDROID_EMULATOR -netdelay none -netspeed full -http-proxy http://REPLACE_THIS_WITH_PROXY_IP:8888 > $path/Workshop-Examples/Shared-Resources/appium_output_log.txt 2>&1 & echo $!> $path/Workshop-Examples/Shared-Resources/android_emulator_PID.txt
  ####
  "$HOME"/Library/Android/sdk/emulator/emulator -avd Nexus_5_API_27 -netdelay none -netspeed full > $path/Workshop-Examples/Shared-Resources/appium_output_log.txt 2>&1 & echo $! > $path/Workshop-Examples/Shared-Resources/android_emulator_PID.txt
  #"$HOME"/Library/Android/sdk/emulator/emulator -avd Nexus_6_API_26 -netdelay none -netspeed full > $path/Workshop-Examples/Shared-Resources/appium_output_log.txt 2>&1 & echo $! > $path/Workshop-Examples/Shared-Resources/android_emulator_PID.txt
  #"$HOME"/Library/Android/sdk/emulator/emulator -avd Pixel_XL_API_28 -netdelay none -netspeed full > $path/Workshop-Examples/Shared-Resources/appium_output_log.txt 2>&1 & echo $! > $path/Workshop-Examples/Shared-Resources/android_emulator_PID.txt
  ####
  sleep 5s &&
  appium -p 4723 --webdriveragent-port 8109 >> $path/Workshop-Examples/Shared-Resources/appium_output_log.txt 2>&1 & echo $! > $path/Workshop-Examples/Shared-Resources/appium_server_PID1.txt &
  appium -p 4724 -bp 5724 --allow-insecure chromedriver_autodownload --relaxed-security >> $path/Workshop-Examples/Shared-Resources/appium_output_log.txt 2>&1 & echo $! > $path/Workshop-Examples/Shared-Resources/appium_server_PID2.txt &
  echo
  echo
  APPIUM_SERVER_PID1=$(cat ./Workshop-Examples/Shared-Resources/appium_server_PID1.txt)
  APPIUM_SERVER_PID2=$(cat ./Workshop-Examples/Shared-Resources/appium_server_PID2.txt)
  ANDROID_EMULATOR_PID=$(cat ./Workshop-Examples/Shared-Resources/android_emulator_PID.txt)
  echo "Starting Appium Server One on PID $APPIUM_SERVER_PID1"
  echo "Starting Appium Server Two on PID $APPIUM_SERVER_PID2"
  echo "Starting Android Emulator on PID $ANDROID_EMULATOR_PID"
  cd $path/Workshop-Examples/Tests/Workshop-Part-Two/Resources
  rm -rf ./*.jar
  wget https://github.com/GraphWalker/graphwalker-project/releases/download/4.2.0/graphwalker-cli-4.2.0.jar
  java -jar ./graphwalker-cli-4.2.0.jar offline --start-element press_one_button --model $path/Workshop-Examples/Tests/Workshop-Part-Two/GraphwalkerModel.graphml "random(edge_coverage(100))" | jq -r '.currentElementName' >> $path/Workshop-Examples/Tests/Workshop-Part-Two/AppiumGraphwalkerPath.csv
fi

if [ "$1" == "Appium-Charles-Proxy-Test-Setup" ]; then
  path=$(pwd)
  npm install -g appium
  brew install ffmpeg
  rm -rf ./Workshop-Examples/.pabotsuitenames
  rm -rf ./Workshop-Examples/Results/pabot_results
  rm -rf ./Workshop-Examples/Results/Android-CPU-Memory-Usage-Logs/*.png
  rm -rf ./Workshop-Examples/Results/Android-CPU-Memory-Usage-Logs/*.html
  rm -rf ./Workshop-Examples/Results/Android-CPU-Memory-Usage-Logs/*.xml
  rm -rf ./Workshop-Examples/Results/Android-CPU-Memory-Usage-Logs/*.ffmpeg
  rm -rf ./Workshop-Examples/Results/Android-CPU-Memory-Usage-Logs/*.mp4
  rm -rf ./Workshop-Examples/Results/Android-CPU-Memory-Usage-Logs/*.txt
  rm -rf ./Workshop-Examples/Results/Android-Apps-Test-Runs/*.png
  rm -rf ./Workshop-Examples/Results/Android-Apps-Test-Runs/*.html
  rm -rf ./Workshop-Examples/Results/Android-Apps-Test-Runs/*.xml
  rm -rf ./Workshop-Examples/Results/Android-Apps-Test-Runs/*.ffmpeg
  rm -rf ./Workshop-Examples/Results/Android-Apps-Test-Runs/*.mp4
  rm -rf ./Workshop-Examples/Results/Android-Apps-Test-Runs/*.txt
  rm -rf ./Workshop-Examples/Results/IOS-Apps-Test-Runs/*.png
  rm -rf ./Workshop-Examples/Results/IOS-Apps-Test-Runs/*.html
  rm -rf ./Workshop-Examples/Results/IOS-Apps-Test-Runs/*.xml
  rm -rf ./Workshop-Examples/Results/IOS-Apps-Test-Runs/*.ffmpeg
  rm -rf ./Workshop-Examples/Results/IOS-Apps-Test-Runs/*.mp4
  rm -rf ./Workshop-Examples/Results/IOS-Apps-Test-Runs/*.txt
  rm -rf $path/Workshop-Examples/Shared-Resources/appium_output_log.txt
  rm -rf $path/Workshop-Examples/Shared-Resources/appium_server_PID*.txt
  rm -rf $path/Workshop-Examples/Shared-Resources/android_emulator_PID.txt
  rm -rf $path/Workshop-Examples/Tests/Workshop-Part-Two/AppiumGraphwalkerPath.csv
  rm -rf ./bugreport-*.zip
  echo "------------------------------------[[[[ Appium Charles Proxy Test Setup ]]]]------------------------------------"
  echo
  echo "The following will set up a Robot Framework Appium test combined with Charles Proxy. This will **RECORD ALL** of the HTTP and SSL/HTTPS traffic on your computer and connected mobile devices."
  echo
  echo "WARNING: The Charles Proxy tests will change your system's network settings and **IT WILL DISRUPT** your computer's network connection and especially your browser's connection to the Internet."
  echo "Please **DON'T PANIC**, the changes Charles Proxy makes are reversible. The following documentation should help with restoring network settings back to normal, and it should cover Charles Proxy related browser disruptions."
  echo
  echo "https://www.charlesproxy.com/documentation/faqs/can-no-longer-browse-without-charles-running/"
  echo
  ####
  #### Copy and paste the following line for every new Android emulator device you want to add to every test setup. The following does not use Charles Proxy.
  ## "$HOME"/Library/Android/sdk/emulator/emulator -avd REPLACE_THIS_WITH_THE_NAME_OF_YOUR_ANDROID_EMULATOR -netdelay none -netspeed full > $path/Workshop-Examples/Shared-Resources/appium_output_log.txt 2>&1 & echo $!> $path/Workshop-Examples/Shared-Resources/android_emulator_PID.txt
  #### Copy and paste the following line for every new Android emulator device you want to add to every test setup. The following uses Charles Proxy.
  ## "$HOME"/Library/Android/sdk/emulator/emulator -avd REPLACE_THIS_WITH_THE_NAME_OF_YOUR_ANDROID_EMULATOR -netdelay none -netspeed full -http-proxy http://REPLACE_THIS_WITH_PROXY_IP:8888 > $path/Workshop-Examples/Shared-Resources/appium_output_log.txt 2>&1 & echo $!> $path/Workshop-Examples/Shared-Resources/android_emulator_PID.txt
  ####
  #### The following is an Android emulator that is pre-set with the correct port and localhost IP to connect to Charles Proxy
  "$HOME"/Library/Android/sdk/emulator/emulator -avd Nexus_5_API_27 -netdelay none -netspeed full -http-proxy http://127.0.01:8888 > $path/Workshop-Examples/Shared-Resources/appium_output_log.txt 2>&1 & echo $! > $path/Workshop-Examples/Shared-Resources/android_emulator_PID.txt
  ####
  sleep 5s &&
  appium -p 4723 --webdriveragent-port 8109 >> $path/Workshop-Examples/Shared-Resources/appium_output_log.txt 2>&1 & echo $! > $path/Workshop-Examples/Shared-Resources/appium_server_PID1.txt &
  appium -p 4724 -bp 5724 --allow-insecure chromedriver_autodownload --relaxed-security >> $path/Workshop-Examples/Shared-Resources/appium_output_log.txt 2>&1 & echo $! > $path/Workshop-Examples/Shared-Resources/appium_server_PID2.txt &
  echo
  echo
  APPIUM_SERVER_PID1=$(cat ./Workshop-Examples/Shared-Resources/appium_server_PID1.txt)
  APPIUM_SERVER_PID2=$(cat ./Workshop-Examples/Shared-Resources/appium_server_PID2.txt)
  ANDROID_EMULATOR_PID=$(cat ./Workshop-Examples/Shared-Resources/android_emulator_PID.txt)
  echo "Starting Appium Server One on PID $APPIUM_SERVER_PID1"
  echo "Starting Appium Server Two on PID $APPIUM_SERVER_PID2"
  echo "Starting Android Emulator on PID $ANDROID_EMULATOR_PID"
fi

if [ "$1" == "All-Appium-Tests-Teardown" ]; then
  APPIUM_SERVER_PID1=$(cat ./Workshop-Examples/Shared-Resources/appium_server_PID1.txt)
  APPIUM_SERVER_PID2=$(cat ./Workshop-Examples/Shared-Resources/appium_server_PID2.txt)
  ANDROID_EMULATOR_PID=$(cat ./Workshop-Examples/Shared-Resources/android_emulator_PID.txt)
  echo "------------------------------------[[[[ All Appium Tests Teardown ]]]]------------------------------------"
  echo
  echo "The following will clean up all instances of Appium that are running on a specific PID."
  echo "This should also clean up any other lingering processes related to these tests."
  echo
  adb kill-server > /dev/null 2>&1
  sleep 5s &&
  kill -s 9 $APPIUM_SERVER_PID1
  kill -s 9 $APPIUM_SERVER_PID2
  kill -s 9 $ANDROID_EMULATOR_PID
  pgrep node | xargs kill > /dev/null 2>&1
  pgrep xcode | xargs kill > /dev/null 2>&1
  pgrep appium | xargs kill > /dev/null 2>&1
  pgrep chromedriver | xargs kill > /dev/null 2>&1
  pgrep emulator | xargs kill > /dev/null 2>&1
  pgrep adb | xargs kill > /dev/null 2>&1
  echo "Stopping Appium Server One on PID $APPIUM_SERVER_PID1"
  echo "Stopping Appium Server Two on PID $APPIUM_SERVER_PID2"
  echo "Stopping Android Emulator on PID $ANDROID_EMULATOR_PID"
  echo
  echo "Appium clean up should definitely be finished by now. It should be ready to be started again."
  echo "Run the following if you are not sure... ps -A | grep appium"
  echo
  ps -A | grep appium
fi

if [ "$1" == "Gather-Mobile-Device-Memory-Data-And-Create-Visual-Graph" ]; then
  # Before running this step you need to manually create your own ".env" file using the provided "template.env" file.
  source ./.env
  echo
  echo
  pip3 install virtualenv --user --force-reinstall > /dev/null 2>&1
  virtualenv -p python3 venv > /dev/null 2>&1
  source venv/bin/activate
  pip3 install -r ./Workshop-Examples/Tests/Workshop-Part-Two/Resources/requirements.txt > /dev/null 2>&1
  robot --include "Performance_Graph" --report NONE --log measure-memory-usage.html --output measure-memory-usage.xml -N "Memory Usage" -d ./Workshop-Examples/Results/Parallel-IOS-Android-Test-Runs ./Workshop-Examples/Tests/Workshop-Part-Two/PaBot-Android-A*.robot
  exit
fi

usage_explanation() {
  echo
  echo
  echo "------------------------------------[[[[ Tool Runner Script ]]]]------------------------------------"
  echo
  echo
  echo "Please read the following to get a full explanation about how this works."
  echo
  echo "https://github.com/jg8481/Getting-Started-Robotframework-AppiumLibrary-RoboCon-2021/blob/master/README.md"
  echo
  echo
}

error_handler() {
  local error_message="$@"
  echo "${error_message}" 1>&2;
}

argument="$1"
if [[ -z $argument ]] ; then
  usage_explanation
else
  case $argument in
    -h|--help)
      usage_explanation
      ;;
    *)
      usage_explanation
      ;;
  esac
fi
