*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections

*** Keywords ***
Open Salesforce Browser
    [Arguments]    ${url}    ${browser}=chrome    ${headless}=false    ${profile_dir}=${EMPTY}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    IF    '${headless}' == 'true'
        Call Method    ${options}    add_argument    --headless
    END
    IF    '${profile_dir}' != ''
        Create Directory    ${profile_dir}
        ${profile_argument}=    Set Variable    --user-data-dir=${profile_dir}
        Evaluate    $options.add_argument($profile_argument)
    END
    Open Browser    ${url}    ${browser}    options=${options}
    Maximize Browser Window

Close Salesforce Browser
    Close All Browsers

Require Environment Variable
    [Arguments]    ${name}
    ${value}=    Get Environment Variable    ${name}
    Should Not Be Empty    ${value}    Environment variable ${name} is required.
    RETURN    ${value}