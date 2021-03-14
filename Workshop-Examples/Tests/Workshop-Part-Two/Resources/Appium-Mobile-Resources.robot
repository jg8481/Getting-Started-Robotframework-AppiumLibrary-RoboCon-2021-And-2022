*** Settings ***

Library           AppiumLibrary    run_on_failure=No Operation
Library           OperatingSystem
Library           Screenshot
Library           Process
Library           String
Library           Collections

*** Variables ***

${PLATFORM_VERSION_IOS}    %{PLATFORM_VERSION_IOS}
${IOS_AUTOMATION_NAME}    XCUITest
${PLATFORM_NAME_IOS}    iOS

${PLATFORM_VERSION_ANDROID}    %{PLATFORM_VERSION_ANDROID}
${PLATFORM_NAME_ANDROID}    Android
${ANDROID_AUTOMATION_NAME}    UiAutomator2

${TEST_SUITE_TIMEOUT}    1
${RETRY_AMOUNT}    4

*** Keywords ***

Set Up Native Default Android App
    [Arguments]     ${APPIUM_REMOTE_URL}    ${DEVICE_NAME_ANDROID}    ${APPIUM_PORT}    ${ANDROID_APP_ACTIVITY}    ${ANDROID_APP_PACKAGE}
    Open Application    ${APPIUM_REMOTE_URL}    platformName=${PLATFORM_NAME_ANDROID}    deviceName=${DEVICE_NAME_ANDROID}    appActivity=${ANDROID_APP_ACTIVITY}     appPackage=${ANDROID_APP_PACKAGE}    automationName=${ANDROID_AUTOMATION_NAME}

Set Up New Android App
    [Arguments]     ${APPIUM_REMOTE_URL}    ${DEVICE_NAME_ANDROID}    ${APPIUM_PORT}    ${ANDROID_APP_FILE}
    Open Application    ${APPIUM_REMOTE_URL}    platformName=${PLATFORM_NAME_ANDROID}    deviceName=${DEVICE_NAME_ANDROID}    app=${ANDROID_APP_FILE}    automationName=${ANDROID_AUTOMATION_NAME}

Set Up New IOS App
    [Arguments]     ${APPIUM_REMOTE_URL}    ${DEVICE_NAME_IOS}    ${IOS_APP_FILE}
    Open Application    ${APPIUM_REMOTE_URL}    platformName=${PLATFORM_NAME_IOS}    platformVersion=${PLATFORM_VERSION_IOS}    devicetype=simulator
    ...    deviceName=${DEVICE_NAME_IOS}    app=${IOS_APP_FILE}    automationName=${IOS_AUTOMATION_NAME}     startIWDP=true

Set Up Chrome In Android
    [Arguments]     ${PARALLEL_APPIUM_REMOTE_URL}    ${DEVICE_NAME_ANDROID}     ${PARALLEL_APPIUM_PORT}
    Open Application    ${PARALLEL_APPIUM_REMOTE_URL}    platformName=${PLATFORM_NAME_ANDROID}    deviceName=${DEVICE_NAME_ANDROID}    PORT=${PARALLEL_APPIUM_PORT}    automationName=${ANDROID_AUTOMATION_NAME}    browserName=Chrome    newCommandTimeout=3600
    Go To Url    %{APP_URL}
    Sleep    1s

Set Up Safari In IOS
    [Arguments]     ${PARALLEL_APPIUM_REMOTE_URL}    ${DEVICE_NAME_IOS}    ${PARALLEL_APPIUM_PORT}    ${PARALLEL_APPIUM_WDALOCALPORT}
    Open Application    ${PARALLEL_APPIUM_REMOTE_URL}    platformName=${PLATFORM_NAME_IOS}    platformVersion=${PLATFORM_VERSION_IOS}    devicetype=simulator
    ...    deviceName=${DEVICE_NAME_IOS}    PORT=${PARALLEL_APPIUM_PORT}    WDALOCALPORT=${PARALLEL_APPIUM_WDALOCALPORT}    automationName=${IOS_AUTOMATION_NAME}     startIWDP=true
    ...    browserName=Safari     bundleid=com.apple.mobilesafari
    Go To Url    %{APP_URL}
    Wait Until Keyword Succeeds   ${RETRY_AMOUNT}x    0.1 sec    Wait Until Page Contains    Password    0.5s
    Sleep    1s

