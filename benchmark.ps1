$Destination = "F:\test"
function delete {
    Param( [parameter(Mandatory=$true)] [String] $DeleteFile )
    if (Test-Path $DeleteFile) {
       Remove-Item $DeleteFile
    }
}

function benchmark {
    Param( [parameter(Mandatory=$true)] [String] $Sourcedir )
    delete $Destination\test-000.bin
    delete $Destination\test-001.bin
    delete $Destination\test-002.bin
    delete $Destination\test-003.bin
    
    robocopy $Sourcedir $Destination $FileName /TEE
}

benchmark random1.dir
benchmark random2.dir

benchmark ones.dir
benchmark random1.dir

benchmark ones.dir
benchmark random2.dir