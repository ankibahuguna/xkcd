#!/usr/bin/env node
const Axios = require('axios');
const Cheerio = require('cheerio');
const OS = require('os');
const FS = require('fs');
const URL = require('url');
const { promisify } = require('util');
const { exec } = require('child_process');

const WriteFile = promisify(FS.writeFile).bind(FS);
const Exec = promisify(exec);



const baseURl = `https://xkcd.com/${getRandomInt()}`

//console.log(baseURl)
async function getXKCDContent() {
    return Axios.get(baseURl);
}

function getRandomInt() {
    return Math.floor(Math.random() * (1950 - 1 + 1)) +1;
}


async function getComic() {

    const {data} = await getXKCDContent();
    const $ = Cheerio.load(data);
    const ImageUrl = $("div#comic").children('img').attr('src');

    return `https:${ImageUrl}`;

}

async function ensureDirectory () {
    if(FS.existsSync(`${OS.homedir()}/comics`)){
        return
    }
    return FS.mkdirSync(`${OS.homedir()}/comics`);
}

async function downloadImage() {
    const imageUrl = await getComic();
    const {data} = await Axios.get(imageUrl, { responseType: 'arraybuffer' });
    const localImage = `${OS.homedir()}${URL.parse(imageUrl).path}`;

    await WriteFile(localImage, data);

    return localImage;
}


(async function () {
    try {
        await ensureDirectory();
        const file = await downloadImage();
        const picture = `/usr/bin/gsettings set org.gnome.desktop.background picture-uri 'file:///${file}'`;
        await Exec(picture,{cwd : __dirname, shell:'/bin/sh'})
        await Exec('/usr/bin/gsettings set org.gnome.desktop.background picture-options "scaled"', { cwd: __dirname, shell: '/bin/sh' });
    }
    catch (err) {
        //await WriteFile('test.log');
        console.error(err);
    }
}())
