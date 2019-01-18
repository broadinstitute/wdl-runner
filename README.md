This directory contains utilities that facilitate running WDLs through the Broad's Cromwell execution engine on the Google Cloud Platform. 
# WDL Runner

Welcome to the WDL Runner repository.

If you are a user and would like some more user-facing documentation, see [readthedocs](https://wdl-runner.readthedocs.io/en/latest/).

## Repository Contents

The repo has directories containing the following contents.

## Docs

These are the source pages which feed our [readthedocs](https://wdl-runner.readthedocs.io/en/latest/) pages.

## The wdl_runner tool

Source code for the `wdl_runner` tool. This is a convenient tool which handles:
 
 * Spinning up a Cromwell server on a GCP VM 
 * Launching a WDL workflow by submitting it to the newly created Cromwell server. 

## Additional Monitoring Tools

Additional monitoring tools are stored in the '[monitoring_tools](https://github.com/broadinstitute/wdl-runner/tree/master/monitoring_tools)' directory of the
`wdl-runner` repository.

These are scripts that facilitate monitoring the status of WDL workflows run on GCP. 
The main monitoring script is `monitor_wdl_pipeline.sh`. 
It accepts an operation ID for a pipeline, extracts the LOGGING, WORKSPACE, and OUTPUT directories from the operation 
and then examines these directories to glean some insights into the status of the operation.

Note that if the WORKSPACE and/or OUTPUT directories for the specified operation are already populated (for example by another operation), this script will emit incorrect output.
