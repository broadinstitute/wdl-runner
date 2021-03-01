#!/bin/bash

# Copyright 2017 Google Inc.
#
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file or at
# https://developers.google.com/open-source/licenses/bsd

set -o errexit

readonly INPUT_PATH=/pipeline/input

# WDL, INPUTS, and OPTIONS filenames are all passed into
# the pipeline as environment variables - write them out as
# files.
mkdir -p "${INPUT_PATH}"

# Only pass in the argument if it exists
files=(WDL WORKFLOW_INPUTS WORKFLOW_OPTIONS WORKFLOW_DEPENDENCIES)
inputLoc=(${INPUT_PATH}/wf.wdl ${INPUT_PATH}/wf.inputs.json ${INPUT_PATH}/wf.options.json ${INPUT_PATH}/wf.dependencies.zip)
argNames=(--wdl --workflow-inputs --workflow-options --workflow-dependencies)

extraArgs=""

COUNTER=0
for file in ${files[@]}; do
    if [[ ! -z "${!file}" ]]; then
        cp "${!file}" "${inputLoc[COUNTER]}"
        extraArgs+="${argNames[COUNTER]} ${inputLoc[COUNTER]} "
    fi
    ((COUNTER+=1))
done

# Set the working directory to the location of the scripts
readonly SCRIPT_DIR=$(dirname $0)
cd "${SCRIPT_DIR}"

# Execute the wdl_runner
python3 -u wdl_runner.py \
 --working-dir "${WORKSPACE}" \
 --output-dir "${OUTPUTS}" \
 ${extraArgs}
