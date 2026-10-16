*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Keywords ***
Open New HomeServe Case And Enter Details
    [Arguments]    ${case_origin}    ${case_type}    ${subject}    ${description}
    Should Not Be Empty    ${case_origin}    Configure HOMESERVE_CASE_ORIGIN in the test environment.
    Should Not Be Empty    ${case_type}    Configure HOMESERVE_CASE_TYPE in the test environment.
    Should Not Be Empty    ${subject}    Configure HOMESERVE_CASE_SUBJECT in the test environment.
    Should Not Be Empty    ${description}    Configure HOMESERVE_CASE_DESCRIPTION in the test environment.
    Wait Until Element Is Visible    ${HOMESERVE_NEW_CASE_LINK}    30s
    Click Element    ${HOMESERVE_NEW_CASE_LINK}
    Wait Until Element Is Visible    ${HOMESERVE_NEW_CASE_HEADING}    30s
    Element Should Contain    ${HOMESERVE_NEW_CASE_HEADING}    New Case
    Click Element    ${HOMESERVE_CASE_RECORD_TYPE_RADIO}
    Click Element    ${HOMESERVE_NEXT_BUTTON}
    Select HomeServe Case Dropdown Value    ${HOMESERVE_CASE_ORIGIN_COMBOBOX}    ${case_origin}
    Select HomeServe Case Dropdown Value    ${HOMESERVE_CASE_TYPE_COMBOBOX}    ${case_type}
    Wait Until Element Is Visible    ${HOMESERVE_CASE_SUBJECT_INPUT}    15s
    Input Text    ${HOMESERVE_CASE_SUBJECT_INPUT}    ${subject}
    Wait Until Element Is Visible    ${HOMESERVE_CASE_DESCRIPTION_INPUT}    15s
    Input Text    ${HOMESERVE_CASE_DESCRIPTION_INPUT}    ${description}
    Wait Until Element Is Visible    ${HOMESERVE_SAVE_CASE_BUTTON}    15s
    Click Element    ${HOMESERVE_SAVE_CASE_BUTTON}
    Get And Store HomeServe Case Number
    Log    STEP COMPLETE: Entered and saved HomeServe case origin, type, subject, and description    INFO
    Capture HomeServe Keyword Screenshot

Get And Store HomeServe Case Number
    Wait Until Element Is Visible    ${HOMESERVE_CASE_NUMBER_FIELD}    30s
    ${case_number}=    Get Text    ${HOMESERVE_CASE_NUMBER_FIELD}
    Should Not Be Empty    ${case_number}    Could not read the created HomeServe case number.
    Set Suite Variable    ${HOMESERVE_CREATED_CASE_NUMBER}    ${case_number}
    Log    Created HomeServe case number: ${HOMESERVE_CREATED_CASE_NUMBER}    INFO
    Capture HomeServe Keyword Screenshot

Select HomeServe Case Dropdown Value
    [Arguments]    ${combobox_locator}    ${value}
    Click Element    ${combobox_locator}
    ${option_locator}=    Set Variable    xpath=//*[@role='option' and (normalize-space(.)="${value}" or @title="${value}")]
    Wait Until Element Is Visible    ${option_locator}    15s
    ${option_count}=    Get Element Count    ${option_locator}
    Should Be Equal As Integers    ${option_count}    1    Expected exactly one case option matching "${value}".
    Click Element    ${option_locator}
    Capture HomeServe Keyword Screenshot

HSCF Request Summary
    [Arguments]    ${request_search}    ${request_number}    ${request_quantity}    ${eligible_value}
    Should Not Be Empty    ${request_search}    Configure HSCF_REQUEST_SEARCH in the test environment.
    Should Not Be Empty    ${request_number}    Configure HSCF_REQUEST_NUMBER in the test environment.
    Should Not Be Empty    ${request_quantity}    Configure HSCF_REQUEST_QUANTITY in the test environment.
    Should Not Be Empty    ${eligible_value}    Configure HSCF_ELIGIBLE in the test environment.
    Wait Until Element Is Visible    ${HSCF_REQUEST_SEARCH_INPUT}    15s
    Input Text    ${HSCF_REQUEST_SEARCH_INPUT}    ${request_search}
    ${request_option}=    Set Variable    xpath=//*[@role='option' and (normalize-space(.)="${request_search}" or @title="${request_search}")]
    Wait Until Element Is Visible    ${request_option}    15s
    ${request_option_count}=    Get Element Count    ${request_option}
    Should Be Equal As Integers    ${request_option_count}    1    Expected exactly one HSCF request option matching "${request_search}".
    Click Element    ${request_option}
    Wait Until Element Is Visible    ${HSCF_REQUEST_NUMBER_INPUT}    15s
    Input Text    ${HSCF_REQUEST_NUMBER_INPUT}    ${request_number}
    Wait Until Element Is Visible    ${HSCF_REQUEST_QUANTITY_INPUT}    15s
    Input Text    ${HSCF_REQUEST_QUANTITY_INPUT}    ${request_quantity}
    Select HomeServe Case Dropdown Value    ${HSCF_ELIGIBLE_DROPDOWN}    ${eligible_value}
    Wait Until Element Is Visible    ${HSCF_REQUEST_NEXT_BUTTON}    15s
    Element Should Be Enabled    ${HSCF_REQUEST_NEXT_BUTTON}
    Click Element    ${HSCF_REQUEST_NEXT_BUTTON}
    Log    STEP COMPLETE: Completed the HSCF request summary and continued to the next step    INFO
    Capture HomeServe Keyword Screenshot