Set Up Safari In IOS After Starting Charles Proxy
    [Timeout]    4 minutes
    [Arguments]     ${PARALLEL_APPIUM_REMOTE_URL}    ${DEVICE_NAME_IOS}    ${PARALLEL_APPIUM_PORT}    ${PARALLEL_APPIUM_WDALOCALPORT}    ${CHARLES_PROXY_APPIUM_EXAMPLE_URL}
    Run Process    ps aux | grep Charles     alias=charles_proxy_mac_os_status    shell=True    timeout=20s    on_timeout=continue
    ${CHARLES_PROXY_MAC_OS_STATUS}=   	Get Process Result    charles_proxy_mac_os_status    stdout=true
    Log    ${CHARLES_PROXY_MAC_OS_STATUS}
    Should Contain    ${CHARLES_PROXY_MAC_OS_STATUS}    Charles.app
    Run Keyword And Ignore Error    Open Application    ${PARALLEL_APPIUM_REMOTE_URL}    platformName=${PLATFORM_NAME_IOS}    platformVersion=${PLATFORM_VERSION_IOS}    devicetype=simulator
    ...    deviceName=${DEVICE_NAME_IOS}    PORT=${PARALLEL_APPIUM_PORT}    WDALOCALPORT=${PARALLEL_APPIUM_WDALOCALPORT}    automationName=${IOS_AUTOMATION_NAME}     startIWDP=true
    ...    browserName=Safari     bundleid=com.apple.mobilesafari
    Go To Url    ${CHARLES_PROXY_APPIUM_EXAMPLE_URL}
    Sleep    4s

Set Up Chrome In Android After Starting Charles Proxy
    [Timeout]    4 minutes
    [Arguments]     ${PARALLEL_APPIUM_REMOTE_URL}    ${DEVICE_NAME_ANDROID}     ${PARALLEL_APPIUM_PORT}
    Run Process    ps aux | grep Charles     alias=charles_proxy_mac_os_status    shell=True    timeout=20s    on_timeout=continue
    ${CHARLES_PROXY_MAC_OS_STATUS}=   	Get Process Result    charles_proxy_mac_os_status    stdout=true
    Log    ${CHARLES_PROXY_MAC_OS_STATUS}
    Should Contain    ${CHARLES_PROXY_MAC_OS_STATUS}    Charles.app
    Run Keyword And Ignore Error    Open Application    ${PARALLEL_APPIUM_REMOTE_URL}    platformName=${PLATFORM_NAME_ANDROID}    deviceName=${DEVICE_NAME_ANDROID}    PORT=${PARALLEL_APPIUM_PORT}    automationName=${ANDROID_AUTOMATION_NAME}    browserName=Chrome    newCommandTimeout=3600
    Go To Url    ${CHARLES_PROXY_APPIUM_EXAMPLE_URL}
    Sleep    4s

Stop Any Running Android Emulators And Related Processes On MacOS
    Run Keyword And Ignore Error    Run    ANDROID_EMULATOR_PID=$(cat ./Workshop-Examples/Shared-Resources/android_emulator_PID.txt) && kill -s 9 $ANDROID_EMULATOR_PID
    Run Keyword And Ignore Error    Run    pgrep emulator | xargs kill
    Run Keyword And Ignore Error    Run    pgrep avd | xargs kill
    Run Keyword And Ignore Error    Run    adb kill-server
    Run Keyword And Ignore Error    Run    killall qemu-system-i386
    Run Keyword And Ignore Error    Run    killall adb

Install And Open New Android App
    [Timeout]    ${TEST_SUITE_TIMEOUT} minutes
    Set Suite Variable    ${APPIUM_REMOTE_URL}    %{PARALLEL_APPIUM_REMOTE_URL2}
    Set Suite Variable    ${DEVICE_NAME_ANDROID}    %{DEVICE_NAME_ANDROID1}
    Set Suite Variable    ${APPIUM_PORT}    %{PARALLEL_APPIUM_PORT2}
    Set Suite Variable    ${ANDROID_APP_FILE}    ${EXECDIR}//Workshop-Examples//Shared-Resources//%{ANDROID_APP_NAME}
    Should Not Be Empty     ${APPIUM_REMOTE_URL}
    Should Not Be Empty     ${DEVICE_NAME_ANDROID}
    Should Not Be Empty     ${APPIUM_PORT}
    Should Not Be Empty     ${ANDROID_APP_FILE}
    Set Up New Android App    ${APPIUM_REMOTE_URL}    ${DEVICE_NAME_ANDROID}    ${APPIUM_PORT}    ${ANDROID_APP_FILE}

