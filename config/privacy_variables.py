"""Environment-backed variables for the privacy case-flow suite."""

import os


DATA = {
	"Status": os.environ.get("PRIVACY_CASE_STATUS", ""),
	"Priority": os.environ.get("PRIVACY_CASE_PRIORITY", ""),
	"ContactName": os.environ.get("PRIVACY_CONTACT_NAME", ""),
	"Subject": os.environ.get("PRIVACY_CASE_SUBJECT", ""),
	"Description": os.environ.get("PRIVACY_CASE_DESCRIPTION", ""),
	"WorkOrderStatus": os.environ.get("PRIVACY_WORK_ORDER_STATUS", ""),
	"WorkOrderCompletionNote": os.environ.get(
		"PRIVACY_WORK_ORDER_COMPLETION_NOTE",
		"Customer via Email work order status completion",
	),
	"CustomerResponseWorkOrderStatus": os.environ.get(
		"PRIVACY_CUSTOMER_RESPONSE_WORK_ORDER_STATUS", ""
	),
	"CustomerResponseCompletionNote": os.environ.get(
		"PRIVACY_CUSTOMER_RESPONSE_COMPLETION_NOTE",
		"Customer response work order status completion",
	),
	"ClosureTaskStatus": os.environ.get(
		"PRIVACY_CLOSURE_TASK_STATUS", "Tasks Complete"
	),
	"ClosureTaskNote": os.environ.get("PRIVACY_CLOSURE_TASK_NOTE", "case closed"),
}

