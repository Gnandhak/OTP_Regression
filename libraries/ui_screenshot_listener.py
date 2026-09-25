"""Capture a browser screenshot after each Robot Framework keyword."""

from __future__ import annotations

import re
from pathlib import Path

from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn

ROBOT_LISTENER_API_VERSION = 3


class UiScreenshotListener:
    """Robot listener that captures screenshots without changing test results."""

    def __init__(self) -> None:
        self._sequence = 0

    def end_keyword(self, data, result) -> None:
        """Capture the browser state after each completed keyword."""
        keyword_name = result.name or "keyword"
        if keyword_name.lower() == "capture page screenshot":
            return

        try:
            selenium = BuiltIn().get_library_instance("SeleniumLibrary")
            if not selenium.get_browser_ids():
                return

            output_dir = Path(BuiltIn().get_variable_value("${OUTPUT DIR}", "."))
            screenshot_dir = output_dir / "screenshots"
            screenshot_dir.mkdir(parents=True, exist_ok=True)
            self._sequence += 1
            safe_name = re.sub(r"[^A-Za-z0-9_.-]+", "_", keyword_name).strip("_") or "keyword"
            filename = screenshot_dir / f"{self._sequence:04d}_{safe_name}.png"
            selenium.capture_page_screenshot(str(filename))
        except Exception as error:  # Screenshot failures must not fail the UI test.
            logger.warn(f"Screenshot capture skipped after '{keyword_name}': {error}")


_listener = UiScreenshotListener()


def end_keyword(data, result) -> None:
    """Forward Robot's listener callback to the screenshot listener instance."""
    _listener.end_keyword(data, result)