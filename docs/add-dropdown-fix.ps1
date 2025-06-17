# Simple script to add dropdown functionality to all HTML files
$siteDir = "c:\Users\VERGIL\Downloads\Premalaya\Social\public_html\public_html\github-pages-site"
Set-Location $siteDir

$dropdownScript = @'
    <script>
        // Dropdown functionality fix
        $(document).ready(function() {
            // Handle dropdown clicks
            $('.dropdown-toggle').on('click', function(e) {
                var $parent = $(this).parent();
                
                // Close other dropdowns
                $('.dropdown.open').not($parent).removeClass('open');
                
                // Toggle current dropdown
                $parent.toggleClass('open');
                
                // Prevent default only if we're showing the dropdown
                if ($parent.hasClass('open')) {
                    e.preventDefault();
                    e.stopPropagation();
                }
            });
            
            // Close dropdowns when clicking outside
            $(document).on('click', function(e) {
                if (!$(e.target).closest('.dropdown').length) {
                    $('.dropdown.open').removeClass('open');
                }
            });
            
            // Hover functionality
            $('.dropdown').hover(
                function() { $(this).addClass('open'); },
                function() { 
                    var $this = $(this);
                    setTimeout(function() {
                        if (!$this.is(':hover')) {
                            $this.removeClass('open');
                        }
                    }, 200);
                }
            );
        });
    </script>
'@

# Get all HTML files except nav-template.html and index.html (already fixed)
$htmlFiles = Get-ChildItem -Filter "*.html" | Where-Object { $_.Name -notin @("nav-template.html", "index.html") }

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)"
    
    try {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        
        # Add dropdown script before closing body tag if not already present
        if ($content -notmatch "Dropdown functionality fix" -and $content -match "</body>") {
            $content = $content -replace "</body>", "$dropdownScript`n</body>"
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
            Write-Host "  - Added dropdown functionality" -ForegroundColor Green
        } else {
            Write-Host "  - Already has dropdown functionality or no closing body tag" -ForegroundColor Yellow
        }
        
    } catch {
        Write-Host "  - Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nDropdown functionality added to all files!" -ForegroundColor Cyan
