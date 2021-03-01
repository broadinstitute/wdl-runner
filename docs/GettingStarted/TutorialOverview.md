# WDL Runner Tutorial Overview

## Note: just in case there are errors...

We want this tutorial to be as useful to completely new users as possible. 
If you find *anything* on this page (or any other) which is:

* Not correct
* Not obvious to you
* Making undeclared assumptions
* Worded obtusely
  
Then:
 
* Please (please!) let us know!
    * You can raise this as an issue [here](https://github.com/broadinstitute/wdl-runner/issues) so that we can improve the tutorial and therefore hopefully improve the experience of future users.
    * If you use github and are so inclined, you are welcome to help us out by correcting the document yourself! Please submit any improvements you'd like to make as a pull request against the repository. This tutorial is stored in the repository [here](https://github.com/broadinstitute/wdl-runner/blob/master/docs/GettingStarted/QuickStart.md).

## Tutorial Scenario

This example demonstrates running a multi-stage workflow on
Google Cloud Platform.

* The workflow is launched with the Google Genomics [Pipelines API](https://cloud.google.com/genomics/docs/quickstart).
* The workflow is defined using the OpenWDL organization's
[Workflow Definition Language](https://github.com/openwdl/wdl) (WDL).
* The workflow stages are orchestrated by the Broad Institute's
[Cromwell](https://github.com/broadinstitute/cromwell).

When submitted using the Pipelines API, the workflow runs
on multiple [Google Compute Engine](https://cloud.google.com/compute/)
virtual machines.
First a master node is created for Cromwell, and then Cromwell submits
each stage of the workflow as one or more separate pipelines.

Execution of a running Pipeline proceeds as:

* Create Compute Engine virtual machine
* On the VM, in a Docker container, execute wdl_runner.py
    * Run Cromwell (server)
    * Submit workflow, inputs, dependencies, and options to Cromwell server
    * Poll for completion as Cromwell executes:
        1. Call pipelines.run() to execute call 1
        2. Poll for completion of call 1
        3. Call pipelines.run() to execute the next call
        4. Poll for completion of the next call
        5. Repeat steps 3-4 until all WDL "calls" complete>
    * Copy workflow metadata to output path
    * Copy workflow outputs to output path
3. Destroy Compute Engine Virtual machine

## Setup Overview

Code packaging for the Pipelines API is done through
[Docker](https://www.docker.com/) images.  The instructions provided
here explain how to create your own Docker image, although a copy
of this Docker image has already been built and made available by
the Broad Institute.

### Code summary

The code in the wdl_runner Docker image includes:

* [OpenJDK 8](http://openjdk.java.net/projects/jdk8/) runtime engine (JRE)
* [Python 3.8](https://www.python.org/downloads/release/python-387/) interpreter
* [Cromwell release 36](https://github.com/broadinstitute/cromwell/releases/tag/36)
* [Python and shell scripts from this repository](.)

Take a look at the [Dockerfile](https://github.com/broadinstitute/wdl-runner/blob/master/wdl_runner/Dockerfile) for full details.

## Tutorial Steps

Now that you've read the overview, you're probably itching to get started! You're ready for the [Tutorial Steps](TutorialSteps.md) themselves.
