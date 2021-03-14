*** Settings ***
Documentation    Simple Android examples using AppiumLibrary and PaBot.

Resource         ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//Appium-Mobile-Resources.robot

*** Variables ***

${PATH}    ${EXECDIR}
${TEST_SUITE_TIMEOUT}     5
${TEST_SUITE_SECONDS_DELAY}    5
${TEST_LOOP_ITERATIONS}    ${USER_DEFINED_MONITORING_ITERATIONS}

*** Test Cases ***

PARALELL ADB TOP MONITORING TEST - Run an adb shell command on a connected Android device to check that a specific package is installed.
    [Tags]    Android_Adb    Parallel_Running_Tests    Emulator_Android_Device
    Create Adb Shell Top Data Log Files
    Run Adb Shell Top Monitoring Test    ${TEST_LOOP_ITERATIONS}
    Display CPU Checkpoints Status And Insert Android Top Data Into Results Log

*** Keywords ***

Run Adb Shell Top Monitoring Test
    [Arguments]    ${REPEAT_KEYWORD_ITERATIONS}
    Repeat Keyword    ${REPEAT_KEYWORD_ITERATIONS} times    Run Keyword And Ignore Error    Run Top Command From Adb Check CPU And Memory Usage Save To Log File

Create Adb Shell Top Data Log Files
    Remove File    ${PATH}//Workshop-Examples//Results//Android-CPU-Memory-Usage-Logs//android-adb-top-cpu-memory-usage-data-log.txt
    Create File    ${PATH}//Workshop-Examples//Results//Android-CPU-Memory-Usage-Logs//android-adb-top-cpu-memory-usage-data-log.txt
    Remove File    ${PATH}//Workshop-Examples//Results//Android-CPU-Memory-Usage-Logs//android-adb-top-cpu-usage-checkpoint-log.txt
    Create File    ${PATH}//Workshop-Examples//Results//Android-CPU-Memory-Usage-Logs//android-adb-top-cpu-usage-checkpoint-log.txt
    Append To File    ${PATH}//Workshop-Examples//Results//Android-CPU-Memory-Usage-Logs//android-adb-top-cpu-memory-usage-data-log.txt    PID-USER-----------PR--NI-VIRT--RES--SHR-S[%CPU]-%MEM-----TIME+-ARGS${\n}

