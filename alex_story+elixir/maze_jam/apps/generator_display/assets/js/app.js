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

let $button = u.u('.btn')

$button.on('click', getMaze)

channel.on('new_maze', resp => build_table(resp.maze))

function getMaze() {
    var cols = u.u('.cols').first().value
    var rows = u.u('.rows').first().value
    channel.push('get_maze', {cols, rows})
}

function build_table(maze) {
    console.log(maze)
    let t = u.u('.maze')
    t.empty()
    let $table = document.querySelector('.maze')
    let rows = R.reduce(R.maxBy(x => x.y),R.head(maze),  R.tail(maze)).y
    let columns = R.reduce(R.maxBy(x => x.x),R.head(maze), R.tail(maze)).x

    for (let i = 0; i <= rows; i++) {
        let $tr = document.createElement('tr')

        for (let j = 0; j <= columns; j++) {
            let $td = document.createElement('td')
            var cell = R.find(R.and(R.propEq('x', j),R.propEq('y', i)))(maze)
            let $div = document.createElement('div')
            if(cell.north) $div.style.borderTop = "#000 1px solid"
            if(cell.east) $div.style.borderRight = "#000 1px solid"
            if(cell.south) $div.style.borderBottom = "#000 1px solid"
            if(cell.west) $div.style.borderLeft = "#000 1px solid"
            $div.classList.add('cell')
            $td.appendChild($div)
            $tr.appendChild($td)
        }
        $table.appendChild($tr)
    }
}


