"""Environment-backed test data and selectors for the HomeServe case flow."""

import os


DATA = {
    "CaseOrigin": os.environ.get("HOMESERVE_CASE_ORIGIN", ""),
    "CaseType": os.environ.get("HOMESERVE_CASE_TYPE", ""),
    "Subject": os.environ.get("HOMESERVE_CASE_SUBJECT", ""),
    "Description": os.environ.get(
        "HOMESERVE_CASE_DESCRIPTION", "HomeServe Cares case creation"
    ),
    "HSCFRequestSearch": os.environ.get("HSCF_REQUEST_SEARCH", ""),
    "HSCFRequestNumber": os.environ.get("HSCF_REQUEST_NUMBER", ""),
    "HSCFRequestQuantity": os.environ.get("HSCF_REQUEST_QUANTITY", ""),
    "HSCFEligible": os.environ.get("HSCF_ELIGIBLE", ""),
    "HSCFJobTaskStatus": os.environ.get("HSCF_JOB_TASK_STATUS", "Completed"),
}

HOMESERVE_NEW_CASE_LINK = os.environ.get(
    "HOMESERVE_NEW_CASE_LINK", "xpath=(//a[contains(@title,'New')])[1]"
)
HOMESERVE_NEW_CASE_HEADING = os.environ.get(
    "HOMESERVE_NEW_CASE_HEADING", "xpath=//h2[contains(text(),'New Case')]"
)
HOMESERVE_CASE_RECORD_TYPE_RADIO = os.environ.get(
    "HOMESERVE_CASE_RECORD_TYPE_RADIO",
    "xpath=(//span[contains(@class,'topdown-radio--faux')])[2]",
)
HOMESERVE_NEXT_BUTTON = os.environ.get(
    "HOMESERVE_NEXT_BUTTON", "xpath=//button[contains(normalize-space(.),'Next')]"
)
HOMESERVE_CASE_ORIGIN_COMBOBOX = os.environ.get(
    "HOMESERVE_CASE_ORIGIN_COMBOBOX",
    "xpath=//button[@role='combobox' and @aria-label='Case Origin']",
)
HOMESERVE_CASE_TYPE_COMBOBOX = os.environ.get(
    "HOMESERVE_CASE_TYPE_COMBOBOX",
    "xpath=//*[@data-target-selection-name='sfdc:RecordField.Case.Type']//button[@role='combobox']",
)
HOMESERVE_CASE_SUBJECT_INPUT = os.environ.get(
    "HOMESERVE_CASE_SUBJECT_INPUT", "xpath=//*[@name='Subject']"
)
HOMESERVE_CASE_DESCRIPTION_INPUT = os.environ.get(
    "HOMESERVE_CASE_DESCRIPTION_INPUT",
    "xpath=(//textarea[contains(@class,'slds-textarea')])[1]",
)
HOMESERVE_SAVE_CASE_BUTTON = os.environ.get(
    "HOMESERVE_SAVE_CASE_BUTTON", "xpath=//*[@name='SaveEdit']"
)
HOMESERVE_CASE_NUMBER_FIELD = os.environ.get(
    "HOMESERVE_CASE_NUMBER_FIELD", "xpath=//slot[@name='primaryField']"
)
HSCF_REQUEST_SEARCH_INPUT = os.environ.get(
    "HSCF_REQUEST_SEARCH_INPUT",
    "xpath=//input[contains(@class,'slds-combobox__input')]",
)
HSCF_REQUEST_NUMBER_INPUT = os.environ.get(
    "HSCF_REQUEST_NUMBER_INPUT", "xpath=//input[contains(@placeholder,'Enter number')]"
)
HSCF_REQUEST_QUANTITY_INPUT = os.environ.get(
    "HSCF_REQUEST_QUANTITY_INPUT",
    "xpath=(//input[contains(@class,'slds-input') and @role='spinbutton'])[2]",
)
HSCF_ELIGIBLE_DROPDOWN = os.environ.get(
    "HSCF_ELIGIBLE_DROPDOWN", "xpath=//button[@name='Eligible__c']"
)
HSCF_REQUEST_NEXT_BUTTON = os.environ.get(
    "HSCF_REQUEST_NEXT_BUTTON",
    "xpath=//button[contains(@class,'slds-button_brand') and normalize-space()='Next']",
)
HSCF_JOB_TASK_STEP_LABEL = os.environ.get(
    "HSCF_JOB_TASK_STEP_LABEL", "xpath=//p[contains(@class,'stepLabel')]"
)
HSCF_JOB_TASK_UPDATE_BUTTONS = os.environ.get(
    "HSCF_JOB_TASK_UPDATE_BUTTONS",
    "//button[@title='Update Work Order Status']",
)
HSCF_JOB_TASK_STATUS_DROPDOWN = os.environ.get(
    "HSCF_JOB_TASK_STATUS_DROPDOWN", "xpath=//*[@name='newStatus']"
)
HSCF_JOB_TASK_SAVE_BUTTON = os.environ.get(
    "HSCF_JOB_TASK_SAVE_BUTTON", "xpath=//*[@title='Save']"
)
HSCF_JOB_TASK_NEXT_BUTTON = os.environ.get(
    "HSCF_JOB_TASK_NEXT_BUTTON", "xpath=//button[@aria-disabled='true']"
)
HSCF_CLOSURE_TASK_BADGES = os.environ.get(
    "HSCF_CLOSURE_TASK_BADGES", "xpath=//*[@class='slds-badge slds-theme_success']"
)
HSCF_CLOSURE_TASK_NAMES = os.environ.get(
    "HSCF_CLOSURE_TASK_NAMES",
    "xpath=//div[contains(@class,'closure-col-name')]//span[contains(@class,'closure-cell-text') and normalize-space(.)!='']",
)
HSCF_CLOSURE_TASK_NOTE = os.environ.get(
    "HSCF_CLOSURE_TASK_NOTE", "xpath=//*[@class='slds-textarea']"
)
HSCF_CLOSE_CASE_BUTTON = os.environ.get(
    "HSCF_CLOSE_CASE_BUTTON", "xpath=//button[contains(.,'Close Case')]"
)
