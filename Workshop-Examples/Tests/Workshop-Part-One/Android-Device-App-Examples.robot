*** Settings ***
Documentation    Simple Android app examples using AppiumLibrary. There are several tests below using adb shell. Please check out this great reference
...              to see hundreds more adb command examples -> https://gist.github.com/Pulimet/5013acf2cd5b28e55036c82c91bd56d8

Resource         ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-One//Resources//Appium-Mobile-Resources.robot

Suite Setup    Close All Android Apps Without Device Reboot    5
Suite Teardown    Close All Android Apps Without Device Reboot    5

*** Variables ***

${PATH}    ${EXECDIR}
${TEST_SUITE_TIMEOUT}     5
${TEST_SUITE_SECONDS_DELAY}    5

*** Test Cases ***

ANDROID APP TEST 1 : Run an adb command on a connected Android device to check the status of a specific app process that is active.
    [Tags]    Android_Adb    Android_Adb_PS_Command    Emulator_Android_Device    All_Android_Tests
    [Setup]   Open Existing Default Installed Android App
    Wait Until Page Contains    DEL    1s
    Run PS Command In Adb Shell And Check Process Status    calculator
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s

ANDROID APP TEST 2 : Run an adb shell command on a connected Android device to check the file system contents for the current directory on the device.
    [Tags]    Android_Adb    Android_Adb_LS_Command    Emulator_Android_Device    All_Android_Tests
    [Setup]   Open Existing Default Installed Android App
    Run Process    adb shell ls    alias=check_adb_ls_output    shell=True    timeout=20s    on_timeout=continue
    ${CHECK_ADB_OUTPUT}=   	Get Process Result   check_adb_ls_output    stdout=true
    Log To Console    ${CHECK_ADB_OUTPUT}
    Log    ${CHECK_ADB_OUTPUT}

ANDROID APP TEST 3 : Run an adb shell command on a connected Android device to check that a specific package is installed.
    [Tags]    Android_Adb    Android_Adb_Dumpsys_Grep_Command    Emulator_Android_Device    All_Android_Tests
    [Setup]   Open Existing Default Installed Android App
    ${CHECK_ADB_OUTPUT}=    Run Any Adb Shell Commands And Return Output    dumpsys package packages | grep calculator
    Should Contain    ${CHECK_ADB_OUTPUT}    calculator
    Log To Console    ${CHECK_ADB_OUTPUT}
    Log    ${CHECK_ADB_OUTPUT}

ANDROID APP TEST 4 : Run an adb shell command on a connected Android device to check detailed information on all installed packages.
    [Tags]    Android_Adb    Android_Adb_Dumpsys_Package_Command    Emulator_Android_Device    All_Android_Tests
    [Setup]   Open Existing Default Installed Android App
    ${CHECK_ADB_OUTPUT}=    Run Any Adb Shell Commands And Return Output    dumpsys package packages
    Should Contain    ${CHECK_ADB_OUTPUT}    calculator
    Should Contain    ${CHECK_ADB_OUTPUT}    wikipedia
    Log To Console    ${CHECK_ADB_OUTPUT}
    Log    ${CHECK_ADB_OUTPUT}

ANDROID APP TEST 5 : Run an adb shell command on a connected Android device to check a list of feature information about the connected device.
    [Tags]    Android_Adb    Android_Adb_PM_List_Command    Emulator_Android_Device    All_Android_Tests
    [Setup]   Open Existing Default Installed Android App
    ${CHECK_ADB_OUTPUT}=    Run Any Adb Shell Commands And Return Output    pm list features
    Should Not Be Empty    ${CHECK_ADB_OUTPUT}
    Log To Console    ${CHECK_ADB_OUTPUT}
    Log    ${CHECK_ADB_OUTPUT}

ANDROID APP TEST 6 : Run an adb shell command on a connected Android device to check the current version of Android OS on the device.
    [Tags]    Android_Adb    Android_Adb_Build_Version_Command    Emulator_Android_Device    All_Android_Tests
    [Setup]   Open Existing Default Installed Android App
    ${CHECK_ADB_OUTPUT}=    Run Any Adb Shell Commands And Return Output    getprop ro.build.version.release
    Should Not Be Empty    ${CHECK_ADB_OUTPUT}
    Log To Console    ${CHECK_ADB_OUTPUT}
    Log    ${CHECK_ADB_OUTPUT}

