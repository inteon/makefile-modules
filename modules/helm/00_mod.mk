# Copyright 2023 The cert-manager Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ifndef bin_dir
$(error bin_dir is not set)
endif

ifndef helm_chart_source_dir
$(error helm_chart_source_dir is not set)
endif

ifndef helm_chart_image_name
$(error helm_chart_image_name is not set)
endif

ifndef helm_chart_version
$(error helm_chart_version is not set)
endif
ifneq ($(helm_chart_version:v%=v),v)
$(error helm_chart_version "$(helm_chart_version)" should start with a "v")
endif

##########################################

helm_chart_name := $(notdir $(helm_chart_image_name))
helm_chart_image_registry := $(dir $(helm_chart_image_name))
helm_chart_image_tag := $(helm_chart_version)
helm_chart_archive := $(bin_dir)/scratch/helm/$(helm_chart_name)-$(helm_chart_version).tgz
helm_digest_path := $(bin_dir)/scratch/helm/$(helm_chart_name)-$(helm_chart_version).digests
helm_digest = $(shell head -1 $(helm_digest_path) 2> /dev/null)
