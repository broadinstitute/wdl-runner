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

# Check if the required file presents
if [[ -z ${WDL} ]]; then
    echo 'no workflow file'
    exit 1
fi
cp "${WDL}" "${INPUT_PATH}/wf.wdl"

if [[ -z ${WORKFLOW_INPUTS} ]]; then
    echo 'no workflow input file'
    exit 1
fi
cp "${WORKFLOW_INPUTS}" "${INPUT_PATH}/wf.inputs.json"

extraArgs=""
# Only pass in the argument if it exists
if [[ ! -z "${WORKFLOW_OPTIONS}" ]]; then
    cp "${WORKFLOW_OPTIONS}" "${INPUT_PATH}/wf.options.json"
    extraArgs+="--workflow-options ${INPUT_PATH}/wf.options.json "
fi

if [[ ! -z "${WORKFLOW_DEPENDENCIES}" ]]; then
    cp "${WORKFLOW_DEPENDENCIES}" "${INPUT_PATH}/wf.dependencies.zip"
    extraArgs+="--workflow-dependencies ${INPUT_PATH}/wf.dependencies.zip "
fi

if [[ ! -z "${OUTPUTS}" ]]; then
    extraArgs+="--output-dir ${OUTPUTS} "
fi

# Set the working directory to the location of the scripts
readonly SCRIPT_DIR=$(dirname $0)
cd "${SCRIPT_DIR}"

# Execute the wdl_runner
python3 -u wdl_runner.py \
 --wdl "${INPUT_PATH}"/wf.wdl \
 --workflow-inputs "${INPUT_PATH}"/wf.inputs.json \
 --working-dir "${WORKSPACE}" \
 ${extraArgs}
