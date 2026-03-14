module.exports = function(eleventyConfig) {
  // Passthrough copy - static assets
  eleventyConfig.addPassthroughCopy("src/img");
  eleventyConfig.addPassthroughCopy("src/css");
  eleventyConfig.addPassthroughCopy("src/js");
  eleventyConfig.addPassthroughCopy("src/pdf");
  eleventyConfig.addPassthroughCopy("src/favicon.ico");
  eleventyConfig.addPassthroughCopy("src/CNAME");
  eleventyConfig.addPassthroughCopy("src/admin");

  // Watch targets
  eleventyConfig.addWatchTarget("src/css/");
  eleventyConfig.addWatchTarget("src/js/");

  // Custom filter: get pages by category
  eleventyConfig.addFilter("where", function(collection, key, value) {
    return collection.filter(item => item.data[key] === value);
  });

  // Custom filter: limit array items
  eleventyConfig.addFilter("limit", function(arr, limit) {
    return arr.slice(0, limit);
  });

  // Paired shortcode for rendering raw HTML content in markdown
  eleventyConfig.addPairedShortcode("rawhtml", function(content) {
    return content;
  });

  // Configure markdown
  const markdownIt = require("markdown-it");
  const md = markdownIt({
    html: true,        // Allow HTML in markdown
    breaks: true,      // Convert \n to <br>
    linkify: true      // Auto-convert URLs to links
  });
  eleventyConfig.setLibrary("md", md);

  return {
    dir: {
      input: "src",
      output: "docs",
      includes: "_includes",
      data: "_data"
    },
    templateFormats: ["njk", "md", "html"],
    htmlTemplateEngine: "njk",
    markdownTemplateEngine: "njk"
  };
};

