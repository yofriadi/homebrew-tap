import fs from "node:fs";
import path from "node:path";
import { execSync } from "node:child_process";
import { createRequire } from "node:module";

const require = createRequire(import.meta.url);
const version = process.argv[2] || "1.143";
const outputZip = process.argv[3] || path.resolve(`CommitMono-all-v${version}.zip`);

console.log(`Building Commit Mono all-variants package for version ${version}...`);

const workDir = fs.mkdtempSync(path.join("/tmp", "commit-mono-build-"));
const extractDir = path.join(workDir, "extract");
const outDir = path.join(workDir, "out");
fs.mkdirSync(extractDir, { recursive: true });
fs.mkdirSync(outDir, { recursive: true });

// Ensure opentype.js is available
console.log("Installing opentype.js in temp directory...");
execSync("npm install --no-save --prefix " + workDir + " opentype.js", { stdio: "inherit" });
const opentype = require(path.join(workDir, "node_modules", "opentype.js"));

// Download upstream source tarball
const tarUrl = `https://github.com/eigilnikolajsen/commit-mono/archive/refs/tags/v${version}.tar.gz`;
const tarPath = path.join(workDir, `commit-mono-${version}.tar.gz`);
console.log(`Downloading ${tarUrl}...`);
execSync(`curl -sSfL "${tarUrl}" -o "${tarPath}"`, { stdio: "inherit" });

console.log("Extracting archive...");
execSync(`tar -xzf "${tarPath}" -C "${extractDir}"`, { stdio: "inherit" });

// Locate fontlab directory
const extractedRoot = fs.readdirSync(extractDir).find((d) => d.startsWith("commit-mono"));
if (!extractedRoot) {
  throw new Error(`Could not find extracted commit-mono directory in ${extractDir}`);
}
const rawDir = path.join(extractDir, extractedRoot, "src", "fonts", "fontlab");
if (!fs.existsSync(rawDir)) {
  throw new Error(`Fontlab directory not found at ${rawDir}`);
}

const rawFiles = fs.readdirSync(rawDir);
console.log(`Found ${rawFiles.length} files in fontlab`);

const fontRegex = /CommitMono.*-(\d+)(Regular|Italic)\.otf$/i;
const vfRegex = /CommitMono.*-VF\.ttf$/i;

let processedCount = 0;

for (const file of rawFiles) {
  const filePath = path.join(rawDir, file);
  const match = file.match(fontRegex);

  if (match) {
    const weight = parseInt(match[1], 10);
    const italicOrRegular = match[2];
    const isItalic = italicOrRegular.toLowerCase() === "italic";
    const style = `${weight} ${italicOrRegular}`;
    const fontName = "CommitMono";
    const styleNoSpace = style.replace(/\s+/g, "");
    const fontFamily = fontName;
    const fullName = `${fontName} ${style}`;
    const postScriptName = `${fontName}-${styleNoSpace}`;

    const buf = fs.readFileSync(filePath);
    const font = opentype.parse(buf.buffer.slice(buf.byteOffset, buf.byteOffset + buf.byteLength));

    const verStr = font.names.windows?.version?.en || `Version ${version}`;
    const uniqueID = `${verStr};;${fontName}-${styleNoSpace};FL820`;

    // Macintosh names
    font.names.macintosh.fontFamily = { en: fontFamily };
    font.names.macintosh.fontSubfamily = { en: style };
    font.names.macintosh.fullName = { en: fullName };
    font.names.macintosh.postScriptName = { en: postScriptName };
    font.names.macintosh.preferredFamily = { en: fontFamily };
    font.names.macintosh.preferredSubfamily = { en: style };

    // Windows names
    font.names.windows.fontFamily = { en: fontFamily };
    font.names.windows.fontSubfamily = { en: style };
    font.names.windows.fullName = { en: fullName };
    font.names.windows.postScriptName = { en: postScriptName };
    font.names.windows.preferredFamily = { en: fontFamily };
    font.names.windows.preferredSubfamily = { en: style };
    font.names.windows.uniqueID = { en: uniqueID };

    if (font.tables.cff?.topDict) {
      font.tables.cff.topDict.familyName = fontFamily;
      font.tables.cff.topDict.fullName = fullName;
      font.tables.cff.topDict.weight = weight >= 700 ? "Bold" : "Regular";
      font.tables.cff.topDict.uniqueId = uniqueID;
      font.tables.cff.topDict.isFixedPitch = 1;
    }

    if (font.tables.hhea) {
      font.tables.hhea.numberOfHMetrics = 3;
    }
    if (font.tables.post) {
      font.tables.post.isFixedPitch = 1;
    }

    font.tables.name = font.names;

    if (font.tables.os2) {
      font.tables.os2.usWeightClass = weight;
      let fsSelection = 0;
      if (isItalic) fsSelection |= 1 << 0;
      if (weight >= 700) fsSelection |= 1 << 5;
      font.tables.os2.fsSelection = fsSelection;
    }

    const outFileName = `CommitMono-${weight}-${italicOrRegular}.otf`;
    const outBuf = Buffer.from(font.toArrayBuffer());
    fs.writeFileSync(path.join(outDir, outFileName), outBuf);
    processedCount++;
  } else if (file.match(vfRegex)) {
    // Copy Variable Font
    fs.copyFileSync(filePath, path.join(outDir, "CommitMono-VF.ttf"));
    processedCount++;
  }
}

console.log(`Processed ${processedCount} font files.`);

// Create zip archive
const resolvedZip = path.resolve(outputZip);
if (fs.existsSync(resolvedZip)) {
  fs.unlinkSync(resolvedZip);
}

execSync(`cd "${outDir}" && zip -9 -q -r "${resolvedZip}" .`, { stdio: "inherit" });
console.log(`Created archive: ${resolvedZip} (${(fs.statSync(resolvedZip).size / 1024 / 1024).toFixed(2)} MB)`);

// Clean up temp dir
fs.rmSync(workDir, { recursive: true, force: true });

// Print sha256
const sha256 = execSync(`shasum -a 256 "${resolvedZip}" | awk '{print $1}'`).toString().trim();
console.log(`SHA256: ${sha256}`);
