$Destination = "F:\test"
$FileName = "test.bin"
function benchmark {
    Param( [parameter(Mandatory=$true)] [String] $Sourcedir )
    if (Test-Path $Destination\$FileName) {
       Remove-Item $Destination\$FileName
    }
    robocopy $Sourcedir $Destination $FileName /TEE
    #xcopy $Sourcedir $Destination
}

benchmark random1.dir
benchmark random2.dir

benchmark ones.dir
benchmark random1.dir

benchmark ones.dir
benchmark random2.dir

benchmark zeros.dir
benchmark random1.dir

benchmark zeros.dir
benchmark random2.dir
