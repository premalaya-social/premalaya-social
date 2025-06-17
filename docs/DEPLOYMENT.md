# Premalaya Social Development Society - GitHub Pages Deployment Guide

## ✅ Conversion Complete!

The Laravel application has been successfully converted into a static website ready for GitHub Pages hosting.

## 📁 Files Structure

```
github-pages-site/
├── index.html (Homepage with carousel and clickable navigation)
├── about.html (About page with photo gallery)
├── contact.html (Contact page with address and map)
├── support.html (Support/Donation page)
│
├── About Us Section:
│   ├── founder.html (Rev. A. Isaiah)
│   ├── vision-mission.html
│   ├── governing-committee.html
│   ├── donors-list.html
│   └── scholarship-recipients.html
│
├── Savitribai Scholarships Section:
│   ├── savitribai-phule.html
│   └── savitribai-scholarships.html
│
├── Programs Section:
│   ├── women-empowerment.html
│   ├── children-home.html
│   ├── health-care.html
│   ├── medical-camps.html
│   ├── relief-operations.html
│   ├── educational-activities.html
│   └── shankar-narayan-library.html
│
├── Assets:
│   ├── css/ (Bootstrap 3.3.7, Font Awesome, custom styles)
│   ├── js/ (jQuery, Bootstrap, Swiper carousel)
│   ├── img/ (All organized images)
│   └── pdf/ (Scholarship form)
│
└── Configuration:
    ├── favicon.ico
    ├── README.md
    └── .gitignore
```

## 🔧 Key Features Preserved

✅ **Top Contact Bar** - Phone, address, email, Facebook link
✅ **Sticky Navigation** - Proper Bootstrap navigation with dropdowns
✅ **Swiper Carousel** - Image slider on homepage
✅ **Clickable Image Navigation** - All program images are clickable
✅ **Responsive Design** - Mobile-friendly Bootstrap layout
✅ **Photo Galleries** - Image galleries for each program
✅ **Google Maps Integration** - Embedded map on contact page
✅ **PDF Downloads** - Scholarship form available
✅ **Social Media Links** - Facebook integration
✅ **Online Donation** - PayUMoney integration maintained

## 🚀 Deploy to GitHub Pages

### Step 1: Create GitHub Repository
1. Go to https://github.com and create a new repository
2. Name it `premalaya-social` (or any name you prefer)
3. Make it public
4. Don't initialize with README (we already have one)

### Step 2: Upload Files
Option A - Using GitHub Web Interface:
1. Click "uploading an existing file"
2. Drag and drop all files from `github-pages-site` folder
3. Commit changes

Option B - Using Git Command Line:
```bash
cd github-pages-site
git init
git add .
git commit -m "Initial commit - Premalaya Social website"
git branch -M main
git remote add origin https://github.com/yourusername/premalaya-social.git
git push -u origin main
```

### Step 3: Enable GitHub Pages
1. Go to repository Settings
2. Scroll down to "Pages" section
3. Select source: "Deploy from a branch"
4. Choose branch: "main"
5. Choose folder: "/ (root)"
6. Click Save

### Step 4: Access Your Website
Your website will be available at:
`https://yourusername.github.io/premalaya-social`

## 🔗 Navigation Structure

All navigation links are properly configured:

**Main Menu:**
- Home → index.html
- About Us → (dropdown with 4 sub-pages)
- Savitribai Scholarships → (dropdown with 6 sub-pages including PDF)
- Programs → (dropdown with 7 program pages)
- Support Us → support.html
- Donate Online → PayUMoney link

**Clickable Images on Homepage:**
- All program images link to their respective pages
- About sections link to relevant pages

## 📱 Mobile Responsive

The website is fully responsive and works on:
- Desktop computers
- Tablets
- Mobile phones

## 🌐 External Integrations

- **Google Maps** - Embedded for location
- **PayUMoney** - Online donation system
- **Facebook** - Social media links
- **Google Analytics** - Ready for tracking code

## 📧 Contact Information

Contact details are properly configured:
- Address: 9/A, 6th St, 2nd Lane, Defence Enclave, Muthapudupet, IAF Avadi, Chennai - 600 055, India
- Phone: +91 9884204493
- Email: premalayasocial@gmail.com

## 🎨 Styling

All original styling has been preserved:
- Custom color scheme (#2f3192 primary blue, #9a3032 accent red)
- Typography (Roboto, Open Sans fonts)
- Bootstrap 3.3.7 responsive grid
- Font Awesome icons
- Custom CSS animations

## ✨ Ready for Production

The website is production-ready with:
- SEO-friendly HTML structure
- Fast loading assets
- Cross-browser compatibility
- Accessibility features
- Clean, semantic markup

Your Premalaya Social Development Society website is now successfully converted and ready for GitHub Pages hosting!
