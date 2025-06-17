# Savitribai Scholarships Pages Validation Script

Write-Host "Validating Savitribai Scholarships Pages..." -ForegroundColor Green

$pages = @(
    "savitribai-scholarships.html",
    "savitribai-phule.html", 
    "governing-committee.html",
    "donors-list.html",
    "scholarship-recipients.html"
)

foreach ($page in $pages) {
    if (Test-Path $page) {
        $content = Get-Content $page -Raw
        $hasTitle = $content -match "Savitribai|Scholarship"
        $hasNavigation = $content -match "Savitribai Scholarships"
        $hasContent = $content.Length -gt 5000
        
        Write-Host "✓ $page exists" -ForegroundColor Green
        Write-Host "  - Has relevant title: $hasTitle" -ForegroundColor $(if($hasTitle) {"Green"} else {"Red"})
        Write-Host "  - Has navigation: $hasNavigation" -ForegroundColor $(if($hasNavigation) {"Green"} else {"Red"})  
        Write-Host "  - Has substantial content: $hasContent" -ForegroundColor $(if($hasContent) {"Green"} else {"Red"})
        Write-Host ""
    } else {
        Write-Host "✗ $page missing!" -ForegroundColor Red
    }
}

# Check PDF form
if (Test-Path "pdf/savithribaischolarship.pdf") {
    Write-Host "✓ Scholarship form PDF exists" -ForegroundColor Green
} else {
    Write-Host "✗ Scholarship form PDF missing!" -ForegroundColor Red
}

Write-Host "Validation complete!" -ForegroundColor Green