Open Existing Default Installed Android App
    [Timeout]    ${TEST_SUITE_TIMEOUT} minutes
    Set Suite Variable    ${APPIUM_REMOTE_URL}    %{PARALLEL_APPIUM_REMOTE_URL2}
    Set Suite Variable    ${DEVICE_NAME_ANDROID}    %{DEVICE_NAME_ANDROID1}
    Set Suite Variable    ${APPIUM_PORT}    %{PARALLEL_APPIUM_PORT2}
    Set Suite Variable    ${ANDROID_APP_ACTIVITY}    %{ANDROID_NATIVE_DEFAULT_APP_ACTIVITY}
    Set Suite Variable    ${ANDROID_APP_PACKAGE}    %{ANDROID_NATIVE_DEFAULT_APP_PACKAGE}
    Should Not Be Empty     ${APPIUM_REMOTE_URL}
    Should Not Be Empty     ${DEVICE_NAME_ANDROID}
    Should Not Be Empty     ${APPIUM_PORT}
    Should Not Be Empty     ${ANDROID_APP_ACTIVITY}
    Should Not Be Empty     ${ANDROID_APP_PACKAGE}
    Set Up Native Default Android App    ${APPIUM_REMOTE_URL}    ${DEVICE_NAME_ANDROID}    ${APPIUM_PORT}    ${ANDROID_APP_ACTIVITY}    ${ANDROID_APP_PACKAGE}

Tap According To Text That Is Displayed
    [Arguments]    ${TARGET_TEXT}    ${EXACT_MATCH_MODE}
    ## This needs to be set to "exact_match=True" or "exact_match=False"
    Click Text    ${TARGET_TEXT}    exact_match=${EXACT_MATCH_MODE}

Tap According To Specific Element Then Check Until Screen Shows Text
    [Arguments]    ${SPECIFIC_ELEMENT}    ${TARGET_TEXT}
    Click Element    ${SPECIFIC_ELEMENT}
    Sleep    2s
    Wait Until Page Contains    ${TARGET_TEXT}    10s

Tap According To Specific Cordinates
    [Arguments]    ${TAP_COORDINATE1}    ${TAP_COORDINATE2}
    Click A Point    x=${TAP_COORDINATE1}   y=${TAP_COORDINATE2}

Swipe According To Specific Cordinates With A Duration
    [Arguments]    ${SWIPE_COORDINATE1}    ${SWIPE_COORDINATE2}    ${SWIPE_COORDINATE3}    ${SWIPE_COORDINATE4}
    #### This is an example of swiping down on an IPad -> "Swipe According To Specific Cordinates    520    1140    500    180"
    #### This is an example of swiping up on an IPad -> "Swipe According To Specific Cordinates    510    300    520    900"
    #### This is an example of swiping down on any Android phone -> "Swipe According To Specific Cordinates    15    600    15    200"
    Swipe    ${SWIPE_COORDINATE1}    ${SWIPE_COORDINATE2}    ${SWIPE_COORDINATE3}    ${SWIPE_COORDINATE4}    500

Check Landscape Mode Take Screenshot Then Go Back To Portrait Mode
    Landscape
    Sleep    4s
    Capture Page Screenshot
    Portrait
    Sleep    2s

Close Android Apps With Adb Shell And Appium Keyword
    Run Keyword And Ignore Error    Run    adb shell input keyevent KEYCODE_APP_SWITCH
    Run Keyword And Ignore Error    Run    adb shell input keyevent 20
    Run Keyword And Ignore Error    Run    adb shell input keyevent DEL
    Run Keyword And Ignore Error    Close All Applications

Create A Random String And Return It
    ${COMPLETELY_RANDOM_STRING}=    Generate Random String    5    [LETTERS]
    [Return]    ${COMPLETELY_RANDOM_STRING}