#!/usr/bin/env -S nix shell nixpkgs#nodejs_20 -c node
const path = require('node:path')
const fs = require('node:fs/promises')
const { env } = require('node:process')

const xdgDataDirs = env.XDG_DATA_DIRS.split(":")
xdgDataDirs.unshift(env.XDG_DATA_HOME ? env.XDG_DATA_HOME : path.join(env.HOME, ".local/share"))

const desktopFile = {
    parse: {
	string: function() {},
	localestring: function() {},
	iconstring: function() {},
	boolean: function() {},
	numeric: function() {}
    }
}

async function main() {
     for (const dir of xdgDataDirs) {
        try {
	    const files = await fs.readdir(path.join(dir, "applications"))
	    for (const file of files) {
	        if (path.extname(file) == ".desktop") {
		    console.log(file)
	        }
	    }
        } catch (err) {
	    if (err.code != "ENOENT") {
		console.error(err)
	    }
        }
    }
}

main()
