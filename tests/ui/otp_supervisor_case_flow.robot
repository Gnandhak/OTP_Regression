*** Settings ***
Variables    ../../config/variables.py
Resource     ../../resources/common.robot
Resource     ../../resources/pages/login_page.robot
Resource     ../../resources/pages/salesforce_workflows.robot
Suite Setup       Open Salesforce Browser    ${SF_LOGIN_URL}    ${SF_BROWSER}    ${SF_HEADLESS}
Suite Teardown    Close Salesforce Browser

*** Test Cases ***
OTP Supervisor Reassigns Case And Reviews Command Center Actions
    Validate Supervisor Flow Inputs
    Login Through SIT SSO    ${SF_MANUAL_SSO}    ${SF_LOGIN_TIMEOUT}
    Wait For Salesforce Home
    Complete UI Test Step    supervisor_login    Logged in as OTP Supervisor
    Open Cases Tab
    Complete UI Test Step    supervisor_cases_tab    Opened the Cases tab
    Select All Open Cases List View
    Complete UI Test Step    supervisor_all_open_cases    Changed list view to All Open Cases
    Open Case By Number    ${OTP_SUPERVISOR_CASE_NUMBER}
    Open Command Center For Service
    Complete UI Test Step    supervisor_command_center    Opened Command Center for Service
    Open Case By Number    ${OTP_COMMAND_CENTER_CASE_NUMBER}
    Complete UI Test Step    supervisor_command_center_case    Opened the selected case in Command Center for Service
    Review Current Case Actions
    Complete UI Test Step    supervisor_case_actions    Opened and reviewed the case actions menu