# PowerShell script to add Contact link to navigation in all HTML files
$siteDir = "c:\Users\VERGIL\Downloads\Premalaya\Social\public_html\public_html\github-pages-site"
Set-Location $siteDir

# Get all HTML files except nav-template.html
$htmlFiles = Get-ChildItem -Filter "*.html" | Where-Object { $_.Name -ne "nav-template.html" }

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)"
    
    try {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        
        # Add Contact link before Support Us
        $pattern = '<li><a href="support\.html" class="linktext2a">Support Us</a></li>'
        $replacement = '<li><a href="contact.html" class="linktext2a">Contact</a></li>' + "`n                " + '<li><a href="support.html" class="linktext2a">Support Us</a></li>'
        
        if ($content -match $pattern) {
            $content = $content -replace $pattern, $replacement
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
            Write-Host "  - Contact link added successfully" -ForegroundColor Green
        } else {
            Write-Host "  - Contact link already exists or pattern not found" -ForegroundColor Yellow
        }
        
    } catch {
        Write-Host "  - Error processing $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nContact link update completed for all HTML files!" -ForegroundColor Cyan
