# PowerShell script to validate dropdown links are clickable
$siteDir = "c:\Users\VERGIL\Downloads\Premalaya\Social\public_html\public_html\github-pages-site"
Set-Location $siteDir

Write-Host "=== Dropdown Links Validation ===" -ForegroundColor Cyan

# Get all HTML files except nav-template.html
$htmlFiles = Get-ChildItem -Filter "*.html" | Where-Object { $_.Name -ne "nav-template.html" }

$validationResults = @()

foreach ($file in $htmlFiles) {
    $result = [PSCustomObject]@{
        FileName = $file.Name
        AboutUsClickable = $false
        SavitribaiClickable = $false
        ProgramsClickable = $false
        Issues = @()
    }
    
    try {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        
        # Check About Us dropdown
        if ($content -match 'href="about\.html".*About us.*caret') {
            $result.AboutUsClickable = $true
        } else {
            $result.Issues += "About Us not clickable"
        }
        
        # Check Savitribai Scholarships dropdown
        if ($content -match 'href="savitribai-scholarships\.html".*Savitribai Scholarships.*caret') {
            $result.SavitribaiClickable = $true
        } else {
            $result.Issues += "Savitribai Scholarships not clickable"
        }
        
        # Check Programs dropdown
        if ($content -match 'href="women-empowerment\.html".*Programs.*caret') {
            $result.ProgramsClickable = $true
        } else {
            $result.Issues += "Programs not clickable"
        }
        
    } catch {
        $result.Issues += "Error reading file: $($_.Exception.Message)"
    }
    
    $validationResults += $result
}

# Display results
$totalFiles = $validationResults.Count
$aboutUsFixed = ($validationResults | Where-Object { $_.AboutUsClickable }).Count
$savitribaiFixed = ($validationResults | Where-Object { $_.SavitribaiClickable }).Count
$programsFixed = ($validationResults | Where-Object { $_.ProgramsClickable }).Count
$allFixed = ($validationResults | Where-Object { $_.AboutUsClickable -and $_.SavitribaiClickable -and $_.ProgramsClickable }).Count

Write-Host "`n=== Results ===" -ForegroundColor Green
Write-Host "Total files: $totalFiles" -ForegroundColor White
Write-Host "About Us clickable: $aboutUsFixed/$totalFiles" -ForegroundColor $(if($aboutUsFixed -eq $totalFiles) {'Green'} else {'Red'})
Write-Host "Savitribai Scholarships clickable: $savitribaiFixed/$totalFiles" -ForegroundColor $(if($savitribaiFixed -eq $totalFiles) {'Green'} else {'Red'})
Write-Host "Programs clickable: $programsFixed/$totalFiles" -ForegroundColor $(if($programsFixed -eq $totalFiles) {'Green'} else {'Red'})
Write-Host "All dropdowns fixed: $allFixed/$totalFiles" -ForegroundColor $(if($allFixed -eq $totalFiles) {'Green'} else {'Red'})

if ($allFixed -eq $totalFiles) {
    Write-Host "`n🎉 All dropdown menu items are now clickable! 🎉" -ForegroundColor Green
} else {
    Write-Host "`n=== Files with Issues ===" -ForegroundColor Red
    $validationResults | Where-Object { $_.Issues.Count -gt 0 } | ForEach-Object {
        Write-Host "$($_.FileName):" -ForegroundColor Yellow
        $_.Issues | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
    }
}
