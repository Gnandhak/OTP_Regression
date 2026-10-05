*** Settings ***
Variables    ../../config/variables.py
Resource     ../../resources/common.robot
Resource     ../../resources/pages/login_page.robot
Resource     ../../resources/pages/salesforce_workflows.robot
Suite Setup       Open Salesforce Browser    ${SF_LOGIN_URL}    ${SF_BROWSER}    ${SF_HEADLESS}
Suite Teardown    Close Salesforce Browser

*** Test Cases ***
OTP Senior Manager Verifies Cases And Opens OTP Analytics
    Validate Senior Manager Flow Inputs
    Login Through SIT SSO    ${SF_MANUAL_SSO}    ${SF_LOGIN_TIMEOUT}
    Wait For Salesforce Home
    Complete UI Test Step    senior_manager_login    Logged in as OTP Senior Manager
    Open Cases Tab
    Complete UI Test Step    senior_manager_cases_tab    Opened the Cases tab
    Select All Open Cases List View
    Complete UI Test Step    senior_manager_all_open_cases    Changed list view to All Open Cases
    Verify Other-Owned Case Is Listed    ${OTP_SENIOR_MANAGER_CASE_NUMBER}    ${OTP_SENIOR_MANAGER_NAME}
    Complete UI Test Step    senior_manager_other_owned_case    Confirmed a case owned by another user is visible
    Create Complaints Case    ${OTP_COMPLAINT_SUBJECT}    ${OTP_COMPLAINT_DESCRIPTION}
    Complete UI Test Step    senior_manager_complaint_created    Created and saved a Complaints case
    Delete Current Case And Confirm
    Complete UI Test Step    senior_manager_complaint_deleted    Confirmed deletion of the Complaints test case
    Open Named Report    ${OTP_REPORT_NAME}
    Complete UI Test Step    senior_manager_otp_report    Opened OTP report ${OTP_REPORT_NAME}
    Open Named Dashboard    ${OTP_DASHBOARD_NAME}
    Complete UI Test Step    senior_manager_otp_dashboard    Opened OTP dashboard ${OTP_DASHBOARD_NAME}