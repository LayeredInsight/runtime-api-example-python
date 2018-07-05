# Copyright (C) 2018 Layered Insight - All Rights Reserved
# Unauthorized copying of this file, via any medium is strictly prohibited
# Proprietary and confidential

from __future__ import print_function
import sys
from vyper import v

API_VERSION_PATH="/v0.01"

# Config setup
def env_setup():
    v.set_env_prefix("li")
    v.automatic_env()

    if not v.is_set("api_key") or not v.is_set("api_host"):
        print("LI_API_KEY or LI_API_HOST environment variables not found.")
        sys.exit()

    if not v.get("api_host").endswith(API_VERSION_PATH):
        print("ERROR: LI_API_HOST environment variable must end with " + API_VERSION_PATH)
        print("LI_API_HOST current value: " + v.get("api_host"))
        sys.exit()
