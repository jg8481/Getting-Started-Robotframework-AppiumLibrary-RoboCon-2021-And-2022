*** Settings ***
Documentation    Simple Android examples using Charles Proxy and AppiumLibrary.

Resource         ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//Appium-Mobile-Resources.robot
Library          ${EXECDIR}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//CharlesProxyExample.py

Suite Teardown    Close All Applications

*** Variables ***
${PATH}    ${EXECDIR}
${TEST_SUITE_TIMEOUT}     2
${CHARLES_PROXY_APPIUM_EXAMPLE_URL}    http://nodegoat.herokuapp.com/login

*** Test Cases ***

CHARLES PROXY ANDROID CHROME TEST : Go to the OWASP Node Goat home page in an Android mobile browser while Charles Proxy is recording a session, and check the JSON session file.
    [Tags]    Android_Chrome    Charles_Proxy    Charles_Proxy_Android    Emulator_Android_Device
    [Setup]    Start Charles Proxy For Mobile Browser
    Open The Chrome Browser In Android After Starting Charles Proxy
    Download Charles Proxy Session File And Convert It To JSON
    Check Charles Proxy JSON Session File Recording
    [Teardown]    Terminate Charles Proxy Sessions And Clean Up

*** Keywords ***

Start Charles Proxy For Mobile Browser
    Remove File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//new-json-session-file.chlsj
    Remove File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//original-raw-session-file.chls
    Remove File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//jq-select-output.txt
    Remove File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//jq-filter-output.txt
    Start Charles Proxy In Headless Mode
    Start Charles Proxy Session Recording

Download Charles Proxy Session File And Convert It To JSON
    Download Charles Proxy Session Recording
    Convert Recorded Session File

Terminate Charles Proxy Sessions And Clean Up
    Stop Charles Proxy Session Recording
    Terminate All Charles Proxy Sessions
    Remove File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//new-json-session-file.chlsj
    Remove File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//original-raw-session-file.chls
    Remove File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//jq-select-output.txt
    Remove File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//jq-filter-output.txt

Open The Chrome Browser In Android After Starting Charles Proxy
    Set Suite Variable    ${APPIUM_REMOTE_URL}    %{PARALLEL_APPIUM_REMOTE_URL2}
    Set Suite Variable    ${DEVICE_NAME_ANDROID}    %{DEVICE_NAME_ANDROID1}
    Set Suite Variable    ${APPIUM_PORT}    %{PARALLEL_APPIUM_PORT2}
    Should Not Be Empty     ${APPIUM_REMOTE_URL}
    Should Not Be Empty     ${DEVICE_NAME_ANDROID}
    Should Not Be Empty     ${APPIUM_PORT}
    Run Keyword And Ignore Error    Set Up Chrome In Android After Starting Charles Proxy    ${APPIUM_REMOTE_URL}    ${DEVICE_NAME_ANDROID}    ${APPIUM_PORT}

Check Charles Proxy JSON Session File Recording
    Run JQ Select Command And Check Results    nodegoat.herokuapp.com
    Run JQ Filter Command And Check Results

Run JQ Select Command And Check Results
    [Arguments]    ${JQ_SELECT_HOST_VALUE}
    Run    cat ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//new-json-session-file.chlsj | jq '.[] | select(.host=="${JQ_SELECT_HOST_VALUE}")' > ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//jq-select-output.txt
    ${JQ_SELECT_OUTPUT}=   	Get File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//jq-select-output.txt
    Log    ${JQ_SELECT_OUTPUT}
    Should Contain    ${JQ_SELECT_OUTPUT}    ${JQ_SELECT_HOST_VALUE}
    Should Contain    ${JQ_SELECT_OUTPUT}    response
    Should Contain    ${JQ_SELECT_OUTPUT}    status
    Should Contain    ${JQ_SELECT_OUTPUT}    COMPLETE

Run JQ Filter Command And Check Results
    Run   cat ${PATH}/Workshop-Examples/Tests/Workshop-Part-Two/Resources/new-json-session-file.chlsj | jq .[].response.status > ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//jq-filter-output.txt
    ${JQ_FILTER_OUTPUT}=   	Get File    ${PATH}//Workshop-Examples//Tests//Workshop-Part-Two//Resources//jq-filter-output.txt
    Log    ${JQ_FILTER_OUTPUT}
    Should Contain        ${JQ_FILTER_OUTPUT}    200
    Should Not Contain    ${JQ_FILTER_OUTPUT}    500
    Should Not Contain    ${JQ_FILTER_OUTPUT}    504

