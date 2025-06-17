# PowerShell script to validate all HTML pages have consistent navigation
$siteDir = "c:\Users\VERGIL\Downloads\Premalaya\Social\public_html\public_html\github-pages-site"
Set-Location $siteDir

Write-Host "=== Navigation Validation Report ===" -ForegroundColor Cyan
Write-Host "Checking all HTML files for consistent navigation..." -ForegroundColor Yellow

# Get all HTML files except nav-template.html
$htmlFiles = Get-ChildItem -Filter "*.html" | Where-Object { $_.Name -ne "nav-template.html" }

$validationResults = @()

foreach ($file in $htmlFiles) {
    $result = [PSCustomObject]@{
        FileName = $file.Name
        HasTopContactBar = $false
        HasNavigation = $false
        HasDropdowns = $false
        HasContactLink = $false
        HasSupportLink = $false
        HasDonateLink = $false
        Issues = @()
    }
    
    try {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        
        # Check for top contact bar
        if ($content -match 'container41.*background-color:#2a2b64') {
            $result.HasTopContactBar = $true
        } else {
            $result.Issues += "Missing top contact bar"
        }
        
        # Check for navigation
        if ($content -match 'navbar navbar-default.*sticky') {
            $result.HasNavigation = $true
        } else {
            $result.Issues += "Missing navigation bar"
        }
        
        # Check for dropdown menus
        if ($content -match 'About us.*caret' -and $content -match 'Savitribai Scholarships.*caret' -and $content -match 'Programs.*caret') {
            $result.HasDropdowns = $true
        } else {
            $result.Issues += "Missing dropdown menus"
        }
        
        # Check for important links
        if ($content -match 'href="contact\.html"') {
            $result.HasContactLink = $true
        } else {
            $result.Issues += "Missing Contact link"
        }
        
        if ($content -match 'href="support\.html"') {
            $result.HasSupportLink = $true
        } else {
            $result.Issues += "Missing Support link"
        }
        
        if ($content -match 'payumoney\.com') {
            $result.HasDonateLink = $true
        } else {
            $result.Issues += "Missing Donate link"
        }
        
    } catch {
        $result.Issues += "Error reading file: $($_.Exception.Message)"
    }
    
    $validationResults += $result
}

# Display results
Write-Host "`n=== Summary ===" -ForegroundColor Green
$totalFiles = $validationResults.Count
$validFiles = ($validationResults | Where-Object { $_.Issues.Count -eq 0 }).Count
$filesWithIssues = $totalFiles - $validFiles

Write-Host "Total files checked: $totalFiles" -ForegroundColor White
Write-Host "Valid files: $validFiles" -ForegroundColor Green
Write-Host "Files with issues: $filesWithIssues" -ForegroundColor $(if($filesWithIssues -eq 0) {'Green'} else {'Red'})

if ($filesWithIssues -gt 0) {
    Write-Host "`n=== Files with Issues ===" -ForegroundColor Red
    $validationResults | Where-Object { $_.Issues.Count -gt 0 } | ForEach-Object {
        Write-Host "$($_.FileName):" -ForegroundColor Yellow
        $_.Issues | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
    }
} else {
    Write-Host "`n🎉 All files have consistent navigation! 🎉" -ForegroundColor Green
}

Write-Host "`n=== Navigation Features Status ===" -ForegroundColor Cyan
Write-Host "Top Contact Bar: $(($validationResults | Where-Object { $_.HasTopContactBar }).Count)/$totalFiles files" -ForegroundColor White
Write-Host "Navigation Bar: $(($validationResults | Where-Object { $_.HasNavigation }).Count)/$totalFiles files" -ForegroundColor White  
Write-Host "Dropdown Menus: $(($validationResults | Where-Object { $_.HasDropdowns }).Count)/$totalFiles files" -ForegroundColor White
Write-Host "Contact Link: $(($validationResults | Where-Object { $_.HasContactLink }).Count)/$totalFiles files" -ForegroundColor White
Write-Host "Support Link: $(($validationResults | Where-Object { $_.HasSupportLink }).Count)/$totalFiles files" -ForegroundColor White
Write-Host "Donate Link: $(($validationResults | Where-Object { $_.HasDonateLink }).Count)/$totalFiles files" -ForegroundColor White
