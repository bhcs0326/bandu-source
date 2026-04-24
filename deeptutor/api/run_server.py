#!/usr/bin/env python
"""
Uvicorn Server Startup Script
Uses Python API instead of command line to avoid Windows path parsing issues.
"""

import asyncio
import os
from pathlib import Path
import sys

# Windows: uvicorn defaults to SelectorEventLoop which does not support
# asyncio.create_subprocess_exec.  Switch to ProactorEventLoop so that
# child-process APIs (used by Math Animator renderer, etc.) work correctly.
if sys.platform == "win32":
    asyncio.set_event_loop_policy(asyncio.WindowsProactorEventLoopPolicy())

import uvicorn

# Force unbuffered output
os.environ["PYTHONUNBUFFERED"] = "1"
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(line_buffering=True)
if hasattr(sys.stderr, "reconfigure"):
    sys.stderr.reconfigure(line_buffering=True)

def main() -> None:
    # Get project root directory
    project_root = Path(__file__).parent.parent.parent

    # Change to project root to ensure correct module imports
    os.chdir(str(project_root))

    # Ensure project root is in Python path
    if str(project_root) not in sys.path:
        sys.path.insert(0, str(project_root))

    # Get port from configuration
    from deeptutor.services.setup import get_backend_port

    backend_port = get_backend_port(project_root)

    reload_enabled = os.environ.get("BANDU_ENABLE_RELOAD", "").strip().lower() in {
        "1",
        "true",
        "yes",
        "on",
    }

    # Configure reload_excludes only when live reload is explicitly enabled.
    reload_excludes = [
        str(project_root / "venv"),  # Virtual environment
        str(project_root / ".venv"),  # Virtual environment (alternative name)
        str(project_root / "data"),  # Data directory (includes knowledge_bases, user data, logs)
        str(project_root / "node_modules"),  # Node modules (if any at root)
        str(project_root / "web" / "node_modules"),  # Web node modules
        str(project_root / "web" / ".next"),  # Next.js build
        str(project_root / ".git"),  # Git directory
        str(project_root / "scripts"),  # Scripts directory - don't reload on launcher changes
    ]

    reload_excludes = [d for d in reload_excludes if Path(d).exists()]

    uvicorn.run(
        "deeptutor.api.main:app",
        host="0.0.0.0",
        port=backend_port,
        reload=reload_enabled,
        reload_excludes=reload_excludes if reload_enabled else None,
        log_level="info",
        access_log=False,
    )


if __name__ == "__main__":
    main()
