# Pangea/Pang Documentation

This directory contains the complete HTML documentation for the Pangea/Pang programming language.

## Structure

- **index.html** - Main landing page with overview and quick start
- **polish-notation.html** - Tutorial on Polish (prefix) notation
- **evaluation.html** - Deep dive into the interpreter's evaluation mechanism with animations
- **examples.html** - Practical code examples from Hello World to recursive functions
- **reference.html** - Complete language reference with all built-in words

## Assets

- **css/style.css** - Shared stylesheet with animations and responsive design
- **images/** - Directory for diagrams and illustrations (SVG embedded in HTML)
- **js/** - Directory for future JavaScript interactivity

## Viewing the Documentation

### Local Viewing

Simply open `index.html` in any modern web browser:

```bash
# From command line
firefox docs/index.html
# or
chromium docs/index.html
# or on macOS
open docs/index.html
```

### Serving via HTTP

For a better experience, serve via HTTP:

```bash
# Python 3
cd docs && python3 -m http.server 8000

# Python 2
cd docs && python -m SimpleHTTPServer 8000

# Then visit: http://localhost:8000
```

### Deploying to GitHub Pages

To publish this documentation on GitHub Pages:

1. Go to repository Settings → Pages
2. Set source to "main" branch, "/docs" folder
3. Save and wait for deployment
4. Access at: https://[username].github.io/pangea/

## Features

- **📱 Responsive Design** - Works on desktop, tablet, and mobile
- **🎨 CSS Animations** - Visual explanations of evaluation steps
- **📊 SVG Diagrams** - Parse trees and flow diagrams embedded inline
- **🌐 Bilingual** - Covers both English and Italian keywords
- **💡 Interactive Examples** - Expandable code samples with explanations

## Documentation Coverage

### 1. Conceptual Understanding
- Polish notation fundamentals
- Prefix vs infix comparison
- Parse tree visualization
- Evaluation order

### 2. Technical Details
- Tokenization (program_words)
- Phrase length calculation
- Recursive evaluation (evaluate_word)
- Call stack management
- word_definitions table structure

### 3. Practical Usage
- 13+ complete code examples
- FizzBuzz, factorial, Fibonacci
- Variable scoping
- Function definition
- File includes
- Best practices

### 4. Complete Reference
- All 30+ built-in words documented
- Arity and signature for each
- English/Italian translation table
- Known limitations

## Maintenance

To update the documentation:

1. Edit the relevant HTML file
2. Test locally by opening in browser
3. Commit changes to git
4. If using GitHub Pages, changes deploy automatically

## Style Guide

- Use semantic HTML5 elements
- Maintain consistent color scheme (defined in CSS variables)
- Add code examples for all concepts
- Include both English and Italian versions where applicable
- Keep navigation synchronized across all pages

## Browser Compatibility

Tested and working on:
- Chrome/Chromium 90+
- Firefox 88+
- Safari 14+
- Edge 90+

Requires:
- CSS Grid support
- SVG support
- ES6 JavaScript (for future interactivity)

## License

Same as Pangea/Pang: MIT License
