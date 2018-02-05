#!/usr/bin/env node
const fs = require('fs');
const {exec} = require('child_process');
const cheerio = require('cheerio');
let $ = cheerio.load('<h2 class = "title">Hello world</h2>');

fs.writeFile(`/home/ankit/test${new Date().getTime()}`, $.html(), function(err) {
        if(err) {
                    return console.log(err);
                        }
    exec("gsettings set org.gnome.desktop.background picture - uri 'file:///home/ankit/comics/quirky_girls.png",(err,res)=>{

    })
                            console.log("The file was saved!");
}); 
