*** Settings ***
Documentation    Simple Android Chrome examples using AppiumLibrary.

Resource         ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-One//Resources//Appium-Mobile-Resources.robot

Suite Setup    Close All Android Apps Without Device Reboot    5
Suite Teardown    Quit Application

*** Variables ***

${TEST_SUITE_TIMEOUT}     1
${TEST_SUITE_SECONDS_DELAY}    5

*** Test Cases ***

ANDROID CHROME TEST 1 - Open a Chrome browser using the URL set in the provided .env file then check the page.
    [Tags]    Android_Chrome    Emulator_Android_Device
    [Setup]   Open The Chrome Browser In Android
    Wait Until Page Contains    User    10s

ANDROID CHROME TEST 2 - Tap the Sign Up link then check the page.
    [Tags]    Android_Chrome    Emulator_Android_Device
    Swipe Down Tap The Sign Up Link And Check The Page

ANDROID CHROME TEST 3 - Fill out the form click the Submit Button then check the page.
    [Tags]    Android_Chrome    Emulator_Android_Device
    Complete Form With Randomized Test Data
    Wait Until Page Contains    Savings    10s
    Wait Until Page Contains    Dashboard    10s
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s

*** Keywords ***

Open The Chrome Browser In Android
    [Timeout]    ${TEST_SUITE_TIMEOUT} minutes
    Set Suite Variable    ${APPIUM_REMOTE_URL}    %{PARALLEL_APPIUM_REMOTE_URL2}
    Set Suite Variable    ${DEVICE_NAME_ANDROID}    %{DEVICE_NAME_ANDROID1}
    Set Suite Variable    ${APPIUM_PORT}    %{PARALLEL_APPIUM_PORT2}
    Should Not Be Empty     ${APPIUM_REMOTE_URL}
    Should Not Be Empty     ${DEVICE_NAME_ANDROID}
    Should Not Be Empty     ${APPIUM_PORT}
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Set Up Chrome In Android    ${APPIUM_REMOTE_URL}    ${DEVICE_NAME_ANDROID}    ${APPIUM_PORT}

Swipe Down Tap The Sign Up Link And Check The Page
    Swipe According To Specific Cordinates With A Duration    15    600    15    200
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Tap According To Specific Element Then Check Until Screen Shows Text    //a[@href="/signup"]    Submit
    Wait Until Page Contains    Submit    10s

Complete Form With Randomized Test Data
    ${CREATE_RANDOM_DATA}=    Create A Random String And Return It
    Input Text    id=userName    QA${CREATE_RANDOM_DATA}
    Input Text    id=firstName    test${CREATE_RANDOM_DATA}
    Input Text    id=lastName    test${CREATE_RANDOM_DATA}
    Input Text    id=password    test${CREATE_RANDOM_DATA}
    Input Text    id=verify    test${CREATE_RANDOM_DATA}
    Input Text    id=email    test${CREATE_RANDOM_DATA}@email.com
    Click Element    css=.btn
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s

Close All Android Apps Without Device Reboot
    [Arguments]     ${REPEAT_KEYWORD_ITERATIONS}
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Run Keyword And Ignore Error    Repeat Keyword    ${REPEAT_KEYWORD_ITERATIONS} times    Close Android Apps With Adb Shell And Appium Keyword
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s