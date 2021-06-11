*** Settings ***
Documentation    Simple Android app examples using AppiumLibrary, PaBot and a Model Based Testing tool called Graphwalker. More information about
...              Graphwalker can be found here -> http://graphwalker.github.io/

Resource         ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//Appium-Mobile-Resources.robot

*** Variables ***

${PATH}    ${EXECDIR}
${TEST_SUITE_SECONDS_DELAY}    5

*** Test Cases ***

PARALELL ANDROID APP GRAPHWALKER TEST : Run Android calculator app Graphwalker test, capture screenshots, and record video of the entire run.
    [Tags]    Android_App    Emulator_Android_Device    Model_Based_Testing
    [Setup]   Open Existing Default Installed Android App
    Run Graphwalker Model Based Tests With Appium    AppiumGraphwalkerPath.csv
    #Run Graphwalker Model Based Tests With Appium   AppiumGraphwalkerPathForWorkshop.csv
    [Teardown]   Close All Android Apps Without Device Reboot    5

*** Keywords ***

Run Graphwalker Model Based Tests With Appium
    [Arguments]    ${GRAPHWALKER_CSV_FILE}
    ${GRAPHWALKER_CSV_FILE_CONTENTS}=     Get File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//${GRAPHWALKER_CSV_FILE}
    @{GRAPHWALKER_PATH_LINES}=    Get Graphwalker Path Keywords From CSV File    ${GRAPHWALKER_CSV_FILE_CONTENTS}
    Run Appium Graphwalker Path Keywords    ${GRAPHWALKER_PATH_LINES}

Get Graphwalker Path Keywords From CSV File
    [Arguments]    ${GRAPHWALKER_CSV_CONTENT}
    @{GRAPHWALKER_LINES}=    Split To Lines    ${GRAPHWALKER_CSV_CONTENT}
    [Return]    @{GRAPHWALKER_LINES}

Run Appium Graphwalker Path Keywords
    [Arguments]      ${GRAPHWALKER_CSV_LINES}
    FOR  ${GRAPHWALKER_PATH_KEYWORD}   IN   @{GRAPHWALKER_CSV_LINES}
        Run Keyword    ${GRAPHWALKER_PATH_KEYWORD}
    END

check_calculator_process_activity_with_adb_shell_ps_command
    ${CHECK_ADB_OUTPUT}=    Execute Adb Shell    ps | grep calculator
    Should Contain    ${CHECK_ADB_OUTPUT}    calculator

press_addition_button
    Run Keyword And Ignore Error    Tap According To Specific Element Then Check Until Screen Shows Text    accessibility_id=plus    RAD
    Capture Page Screenshot

press_subtraction_button
    Run Keyword And Ignore Error    Tap According To Specific Element Then Check Until Screen Shows Text    accessibility_id=minus    RAD
    Capture Page Screenshot

press_division_button
    Run Keyword And Ignore Error    Tap According To Specific Element Then Check Until Screen Shows Text    accessibility_id=divide    RAD
    Capture Page Screenshot

press_mutiplication_button
    Run Keyword And Ignore Error    Tap According To Specific Element Then Check Until Screen Shows Text    accessibility_id=multiply    RAD
    Capture Page Screenshot

press_one_button
    Run Keyword And Ignore Error    Tap According To Text That Is Displayed    1    True
    Capture Page Screenshot

press_two_button
    Run Keyword And Ignore Error    Tap According To Text That Is Displayed    2    True
    Capture Page Screenshot

press_three_button
    Run Keyword And Ignore Error    Tap According To Text That Is Displayed    3    True
    Capture Page Screenshot

press_four_button
    Run Keyword And Ignore Error    Tap According To Text That Is Displayed    4    True
    Capture Page Screenshot

press_five_button
    Run Keyword And Ignore Error    Tap According To Text That Is Displayed    5    True
    Capture Page Screenshot

press_six_button
    Run Keyword And Ignore Error    Tap According To Text That Is Displayed    6    True
    Capture Page Screenshot

press_seven_button
    Run Keyword And Ignore Error    Tap According To Text That Is Displayed    7    True
    Capture Page Screenshot

press_eight_button
    Run Keyword And Ignore Error    Tap According To Text That Is Displayed    8    True
    Capture Page Screenshot

press_nine_button
    Run Keyword And Ignore Error    Tap According To Text That Is Displayed    9    True
    Capture Page Screenshot

press_zero_button
    Run Keyword And Ignore Error    Tap According To Text That Is Displayed    0    True
    Capture Page Screenshot

Close All Android Apps Without Device Reboot
    [Arguments]     ${REPEAT_KEYWORD_ITERATIONS}
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s
    Run Keyword And Ignore Error    Repeat Keyword    ${REPEAT_KEYWORD_ITERATIONS} times    Close Android Apps With Adb Shell And Appium Keyword
    Sleep    ${TEST_SUITE_SECONDS_DELAY}s