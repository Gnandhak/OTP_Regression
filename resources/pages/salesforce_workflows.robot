*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${CASES_TAB}    xpath=//a[@title='Cases' or normalize-space(.)='Cases']
${NAVIGATION_MENU_BUTTON}    xpath=//button[@title='Show Navigation Menu']
${APP_LAUNCHER_BUTTON}    xpath=//button[@title='App Launcher']
${LIST_VIEW_BUTTON}    xpath=//button[@title='Select a List View']
${CASE_ACTIONS_BUTTON}    xpath=//button[@title='Show more actions']

*** Keywords ***
Validate Supervisor Flow Inputs
    Should Not Be Empty    ${OTP_SUPERVISOR_CASE_NUMBER}    Set OTP_SUPERVISOR_CASE_NUMBER to the case number to reassign.
    Should Not Be Empty    ${OTP_TARGET_USER_NAME}    Set OTP_TARGET_USER_NAME to the target OTP user's name.
    Should Not Be Empty    ${OTP_COMMAND_CENTER_CASE_NUMBER}    Set OTP_COMMAND_CENTER_CASE_NUMBER to a case number available in Command Center.

Validate Senior Manager Flow Inputs
    Should Not Be Empty    ${OTP_SENIOR_MANAGER_CASE_NUMBER}    Set OTP_SENIOR_MANAGER_CASE_NUMBER to a case number owned by another user.
    Should Not Be Empty    ${OTP_SENIOR_MANAGER_NAME}    Set OTP_SENIOR_MANAGER_NAME to the senior manager's Salesforce name.
    Should Not Be Empty    ${OTP_COMPLAINT_SUBJECT}    Set OTP_COMPLAINT_SUBJECT to a unique test-case subject.
    Should Not Be Empty    ${OTP_COMPLAINT_DESCRIPTION}    Set OTP_COMPLAINT_DESCRIPTION to the test-case description.
    Should Not Be Empty    ${OTP_REPORT_NAME}    Set OTP_REPORT_NAME to the exact OTP report name.
    Should Not Be Empty    ${OTP_DASHBOARD_NAME}    Set OTP_DASHBOARD_NAME to the exact OTP dashboard name.

Open Cases Tab
    Wait Until Element Is Visible    ${CASES_TAB}    30s
    Click Element    ${CASES_TAB}
    Wait Until Location Contains    /Case/    30s

Select All Open Cases List View
    Wait Until Element Is Visible    ${LIST_VIEW_BUTTON}    30s
    Click Element    ${LIST_VIEW_BUTTON}
    Click Element    xpath=//*[self::span or self::a][normalize-space(.)='All Open Cases']
    Wait Until Page Contains Element    xpath=//a[contains(@href, '/Case/') or contains(@href, '/lightning/r/Case/')]    30s

Open Case By Number
    [Arguments]    ${case_number}
    Should Not Be Empty    ${case_number}
    ${case_link}=    Set Variable    xpath=//a[normalize-space(.)="${case_number}"]
    Wait Until Element Is Visible    ${case_link}    30s
    Click Element    ${case_link}
    Wait Until Page Contains Element    ${CASE_ACTIONS_BUTTON}    30s

Get Case Owner Name
    ${owner}=    Get Text    xpath=//*[normalize-space(.)='Case Owner']/following::a[1]
    RETURN    ${owner}

Assign Current Case To User
    [Arguments]    ${user_name}
    Should Not Be Empty    ${user_name}
    Click Element    xpath=//button[normalize-space(.)='Assign'] | //a[normalize-space(.)='Assign']
    Wait Until Page Contains Element    xpath=//*[normalize-space(.)='Assign To']    20s
    Click Element    xpath=//*[normalize-space(.)='User']
    ${user_search}=    Set Variable    xpath=//input[contains(@placeholder, 'Search') or @type='search']
    Wait Until Element Is Visible    ${user_search}    20s
    Input Text    ${user_search}    ${user_name}
    ${user_option}=    Set Variable    xpath=//*[self::li or self::span or self::div][normalize-space(.)="${user_name}"]
    Wait Until Element Is Visible    ${user_option}    20s
    Click Element    ${user_option}
    Click Button    Next
    Click Button    Finish
    Wait Until Page Does Not Contain Element    xpath=//*[normalize-space(.)='Assign To']    30s

