#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 vYYYYMMDD"
  exit 1
fi

VERSION="$1"
if [[ ! "$VERSION" =~ ^v[0-9]{8}$ ]]; then
  echo "Version must be in format: vYYYYMMDD (example: v20260427)"
  exit 1
fi

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

ASSET_FILES=(
  "assets/css/main.css"
  "assets/css/noscript.css"
  "assets/js/jquery.min.js"
  "assets/js/jquery.scrolly.min.js"
  "assets/js/jquery.scrollex.min.js"
  "assets/js/browser.min.js"
  "assets/js/breakpoints.min.js"
  "assets/js/util.js"
  "assets/js/main.js"
  "images/banner.jpg"
  "images/pic01.jpg"
  "images/pic02.jpg"
  "images/pic03.jpg"
  "images/pic04.jpg"
  "images/pic05.jpg"
  "images/pic06.jpg"
  "images/certifications/cert_1.png"
  "images/certifications/cert_2.png"
  "images/certifications/cert_3.png"
  "images/hobby/hobby_1.png"
  "images/hobby/hobby_2.png"
  "images/hobby/hobby_3.png"
  "images/cognizant/cognizant_1.png"
  "images/cognizant/cognizant_2.png"
  "images/cognizant/cognizant_3.png"
  "images/finance/fin_1.png"
  "images/finance/fin_2.png"
  "images/finance/fin_3.png"
  "images/education/edu_1.png"
  "images/education/edu_2.png"
  "images/education/edu_3.jpg"
  "images/pwc/pwc_1.png"
  "images/pwc/pwc_2.png"
  "images/pwc/pwc_3.png"
)

for f in "${ASSET_FILES[@]}"; do
  ext="${f##*.}"
  stem="${f%.*}"
  cp -f "$f" "${stem}.${VERSION}.${ext}"
done

# These banner names are used directly in HTML files.
cp -f "images/banner.jpg" "images/pwc-banner.${VERSION}.jpg"
cp -f "images/banner.jpg" "images/cognizant-banner.${VERSION}.jpg"

ruby <<'RUBY' "$VERSION"
version = ARGV[0]
files = %w[index.html pwc.html cognizant.html finance.html hobby.html certification.html education.html]

rules = [
  [/assets\/css\/main(?:\.v\d{8})?\.css/, "assets/css/main.#{version}.css"],
  [/assets\/css\/noscript(?:\.v\d{8})?\.css/, "assets/css/noscript.#{version}.css"],
  [/assets\/js\/jquery\.min(?:\.v\d{8})?\.js/, "assets/js/jquery.min.#{version}.js"],
  [/assets\/js\/jquery\.scrolly\.min(?:\.v\d{8})?\.js/, "assets/js/jquery.scrolly.min.#{version}.js"],
  [/assets\/js\/jquery\.scrollex\.min(?:\.v\d{8})?\.js/, "assets/js/jquery.scrollex.min.#{version}.js"],
  [/assets\/js\/browser\.min(?:\.v\d{8})?\.js/, "assets/js/browser.min.#{version}.js"],
  [/assets\/js\/breakpoints\.min(?:\.v\d{8})?\.js/, "assets/js/breakpoints.min.#{version}.js"],
  [/assets\/js\/util(?:\.v\d{8})?\.js/, "assets/js/util.#{version}.js"],
  [/assets\/js\/main(?:\.v\d{8})?\.js/, "assets/js/main.#{version}.js"],
  [/images\/pic01(?:\.v\d{8})?\.jpg/, "images/pic01.#{version}.jpg"],
  [/images\/pic02(?:\.v\d{8})?\.jpg/, "images/pic02.#{version}.jpg"],
  [/images\/pic03(?:\.v\d{8})?\.jpg/, "images/pic03.#{version}.jpg"],
  [/images\/pic04(?:\.v\d{8})?\.jpg/, "images/pic04.#{version}.jpg"],
  [/images\/pic05(?:\.v\d{8})?\.jpg/, "images/pic05.#{version}.jpg"],
  [/images\/pic06(?:\.v\d{8})?\.jpg/, "images/pic06.#{version}.jpg"],
  [/images\/pwc-banner(?:\.v\d{8})?\.jpg/, "images/pwc-banner.#{version}.jpg"],
  [/images\/cognizant-banner(?:\.v\d{8})?\.jpg/, "images/cognizant-banner.#{version}.jpg"],
  [/images\/certifications\/cert_1(?:\.v\d{8})?\.png/, "images/certifications/cert_1.#{version}.png"],
  [/images\/certifications\/cert_2(?:\.v\d{8})?\.png/, "images/certifications/cert_2.#{version}.png"],
  [/images\/certifications\/cert_3(?:\.v\d{8})?\.png/, "images/certifications/cert_3.#{version}.png"],
  [/images\/hobby\/hobby_1(?:\.v\d{8})?\.png/, "images/hobby/hobby_1.#{version}.png"],
  [/images\/hobby\/hobby_2(?:\.v\d{8})?\.png/, "images/hobby/hobby_2.#{version}.png"],
  [/images\/hobby\/hobby_3(?:\.v\d{8})?\.png/, "images/hobby/hobby_3.#{version}.png"],
  [/images\/cognizant\/cognizant_1(?:\.v\d{8})?\.png/, "images/cognizant/cognizant_1.#{version}.png"],
  [/images\/cognizant\/cognizant_2(?:\.v\d{8})?\.png/, "images/cognizant/cognizant_2.#{version}.png"],
  [/images\/cognizant\/cognizant_3(?:\.v\d{8})?\.png/, "images/cognizant/cognizant_3.#{version}.png"],
  [/images\/finance\/fin_1(?:\.v\d{8})?\.png/, "images/finance/fin_1.#{version}.png"],
  [/images\/finance\/fin_2(?:\.v\d{8})?\.png/, "images/finance/fin_2.#{version}.png"],
  [/images\/finance\/fin_3(?:\.v\d{8})?\.png/, "images/finance/fin_3.#{version}.png"],
  [/images\/education\/edu_1(?:\.v\d{8})?\.png/, "images/education/edu_1.#{version}.png"],
  [/images\/education\/edu_2(?:\.v\d{8})?\.png/, "images/education/edu_2.#{version}.png"],
  [/images\/education\/edu_3(?:\.v\d{8})?\.jpg/, "images/education/edu_3.#{version}.jpg"],
  [/images\/pwc\/pwc_1(?:\.v\d{8})?\.png/, "images/pwc/pwc_1.#{version}.png"],
  [/images\/pwc\/pwc_2(?:\.v\d{8})?\.png/, "images/pwc/pwc_2.#{version}.png"],
  [/images\/pwc\/pwc_3(?:\.v\d{8})?\.png/, "images/pwc/pwc_3.#{version}.png"]
]

files.each do |path|
  content = File.read(path, encoding: "UTF-8")
  rules.each { |pattern, replacement| content = content.gsub(pattern, replacement) }
  File.write(path, content)
end

css_path = "assets/css/main.#{version}.css"
css = File.read(css_path, encoding: "UTF-8")
css = css.gsub(/..\/..\/images\/banner(?:\.v\d{8})?\.jpg/, "../../images/banner.#{version}.jpg")
File.write(css_path, css)
RUBY

echo "Asset version bumped to ${VERSION}"
