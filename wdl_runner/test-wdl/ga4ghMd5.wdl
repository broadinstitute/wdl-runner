import "ga4ghMd5Tasks.wdl" as tasks

workflow ga4ghMd5 {
 File inputFile
 call tasks.md5 { input: inputFile=inputFile }
}
