# PowerShell script to comment out the "Donate Online" nav link in all HTML files
$siteDir = "c:\Users\VERGIL\Downloads\Premalaya\Social\public_html\public_html\github-pages-site"
Set-Location $siteDir

Write-Host "Commenting out 'Donate Online' nav link in all HTML files..." -ForegroundColor Cyan

# Get all HTML files except nav-template.html
$htmlFiles = Get-ChildItem -Filter "*.html" | Where-Object { $_.Name -ne "nav-template.html" }

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)" -ForegroundColor Yellow
    
    try {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        $updated = $false
        
        # Comment out the donate online link
        if ($content -match '<li><a href="https://www\.payumoney\.com/paybypayumoney/#/380069".*?>Donate Online</a></li>') {
            $content = $content -replace '<li><a href="https://www\.payumoney\.com/paybypayumoney/#/380069"(.*?)>Donate Online</a></li>', '<!-- <li><a href="https://www.payumoney.com/paybypayumoney/#/380069"$1>Donate Online</a></li> -->'
            $updated = $true
            Write-Host "  - Commented out Donate Online link" -ForegroundColor Green
        } else {
            Write-Host "  - Donate Online link not found or already commented" -ForegroundColor Gray
        }
        
        if ($updated) {
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
            Write-Host "  - File updated successfully" -ForegroundColor Green
        }
        
    } catch {
        Write-Host "  - Error processing $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nDonate Online nav link commented out in all files!" -ForegroundColor Cyan