PRIVACY_FORM_URL = os.environ.get("PRIVACY_FORM_URL", "")
PRIVACY_TEST_EMAIL = os.environ.get("PRIVACY_TEST_EMAIL", "")
PRIVACY_CASE_SEARCH_VALUE = os.environ.get("PRIVACY_CASE_SEARCH_VALUE", "")
PRIVACY_WAV_FILE_PATH = os.environ.get("PRIVACY_WAV_FILE_PATH", "")
PRIVACY_FORM_READY_LOCATOR = os.environ.get("PRIVACY_FORM_READY_LOCATOR", "")
PRIVACY_FIRST_NAME_LOCATOR = os.environ.get("PRIVACY_FIRST_NAME_LOCATOR", "")
PRIVACY_LAST_NAME_LOCATOR = os.environ.get("PRIVACY_LAST_NAME_LOCATOR", "")
PRIVACY_EMAIL_LOCATOR = os.environ.get("PRIVACY_EMAIL_LOCATOR", "")
PRIVACY_TYPE = os.environ.get("PRIVACY_TYPE", "")
PRIVACY_TYPE_CONTROL_LOCATOR = os.environ.get("PRIVACY_TYPE_CONTROL_LOCATOR", "")
PRIVACY_SUBMIT_LOCATOR = os.environ.get("PRIVACY_SUBMIT_LOCATOR", "")
PRIVACY_ACKNOWLEDGEMENT_LOCATOR = os.environ.get("PRIVACY_ACKNOWLEDGEMENT_LOCATOR", "")
PRIVACY_FIRST_NAME_ERROR_LOCATOR = os.environ.get("PRIVACY_FIRST_NAME_ERROR_LOCATOR", "")
PRIVACY_LAST_NAME_ERROR_LOCATOR = os.environ.get("PRIVACY_LAST_NAME_ERROR_LOCATOR", "")
PRIVACY_EMAIL_ERROR_LOCATOR = os.environ.get("PRIVACY_EMAIL_ERROR_LOCATOR", "")
PRIVACY_SF_CONSOLE_LOCATOR = os.environ.get("PRIVACY_SF_CONSOLE_LOCATOR", "")
PRIVACY_SF_CONSOLE_READY_LOCATOR = os.environ.get("PRIVACY_SF_CONSOLE_READY_LOCATOR", "")
PRIVACY_SF_CASES_TAB_LOCATOR = os.environ.get("PRIVACY_SF_CASES_TAB_LOCATOR", "")
PRIVACY_SF_CASES_READY_LOCATOR = os.environ.get("PRIVACY_SF_CASES_READY_LOCATOR", "")
PRIVACY_SF_LIST_VIEW_BUTTON_LOCATOR = os.environ.get("PRIVACY_SF_LIST_VIEW_BUTTON_LOCATOR", "")
PRIVACY_SF_ALL_OPEN_CASES_LOCATOR = os.environ.get("PRIVACY_SF_ALL_OPEN_CASES_LOCATOR", "")
PRIVACY_SF_LIST_VIEW_READY_LOCATOR = os.environ.get("PRIVACY_SF_LIST_VIEW_READY_LOCATOR", "")
PRIVACY_SF_CASE_SEARCH_LOCATOR = os.environ.get("PRIVACY_SF_CASE_SEARCH_LOCATOR", "")
PRIVACY_SF_CASE_RESULT_LOCATOR = os.environ.get("PRIVACY_SF_CASE_RESULT_LOCATOR", "")
PRIVACY_SF_CASE_READY_LOCATOR = os.environ.get("PRIVACY_SF_CASE_READY_LOCATOR", "")
PRIVACY_SF_REQUEST_ORIGIN_LOCATOR = os.environ.get("PRIVACY_SF_REQUEST_ORIGIN_LOCATOR", "")
PRIVACY_SF_PRIVACY_TYPE_LOCATOR = os.environ.get("PRIVACY_SF_PRIVACY_TYPE_LOCATOR", "")
PRIVACY_SF_CASE_OWNER_LOCATOR = os.environ.get("PRIVACY_SF_CASE_OWNER_LOCATOR", "")
PRIVACY_TASK_OVERVIEW_LOCATOR = os.environ.get("PRIVACY_TASK_OVERVIEW_LOCATOR", "")
PRIVACY_TASK_STATUS_LOCATOR = os.environ.get("PRIVACY_TASK_STATUS_LOCATOR", "")
PRIVACY_TASK_OVERVIEW_UPDATE_LOCATOR = os.environ.get(
	"PRIVACY_TASK_OVERVIEW_UPDATE_LOCATOR",
	"xpath=(//*[@title='Update Work Order Status'])[2]",
)
PRIVACY_TASK_OVERVIEW_STATUS_DROPDOWN_LOCATOR = os.environ.get(
	"PRIVACY_TASK_OVERVIEW_STATUS_DROPDOWN_LOCATOR",
	'xpath=//*[@id="combobox-button-314"]',
)
PRIVACY_CUSTOMER_RESPONSE_UPDATE_LOCATOR = os.environ.get(
	"PRIVACY_CUSTOMER_RESPONSE_UPDATE_LOCATOR",
	"xpath=(//*[@title='Update Work Order Status'])[3]",
)
PRIVACY_CUSTOMER_RESPONSE_STATUS_DROPDOWN_LOCATOR = os.environ.get(
	"PRIVACY_CUSTOMER_RESPONSE_STATUS_DROPDOWN_LOCATOR",
	'xpath=//*[@id="combobox-button-531"]',
)
PRIVACY_CUSTOMER_RESPONSE_NEXT_BUTTON_LOCATOR = os.environ.get(
	"PRIVACY_CUSTOMER_RESPONSE_NEXT_BUTTON_LOCATOR",
	"xpath=//*[@class='slds-button slds-button_brand']",
)
PRIVACY_CLOSURE_TASK_BADGES_LOCATOR = os.environ.get(
	"PRIVACY_CLOSURE_TASK_BADGES_LOCATOR",
	"xpath=(//span[contains(@class,'slds-badge')])",
)
PRIVACY_CLOSURE_TASK_STATUS_DROPDOWN_LOCATOR = os.environ.get(
	"PRIVACY_CLOSURE_TASK_STATUS_DROPDOWN_LOCATOR",
	'xpath=//*[@id="combobox-button-682"]',
)
PRIVACY_CLOSURE_TASK_NOTE_LOCATOR = os.environ.get(
	"PRIVACY_CLOSURE_TASK_NOTE_LOCATOR",
	"xpath=//*[@class='slds-textarea']",
)
PRIVACY_CLOSE_CASE_BUTTON_LOCATOR = os.environ.get(
	"PRIVACY_CLOSE_CASE_BUTTON_LOCATOR",
	"xpath=//button[@class='slds-button slds-button_brand']",
)