ANDROID APP TEST 7 : Run an adb shell command on a connected Android device to check netstat (network statistics) for incoming and outgoing TCP connections going through the device.
    [Tags]    Android_Adb    Android_Adb_Netstat_Command    Emulator_Android_Device    All_Android_Tests
    [Setup]   Open Existing Default Installed Android App
    ${CHECK_ADB_OUTPUT}=    Run Any Adb Shell Commands And Return Output    netstat
    Should Not Be Empty    ${CHECK_ADB_OUTPUT}
    Log To Console    ${CHECK_ADB_OUTPUT}
    Log    ${CHECK_ADB_OUTPUT}

ANDROID APP TEST 8 : Run an adb shell command on a connected Android device to bring up the contacts list.
    [Tags]    Android_Adb    Android_Adb_Contacts_List_Command    Emulator_Android_Device    All_Android_Tests
    [Setup]   Open Existing Default Installed Android App
    ${CHECK_ADB_OUTPUT}=    Run Any Adb Shell Commands And Return Output    input keyevent 207
    Log    ${CHECK_ADB_OUTPUT}
    Wait Until Page Contains    contacts    1s
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s

ANDROID APP TEST 9 : Run an adb shell command on a connected Android device to start a phone call, then end the call.
    [Tags]    Android_Adb    Android_Adb_Phone_Call_Command    Emulator_Android_Device    All_Android_Tests
    [Setup]   Open Existing Default Installed Android App
    ${CHECK_ADB_OUTPUT}=    Run Any Adb Shell Commands And Return Output    am start -a android.intent.action.CALL -d tel:8888888888
    Log    ${CHECK_ADB_OUTPUT}
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    ${CHECK_ADB_OUTPUT}=    Run Any Adb Shell Commands And Return Output    input keyevent 6
    Log To Console    ${CHECK_ADB_OUTPUT}
    Log    ${CHECK_ADB_OUTPUT}

ANDROID APP TEST 10 : Run an adb shell command on a connected Android device to prepare a text message from an Android device.
    [Tags]    Android_Adb    Android_Adb_Text_Message_Command    Emulator_Android_Device    All_Android_Tests
    [Setup]   Open Existing Default Installed Android App
    ${CHECK_ADB_OUTPUT}=    Run Any Adb Shell Commands And Return Output    am start -a android.intent.action.SENDTO -d sms:+8888888888 --es sms_body "Testing the SMS screen from an Android device." --ez exit_on_sent false
    Log To Console    ${CHECK_ADB_OUTPUT}
    Log    ${CHECK_ADB_OUTPUT}
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s

ANDROID APP TEST 11 : Run an adb shell command on a connected Android device to run logcat to collect the device's system logs in a file.
    [Tags]    Android_Adb    Android_Adb_Logcat_Command    Emulator_Android_Device    All_Android_Tests
    [Setup]   Open Existing Default Installed Android App
    Run Logcat Command In Adb Shell Collect Output In Text File

ANDROID APP TEST 12 : Run an adb shell command on a connected Android device to run bugreport to collect the device's system logs, stack traces, and other helpful diagnostic data.
    [Tags]    Android_Adb    Android_Adb_Bugreport_Command    Emulator_Android_Device    All_Android_Tests
    [Setup]   Open Existing Default Installed Android App
    Run Bugreport Command In Adb Shell Collect Output In Zip File

ANDROID APP TEST 13 : Install the Wikipedia app on an Android device and open it.
    [Tags]    Android_App_Recording_Screen_Capture    Emulator_Android_Device    All_Android_Tests
    [Setup]   Install And Open New Android App
    Run Keyword And Continue On Failure    Wait Until Page Contains    Wikipedia    5s
    Run Keyword And Continue On Failure    Capture Page Screenshot
    Run Keyword And Continue On Failure    Start Screen Recording
    Run Keyword And Continue On Failure    Sleep    ${TEST_SUITE_SECONDS_DELAY}s