Open Command Center For Service
    ${nav_menu_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${NAVIGATION_MENU_BUTTON}    5s
    IF    ${nav_menu_visible}
        Click Element    ${NAVIGATION_MENU_BUTTON}
        ${command_center_visible}=    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[normalize-space(.)='Command Center for Service']    5s
        IF    ${command_center_visible}
            Click Element    xpath=//*[normalize-space(.)='Command Center for Service']
            RETURN
        END
    END
    Click Element    ${APP_LAUNCHER_BUTTON}
    ${app_search}=    Set Variable    xpath=//input[contains(@placeholder, 'Search')]
    Wait Until Element Is Visible    ${app_search}    15s
    Input Text    ${app_search}    Command Center for Service
    Click Element    xpath=//*[normalize-space(.)='Command Center for Service']

Review Current Case Actions
    Click Element    ${CASE_ACTIONS_BUTTON}
    ${action_elements}=    Get WebElements    xpath=//div[contains(@class, 'slds-dropdown')]//*[self::a or self::button]
    @{action_names}=    Create List
    FOR    ${element}    IN    @{action_elements}
        ${action_name}=    Get Text    ${element}
        IF    '${action_name}' != ''
            Append To List    ${action_names}    ${action_name}
        END
    END
    Should Not Be Empty    ${action_names}    No case actions were visible in the open menu.
    Log Many    @{action_names}

Verify Other-Owned Case Is Listed
    [Arguments]    ${case_number}    ${manager_name}
    Should Not Be Empty    ${case_number}
    Should Not Be Empty    ${manager_name}
    ${row}=    Set Variable    xpath=//*[normalize-space(.)="${case_number}"]/ancestor::tr[1]
    Wait Until Element Is Visible    ${row}    30s
    ${owner}=    Get Text    ${row}//a[contains(@href, '/User/') or contains(@href, '/Contact/')]
    Should Not Be Equal    ${owner}    ${manager_name}

Create Complaints Case
    [Arguments]    ${subject}    ${description}
    Should Not Be Empty    ${subject}
    Should Not Be Empty    ${description}
    Click Button    New
    Wait Until Page Contains Element    xpath=//*[normalize-space(.)='Record Type of new record']    20s
    Click Element    xpath=//*[normalize-space(.)='Complaints']
    Click Button    Next
    Wait Until Page Contains Element    xpath=//label[normalize-space(.)='Subject']    20s
    ${subject_input}=    Set Variable    xpath=//label[normalize-space(.)='Subject']/following::input[1]
    ${description_input}=    Set Variable    xpath=//label[normalize-space(.)='Description']/following::textarea[1]
    Input Text    ${subject_input}    ${subject}
    Input Text    ${description_input}    ${description}
    Click Button    Save
    Wait Until Page Contains Element    ${CASE_ACTIONS_BUTTON}    30s

Delete Current Case And Confirm
    Click Element    ${CASE_ACTIONS_BUTTON}
    Click Element    xpath=//*[self::a or self::button][normalize-space(.)='Delete']
    Wait Until Page Contains Element    xpath=//*[contains(normalize-space(.), 'delete this case') or contains(normalize-space(.), 'Delete this case')]    15s
    Click Button    xpath=//button[normalize-space(.)='Delete']
    Wait Until Page Does Not Contain Element    xpath=//*[contains(normalize-space(.), 'delete this case') or contains(normalize-space(.), 'Delete this case')]    30s

Open Named Report
    [Arguments]    ${report_name}
    Should Not Be Empty    ${report_name}
    Click Element    xpath=//a[@title='Reports' or normalize-space(.)='Reports']
    Wait Until Element Is Visible    xpath=//*[normalize-space(.)="${report_name}"]    30s
    Click Element    xpath=//*[normalize-space(.)="${report_name}"]

Open Named Dashboard
    [Arguments]    ${dashboard_name}
    Should Not Be Empty    ${dashboard_name}
    Click Element    xpath=//a[@title='Dashboards' or normalize-space(.)='Dashboards']
    Wait Until Element Is Visible    xpath=//*[normalize-space(.)="${dashboard_name}"]    30s
    Click Element    xpath=//*[normalize-space(.)="${dashboard_name}"]