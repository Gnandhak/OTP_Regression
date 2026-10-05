"""Robot Framework variables loaded from environment variables."""

import os
from pathlib import Path


SF_LOGIN_URL = os.environ.get("SF_LOGIN_URL", "https://homeservehs--sit.sandbox.my.salesforce.com/")
SF_BROWSER = os.environ.get("SF_BROWSER", "chrome")
SF_HEADLESS = os.environ.get("SF_HEADLESS", "false").lower()
SF_MANUAL_SSO = os.environ.get("SF_MANUAL_SSO", "true").lower()
SF_PROFILE_DIR = os.environ.get(
	"SF_PROFILE_DIR",
	str(Path(__file__).resolve().parents[1] / ".runtime" / "salesforce-profile"),
)
SF_LOGIN_TIMEOUT = os.environ.get("SF_LOGIN_TIMEOUT", "180")

OTP_SUPERVISOR_CASE_NUMBER = os.environ.get("OTP_SUPERVISOR_CASE_NUMBER", "")
OTP_TARGET_USER_NAME = os.environ.get("OTP_TARGET_USER_NAME", "")
OTP_COMMAND_CENTER_CASE_NUMBER = os.environ.get("OTP_COMMAND_CENTER_CASE_NUMBER", "")
OTP_SENIOR_MANAGER_CASE_NUMBER = os.environ.get("OTP_SENIOR_MANAGER_CASE_NUMBER", "")
OTP_SENIOR_MANAGER_NAME = os.environ.get("OTP_SENIOR_MANAGER_NAME", "")
OTP_COMPLAINT_SUBJECT = os.environ.get("OTP_COMPLAINT_SUBJECT", "")
OTP_COMPLAINT_DESCRIPTION = os.environ.get("OTP_COMPLAINT_DESCRIPTION", "")
OTP_REPORT_NAME = os.environ.get("OTP_REPORT_NAME", "")
OTP_DASHBOARD_NAME = os.environ.get("OTP_DASHBOARD_NAME", "")