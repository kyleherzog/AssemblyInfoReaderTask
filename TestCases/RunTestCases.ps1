Param()

$scriptPath = '../AssemblyInfoReaderTask'
$scriptPath = Resolve-Path $scriptPath | Select-Object -ExpandProperty Path | Out-String
$scriptPath = $scriptPath.Trim() + '\AssemblyInfoReader.ps1'

# Expected versions are manually pulled ahead-of-time from the testcase files

function AssemblyInfoReaderShouldReturnExpectedVersionForCSharpAssemblyInfo() {
	# Arrange
	$expectedMajorVersion = '2'
	$expectedMinorVersion = '4'
	$expectedBuildVersion = '6'
	$expectedReleaseVersion = '8'

	# Act
	Write-Host("Executing script " + $scriptPath)
	& $scriptPath -searchPattern '..\AssemblyInfo.cs'

	# Assert
	# TBD... need to refactor so this is easily doable
}

function AssemblyInfoReaderShouldReturnExpectedVersionForVbNetAssemblyInfo() {

}

function AssemblyInfoReaderShouldReturnExpectedVersionForCobolAssemblyInfo() {

}

# Run the testcases
AssemblyInfoReaderShouldReturnExpectedVersionForCSharpAssemblyInfo

AssemblyInfoReaderShouldReturnExpectedVersionForVbNetAssemblyInfo

AssemblyInfoReaderShouldReturnExpectedVersionForCobolAssemblyInfo