ANDROID APP TEST 14 : Switch the Android device to landscape mode then switch it back to portrait.
    [Tags]    Android_App_Recording_Screen_Capture    Emulator_Android_Device    All_Android_Tests
    Run Keyword And Continue On Failure    Check Landscape Mode Take Screenshot Then Go Back To Portrait Mode

ANDROID APP TEST 15 : Tap the search field and search for cat on Wikipedia.
    [Tags]    Android_App_Recording_Screen_Capture    Emulator_Android_Device    All_Android_Tests
    Run Keyword And Continue On Failure    Tap According To Specific Element Then Check Until Screen Shows Text    xpath=(//android.widget.ImageView[@content-desc="Search Wikipedia"])[1]    Search
    Run Keyword And Continue On Failure    Input Text    id=org.wikipedia.alpha:id/search_src_text    cat
    Run Keyword And Continue On Failure    Wait Until Page Contains    Cat    5s
    Run Keyword And Continue On Failure    Capture Page Screenshot
    Run Keyword And Continue On Failure    Sleep    ${TEST_SUITE_SECONDS_DELAY}s

ANDROID APP TEST 16 : Tap the search field and search for dog on Wikipedia.
    [Tags]    Android_App_Recording_Screen_Capture    Emulator_Android_Device    All_Android_Tests
    Run Keyword And Continue On Failure    Tap According To Specific Element Then Check Until Screen Shows Text    xpath=(//android.widget.ImageView[@content-desc="Search Wikipedia"])[1]    Search
    Run Keyword And Continue On Failure    Input Text    id=org.wikipedia.alpha:id/search_src_text    dog
    Run Keyword And Continue On Failure    Wait Until Page Contains    Dog    5s
    Run Keyword And Continue On Failure    Capture Page Screenshot
    Run Keyword And Continue On Failure    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Run Keyword And Continue On Failure    Stop Screen Recording

ANDROID APP TEST 17 : Install the Wikipedia app on a real Android device.
    [Tags]    Real_Android_Device
    Install And Open New Android App On Real Devices

*** Keywords ***

Run PS Command In Adb Shell And Check Process Status
    [Arguments]     ${GREP_FILTER}
    ${ADB_SHELL_PS_OUTPUT}=    Execute Adb Shell    ps | grep ${GREP_FILTER}
    Log To Console    ${ADB_SHELL_PS_OUTPUT}
    Log    ${ADB_SHELL_PS_OUTPUT}

Run Any Adb Shell Commands And Return Output
    [Arguments]     ${ADB_COMMANDS}
    ${ADB_SHELL_COMMAND_OUTPUT}=    Execute Adb Shell    ${ADB_COMMANDS}
    [Return]    ${ADB_SHELL_COMMAND_OUTPUT}

Run Logcat Command In Adb Shell Collect Output In Text File
    Run    adb logcat -d > ${PATH}//Workshop-Examples//Shared-Resources//logcat-file.txt
    ${ADB_LOGCAT_OUTPUT}=   	Get File    ${PATH}//Workshop-Examples//Shared-Resources//logcat-file.txt
    Log    ${ADB_LOGCAT_OUTPUT}
    Run Process    ls -l ${PATH}//Workshop-Examples//Shared-Resources | grep logcat-file.txt    alias=check_logcat_in_directory    shell=True    timeout=20s    on_timeout=continue
    ${CHECK_LOGCAT_FILE}=   	Get Process Result   check_logcat_in_directory    stdout=true
    Log To Console    ${CHECK_LOGCAT_FILE}
    Log    ${CHECK_LOGCAT_FILE}

Run Bugreport Command In Adb Shell Collect Output In Zip File
    Run    adb bugreport > ${PATH}//Workshop-Examples//Shared-Resources//bugreport-files.txt
    ${ADB_BUGREPORT_OUTPUT}=   	Get File    ${PATH}//Workshop-Examples//Shared-Resources//bugreport-files.txt
    Log To Console    ${ADB_BUGREPORT_OUTPUT}
    Log    ${ADB_BUGREPORT_OUTPUT}

Close All Android Apps Without Device Reboot
    [Arguments]     ${REPEAT_KEYWORD_ITERATIONS}
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Run Keyword And Ignore Error    Repeat Keyword    ${REPEAT_KEYWORD_ITERATIONS} times    Close Android Apps With Adb Shell And Appium Keyword
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s