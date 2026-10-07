*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Variables   ../../config/variables.py
Variables   ../../config/privacy_variables.py
Resource    ../../resources/common.robot
Resource    ../../resources/pages/login_page.robot
Resource    ../../resources/pages/privacy_case_flow.robot

*** Test Cases ***
Submit Privacy Request For Configured Type And Verify Acknowledgement
    [Teardown]    Close All Browsers
    Submit Privacy Request And Verify Acknowledgement

Submit Privacy Request With Required Fields Blank
    [Teardown]    Close All Browsers
    Submit Empty Privacy Request And Verify Required Errors

MuleSoft OAuth Authentication Verification Requires Integration Team
    Skip    External integration verification: confirm with the integrations team that MuleSoft rejects missing or invalid Okta OAuth tokens.

OTP Privacy Allocator Opens New Case And Selects Third Record Type
    [Teardown]    Close All Browsers
    Validate Salesforce Privacy Case Settings
    Login As OTP Privacy Allocator
    Open OTP Service Console
    Open Privacy Cases Tab
    Open New Case, Select Third Record Type, And Set Status    ${DATA.Status}    ${DATA.Priority}    ${DATA.ContactName}    ${DATA.Subject}    ${DATA.Description}

OTP Privacy Allocator Verifies Created Privacy Case
    [Teardown]    Close All Browsers
    Validate Salesforce Privacy Case Settings
    Login As OTP Privacy Allocator
    Open OTP Service Console
    Open Privacy Cases Tab
    Select All Open Privacy Cases
    Open Privacy Case From Search
    Verify Privacy Case Details

Verify Privacy Intake WAV Notification Exists
    [Documentation]    Requires the integration to provide the exact WAV artifact path for this intake.
    Should Not Be Empty    ${PRIVACY_WAV_FILE_PATH}    Set PRIVACY_WAV_FILE_PATH to the expected intake WAV artifact.
    File Should Exist    ${PRIVACY_WAV_FILE_PATH}
