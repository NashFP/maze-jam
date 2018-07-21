// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"


// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import {channel, socket} from "./socket"

let $button = u.u('.js-make-maze')
let $example = u.u('.js-make-example')

$button.on('click', getMaze)
$example.on('click', getExample)

channel.on('new_maze', resp => build_table(resp.maze))

function getMaze() {
    var cols = u.u('.cols').first().value
    var rows = u.u('.rows').first().value
    channel.push('get_maze', {cols, rows})
}

function getExample() {
    channel.push('get_example')
}

function build_table(maze) {
    console.log(maze)
    let t = u.u('.maze')
    t.empty()
    let $table = document.querySelector('.maze')
    R.forEach(x => {
        let $tr = document.createElement('tr')
        $table.appendChild($tr)
        R.forEach(y => {
            let $td = document.createElement('td')
            $tr.appendChild($td)
            $td.innerText = y
            if (!isWest(y))
                $td.style.borderLeft = "solid 1px black"
            if (!isEast(y))
                $td.style.borderRight = "solid 1px black"
            if (!isSouth(y))
                $td.style.borderBottom = "solid 1px black"
            if (!isNorth(y))
                $td.style.borderTop = "solid 1px black"
        })(x)
    })(maze)
}

let isWest = x => toBinary(x)[0] == "1"
let isEast = x => toBinary(x)[1] == "1"
let isSouth = x => toBinary(x)[2] == "1"
let isNorth = x => toBinary(x)[3] == "1"

let toBinary = x => (x).toString(2).padStart(4,"0")
