Param (
    [string]$searchPattern = "**\AssemblyInfo.cs"
)

# Write all params to the console.
Write-Host ("Search Pattern: " + $searchPattern)

$filesFound = GetAssemblyInfoFiles($searchPattern)

if ($filesFound.Count -eq 0)
{
    Write-Warning ("No files matching pattern found.")
}

foreach ($fileFound in $filesFound)
{
    Write-Host ("Reading file: " + $fileFound)
    $fileText = [IO.File]::ReadAllText($fileFound) #"c:\vstsagent\_work\7\s\Wells.Entities.B2B.Equipment\Properties\AssemblyInfo.cs")
    SetAssemblyVariables($fileText)
}

# Write-Host $content



function GetAssemblyInfoFiles($pattern)
{
    if ($env:BUILD_SOURCESDIRECTORY)
    {
        Write-Host "Using build.sourcesdirectory as root folder"
        return Get-ChildItem -Path ($env:BUILD_SOURCESDIRECTORY + $pattern) -Recurse
    }
    elseif ($env:SYSTEM_ARTIFACTSDIRECTORY)
    {
        Write-Host "Using system.artifactsdirectory as root folder"
        return Get-ChildItem -Path ($env:SYSTEM_ARTIFACTSDIRECTORY  + $pattern) -Recurse
    }
    else
    {
        Write-Host "Using current folder as root folder"
        return Get-ChildItem -Path $pattern -Recurse
    }
}

function SetBuildVariable([string]$varName, [string]$varValue)
{
	Write-Host ("Setting variable " + $varName + " to '" + $varValue + "'")
	Write-Output ("##vso[task.setvariable variable=" + $varName + ";]" +  $varValue )
}

function SetAssemblyVariables($content)
{
    $matches = [regex]::Matches($content, '(?m)^\s*\[\s*assembly:\s*(\w*)\(\s*"([^"]*)')

    if($matches.Success)
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