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
    R.forEach(x => {
        let $tr = document.createElement('tr')
        $table.appendChild($tr)
        R.forEach(y => {
            debugger
            let $td = document.createElement('td')
            $tr.appendChild($td)
            $td.innerText = y
            let [west, wn] = isWest(y)
            if (west)
                $td.style.borderLeft = "solid 1px black"
            let [east, en] = isEast(wn)
            if (east)
                $td.style.borderRight = "solid 1px black"
            let [south, sn] = isSouth(en)
            if (south)
                $td.style.borderBottom = "solid 1px black"
            if (isNorth(sn))
                $td.style.borderTop = "solid 1px black"
        })(x)
    })(maze)
}

let isWest = R.ifElse(
    R.lte(8),
    R.identity(x => [true, x - 8]),
    R.identity(x => [false, x])
)

let isEast = R.ifElse(
    R.lte(4),
    R.identity(x => [true, x - 4]),
    R.identity(x => [false, x])
)

let isSouth = R.ifElse(
    R.lte(2),
    R.identity(x => [true, x - 2]),
    R.identity(x => [false, x])
)

let isNorth = R.ifElse(
    R.equals(1),
    R.T,
    R.F
)
