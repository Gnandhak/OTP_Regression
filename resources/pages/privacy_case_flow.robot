*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${THIRD_RECORD_TYPE_RADIO_CONTAINER}    xpath=(//label[contains(@class,'topdown-radio-container')])[3]
${NEW_CASE_LINK}                         xpath=(//a[contains(@title,'New')])[1]
${RECORD_TYPE_NEXT_BUTTON}               xpath=(//button[contains(@class,'slds-button_brand')])[5]
${CASE_STATUS_COMBOBOX}                  xpath=//*[@data-target-selection-name='sfdc:RecordField.Case.Status']//button[@role='combobox']
${CASE_PRIORITY_COMBOBOX}                xpath=(//flexipage-field[@data-field-id='RecordPriorityField']//button[@role='combobox'])[2]
${NEW_CASE_NUMBER_FIELD}                 xpath=(//*[@name='primaryField'])[1]
${CONTACT_NAME_LOOKUP_INPUT}             xpath=//*[@id='combobox-input-207']
${UPDATE_WORK_ORDER_STATUS}              xpath=(//*[@title='Update Work Order Status'])[2]
${CASE_SUBJECT_INPUT}                    xpath=//*[@name='Subject']
${CASE_DESCRIPTION_INPUT}                xpath=//textarea[@name='Description']

*** Keywords ***
Submit Privacy Request And Verify Acknowledgement
    Open Privacy Request Form
    Require Setting    ${PRIVACY_TEST_EMAIL}    PRIVACY_TEST_EMAIL
    Require Setting    ${PRIVACY_TYPE}    PRIVACY_TYPE
    Require Setting    ${PRIVACY_ACKNOWLEDGEMENT_LOCATOR}    PRIVACY_ACKNOWLEDGEMENT_LOCATOR
    Input Text    ${PRIVACY_FIRST_NAME_LOCATOR}    Jane
    Input Text    ${PRIVACY_LAST_NAME_LOCATOR}    Doe
    Input Text    ${PRIVACY_EMAIL_LOCATOR}    ${PRIVACY_TEST_EMAIL}
    Select Privacy Type    ${PRIVACY_TYPE}
    Click Element    ${PRIVACY_SUBMIT_LOCATOR}
    Wait Until Element Is Visible    ${PRIVACY_ACKNOWLEDGEMENT_LOCATOR}    30s
    ${acknowledgement}=    Get Text    ${PRIVACY_ACKNOWLEDGEMENT_LOCATOR}
    Should Match Regexp    ${acknowledgement}    (?is).*received.*request.*process.*
    Complete UI Test Step    privacy_rtoo_submitted    Submitted an RTOO privacy request and verified its acknowledgement

Submit Empty Privacy Request And Verify Required Errors
    Open Privacy Request Form
    Require Setting    ${PRIVACY_FIRST_NAME_ERROR_LOCATOR}    PRIVACY_FIRST_NAME_ERROR_LOCATOR
    Require Setting    ${PRIVACY_LAST_NAME_ERROR_LOCATOR}    PRIVACY_LAST_NAME_ERROR_LOCATOR
    Require Setting    ${PRIVACY_EMAIL_ERROR_LOCATOR}    PRIVACY_EMAIL_ERROR_LOCATOR
    Require Setting    ${PRIVACY_ACKNOWLEDGEMENT_LOCATOR}    PRIVACY_ACKNOWLEDGEMENT_LOCATOR
    Click Element    ${PRIVACY_SUBMIT_LOCATOR}
    Wait Until Element Is Visible    ${PRIVACY_FIRST_NAME_ERROR_LOCATOR}    15s
    Wait Until Element Is Visible    ${PRIVACY_LAST_NAME_ERROR_LOCATOR}    15s
    Wait Until Element Is Visible    ${PRIVACY_EMAIL_ERROR_LOCATOR}    15s
    Page Should Not Contain Element    ${PRIVACY_ACKNOWLEDGEMENT_LOCATOR}
    Complete UI Test Step    privacy_required_validation    Confirmed blank required fields prevent submission and show validation errors

Open Privacy Request Form
    Require Setting    ${PRIVACY_FORM_URL}    PRIVACY_FORM_URL
    Require Setting    ${PRIVACY_FORM_READY_LOCATOR}    PRIVACY_FORM_READY_LOCATOR
    Require Setting    ${PRIVACY_FIRST_NAME_LOCATOR}    PRIVACY_FIRST_NAME_LOCATOR
    Require Setting    ${PRIVACY_LAST_NAME_LOCATOR}    PRIVACY_LAST_NAME_LOCATOR
    Require Setting    ${PRIVACY_EMAIL_LOCATOR}    PRIVACY_EMAIL_LOCATOR
    Require Setting    ${PRIVACY_TYPE_CONTROL_LOCATOR}    PRIVACY_TYPE_CONTROL_LOCATOR
    Require Setting    ${PRIVACY_SUBMIT_LOCATOR}    PRIVACY_SUBMIT_LOCATOR
    Open Browser    ${PRIVACY_FORM_URL}    ${SF_BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${PRIVACY_FORM_READY_LOCATOR}    30s

Select Privacy Type
    [Arguments]    ${privacy_type}
    Click Element    ${PRIVACY_TYPE_CONTROL_LOCATOR}
    ${option}=    Set Variable    xpath=//*[starts-with(@id,'source-list-')]/li[@data-value="${privacy_type}" or .//*[@data-value="${privacy_type}"]]
    Wait Until Element Is Visible    ${option}    15s
    ${option_count}=    Get Element Count    ${option}
    Should Be Equal As Integers    ${option_count}    1    Expected exactly one privacy type option with data-value "${privacy_type}".
    Click Element    ${option}

Open New Case, Select Third Record Type, And Set Status
    [Arguments]    ${status}    ${priority}    ${contact_name}    ${subject}    ${description}
    Wait Until Element Is Visible    ${NEW_CASE_LINK}    30s
    Click Element    ${NEW_CASE_LINK}
    Wait Until Element Is Visible    ${THIRD_RECORD_TYPE_RADIO_CONTAINER}    30s
    Click Element    ${THIRD_RECORD_TYPE_RADIO_CONTAINER}
    Click Next, Set Status, Priority, Contact, Subject, And Description    ${status}    ${priority}    ${contact_name}    ${subject}    ${description}

Click Next, Set Status, Priority, Contact, Subject, And Description
    [Arguments]    ${status}    ${priority}    ${contact_name}    ${subject}    ${description}
    Wait Until Element Is Visible    ${RECORD_TYPE_NEXT_BUTTON}    30s
    Click Element    ${RECORD_TYPE_NEXT_BUTTON}
    Select Case Status    ${status}
    Select Case Priority    ${priority}
    Search And Select Contact Name    ${contact_name}
    Enter Case Subject    ${subject}
    Enter Case Description    ${description}
    Save New Case And Validate Case Number
    Complete UI Test Step    privacy_new_case_fields    Set status ${status}, priority ${priority}, contact ${contact_name}, subject, and description

Select Case Status
    [Arguments]    ${status}
    Require Setting    ${status}    DATA.Status
    Wait Until Element Is Visible    ${CASE_STATUS_COMBOBOX}    30s
    Click Element    ${CASE_STATUS_COMBOBOX}
    ${status_option}=    Set Variable    xpath=//*[@role='option' and @title="${status}"]
    Wait Until Element Is Visible    ${status_option}    15s
    ${status_option_count}=    Get Element Count    ${status_option}
    Should Be Equal As Integers    ${status_option_count}    1    Expected exactly one Case Status option titled "${status}".
    Click Element    ${status_option}

Select Case Priority
    [Arguments]    ${priority}
    Require Setting    ${priority}    DATA.Priority
    Wait Until Element Is Visible    ${CASE_PRIORITY_COMBOBOX}    30s
    Click Element    ${CASE_PRIORITY_COMBOBOX}
    ${priority_option}=    Set Variable    xpath=//*[@role='option' and @title="${priority}"]
    Wait Until Element Is Visible    ${priority_option}    15s
    ${priority_option_count}=    Get Element Count    ${priority_option}
    Should Be Equal As Integers    ${priority_option_count}    1    Expected exactly one Case Priority option titled "${priority}".
    Click Element    ${priority_option}

Search And Select Contact Name
    [Arguments]    ${contact_name}
    Should Not Be Empty    ${contact_name}    Contact name test data is required.
    Wait Until Element Is Visible    ${CONTACT_NAME_LOOKUP_INPUT}    15s
    Input Text    ${CONTACT_NAME_LOOKUP_INPUT}    ${contact_name}
    ${contact_option}=    Set Variable    xpath=//*[@role='option' and contains(normalize-space(.), "${contact_name}")]
    Wait Until Element Is Visible    ${contact_option}    15s
    ${contact_option_count}=    Get Element Count    ${contact_option}
    Should Be Equal As Integers    ${contact_option_count}    1    Expected exactly one contact suggestion named "${contact_name}".
    Click Element    ${contact_option}

Enter Case Subject
    [Arguments]    ${subject}
    Require Setting    ${subject}    DATA.Subject
    Wait Until Element Is Visible    ${CASE_SUBJECT_INPUT}    15s
    Input Text    ${CASE_SUBJECT_INPUT}    ${subject}

Enter Case Description
    [Arguments]    ${description}
    Require Setting    ${description}    DATA.Description
    Wait Until Element Is Visible    ${CASE_DESCRIPTION_INPUT}    15s
    Input Text    ${CASE_DESCRIPTION_INPUT}    ${description}

Save New Case And Validate Case Number
    Wait Until Element Is Visible    xpath=//*[@name='SaveEdit']    15s
    Click Element    xpath=//*[@name='SaveEdit']
    Validate New Case Number

Validate New Case Number
    Wait Until Element Is Visible    ${NEW_CASE_NUMBER_FIELD}    30s
    ${case_number}=    Get Text    ${NEW_CASE_NUMBER_FIELD}
    IF    $case_number == ''
        ${case_number}=    Get Value    ${NEW_CASE_NUMBER_FIELD}
    END
    Should Not Be Empty    ${case_number}    Could not read the created case number from the primary field.
    Log    Created case number: ${case_number}    INFO

Login As OTP Privacy Allocator
    Open Browser    ${SF_LOGIN_URL}    ${SF_BROWSER}
    Maximize Browser Window
    Login Through SIT SSO    ${SF_MANUAL_SSO}    ${SF_LOGIN_TIMEOUT}
    Wait For Salesforce Home
    Complete UI Test Step    privacy_allocator_login    Logged in as OTP Privacy Allocator

Open OTP Service Console
    Wait Until Element Is Visible    ${PRIVACY_SF_CONSOLE_LOCATOR}    30s
    Click Element    ${PRIVACY_SF_CONSOLE_LOCATOR}
    Wait Until Element Is Visible    ${PRIVACY_SF_CONSOLE_READY_LOCATOR}    30s
    Complete UI Test Step    privacy_allocator_console    Opened the OTP Service Console

Open Privacy Cases Tab
    Click Element    ${PRIVACY_SF_CASES_TAB_LOCATOR}
    Wait Until Element Is Visible    ${PRIVACY_SF_CASES_READY_LOCATOR}    30s
    Complete UI Test Step    privacy_cases_tab    Opened the Cases tab

Select All Open Privacy Cases
    Click Element    ${PRIVACY_SF_LIST_VIEW_BUTTON_LOCATOR}
    Click Element    ${PRIVACY_SF_ALL_OPEN_CASES_LOCATOR}
    Wait Until Element Is Visible    ${PRIVACY_SF_LIST_VIEW_READY_LOCATOR}    30s
    Complete UI Test Step    privacy_all_open_cases    Changed the list view to All Open Cases

Open Privacy Case From Search
    Input Text    ${PRIVACY_SF_CASE_SEARCH_LOCATOR}    ${PRIVACY_CASE_SEARCH_VALUE}
    Wait Until Element Is Visible    ${PRIVACY_SF_CASE_RESULT_LOCATOR}    30s
    Click Element    ${PRIVACY_SF_CASE_RESULT_LOCATOR}
    Wait Until Element Is Visible    ${PRIVACY_SF_CASE_READY_LOCATOR}    30s
    Complete UI Test Step    privacy_case_opened    Opened the new Privacy case

Verify Privacy Case Details
    Element Should Contain    ${PRIVACY_SF_REQUEST_ORIGIN_LOCATOR}    Web - Privacy
    Element Should Contain    ${PRIVACY_SF_PRIVACY_TYPE_LOCATOR}    ${PRIVACY_TYPE}
    Element Should Contain    ${PRIVACY_SF_CASE_OWNER_LOCATOR}    Privacy Queue
    Complete UI Test Step    privacy_case_values_verified    Verified request origin, privacy type, and queue ownership

Verify Privacy Task Overview Shows Completed Status
    Require Setting    ${PRIVACY_TASK_OVERVIEW_LOCATOR}    PRIVACY_TASK_OVERVIEW_LOCATOR
    Require Setting    ${PRIVACY_TASK_STATUS_LOCATOR}    PRIVACY_TASK_STATUS_LOCATOR
    Wait Until Element Is Visible    ${PRIVACY_TASK_OVERVIEW_LOCATOR}    30s
    Click Element    ${PRIVACY_TASK_OVERVIEW_LOCATOR}
    Wait Until Element Is Visible    ${UPDATE_WORK_ORDER_STATUS}    30s
    Click Element    ${UPDATE_WORK_ORDER_STATUS}
    Wait Until Element Is Visible    ${PRIVACY_TASK_STATUS_LOCATOR}    30s
    Element Should Contain    ${PRIVACY_TASK_STATUS_LOCATOR}    Completed
    Complete UI Test Step    privacy_task_completed    Verified the Privacy Task Overview status is Completed

Validate Salesforce Privacy Case Settings
    Require Setting    ${SF_LOGIN_URL}    SF_LOGIN_URL
    Require Setting    ${PRIVACY_CASE_SEARCH_VALUE}    PRIVACY_CASE_SEARCH_VALUE
    Require Setting    ${PRIVACY_SF_CONSOLE_LOCATOR}    PRIVACY_SF_CONSOLE_LOCATOR
    Require Setting    ${PRIVACY_SF_CONSOLE_READY_LOCATOR}    PRIVACY_SF_CONSOLE_READY_LOCATOR
    Require Setting    ${PRIVACY_SF_CASES_TAB_LOCATOR}    PRIVACY_SF_CASES_TAB_LOCATOR
    Require Setting    ${PRIVACY_SF_CASES_READY_LOCATOR}    PRIVACY_SF_CASES_READY_LOCATOR
    Require Setting    ${PRIVACY_SF_LIST_VIEW_BUTTON_LOCATOR}    PRIVACY_SF_LIST_VIEW_BUTTON_LOCATOR
    Require Setting    ${PRIVACY_SF_ALL_OPEN_CASES_LOCATOR}    PRIVACY_SF_ALL_OPEN_CASES_LOCATOR
    Require Setting    ${PRIVACY_SF_LIST_VIEW_READY_LOCATOR}    PRIVACY_SF_LIST_VIEW_READY_LOCATOR
    Require Setting    ${PRIVACY_SF_CASE_SEARCH_LOCATOR}    PRIVACY_SF_CASE_SEARCH_LOCATOR
    Require Setting    ${PRIVACY_SF_CASE_RESULT_LOCATOR}    PRIVACY_SF_CASE_RESULT_LOCATOR
    Require Setting    ${PRIVACY_SF_CASE_READY_LOCATOR}    PRIVACY_SF_CASE_READY_LOCATOR
    Require Setting    ${PRIVACY_SF_REQUEST_ORIGIN_LOCATOR}    PRIVACY_SF_REQUEST_ORIGIN_LOCATOR
    Require Setting    ${PRIVACY_SF_PRIVACY_TYPE_LOCATOR}    PRIVACY_SF_PRIVACY_TYPE_LOCATOR
    Require Setting    ${PRIVACY_SF_CASE_OWNER_LOCATOR}    PRIVACY_SF_CASE_OWNER_LOCATOR

Require Setting
    [Arguments]    ${value}    ${setting_name}
    Should Not Be Empty    ${value}    Configure ${setting_name} in the test environment before running this case.