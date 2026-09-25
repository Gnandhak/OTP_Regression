*** Settings ***
Library    SeleniumLibrary
Library    Dialogs

*** Variables ***
${USERNAME_INPUT}    id=username
${PASSWORD_INPUT}    id=password
${LOGIN_BUTTON}      id=Login
${SIT_SSO_BUTTON}    xpath=//*[self::button or self::a][contains(normalize-space(.), 'Login with SIT SSO')]

*** Keywords ***
Login To Salesforce
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    ${USERNAME_INPUT}    30s
    Input Text    ${USERNAME_INPUT}    ${username}
    Input Password    ${PASSWORD_INPUT}    ${password}
    Click Button    ${LOGIN_BUTTON}

Login Through SIT SSO
    [Arguments]    ${manual}=true    ${timeout}=180
    ${sso_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SIT_SSO_BUTTON}    10s
    IF    ${sso_visible}
        Click Element    ${SIT_SSO_BUTTON}
    END
    IF    '${manual}' == 'true'
        Pause Execution    Complete the Okta password and MFA manually, then click Continue in the Robot prompt.
    END
    Wait Until Location Does Not Contain    login    ${timeout}s

Wait For Salesforce Home
    [Arguments]    ${timeout}=60s
    Wait Until Location Does Not Contain    login    ${timeout}