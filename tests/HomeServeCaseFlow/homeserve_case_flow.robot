*** Settings ***
Library     SeleniumLibrary
Variables   ../../config/variables.py
Variables   ../../config/privacy_variables.py
Variables   ../../config/homeserve_variables.py
Resource    ../../resources/common.robot
Resource    ../../resources/pages/login_page.robot
Resource    ../../resources/pages/privacy_case_flow.robot
Resource    ../../resources/pages/homeserve_case_flow.robot

*** Test Cases ***
OTP Privacy Allocator Enters HomeServe Case Details
    [Teardown]    Close All Browsers
    Login As OTP Privacy Allocator
    Open OTP Service Console
    Open Privacy Cases Tab
    Open New HomeServe Case And Enter Details    ${DATA.CaseOrigin}    ${DATA.CaseType}    ${DATA.Subject}    ${DATA.Description}
    HSCF Request Summary    ${DATA.HSCFRequestSearch}    ${DATA.HSCFRequestNumber}    ${DATA.HSCFRequestQuantity}    ${DATA.HSCFEligible}
    HSCF Job Task Overview    ${DATA.HSCFJobTaskStatus}
    HSCF Closure Task Status
