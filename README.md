# CRT-Odyssey-OTP-Regression-Testing

Copado CRT support for Odyssey OTP regression testing.

## Reusable HSCF email method

The reusable implementation is in [libraries/email_sender.py](libraries/email_sender.py). It creates a unique plus-address from a configured mailbox, then sends the HSCF flow message through an SMTP relay. The mailbox provider must support plus addressing, or the test recipient should be replaced with a unique mailbox service address.

### Folder structure

```text
libraries/
	email_sender.py       # Python SMTP implementation
robot/
	EmailKeywords.py      # Robot Framework keyword wrapper
	HSCF_Email.robot      # Aqua case usage example
.env.example            # Configuration reference
```

### Copado configuration

Create the variables in [.env.example](.env.example) as Copado job environment variables. You may use your own Outlook/Microsoft 365 mailbox as `SMTP_USERNAME` and `SMTP_FROM`. Store `SMTP_PASSWORD` as a Copado secret and never commit real credentials.

For Outlook/Microsoft 365, use `smtp.office365.com`, port `587`, and TLS enabled. Your Microsoft 365 administrator must allow authenticated SMTP (SMTP AUTH) for your account. If MFA is enabled, a normal mailbox password usually cannot be used; use an approved app password where your organization permits it, or use an OAuth2/Microsoft Graph implementation instead. Do not disable MFA or tenant security controls just to make the test work.

Required variables are `SMTP_HOST`, `SMTP_PORT`, `SMTP_USERNAME`, `SMTP_PASSWORD`, `SMTP_FROM`, and `SMTP_USE_TLS`.

Run the example from the repository root with:

```powershell
robot --pythonpath . robot/HSCF_Email.robot
```

The example uses `Send HSCF Test Mail` to send to the exact Salesforce Case email address. Use `Send Unique HSCF Test Mail` when the target mailbox supports plus addressing and each test run needs a generated recipient. Both keywords return the address used.

## Salesforce UI automation framework

The UI framework uses Robot Framework and SeleniumLibrary. Tests are separated from reusable browser keywords and page objects so new Salesforce flows can reuse the same login and browser foundation.

### Folder structure

```text
config/
	variables.py                 # Environment-backed, non-secret Robot variables
resources/
	common.robot                 # Browser lifecycle and shared keywords
	pages/
		login_page.robot           # Salesforce login page object
tests/
	ui/
		salesforce_login.robot     # Starter Salesforce UI smoke test
libraries/                     # Python integrations, including email_sender.py
requirements.txt               # Python dependencies
```

### Install dependencies

Use the approved Python package source configured for your organization:

```powershell
python -m pip install -r requirements.txt
```

### Copado variables

Configure these as Copado job variables. Mark `SF_PASSWORD` as a secret and do not commit it:

```text
SF_LOGIN_URL=https://homeservehs--sit.sandbox.my.salesforce.com/
SF_BROWSER=chrome
SF_HEADLESS=false
SF_MANUAL_SSO=true
SF_LOGIN_TIMEOUT=180
SF_PROFILE_DIR=.runtime/salesforce-profile
```

### Run locally or in Copado

```powershell
python -m robot --pythonpath . --listener libraries/ui_screenshot_listener.py tests/ui/salesforce_login.robot
```

The starter test launches the SIT URL, clicks `Login with SIT SSO` when visible, and pauses for manual Okta password/MFA completion. Chrome uses `.runtime/salesforce-profile` so the authenticated session can be reused locally on later runs. The profile contains sensitive session cookies, is ignored by Git, and must not be copied or shared. Keep `SF_HEADLESS=false` for this manual flow; it is not suitable for unattended Copado jobs until an approved non-interactive SSO solution is available. Keep the `--listener libraries/ui_screenshot_listener.py` option in the Copado execution command to enable screenshots.

### Automatic screenshots

The UI suite imports [libraries/ui_screenshot_listener.py](libraries/ui_screenshot_listener.py), which captures a screenshot after each completed Robot keyword when a browser is active. Files are written to `screenshots/` under the Robot output directory and are ignored by Git. Screenshot failures are logged as warnings and do not fail the business test.
