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