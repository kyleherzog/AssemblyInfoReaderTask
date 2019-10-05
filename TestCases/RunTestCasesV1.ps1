Param()

$scriptPath = '../AssemblyInfoReaderTask'
$scriptPath = Resolve-Path $scriptPath | Select-Object -ExpandProperty Path | Out-String
$scriptPath = $scriptPath.Trim() + '\AssemblyInfoReaderTaskV1\AssemblyInfoReader.ps1'

# Expected versions are manually pulled ahead-of-time from the testcase files

function AssemblyInfoReaderShouldReturnExpectedVersionForCSharpAssemblyInfo() {
	# Arrange
	[string]$expectedMajorVersion = '2'
	[string]$expectedMinorVersion = '4'
	[string]$expectedBuildVersion = '6'
	[string]$expectedReleaseVersion = '8'

	[bool]$wasMajorVersionDetected = $false
	[bool]$wasMinorVersionDetected = $false
	[bool]$wasBuildVersionDetected = $false
	[bool]$wasReleaseVersionDetected = $false

	# Act
	Write-Host("Executing script " + $scriptPath)
	$result = & $scriptPath -searchPattern '..\AssemblyInfo.cs' | Out-String

	# Assert
	Write-Host("Asserting results")
	$stringReader = New-Object -TypeName System.IO.StringReader -ArgumentList $result

	[string] $lineText = ''
	while ($stringReader.Peek() -gt -1) {
		$lineText = $stringReader.ReadLine()

		if (-not $lineText.Contains('AssemblyVersion')) {
			continue
		}

		[string] $informationText = $lineText.Split([char]']')[1]

		if ($lineText.Contains('AssemblyVersion.Major')) {
			$wasMajorVersionDetected = $true

			if (-not $expectedMajorVersion.Equals($informationText)) {
				Write-Error("Expected major version $expectedMajorVersion; actual value was $informationText")
			}
		}

		if ($lineText.Contains('AssemblyVersion.Minor')) {
			$wasMinorVersionDetected = $true

			if (-not $expectedMinorVersion.Equals($informationText)) {
				Write-Error("Expected minor version $expectedMinorVersion; actual value was $informationText")
			}
		}

		if ($lineText.Contains('AssemblyVersion.Build')) {
			$wasBuildVersionDetected = $true

			if (-not $expectedBuildVersion.Equals($informationText)) {
				Write-Error("Expected build version $expectedBuildVersion; actual value was $informationText")
			}
		}

		if ($lineText.Contains('AssemblyVersion.Release')) {
			$wasReleaseVersionDetected = $true

			if (-not $expectedReleaseVersion.Equals($informationText)) {
				Write-Error("Expected release version $expectedReleaseVersion; actual value was $informationText")
			}
		}
	}

	# Ensure the various versions were detected
	if (-not $wasMajorVersionDetected) {
		Write-Error("Could not detect major version.")
	}

	if (-not $wasMinorVersionDetected) {
		Write-Error("Could not detect minor version.")
	}

	if (-not $wasBuildVersionDetected) {
		Write-Error("Could not detect build version.")
	}

	if (-not $wasReleaseVersionDetected) {
		Write-Error("Could not detect release version.")
	}
}

