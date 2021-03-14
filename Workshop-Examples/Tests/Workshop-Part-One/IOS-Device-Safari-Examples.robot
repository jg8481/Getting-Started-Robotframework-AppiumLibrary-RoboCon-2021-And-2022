*** Settings ***
Documentation    Simple IOS Safari examples using AppiumLibrary.

Resource         ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-One//Resources//Appium-Mobile-Resources.robot

Suite Teardown    Close All Applications

*** Variables ***

${TEST_SUITE_TIMEOUT}     4
${TEST_SUITE_SECONDS_DELAY}    5

*** Test Cases ***

IOS SAFARI TEST 1 - Open a Safari browser using the URL set in the provided .env file then check the page.
    [Tags]    IOS_Safari    Simulator_IOS_Device
    [Setup]   Open The Safari Browser In IOS
    Wait Until Page Contains    User    10s

IOS SAFARI TEST 2 - Tap the Sign Up link then check the page.
    [Tags]    IOS_Safari    Simulator_IOS_Device
    Tap According To Specific Element Then Check Until Screen Shows Text    //a[@href="/signup"]    Submit

IOS SAFARI TEST 3 - Fill out the form click the Submit Button then check the page.
    [Tags]    IOS_Safari    Simulator_IOS_Device
    Complete Form With Randomized Test Data
    Wait Until Page Contains    Savings    10s
    Wait Until Page Contains    Dashboard    10s
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s

*** Keywords ***

Open The Safari Browser In IOS
    [Timeout]    ${TEST_SUITE_TIMEOUT} minutes
    Set Suite Variable    ${APPIUM_REMOTE_URL}    %{PARALLEL_APPIUM_REMOTE_URL1}
    Set Suite Variable    ${DEVICE_NAME_IOS}    %{DEVICE_NAME_IOS1}
    Set Suite Variable    ${APPIUM_PORT}    %{PARALLEL_APPIUM_PORT1}
    Set Suite Variable    ${APPIUM_WDALOCALPORT}     %{PARALLEL_APPIUM_WDALOCALPORT1}
    Should Not Be Empty     ${APPIUM_REMOTE_URL}
    Should Not Be Empty     ${DEVICE_NAME_IOS}
    Should Not Be Empty     ${APPIUM_PORT}
    Should Not Be Empty     ${APPIUM_WDALOCALPORT}
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Set Up Safari In IOS    ${APPIUM_REMOTE_URL}    ${DEVICE_NAME_IOS}    ${APPIUM_PORT}    ${APPIUM_WDALOCALPORT}

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