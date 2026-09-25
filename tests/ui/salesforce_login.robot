*** Settings ***
Variables    ../../config/variables.py
Resource     ../../resources/common.robot
Resource     ../../resources/pages/login_page.robot
Suite Setup       Open Salesforce Browser    ${SF_LOGIN_URL}    ${SF_BROWSER}    ${SF_HEADLESS}
Suite Teardown    Close Salesforce Browser

*** Test Cases ***
Salesforce SIT SSO Login Smoke Test
    Login Through SIT SSO    ${SF_MANUAL_SSO}    ${SF_LOGIN_TIMEOUT}
    Wait For Salesforce Home