# PowerShell script to make dropdown menu items clickable in all HTML files
$siteDir = "c:\Users\VERGIL\Downloads\Premalaya\Social\public_html\public_html\github-pages-site"
Set-Location $siteDir

Write-Host "Making dropdown menu items clickable..." -ForegroundColor Cyan

# Get all HTML files except nav-template.html
$htmlFiles = Get-ChildItem -Filter "*.html" | Where-Object { $_.Name -ne "nav-template.html" }

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)" -ForegroundColor Yellow
    
    try {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        $updated = $false
        
        # Fix About Us dropdown
        if ($content -match 'href="#".*About us.*caret') {
            $content = $content -replace 'href="#"(.*class="dropdown-toggle".*?)About us', 'href="about.html"$1About us'
            $updated = $true
            Write-Host "  - Fixed About Us dropdown" -ForegroundColor Green
        }
        
        # Fix Savitribai Scholarships dropdown  
        if ($content -match 'href="#".*Savitribai Scholarships.*caret') {
            $content = $content -replace 'href="#"(.*class="dropdown-toggle".*?)Savitribai Scholarships', 'href="savitribai-scholarships.html"$1Savitribai Scholarships'
            $updated = $true
            Write-Host "  - Fixed Savitribai Scholarships dropdown" -ForegroundColor Green
        }
        
        # Fix Programs dropdown
        if ($content -match 'href="#".*Programs.*caret') {
            $content = $content -replace 'href="#"(.*class="dropdown-toggle".*?)Programs', 'href="women-empowerment.html"$1Programs'
            $updated = $true
            Write-Host "  - Fixed Programs dropdown" -ForegroundColor Green
        }
        
        if ($updated) {
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
            Write-Host "  - File updated successfully" -ForegroundColor Green
        } else {
            Write-Host "  - No changes needed" -ForegroundColor Gray
        }
        
    } catch {
        Write-Host "  - Error processing $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nDropdown menu fix completed! All dropdown items are now clickable." -ForegroundColor Cyan