Run Top Command From Adb Check CPU And Memory Usage Save To Log File
    ${ADB_SHELL_FULL_TOP_OUTPUT}=    Run Adb Shell Top Command And Return Output    top -b -n 1 | grep --line-buffered 'calculator2' | head -1
    ${ADB_SHELL_TOP_CPU_USAGE_OUTPUT}=    Run Adb Shell Top Command And Return Output    top -b -n 1 | grep --line-buffered 'calculator2' | head -1 | awk '{print $9}'
    #${ADB_SHELL_TOP_MEMORY_USAGE_OUTPUT}=    Run Adb Shell Top Command And Return Output    top -b -n 1 | grep --line-buffered 'calculator2' | head -1 | awk '{print $10}'
    ${ADB_SHELL_TOP_CPU_USAGE_EVALUATION}=    Evaluate   round(${ADB_SHELL_TOP_CPU_USAGE_OUTPUT})
    ${ADB_SHELL_TOP_CPU_USAGE_CONVERTED}=    Convert To Integer    ${ADB_SHELL_TOP_CPU_USAGE_EVALUATION}
    Run Keyword And Ignore Error    Run Keyword If    ${60} < ${ADB_SHELL_TOP_CPU_USAGE_CONVERTED} < ${100}    Set Suite Variable    ${CPU_USAGE_CHECKPOINT1}    WARNING: Excessive CPU usage has been detected by CPU Checkpoint one.
    ...    ELSE    Set Suite Variable    ${CPU_USAGE_CHECKPOINT1}    CPU Checkpoint one passed.
    Run Keyword And Ignore Error    Run Keyword If   ${ADB_SHELL_TOP_CPU_USAGE_CONVERTED} == 0    Set Suite Variable    ${CPU_USAGE_CHECKPOINT2}    CPU Checkpoint two passed. Top detected CPU usage at 0%.
    Set Suite Variable    ${CPU_USAGE_CHECKPOINT1}
    Set Suite Variable    ${CPU_USAGE_CHECKPOINT2}
    Append To File    ${PATH}//Workshop-Examples//Results//Android-CPU-Memory-Usage-Logs//android-adb-top-cpu-memory-usage-data-log.txt    ${ADB_SHELL_FULL_TOP_OUTPUT}${\n}
    Append To File    ${PATH}//Workshop-Examples//Results//Android-CPU-Memory-Usage-Logs//android-adb-top-cpu-usage-checkpoint-log.txt    ${CPU_USAGE_CHECKPOINT1}${\n}
    Append To File    ${PATH}//Workshop-Examples//Results//Android-CPU-Memory-Usage-Logs//android-adb-top-cpu-usage-checkpoint-log.txt    ${CPU_USAGE_CHECKPOINT2}${\n}
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    PID-USER-----------PR--NI-VIRT--RES--SHR-S[%CPU]-%MEM-----TIME+-ARGS
    Log To Console    ${ADB_SHELL_FULL_TOP_OUTPUT}
    Log To Console    ...
    Log To Console    ...
    Log Many    This is the complete line of top data for the given process filtered through the Android adb shell --> ${ADB_SHELL_FULL_TOP_OUTPUT}
    Log Many    This is just the CPU usage percentage top data for the given process filtered through the Android adb shell -->   ${ADB_SHELL_TOP_CPU_USAGE_OUTPUT}

Display CPU Checkpoints Status And Insert Android Top Data Into Results Log
    ${ADB_SHELL_TOP_LOG_OUTPUT}=    Get File    ${PATH}//Workshop-Examples//Results//Android-CPU-Memory-Usage-Logs//android-adb-top-cpu-memory-usage-data-log.txt
    ${ADB_SHELL_TOP_CHECKPOINT_OUTPUT}=    Get File    ${PATH}//Workshop-Examples//Results//Android-CPU-Memory-Usage-Logs//android-adb-top-cpu-usage-checkpoint-log.txt
    Log    ${ADB_SHELL_TOP_LOG_OUTPUT}
    Log    ${ADB_SHELL_TOP_CHECKPOINT_OUTPUT}
    ${ADB_SHELL_TOP_CHECKPOINT_STATUS}     ${ADB_SHELL_TOP_CHECKPOINT_ANALYSIS}=    Run Keyword And Ignore Error    Should Not Contain    ${ADB_SHELL_TOP_CHECKPOINT_OUTPUT}    WARNING
    Run Keyword And Ignore Error    Run Keyword If    '${ADB_SHELL_TOP_CHECKPOINT_STATUS}' == 'PASS'    Set Suite Variable    ${ADB_SHELL_TOP_CPU_USAGE_STATUS}    The PaBot monitoring automation didn't find anything. No CPU usage warnings detected.
    ...    ELSE    Set Suite Variable    ${ADB_SHELL_TOP_CPU_USAGE_STATUS}    The PaBot monitoring automation found something. CPU usage warnings were detected.
    Log To Console    ...
    Log To Console    ...
    Log To Console    ...
    Log To Console    ${ADB_SHELL_TOP_CPU_USAGE_STATUS}
    Log To Console    ...
    Log To Console    ...

Run Adb Shell Top Command And Return Output
    [Arguments]     ${ADB_SHELL_TOP_COMMAND}
    Run Process    adb shell ${ADB_SHELL_TOP_COMMAND}    alias=adb_shell_top_result    shell=True    timeout=2min    on_timeout=continue
    ${ADB_SHELL_TOP_RESULTS}=   	Get Process Result    adb_shell_top_result    stdout=true
    [Return]    ${ADB_SHELL_TOP_RESULTS}