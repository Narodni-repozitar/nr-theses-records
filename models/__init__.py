# Copyright (c) 2022 CESNET
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

import importlib.resources as pkg_resources
from yaml import full_load
from .. import models

nr_theses_records = full_load(pkg_resources.open_text(models, 'nr-theses-records.yaml'))
