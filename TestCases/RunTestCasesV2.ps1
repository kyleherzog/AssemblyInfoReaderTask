Param()

$scriptRoot = '../AssemblyInfoReaderTask/AssemblyInfoReaderTaskV2'
$scriptRoot = Resolve-Path $scriptRoot | Select-Object -ExpandProperty Path | Out-String
$scriptPath = $scriptRoot.Trim() + '\AssemblyInfoReader.ps1'

$vstsTaskSdkPath = $scriptRoot.Trim() + '\ps_modules\VstsTaskSdk'

Write-Host "vsts task sdk root = $vstsTaskSdkPath"

Import-Module $vstsTaskSdkPath -ArgumentList @{ NonInteractive = $true }


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
	Set-VstsTaskVariable -Name 'searchPattern' -Value '..\AssemblyInfo.cs'
	$result = Invoke-VstsTaskScript -ScriptBlock ([scriptblock]::Create($scriptPath)) 2>&1 3>&1 4>&1 5>&1 6>&1 | Out-String

	# Assert
	Write-Host("Asserting results")
	$stringReader = New-Object -TypeName System.IO.StringReader -ArgumentList $result

	[string] $lineText = ''
	while ($stringReader.Peek() -gt -1) {
		$lineText = $stringReader.ReadLine()

		if (-not $lineText.Contains('AssemblyVersion')) {
			continue
		}

		[string] $informationText = $lineText.Split([char]"'")[1]

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
	Set-VstsTaskVariable -Name 'searchPattern' -Value '..\AssemblyInfo.vb'
	$result = Invoke-VstsTaskScript -ScriptBlock ([scriptblock]::Create($scriptPath))  2>&1 3>&1 4>&1 5>&1 6>&1 | Out-String

	# Assert
	Write-Host("Asserting results")
	$stringReader = New-Object -TypeName System.IO.StringReader -ArgumentList $result

	[string] $lineText = ''
	while ($stringReader.Peek() -gt -1) {
		$lineText = $stringReader.ReadLine()

		if (-not $lineText.Contains('AssemblyVersion')) {
			continue
		}

		[string] $informationText = $lineText.Split([char]"'")[1]

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
	Set-VstsTaskVariable -Name 'searchPattern' -Value '..\AssemblyInfo.cob'
	$result = Invoke-VstsTaskScript -ScriptBlock ([scriptblock]::Create($scriptPath))  2>&1 3>&1 4>&1 5>&1 6>&1 | Out-String

	# Assert
	Write-Host("Asserting results")
	$stringReader = New-Object -TypeName System.IO.StringReader -ArgumentList $result

	[string] $lineText = ''
	while ($stringReader.Peek() -gt -1) {
		$lineText = $stringReader.ReadLine()

		if (-not $lineText.Contains('AssemblyVersion')) {
			continue
		}

		[string] $informationText = $lineText.Split([char]"'")[1]

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