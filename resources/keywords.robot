*** Settings ***
Library    Browser

*** Variables ***
${DEFAULT_TIMEOUT}    10s

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}    ${headless}=true
    New Browser    chromium    headless=${headless}
    New Context
    New Page    ${url}

Type And Submit
    [Arguments]    ${user_selector}    ${pass_selector}    ${button_selector}    ${username}    ${password}
    Wait For Elements State    ${user_selector}    visible    ${DEFAULT_TIMEOUT}
    Fill Text    ${user_selector}    ${username}
    Fill Text    ${pass_selector}    ${password}
    Click    ${button_selector}

Should See Text
    [Arguments]    ${locator}    ${expected}
    Wait For Elements State    ${locator}    visible    ${DEFAULT_TIMEOUT}
    Get Text    ${locator}    ==    ${expected}