HSCF Job Task Overview
    [Arguments]    ${completed_status}
    Should Not Be Empty    ${completed_status}    Configure HSCF_JOB_TASK_STATUS in the test environment.
    Wait Until Element Is Visible    ${HSCF_JOB_TASK_STEP_LABEL}    30s
    Element Should Contain    ${HSCF_JOB_TASK_STEP_LABEL}    In Progress
    ${update_button_count}=    Get Element Count    xpath=${HSCF_JOB_TASK_UPDATE_BUTTONS}
    Should Be True    ${update_button_count} > 0    No Update Work Order Status buttons were found.
    FOR    ${index}    IN RANGE    ${update_button_count}
        ${button_position}=    Evaluate    ${index} + 1
        ${update_button}=    Set Variable    xpath=(${HSCF_JOB_TASK_UPDATE_BUTTONS})[${button_position}]
        Click Element    ${update_button}
        ${overlay_header}=    Set Variable    xpath=//h2[contains(text(),'Update Work Order')]
        Wait Until Element Is Visible    ${overlay_header}    15s
        Wait Until Element Is Visible    ${HSCF_JOB_TASK_STATUS_DROPDOWN}    15s
        Click Element    ${HSCF_JOB_TASK_STATUS_DROPDOWN}
        ${status_option}=    Set Variable    xpath=//*[@role='option' and (normalize-space(.)="${completed_status}" or @title="${completed_status}")]
        Wait Until Element Is Visible    ${status_option}    15s
        Click Element    ${status_option}
        Wait Until Element Is Visible    ${HSCF_JOB_TASK_SAVE_BUTTON}    15s
        Element Should Be Enabled    ${HSCF_JOB_TASK_SAVE_BUTTON}
        Click Element    ${HSCF_JOB_TASK_SAVE_BUTTON}
        Wait Until Element Is Not Visible    ${overlay_header}    15s
    END
    Wait Until Element Is Visible    ${HSCF_JOB_TASK_NEXT_BUTTON}    15s
    Element Should Be Enabled    ${HSCF_JOB_TASK_NEXT_BUTTON}
    Click Element    ${HSCF_JOB_TASK_NEXT_BUTTON}
    Log    STEP COMPLETE: Marked all work orders Completed and continued from the Job Task Overview    INFO
    Capture HomeServe Keyword Screenshot

HSCF Closure Task Status
    ${task_badges}=    Get WebElements    ${HSCF_CLOSURE_TASK_BADGES}
    ${task_names}=    Get WebElements    ${HSCF_CLOSURE_TASK_NAMES}
    ${badge_count}=    Get Length    ${task_badges}
    ${task_name_count}=    Get Length    ${task_names}
    Should Be True    ${badge_count} > 0    No completed closure task status badges were found.
    Should Be Equal As Integers    ${task_name_count}    ${badge_count}    Task name and status counts do not match.
    ${task_statuses}=    Create List
    FOR    ${badge}    IN    @{task_badges}
        ${task_status}=    Get Text    ${badge}
        Should Be Equal    ${task_status}    Completed    Expected every closure task status to be Completed.
        Append To List    ${task_statuses}    ${task_status}
    END
    ${report_table}=    Set Variable    <table border="1"><thead><tr><th>Task Name</th><th>Status</th></tr></thead><tbody>
    FOR    ${task_name}    ${task_status}    IN ZIP    ${task_names}    ${task_statuses}
        ${task_name_text}=    Get Text    ${task_name}
        Should Not Be Empty    ${task_name_text}    Found an empty closure task name.
        ${report_table}=    Catenate    SEPARATOR=    ${report_table}    <tr><td>${task_name_text}</td><td>${task_status}</td></tr>
    END
    ${report_table}=    Catenate    SEPARATOR=    ${report_table}    </tbody></table>
    Log    ${report_table}    level=INFO    html=True
    Wait Until Element Is Visible    ${HSCF_CLOSURE_TASK_NOTE}    15s
    Input Text    ${HSCF_CLOSURE_TASK_NOTE}    Closing the case with all status validated
    Wait Until Element Is Visible    ${HSCF_CLOSE_CASE_BUTTON}    15s
    Element Should Be Enabled    ${HSCF_CLOSE_CASE_BUTTON}
    Click Element    ${HSCF_CLOSE_CASE_BUTTON}
    Log    STEP COMPLETE: Validated completed closure tasks, logged task names and statuses, and closed the case    INFO
    Capture HomeServe Keyword Screenshot

Capture HomeServe Keyword Screenshot
    Capture Page Screenshot
