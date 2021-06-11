*** Settings ***
Documentation    Simple IOS app examples using AppiumLibrary.

Resource         ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-One//Resources//Appium-Mobile-Resources.robot

Suite Teardown    Close All Applications

*** Variables ***

${TEST_SUITE_TIMEOUT}     5
${TEST_SUITE_SECONDS_DELAY}    4

*** Test Cases ***

IOS APP TEST 1 : Install the Wikipedia app on an IOS device and open it.
    [Tags]    IOS_App    Emulator_IOS_Device
    [Setup]   Open Existing Default Installed IOS App
    Wait Until Page Contains    Next    10s
    #Start Screen Recording
    Capture Page Screenshot
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s

IOS APP TEST 2 : Switch the IOS device to landscape back to portrait, then tap the Next button and check the app.
    [Tags]    IOS_App    Emulator_IOS_Device
    Check Landscape Mode Take Screenshot Then Go Back To Portrait Mode
    Click Element    xpath=//XCUIElementTypeStaticText[@name="Next"]
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Capture Page Screenshot

IOS APP TEST 3 : Tap the Next button on the second Wikipedia setup screen and check the app.
    [Tags]    IOS_App    Emulator_IOS_Device
    Click Element    xpath=//XCUIElementTypeStaticText[@name="Next"]
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Capture Page Screenshot

IOS APP TEST 4 : Tap the Next button on the third Wikipedia setup screen and check the app.
    [Tags]    IOS_App    Emulator_IOS_Device
    Click Element    xpath=//XCUIElementTypeStaticText[@name="Next"]
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Capture Page Screenshot

IOS APP TEST 5 : Tap the Get Started button on the last Wikipedia setup screen and check the app.
    [Tags]    IOS_App    Emulator_IOS_Device
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Click Element    xpath=//XCUIElementTypeStaticText[@name="Get started"]
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Wait Until Page Contains    Search    10s
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Wait Until Page Contains    Wikipedia    10s
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Capture Page Screenshot

IOS APP TEST 6 : Tap the Search button and type in cat then check the app.
    [Tags]    IOS_App    Emulator_IOS_Device
    Tap According To Specific Cordinates    870    1320
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Tap According To Specific Cordinates    155    125
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Input Value    accessibility_id=Search Wikipedia    cat
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Wait Until Page Contains    Cat    10s
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Capture Page Screenshot

IOS APP TEST 7 : Delete cat from the Search Field and type in dog then check the app.
    [Tags]    IOS_App    Emulator_IOS_Device
    Repeat Keyword    4 times    Tap According To Specific Cordinates    980    1040
    Input Value    accessibility_id=Search Wikipedia    dog
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Wait Until Page Contains    Dog    10s
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Capture Page Screenshot
    #Stop Screen Recording

*** Keywords ***

Open Existing Default Installed IOS App
    [Timeout]    ${TEST_SUITE_TIMEOUT} minutes
    Set Suite Variable    ${APPIUM_REMOTE_URL}    %{PARALLEL_APPIUM_REMOTE_URL1}
    Set Suite Variable    ${DEVICE_NAME_IOS}    %{DEVICE_NAME_IOS1}
    Set Suite Variable    ${IOS_APP_FILE}    ${EXECDIR}//Workshop-Examples//Shared-Resources//%{IOS_APP_NAME}
    Should Not Be Empty     ${APPIUM_REMOTE_URL}
    Should Not Be Empty     ${DEVICE_NAME_IOS}
    Should Not Be Empty     ${IOS_APP_FILE}
    Set Up New IOS App    ${APPIUM_REMOTE_URL}    ${DEVICE_NAME_IOS}    ${IOS_APP_FILE}