function AssemblyInfoReaderShouldReturnExpectedVersionForVbNetAssemblyInfo() {
	# Arrange
	[string]$expectedMajorVersion = '3'
	[string]$expectedMinorVersion = '6'
	[string]$expectedBuildVersion = '9'
	[string]$expectedReleaseVersion = '0'

	[bool]$wasMajorVersionDetected = $false
	[bool]$wasMinorVersionDetected = $false
	[bool]$wasBuildVersionDetected = $false
	[bool]$wasReleaseVersionDetected = $false

	# Act
	Write-Host("Executing script " + $scriptPath)
	$result = & $scriptPath -searchPattern '..\AssemblyInfo.vb' | Out-String

	# Assert
	Write-Host("Asserting results")
	$stringReader = New-Object -TypeName System.IO.StringReader -ArgumentList $result

	[string] $lineText = ''
	while ($stringReader.Peek() -gt -1) {
		$lineText = $stringReader.ReadLine()

		if (-not $lineText.Contains('AssemblyVersion')) {
			continue
		}

		[string] $informationText = $lineText.Split([char]']')[1]

		if ($lineText.Contains('AssemblyVersion.Major')) {
			$wasMajorVersionDetected = $true

			if (-not $expectedMajorVersion.Equals($informationText)) {
				Write-Error("Expected major version $expectedMajorVersion; actual value was $informationText")
			}
		}

		if ($lineText.Contains('AssemblyVersion.Minor')) {
			$wasMinorVersionDetected = $true

			if (-not $expectedMinorVersion.Equals($informationText)) {
				Write-Error("Expected minor version $expectedMinorVersion; actual value was $informationText")
			}
		}

		if ($lineText.Contains('AssemblyVersion.Build')) {
			$wasBuildVersionDetected = $true

			if (-not $expectedBuildVersion.Equals($informationText)) {
				Write-Error("Expected build version $expectedBuildVersion; actual value was $informationText")
			}
		}

		if ($lineText.Contains('AssemblyVersion.Release')) {
			$wasReleaseVersionDetected = $true

			if (-not $expectedReleaseVersion.Equals($informationText)) {
				Write-Error("Expected release version $expectedReleaseVersion; actual value was $informationText")
			}
		}
	}

	# Ensure the various versions were detected
	if (-not $wasMajorVersionDetected) {
		Write-Error("Could not detect major version.")
	}

	if (-not $wasMinorVersionDetected) {
		Write-Error("Could not detect minor version.")
	}

	if (-not $wasBuildVersionDetected) {
		Write-Error("Could not detect build version.")
	}

	if (-not $wasReleaseVersionDetected) {
		Write-Error("Could not detect release version.")
	}
}

function AssemblyInfoReaderShouldReturnExpectedVersionForCobolAssemblyInfo() {
	# Arrange
	[string]$expectedMajorVersion = '1'
	[string]$expectedMinorVersion = '3'
	[string]$expectedBuildVersion = '5'
	[string]$expectedReleaseVersion = '7'

	[bool]$wasMajorVersionDetected = $false
	[bool]$wasMinorVersionDetected = $false
	[bool]$wasBuildVersionDetected = $false
	[bool]$wasReleaseVersionDetected = $false

	# Act
	Write-Host("Executing script " + $scriptPath)
	$result = & $scriptPath -searchPattern '..\AssemblyInfo.cob' | Out-String

	# Assert
	Write-Host("Asserting results")
	$stringReader = New-Object -TypeName System.IO.StringReader -ArgumentList $result

	[string] $lineText = ''
	while ($stringReader.Peek() -gt -1) {
		$lineText = $stringReader.ReadLine()

		if (-not $lineText.Contains('AssemblyVersion')) {
			continue
		}

		[string] $informationText = $lineText.Split([char]']')[1]

		if ($lineText.Contains('AssemblyVersion.Major')) {
			$wasMajorVersionDetected = $true

			if (-not $expectedMajorVersion.Equals($informationText)) {
				Write-Error("Expected major version $expectedMajorVersion; actual value was $informationText")
			}
		}

		if ($lineText.Contains('AssemblyVersion.Minor')) {
			$wasMinorVersionDetected = $true

			if (-not $expectedMinorVersion.Equals($informationText)) {
				Write-Error("Expected minor version $expectedMinorVersion; actual value was $informationText")
			}
		}

		if ($lineText.Contains('AssemblyVersion.Build')) {
			$wasBuildVersionDetected = $true

			if (-not $expectedBuildVersion.Equals($informationText)) {
				Write-Error("Expected build version $expectedBuildVersion; actual value was $informationText")
			}
		}

		if ($lineText.Contains('AssemblyVersion.Release')) {
			$wasReleaseVersionDetected = $true

			if (-not $expectedReleaseVersion.Equals($informationText)) {
				Write-Error("Expected release version $expectedReleaseVersion; actual value was $informationText")
			}
		}
	}

	# Ensure the various versions were detected
	if (-not $wasMajorVersionDetected) {
		Write-Error("Could not detect major version.")
	}

	if (-not $wasMinorVersionDetected) {
		Write-Error("Could not detect minor version.")
	}

	if (-not $wasBuildVersionDetected) {
		Write-Error("Could not detect build version.")
	}

	if (-not $wasReleaseVersionDetected) {
		Write-Error("Could not detect release version.")
	}
}

# Run the testcases
AssemblyInfoReaderShouldReturnExpectedVersionForCSharpAssemblyInfo

AssemblyInfoReaderShouldReturnExpectedVersionForVbNetAssemblyInfo

AssemblyInfoReaderShouldReturnExpectedVersionForCobolAssemblyInfo