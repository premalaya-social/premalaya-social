# PowerShell script to update navigation in all HTML files
# Ensures all pages have consistent navigation header and top contact bar

$siteDir = "c:\Users\VERGIL\Downloads\Premalaya\Social\public_html\public_html\github-pages-site"
Set-Location $siteDir

# Get all HTML files except nav-template.html and index.html (already updated)
$htmlFiles = Get-ChildItem -Filter "*.html" | Where-Object { $_.Name -notin @("nav-template.html", "index.html", "about.html") }

# Read the navigation template
$navTemplate = Get-Content "nav-template.html" -Raw

# Standard head section with common styles
$headStyles = @"
    <style>
    .container { padding: 0px; border: 0px solid red; margin: 0px auto; }
    .container2 { padding-right: 15px; padding-left: 15px; margin-right: auto; margin-left: auto; border: 0px solid red; }
    .container4 { margin-right: auto; margin-left: auto; border: 0px solid red; padding-top: 0px; }
    .container41 { background-color: #2a2b64; padding: 10px 0px; }
    .supertop { display: inline; margin: 0px; padding: 0px; margin-left: 10px; }
    .supertop li { padding: 0px; list-style-type: none; font-size: 14px; font-family: 'segoe ui'; display: inline; margin-right: 25px; color: #FFFFFF; }
    .navlogo { background-image: url('img/images2/premalayalogos.png'); width: 238px; height: 60px; margin: 0px; }
    
    @media (min-width: 768px) {
      .container, .container2 { width: 750px; }
      .navlogo { background-image: url('img/images2/premalayalogol.png'); width: 400px; height: 60px; margin: 0px; }
    }
    @media (min-width: 992px) { .container, .container2 { width: 970px; } }
    @media (min-width: 1200px) { .container, .container2 { width: 1170px; } }
    
    .navbar-default { font-family: roboto,"Open Sans", sans-serif; border: none; border-radius: 0; margin-bottom: 0; width: 100%; min-height: 80px; padding: 15px 0; box-shadow: -1px 1px 3px rgba(0, 0, 0, 0.1); background: #fff; transition: all 0.4s ease-in-out; }
    .navbar-default .navbar-nav > .active > a, .navbar-default .navbar-nav > .active > a:hover, .navbar-default .navbar-nav > .active > a:focus { color: #2a2b64; background-color: transparent; }
    .navbar-default .navbar-nav > li > a { color: #777; font-weight: 400; font-size: 14px; text-transform: uppercase; }
    .navbar-default .navbar-nav > li > a:hover { color: #2a2b64; }
    .navbar .dropdown-menu { margin: 0; background-color: #fff; border: none; padding: 0px; }
    .navbar .dropdown-menu li a { color: #777; padding: 4px 20px; font-weight: 400; font-size: 14px; text-transform: uppercase; transition: all 200ms ease-in; }
    .navbar-brand { font-weight: 800; color: #000 !important; font-size: 30px; line-height: 14px; padding:0px 0px 0px 10px; margin:0px; height:60px; }
    .sticky { position: -webkit-sticky; position: sticky; top: 0; z-index: 1000; }
    a.linktext2a:visited, a.linktext2a:link { text-decoration: none; color: #000000; }
    a.linktext2a:hover { text-decoration: none; color: #1090bf; }
    h1, h4 { color: #333333; margin: 15px 0px 10px 0px; padding: 15px 0px 0px 0px; font-family: Roboto; font-size: 26px; font-weight: bold; text-align: center; line-height: 100%; }
    .blu { color: #2f3192; }
    </style>
"@

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)"
    
    try {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        
        # Extract page title for specific replacement
        $pageTitle = $file.BaseName -replace '-', ' '
        $pageTitle = (Get-Culture).TextInfo.ToTitleCase($pageTitle)
        
        # Replace title placeholder if exists
        $content = $content -replace '\{\{TITLE\}\}', $pageTitle
        
        # Update head section - ensure proper CSS links and styles
        if ($content -match '(?s)<head[^>]*>(.*?)</head>') {
            $headContent = $matches[1]
            
            # Basic head structure
            $newHeadContent = @"
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>$pageTitle - Premalaya Social Development Society</title>
    <meta name="description" content="Premalaya Social Development Society works for the well-being of downtrodden and vulnerable sections in Tiruvallur, Chennai Districts of Tamilnadu and in Prakasam, Nellore Districts of Andhra Pradesh.">
    
    <link href="favicon.ico" type="image/x-icon" rel="icon">
    <link rel="stylesheet" href="css/bootstrap-3.3.7-dist/css/bootstrap.css">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans%7CRoboto:400,700%7CLato%7COswald%7CRoboto+Condensed' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="css/swiper/swiper.min.css">
    <link rel="stylesheet" href="css/font-awesome-4.5.0/css/font-awesome.min.css">
    <link href="css/app.css" rel="stylesheet">
    
$headStyles
"@
            
            $content = $content -replace '(?s)<head[^>]*>.*?</head>', "<head>$newHeadContent</head>"
        }
        
        # Find and replace the navigation section
        # Look for various navigation patterns and replace with standardized one
        $navPatterns = @(
            '(?s)<!-- Top Contact Bar -->.*?</div>\s*</div>\s*<!-- Navigation -->.*?</div>\s*</div>',
            '(?s)<div class="container41".*?</div>\s*</div>\s*<div class="navbar.*?</div>\s*</div>',
            '(?s)<!-- Navigation -->.*?</nav>',
            '(?s)<nav class="navbar.*?</nav>',
            '(?s)<div class="navbar.*?</div>\s*</div>\s*</div>'
        )
        
        $replaced = $false
        foreach ($pattern in $navPatterns) {
            if ($content -match $pattern -and -not $replaced) {
                $content = $content -replace $pattern, $navTemplate
                $replaced = $true
                Write-Host "  - Navigation replaced using pattern match"
                break
            }
        }
        
        # If no pattern matched, try to insert after <body> or <div id="app">
        if (-not $replaced) {
            if ($content -match '(?s)(<body[^>]*>\s*<div id="app">\s*)') {
                $content = $content -replace '(?s)(<body[^>]*>\s*<div id="app">\s*)', "`$1$navTemplate`n        "
                Write-Host "  - Navigation inserted after app div"
            } elseif ($content -match '(?s)(<body[^>]*>\s*)') {
                $content = $content -replace '(?s)(<body[^>]*>\s*)', "`$1<div id=`"app`">$navTemplate`n        "
                Write-Host "  - Navigation inserted after body with app wrapper"
            }
        }
        
        # Save the updated content
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "  - Updated successfully" -ForegroundColor Green
        
    } catch {
        Write-Host "  - Error processing $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nNavigation update completed for all HTML files!" -ForegroundColor Cyan
