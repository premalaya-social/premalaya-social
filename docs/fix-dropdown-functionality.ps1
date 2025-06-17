# PowerShell script to fix dropdown functionality across all HTML files
$siteDir = "c:\Users\VERGIL\Downloads\Premalaya\Social\public_html\public_html\github-pages-site"
Set-Location $siteDir

Write-Host "Fixing dropdown functionality in all HTML files..." -ForegroundColor Cyan

# Get all HTML files except nav-template.html
$htmlFiles = Get-ChildItem -Filter "*.html" | Where-Object { $_.Name -ne "nav-template.html" }

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)" -ForegroundColor Yellow
    
    try {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        $updated = $false
        
        # Fix navbar-brand href if it's pointing to #
        if ($content -match 'navbar-brand.*href="#"') {
            $content = $content -replace '(navbar-brand.*?)href="#"', '$1href="index.html"'
            $updated = $true
            Write-Host "  - Fixed navbar-brand link" -ForegroundColor Green
        }
        
        # Ensure Bootstrap JS is loaded (check if missing)
        if ($content -notmatch 'bootstrap.*\.js') {
            # Find where jQuery is loaded and add Bootstrap after it
            if ($content -match '(<script src="js/jquery\.min\.js"></script>)') {
                $content = $content -replace '(<script src="js/jquery\.min\.js"></script>)', '$1' + "`n    " + '<script src="js/bootstrap-3.3.7-dist/js/bootstrap.js"></script>'
                $updated = $true
                Write-Host "  - Added Bootstrap JS" -ForegroundColor Green
            }
        }
        
        # Add dropdown debugging script if not present
        if ($content -notmatch 'Debug dropdown functionality') {
            $debugScript = @"

    <script>
        // Debug dropdown functionality
        `$(document).ready(function() {
            console.log('jQuery loaded:', typeof `$ !== 'undefined');
            console.log('Bootstrap loaded:', typeof `$.fn.dropdown !== 'undefined');
            
            // Ensure dropdown functionality works
            `$('.dropdown-toggle').off('click.bs.dropdown').on('click.bs.dropdown', function(e) {
                var `$this = `$(this);
                var `$parent = `$this.parent();
                
                // Close other open dropdowns
                `$('.dropdown.open').not(`$parent).removeClass('open');
                
                // Toggle current dropdown
                `$parent.toggleClass('open');
                
                // Prevent default link behavior only if showing dropdown
                if (`$parent.hasClass('open')) {
                    e.preventDefault();
                    e.stopPropagation();
                }
            });
            
            // Close dropdowns when clicking outside
            `$(document).on('click', function(e) {
                if (!`$(e.target).closest('.dropdown').length) {
                    `$('.dropdown.open').removeClass('open');
                }
            });
            
            // Add hover functionality for better UX
            `$('.dropdown').hover(
                function() { 
                    `$(this).addClass('open'); 
                },
                function() { 
                    var `$this = `$(this);
                    setTimeout(function() {
                        if (!`$this.is(':hover')) {
                            `$this.removeClass('open');
                        }
                    }, 100);
                }
            );
        });
    </script>
"@
            
            # Insert before closing body tag
            if ($content -match '</body>') {
                $content = $content -replace '</body>', $debugScript + "`n</body>"
                $updated = $true
                Write-Host "  - Added dropdown functionality script" -ForegroundColor Green
            }
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

Write-Host "`nDropdown functionality fix completed!" -ForegroundColor Cyan
Write-Host "Test the dropdowns in your browser. They should now work on both click and hover." -ForegroundColor Green
