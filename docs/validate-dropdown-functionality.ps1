# Validation script for dropdown functionality
$siteDir = "c:\Users\VERGIL\Downloads\Premalaya\Social\public_html\public_html\github-pages-site"
Set-Location $siteDir

Write-Host "=== Dropdown Functionality Validation ===" -ForegroundColor Cyan

$htmlFiles = Get-ChildItem -Filter "*.html" | Where-Object { $_.Name -ne "nav-template.html" }

$validationResults = @()

foreach ($file in $htmlFiles) {
    $result = [PSCustomObject]@{
        FileName = $file.Name
        HasBootstrapJS = $false
        HasJQuery = $false
        HasDropdownScript = $false
        HasDropdownHTML = $false
        Issues = @()
    }
    
    try {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        
        # Check for Bootstrap JS
        if ($content -match 'bootstrap.*\.js') {
            $result.HasBootstrapJS = $true
        } else {
            $result.Issues += "Missing Bootstrap JS"
        }
        
        # Check for jQuery
        if ($content -match 'jquery.*\.js') {
            $result.HasJQuery = $true
        } else {
            $result.Issues += "Missing jQuery"
        }
        
        # Check for dropdown functionality script
        if ($content -match 'Dropdown functionality fix') {
            $result.HasDropdownScript = $true
        } else {
            $result.Issues += "Missing dropdown functionality script"
        }
        
        # Check for dropdown HTML structure
        if ($content -match 'class="dropdown".*dropdown-toggle.*dropdown-menu') {
            $result.HasDropdownHTML = $true
        } else {
            $result.Issues += "Missing dropdown HTML structure"
        }
        
    } catch {
        $result.Issues += "Error reading file: $($_.Exception.Message)"
    }
    
    $validationResults += $result
}

# Display results
$totalFiles = $validationResults.Count
$fullyFunctional = ($validationResults | Where-Object { 
    $_.HasBootstrapJS -and $_.HasJQuery -and $_.HasDropdownScript -and $_.HasDropdownHTML 
}).Count

Write-Host "`n=== Summary ===" -ForegroundColor Green
Write-Host "Total files: $totalFiles" -ForegroundColor White
Write-Host "Fully functional dropdowns: $fullyFunctional/$totalFiles" -ForegroundColor $(if($fullyFunctional -eq $totalFiles) {'Green'} else {'Red'})

Write-Host "`n=== Component Status ===" -ForegroundColor Cyan
Write-Host "Bootstrap JS: $(($validationResults | Where-Object { $_.HasBootstrapJS }).Count)/$totalFiles" -ForegroundColor White
Write-Host "jQuery: $(($validationResults | Where-Object { $_.HasJQuery }).Count)/$totalFiles" -ForegroundColor White
Write-Host "Dropdown Script: $(($validationResults | Where-Object { $_.HasDropdownScript }).Count)/$totalFiles" -ForegroundColor White
Write-Host "Dropdown HTML: $(($validationResults | Where-Object { $_.HasDropdownHTML }).Count)/$totalFiles" -ForegroundColor White

if ($fullyFunctional -eq $totalFiles) {
    Write-Host "`n🎉 All dropdown menus should be working! 🎉" -ForegroundColor Green
    Write-Host "Try hovering over or clicking the dropdown menu items in your browser." -ForegroundColor Green
} else {
    Write-Host "`n=== Files with Issues ===" -ForegroundColor Red
    $validationResults | Where-Object { $_.Issues.Count -gt 0 } | ForEach-Object {
        Write-Host "$($_.FileName):" -ForegroundColor Yellow
        $_.Issues | ForEach-Object { Write-Host "  - $_" -ForegroundColor Red }
    }
}
