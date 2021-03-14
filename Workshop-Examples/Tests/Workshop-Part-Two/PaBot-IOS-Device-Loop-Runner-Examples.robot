*** Settings ***
Documentation    Simple IOS app examples using AppiumLibrary and PaBot.

Resource         ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//Appium-Mobile-Resources.robot

*** Variables ***

${TEST_SUITE_TIMEOUT}     5
${TEST_SUITE_SECONDS_DELAY}    2
${TEST_LOOP_ITERATIONS}    ${USER_DEFINED_IOS_TEST_ITERATIONS}

*** Test Cases ***

PARALELL IOS APP LOOP TEST - Run the IOS Wikipedia app tests in a loop while recording it and taking screenshots.
    [Tags]    IOS_App    Parallel_Running_Tests    Emulator_IOS_Device
    [Setup]   Open Existing Default Installed IOS App
    Run IOS Wikipedia App Test Steps In A Loop    ${TEST_LOOP_ITERATIONS}
    [Teardown]    Run Keyword And Ignore Error    Quit Application

*** Keywords ***

Run IOS Wikipedia App Test Steps In A Loop
    [Arguments]     ${REPEAT_KEYWORD_ITERATIONS}
    Run Keyword And Ignore Error    Repeat Keyword    ${REPEAT_KEYWORD_ITERATIONS} times    Run IOS Wikipedia App Test Steps In A Sequence

Run IOS Wikipedia App Test Steps In A Sequence
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Install Wikipedia App On IOS Device Then Open It
    Switch To Landscape Back To Portrait Tap Next Button
    Tap Next Button On Second Wikipedia Setup Screen
    Tap Next Button On Third Wikipedia Setup Screen
    Tap Get Started Button On Last Wikipedia Setup Screen
    Tap Search Button Enter First Text Entry Into Search Field    Cat
    Delete Previous Text From Search Field Type In More Text    Dog
    #Delete Previous Text From Search Field Type In More Text    Zebra
    #Delete Previous Text From Search Field Type In More Text    Lion
    #Delete Previous Text From Search Field Type In More Text    Shark
    #Delete Previous Text From Search Field Type In More Text    Elephant
    #Delete Previous Text From Search Field Type In More Text    Hawk

Install Wikipedia App On IOS Device Then Open It
    Open Existing Default Installed IOS App
    Wait Until Page Contains    Next    10s
    Capture Page Screenshot
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s

Switch To Landscape Back To Portrait Tap Next Button
    Check Landscape Mode Take Screenshot Then Go Back To Portrait Mode
    Click Element    xpath=//XCUIElementTypeStaticText[@name="Next"]
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Capture Page Screenshot

Tap Next Button On Second Wikipedia Setup Screen
    Click Element    xpath=//XCUIElementTypeStaticText[@name="Next"]
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Capture Page Screenshot

Tap Next Button On Third Wikipedia Setup Screen
    Click Element    xpath=//XCUIElementTypeStaticText[@name="Next"]
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Capture Page Screenshot

Tap Get Started Button On Last Wikipedia Setup Screen
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Click Element    xpath=//XCUIElementTypeStaticText[@name="Get started"]
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Wait Until Page Contains    Search    10s
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Wait Until Page Contains    Wikipedia    10s
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Capture Page Screenshot

Tap Search Button Enter First Text Entry Into Search Field
    [Arguments]     ${INPUT_VALUE_TEXT}
    Tap According To Specific Cordinates    870    1320
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Tap According To Specific Cordinates    155    125
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Input Value    accessibility_id=Search Wikipedia    ${INPUT_VALUE_TEXT}
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Wait Until Page Contains    ${INPUT_VALUE_TEXT}    10s
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Capture Page Screenshot

Delete Previous Text From Search Field Type In More Text
    [Arguments]     ${INPUT_VALUE_TEXT}
    #Repeat Keyword    20 times    Tap According To Specific Cordinates    980    1040
    Clear Text    accessibility_id=Search Wikipedia
    Input Value    accessibility_id=Search Wikipedia    ${INPUT_VALUE_TEXT}
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Wait Until Page Contains    ${INPUT_VALUE_TEXT}    10s
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Capture Page Screenshot

Open Existing Default Installed IOS App
    [Timeout]    ${TEST_SUITE_TIMEOUT} minutes
    Set Suite Variable    ${APPIUM_REMOTE_URL}    %{PARALLEL_APPIUM_REMOTE_URL1}
    Set Suite Variable    ${DEVICE_NAME_IOS}    %{DEVICE_NAME_IOS1}
    Set Suite Variable    ${IOS_APP_FILE}    ${EXECDIR}//Workshop-Examples//Shared-Resources//%{IOS_APP_NAME}
    Should Not Be Empty     ${APPIUM_REMOTE_URL}
    Should Not Be Empty     ${DEVICE_NAME_IOS}
    Should Not Be Empty     ${IOS_APP_FILE}
    Set Up New IOS App    ${APPIUM_REMOTE_URL}    ${DEVICE_NAME_IOS}    ${IOS_APP_FILE}