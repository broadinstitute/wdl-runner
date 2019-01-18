# Welcome to WDL Runner!

Welcome to our user-facing documentation for the `wdl_runner` tool!

Since github repository documentation can get pretty heavily biased towards developers, these
pages are intended to help you to:

- Get started with `wdl_runner` from scratch
- Learn how to use `wdl_runner` in a variety of situations


# Contents

## The wdl_runner tool

The `wdl_runner` tool itself! This is a convenient tool which handles:
 
 * Spinning up a Cromwell server on a GCP VM 
 * Launching a WDL workflow by submitting it to the newly created Cromwell server. 
 
See the [Quick Start](GettingStarted/QuickStart.md) page for a quick tutorial to get you started.

## Additional Monitoring Tools

Additional monitoring tools are stored in the '[monitoring_tools](https://github.com/broadinstitute/wdl-runner/tree/master/monitoring_tools)' directory of the
`wdl-runner` repository.

These are scripts that facilitate monitoring the status of WDL workflows run on GCP. 
The main monitoring script is `monitor_wdl_pipeline.sh`. 
It accepts an operation ID for a pipeline, extracts the LOGGING, WORKSPACE, and OUTPUT directories from the operation 
and then examines these directories to glean some insights into the status of the operation.

Note that if the WORKSPACE and/or OUTPUT directories for the specified operation are already populated (for example by another operation), this script will emit incorrect output.