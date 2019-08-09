Param (
    [string]$searchPattern = "**\AssemblyInfo.cs",
	[string]$variablesPrefix
)

function SetBuildVariable([string]$varName, [string]$varValue)
{
	Write-Host ("Setting variable " + $variablesPrefix + $varName + " to '" + $varValue + "'")
	Write-Output ("##vso[task.setvariable variable=" + $variablesPrefix + $varName + ";]" +  $varValue )
}

function ReadAndSetAssemblyVariables([string]$content, [string]$regexExpression)
{
    $matches = [regex]::Matches($content, $regexExpression)

	$wereMatchesFound = $matches.Success
	if (-not $wereMatchesFound) {
		Write-Host("Could not find matches for regex expression " + $regexExpression + " in content.")
	}

    if($wereMatchesFound)
    {
        foreach($match in $matches)
        {
            if($match.Groups.Count -eq 3 -and $match.Groups[2] -ne '')
            {
				$prefix = "AssemblyInfo."
                $propertyName = $match.Groups[1]
                $value = $match.Groups[2]
				SetBuildVariable "$prefix$propertyName" $value

                if ($propertyName -match "Version")
                {
                    $versionMatch = [regex]::Match( $value, "(\d+)\.?(\d+)?\.?(\d+)?\.?(\d+)?")
                    if ($versionMatch.Success)
                    {
                        if ($versionMatch.Groups[1].Success)
                        {
                            $major = $versionMatch.Groups[1].Value
                            SetBuildVariable "$prefix$propertyName.Major" $major

                            if ($versionMatch.Groups[2].Success)
                            {
                                $minor = $versionMatch.Groups[2].Value
                                SetBuildVariable "$prefix$propertyName.Minor" $minor

                                if ($versionMatch.Groups[3].Success)
                                {
                                    $build = $versionMatch.Groups[3].Value
                                    SetBuildVariable "$prefix$propertyName.Build" $build
                                    SetBuildVariable "$prefix$propertyName.Patch" $build

                                    if ($versionMatch.Groups[4].Success)
                                    {
                                        $release = $versionMatch.Groups[4].Value
                                        SetBuildVariable "$prefix$propertyName.Release" $release
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

# Write all params to the console.
Write-Host ("Search Pattern: " + $searchPattern)
Write-Host ("Variables Prefix: " + $variablesPrefix)

# Pseudo-consts
$csharpVbRegexExpression = '(?m)^\s*[\[\<]\s*[Aa]ssembly:\s*(\w*)\(\s*@?"([^"]*)'
$cobolRegexExpression = '(?mi)\s*\w*([Aa]ssembly\w*)\s*USING N"([^"]*)'

$filesFound = Get-ChildItem -Path $searchPattern -Recurse

if ($filesFound.Count -eq 0)
{
	Write-Warning ("No files matching pattern found.")
}

if ($filesFound.Count -gt 1)
{
	Write-Warning ("Multiple assemblyinfo files found.")
}

foreach ($fileFound in $filesFound)
{
	Write-Host ("Reading file: " + $fileFound)
	$fileText = [IO.File]::ReadAllText($fileFound)

	# Determine which RegEx expression is appropriate for this file
	$regexExpression = ''
	if ($searchPattern.EndsWith(".cs", [System.StringComparison]::OrdinalIgnoreCase) -or $searchPattern.EndsWith(".vb", [System.StringComparison]::OrdinalIgnoreCase))
	{
		Write-Host("Using CSharp/VbNet regex expression " + $csharpVbRegexExpression)
		$regexExpression = $csharpVbRegexExpression
	}
	elseif ($searchPattern.EndsWith(".cob", [System.StringComparison]::OrdinalIgnoreCase))
	{
		Write-Host("Using Cobol regex expression " + $cobolRegexExpression)
		$regexExpression = $cobolRegexExpression
	}

	# Read assembly info from file content using the appropriate RegEx expression
	ReadAndSetAssemblyVariables $fileText $regexExpression
}