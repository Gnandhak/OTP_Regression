*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections
Library    String

*** Keywords ***
Open Salesforce Browser
    [Arguments]    ${url}    ${browser}=chrome    ${headless}=false    ${profile_dir}=${EMPTY}
    ${browser_name}=    Convert To Lower Case    ${browser}
    IF    $browser_name == 'edge'
        ${options}=    Evaluate    sys.modules['selenium.webdriver'].EdgeOptions()    sys, selenium.webdriver
    ELSE
        ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    END
    IF    '${headless}' == 'true'
        Call Method    ${options}    add_argument    --headless
    END
    IF    $profile_dir != ''
        Create Directory    ${profile_dir}
        ${profile_argument}=    Set Variable    --user-data-dir=${profile_dir}
        Evaluate    $options.add_argument($profile_argument)
    END
    Open Browser    ${url}    ${browser}    options=${options}
    Maximize Browser Window

Close Salesforce Browser
    Close All Browsers

Complete UI Test Step
    [Arguments]    ${step_id}    ${step_description}
    Create Directory    ${OUTPUT DIR}${/}screenshots
    Log    STEP COMPLETE: ${step_description}    INFO
    Capture Page Screenshot    ${OUTPUT DIR}${/}screenshots${/}${step_id}.png

Require Environment Variable
    [Arguments]    ${name}
    ${value}=    Get Environment Variable    ${name}
    Should Not Be Empty    ${value}    Environment variable ${name} is required.
    RETURN    ${value}