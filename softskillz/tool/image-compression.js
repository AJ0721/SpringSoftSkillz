const fs = require('fs');
const path = require('path');
const sharp = require('sharp');

// 指定路徑，請使用絕對路徑
const rootDirectoryPath = '/Users/user/Downloads/softskillz/src/main/webapp';

function main() {
    digForImages(rootDirectoryPath);
}

function digForImages(target) {
    console.log("Dig:", target);
    fs.stat(target, (err, stats) => {
        if (err) {
            console.error("Failed to dig (fs.stat):", target);
            return;
        }

        // 如果是資料夾
        if (stats.isDirectory()) {
            fs.readdir(target, (err, files) => {
                if (err) {
                    console.error("Failed to dig (fs.readdir):", target);
                    return;
                }
                files.forEach(file => {
                    digForImages(path.join(target, file));
                });
            })
        } else {
            const extName = path.extname(target).toLowerCase();
            const isPNG = extName.includes(".png");
            const isJPG = extName.includes(".jpg") || extName.includes(".jpeg");
            if (isPNG) {
                compressPNG(target);
            } else if (isJPG) {
                compressJPG(target);
            }
        }
    });
}

async function compressPNG(target) {
    console.log("png");
    const imageData = await sharp(await fs.promises.readFile(target));
    const buffer = await imageData
        .png({ quality: 80, palette: true, compressionLevel: 9 })
        .toBuffer();
    fs.promises.writeFile(target, buffer);
}

async function compressJPG(target) {
    console.log("jpg");
    const imageData = await sharp(await fs.promises.readFile(target));
    const buffer = await imageData
        .jpeg({ quality: 60 })
        .toBuffer();
    fs.promises.writeFile(target, buffer);
}

main();