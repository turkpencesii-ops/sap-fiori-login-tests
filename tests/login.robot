*** Settings ***
Library           Browser
Resource          ../resources/keywords.robot
Variables         ../variables/credentials.py
Suite Setup       Setup Suite
Suite Teardown    Close Browser
Test Teardown     Take Screenshot    filename=EMBED

*** Variables ***
${PROFILE}        demo
${HEADLESS}       ${True}

# Demo selectors (default)
${DEMO_USER}      css=#username
${DEMO_PASS}      css=#password
${DEMO_BTN}       css=button[type="submit"]
${DEMO_SUCCESS}   css=.flash.success

# Example SAP selectors (adjust to your FLP)
${SAP_USER}       css=#j_username
${SAP_PASS}       css=#j_password
${SAP_BTN}        css=button[type="submit"], css=[data-testid="login-submit"]
${SAP_SUCCESS}    css=[role="heading"], h1:has-text("Home")

*** Keywords ***
Setup Suite
    ${base_url}    ${username}    ${password}=    Resolve Credentials
    Open Browser To URL    ${base_url}    ${HEADLESS}
    Set Suite Variable    ${_USERNAME}    ${username}
    Set Suite Variable    ${_PASSWORD}    ${password}

Resolve Credentials
    ${is_sap}=    Run Keyword And Return Status    Should Be Equal As Strings    ${PROFILE}    sap
    IF    ${is_sap}
        ${base_url}=    Set Variable    ${sap["base_url"]}
        ${username}=    Set Variable    ${sap["username"]}
        ${password}=    Set Variable    ${sap["password"]}
    ELSE
        ${base_url}=    Set Variable    ${demo["base_url"]}
        ${username}=    Set Variable    ${demo["username"]}
        ${password}=    Set Variable    ${demo["password"]}
    END
    RETURN    ${base_url}    ${username}    ${password}

*** Test Cases ***
Demo Login Works
    [Tags]    demo    smoke
    Run Keyword If    '${PROFILE}'=='sap'    Skip    Demo only when PROFILE=demo
    Type And Submit    ${DEMO_USER}    ${DEMO_PASS}    ${DEMO_BTN}    ${_USERNAME}    ${_PASSWORD}
    Wait For Elements State    ${DEMO_SUCCESS}    visible    5s
    ${txt}=    Get Text    ${DEMO_SUCCESS}
    Should Contain    ${txt}    logged into a secure area

SAP Fiori Login (Adjust Selectors)
    [Tags]    sap    smoke
    Run Keyword If    '${PROFILE}'=='demo'    Skip    Runs only when PROFILE=sap
    Type And Submit    ${SAP_USER}    ${SAP_PASS}    ${SAP_BTN}    ${_USERNAME}    ${_PASSWORD}
    Wait For Elements State    ${SAP_SUCCESS}    visible    15s

