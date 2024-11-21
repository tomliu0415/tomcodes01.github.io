// # of blocks on the x-axis
const x_max = 10;

// # of blocks on the y-axis
const y_max = 20;

// size of blocks
const block_size = 40;

// index of blocks
const block_list = [];

// blocks that are moving
var active_blocks = null;
///blocks that are going to show
var next_active_blocks = null;

// the score of the game
var score = 0;

// dom for the score element
const score_element = document.getElementById("score");

// dom for the pause element
const pause_element = document.getElementById("game-pause");

// dom for the game over element
const over_element = document.getElementById("game-over");

// position of the top cell
var top_cell_position = y_max;

// canvas
const canvas = document.getElementById("canvas");
canvas.width = block_size * x_max;
canvas.height = block_size * y_max;
const context = canvas.getContext('2d');

// Game Stopped
var gameState = -1;
 
// var gameState = 0 Running
// var gameState = 1 Paused

// draw the Tetris Game Background
function drawBackground() {
    context.lineWidth = 1;
    context.fillStyle = "#000";
    context.fillRect(0, 0, canvas.width, canvas.height);
    context.strokeStyle = "#eee";

		// draw horizontal line
    for (let i = block_size; i < canvas.height; i += block_size) {
        context.beginPath();
        context.moveTo(0, i);
        context.lineTo(canvas.width, i);
        context.closePath();
        context.stroke(); // Draw path
    }
		// draw vertical line
	for (let i = block_size; i < canvas.width; i += block_size) {
		context.beginPath();
		context.moveTo(i, 0);
		context.lineTo(i, canvas.height);
		context.closePath();
		context.stroke(); // draw path
	}
}

// Draw the blocks
function drawAllBlock() {
    for (let i = 0; i < y_max; i++) {
        for (let b = 0; b < x_max; b++) {
            context.lineWidth = 8;
            let cell = block_list[i][b];
            if (!cell) {
                continue
            }
            context.strokeStyle = cell.color;
            context.strokeRect(cell.x * block_size + 4, cell.y * block_size + 4, block_size - 8, block_size - 8);
        };
    };
}

class Cell {
	// location of each cell
    x = 0;
    y = 0;
		
	// Cell's color
    color = "#000";
	// ID for each cell, to differenciate each cell
    id = "";
		
	// Constructor
    constructor({x, y, color}) {
        this.x = x || 0;
        this.y = y || 0;
        this.color = color || "#000";
        this.id = `${new Date().getTime()}${x}${y}`;
        if (this.y >= 0) {
            block_list[this.y][this.x] = this;
        };
    };
	
    getMovePositionByType(type) {
        let position = {
            x: this.x,
            y: this.y
        };
		// blocks moving left, right and down
        // on the x and y-axis.
        switch(type) {
            case "LEFT":
                position.x -= 1;
                break;
            case "RIGHT":
                position.x += 1;
                break;
            case "DOWN":
                position.y += 1;
                break;
        };
        return position;
    }
    
	// Set up each cell's position
    setCellPosition({x, y}) {
		//store the cell's original coordinates
        let preX = this.x;
        let preY = this.y;
		
        if (preY >= 0 && block_list[preY][preX].id == this.id) {
            block_list[preY][preX] = null;
        };
        if (y >= 0) {
            block_list[y][x] = this;
						
            this.x = x;
            this.y = y;
        }
    }
};

class Block {
	
	// body of the blocks
    body = []
	// an array of different rotation angles for the blocks
    rotationList = []
		
    rotate = -1
    centerPoint = -1
		
	// speed for going down the cells
    downSpeed = 500
		
	//timer for falling down the cells
    downTimer = null
		
	//whether the block has stopped moving
    stopActive = false
		
	//initialize the Tetris board
    initBody(x, y) {
        if (this.rotate == -1 || !this.rotationList.length) {
            return
        }
        // if there is a center point for rotation, use this point;
        // !this.centerPoint != 1 ? this.centerPoint : 0
        // 
        let contrastPoint = this.centerPoint != -1 ? this.centerPoint : 0;
        let centerPosition = this.rotationList[this.rotate][contrastPoint];

        for(let i = 0; i < this.rotationList[this.rotate].length; i++) {
            let position = this.rotationList[this.rotate][i];
            this.body.push(
                new Cell({
                    x: x + (position.x - centerPosition.x),
                    y: y + (position.y - centerPosition.y),
                    color: this.color
                })

            )
        }
		/// calls the function, then goes down
        this.down();
    }

	// function for rotating the blocks
    rotationBlock() {
			// if there is no center point to rotate with, don't rotate
        if (this.centerPoint == -1) {
            return
        }
        
        if (this.isCollision("ROTATION")) {
            return // if the block has collided with another 
        }

        this.body.forEach((e, index) => {
            e.setCellPosition(this.getOffsetPosition(index)); // calculate offset position for each cell
        })
				
        this.rotate += 1;
        if (this.rotate == this.rotationList.length) {
            this.rotate = 0;
        }
    }
		
    down() {
        this.downTimer = setInterval(() => {
            if (this.stopActive) {
                clearInterval(this.downTimer);
								// if the blocks has already stopped moving, cancell the timer
                return
            }
            if (gameState == 0) {
                this.move("DOWN");
								// the blocks can keep going down as long as the game is running
            }
        }, this.downSpeed);
    }
		
    move(type) {
        // stop if the blocks have 
        // collided
        if (this.isCollision(type)) {
            return
        }
        // move the blocks
        for (let i = 0, len = this.body.length; i < len; i++) {
            // get the next moving position
            let position = this.body[i].getMovePositionByType(type);
            // pass the values in
            this.body[i].setCellPosition(position);
        }
    }
	// Detect whether the blocks has 
    // collided with other blocks	
    isCollision(type) {
        let result = false;

        for(let i = 0, len = this.body.length; i < len; i++) {
            let position = { };
            if (type != "ROTATION") {
            // get the next moving coordinates
                position = this.body[i].getMovePositionByType(type);
            } else {
            // rotation types
                position = this.getOffsetPosition(i);
            }
			// detect to see if the blocks have collided or not
            if (position.x < 0 || position.x >= x_max) {
                result = true
                break
            }
			// has y collided yet
            if (position.y >= y_max) {
                result = true
                break
            }

			// if y is negative, no need to test it, go pass this if statement
			if (position.y < 0) {
                break
            }

            // see if blocks has collided
            // disregard collision with itself
            // !this.body.some(e => e.id == targetBlock.id) as long as is a block that 
            // belongs to itself, then it wouldn't be counted as a collision
            let targetBlock = block_list[position.y][position.x];
            if(targetBlock && !this.body.some( e => e.id == targetBlock.id)) {
                result = true
                break
            }
        }
        // if the block is going down and has collided with a block
        // then this block can stop being active
        if (type == "DOWN" && result) {
            this.stopActive = true;
        }
        return result
    }

    getOffsetPosition(cellIndex) {
        let index = this.rotate + 1;
        if (this.rotate == this.rotationList.length - 1) {
            index = 0
        }
        let targetPosition = this.rotationList[index][cellIndex];
        let centerPosition = this.rotationList[index][this.centerPoint];
        return {
            x: this.body[this.centerPoint].x + (targetPosition.x - centerPosition.x),
            y: this.body[this.centerPoint].y + (targetPosition.y - centerPosition.y)
        };
    }
    // get the location of the top cells
    getTopCellY() {
        return Math.min(...this.body.map( e => e.y ));
    }
}

class BigBlock extends Block {
    constructor({x, y, color}) {
        super()
        this.color = color || "#0FF" // color of the blocks
        this.rotate = 0 // current rotation degrees
        this.rotationList = [
            [{x: 0, y: 0}, {x: 1, y: 0}, {x: 0, y: 1}, {x: 1, y: 1}]
        ]
        this.initBody(x || 4, y || -1);
    }
}

class LongBlock extends Block {
    constructor({x, y, color}) {
        super()
        this.color = color || "#FF7F00";
        this.rotate = 0;
        this.centerPoint = 1;
        this.rotationList = [
            [{x: 0, y: 0}, {x: 1, y: 0}, {x: 2, y: 0}, {x: 3, y: 0}],
            [{x: 1, y: -1}, {x: 1, y: 0}, {x: 1, y: 1}, {x: 1, y: 2}]
        ]// x and y coordinates that the block can rotate to
        this.initBody(x || 4, y || -1);
				// where the blocks appear from the top
    }
}

class LBlock extends Block {
    constructor({x, y, color}) {
        super()
        this.color = color || "#00FFFF"
        this.centerPoint = 2
        this.rotate = 0
        this.rotationList = [
            [{x: 0, y: 0}, {x: 0, y: 1}, {x: 1, y: 1}, {x: 2, y: 1}], //original shape
            [{x: 2, y: 0}, {x: 1, y: 0}, {x: 1, y: 1}, {x: 1, y: 2}], // rotate 90
            [{x: 2, y: 2}, {x: 2, y: 1}, {x: 1, y: 1}, {x: 0, y: 1}], // rotate 180
            [{x: 0, y: 2}, {x: 1, y: 2}, {x: 1, y: 1}, {x: 1, y: 0}], // rotate 270
        ]
        this.initBody(x || 4, y || -1);
    }
}

class RLBlock extends Block {
    constructor({x, y, color}) {
        super()
        this.color = color || "#00F"
        this.centerPoint = 1
        this.rotate = 0
        this.rotationList = [
            [{x: 0, y: 1}, {x: 1, y: 1}, {x: 2, y: 1}, {x: 2, y: 0}], // original shape
            [{x: 1, y: 0}, {x: 1, y: 1}, {x: 1, y: 2}, {x: 2, y: 2}], // rotate 90
            [{x: 2, y: 1}, {x: 1, y: 1}, {x: 0, y: 1}, {x: 0, y: 2}], // rotate 180
            [{x: 1, y: 2}, {x: 1, y: 1}, {x: 1, y: 0}, {x: 0, y: 0}], // rotate 270
        ]
        this.initBody(x || 4, y || -1); // where the blocks on the board appear
    }
}

class ZBlock extends Block {
    constructor({x, y, color}) {
        super()
        this.color = color || "#0F0"
        this.centerPoint = 2
        this.rotate = 0
        this.rotationList = [
            [{x: 0, y: 0}, {x: 1, y: 0}, {x: 1, y: 1}, {x: 2, y: 1}], // original shape
            [{x: 2, y: 0}, {x: 2, y: 1}, {x: 1, y: 1}, {x: 1, y: 2}],// rotate 90
            [{x: 2, y: 2}, {x: 1, y: 2}, {x: 1, y: 1}, {x: 0, y: 1}],//rotate 180
            [{x: 0, y: 2}, {x: 0, y: 1}, {x: 1, y: 1}, {x: 1, y: 0}],//rotate 270
        ]
        this.initBody(x || 4, y || -1)//where the blocks appear on the board from the top
    }
}

class RZBlock extends Block {
    constructor({x, y, color}) {
        super()
        this.color = color || "#8B00FF"
        this.centerPoint = 1
        this.rotate = 0
        this.rotationList = [
            [{x: 0, y: 1}, {x: 1, y: 1}, {x: 1, y: 0}, {x: 2, y: 0}], // original shape
            [{x: 1, y: 0}, {x: 1, y: 1}, {x: 2, y: 1}, {x: 2, y: 2}], // rotate 90
            [{x: 2, y: 1}, {x: 1, y: 1}, {x: 1, y: 2}, {x: 0, y: 2}], // rotate 180
            [{x: 1, y: 2}, {x: 1, y: 1}, {x: 0, y: 1}, {x: 0, y: 0}], // rotate 270
        ]
        this.initBody(x || 4, y || -1)//where the blocks appear from the top of the board
    }
}

class TBlock extends Block {
    constructor({x, y, color}) {
        super()
        this.color = color || "#F00"
        this.centerPoint = 2 // which block does the block rotate from
        this.rotate = 0 //current rotation degrees
        this.rotationList = [
            [{x: 1, y: 0}, {x: 0, y: 1}, {x: 1, y: 1}, {x: 2, y: 1}],//original shape
            [{x: 2, y: 1}, {x: 1, y: 0}, {x: 1, y: 1}, {x: 1, y: 2}],//rotate 90
            [{x: 1, y: 2}, {x: 2, y: 1}, {x: 1, y: 1}, {x: 0, y: 1}],//rotate 180
            [{x: 0, y: 1}, {x: 1, y: 2}, {x: 1, y: 1}, {x: 1, y: 0}],//rotate 190
        ]
        this.initBody(x || 4, y || -1)
    }
}

// the keys has been pressed what does the blocks do
document.onkeydown = function(event) {
    let e = event || window.event;
    switch (e.keyCode) {
        case 87: // W
            active_blocks.rotationBlock();
            break

        case 83: // S
            active_blocks.move("DOWN");
            break

        case 65: // A
            active_blocks.move("LEFT");
            break

        case 68: // D
            active_blocks.move("RIGHT");
            break

        case 32: // Space
            pause();
            break
    }
}

// initialize body list
function initBodyList() {
    for(let i = 0; i < y_max; i++) {
        let list = []
        for(let j = 0; j < x_max; j++) {
            list.push(null)
        }
        block_list.push(list)
    }
}

function computeScore() {
    let clearRowIndexList = [ ]
    for(let i = y_max - 1; i >= 0; i--) {
        if (block_list[i].every(e => e)) { 
            // if there is a block at every section, clear this block, and move the blocks above down 1 section simoutaneously, then add 10 points
            score += 10
            // keep the rows that still needs to be cleared
            // in clearRowIndexList
            clearRowIndexList.unshift(i);
        }
    }
    clearRow(clearRowIndexList); // clear this row
    score_element.innerText = score;
}
// clear index
// then move the blocks from the index down 1 line
// basically how Tetris move the entire blocks down 1 row and hide the ones at the very bottom
function clearRow(list) {
    while(list.length) {
        let index = list.pop();

        for(let i = 0; i < x_max; i++) {
			// clear the blocks
            block_list[index][i] = null;
        }
			// move the blocks above down
        for(let i = index - 1; i >= 0; i--) {
            block_list[i].forEach(e => {
                if(e) {
                    let position = e.getMovePositionByType("DOWN");
                    e.setCellPosition(position);
                }
            })
        }
		// increase the blocks left on the board by 1
        for(let i = 0, len = list.length; i < len; i++) {
            list[i] += 1
        }
    }
}

// generate random blocks
function getRandomBlock() {
    let block = null;
    let randomType = Math.floor(Math.random() * 7);
    switch (randomType) {
        case 0: // Z shaped block
            block = new ZBlock({});
            break
        case 1: // Big block
            block = new BigBlock({});
            break
        case 2: // Long block
            block = new LongBlock({});
            break
        case 3: // L shaped slock
            block = new LBlock({});
            break
        case 4: // Reversed L shaped block
            block = new RLBlock({});
            break
        case 5: // Reversed Z shaped block
            block = new RZBlock({});
            break
        case 6: // T shaped block
            block = new TBlock({});
            break
    }
    return block;
}

// set up the top cell's position
function setTopCellPosition() {
    if (active_blocks.getTopCellY() < top_cell_position) {
        top_cell_position = active_blocks.getTopCellY();
    }
}

function gameOver() {
    if (top_cell_position <= 0) {
        gameState = -1;
        over_element.style.display = "block";
    }
}

function pause() {
    if (gameState == 1) {
		// Game Start
        gameState = 0;
		// hide the 'Game Paused' phrase
		pause_element.style.display = "none";
    } else if (gameState != -1) {
		// Game Over
        gameState = 1;
        pause_element.style.display = "block";
    }
}

// run the game
function run() {
	// Request animation frame to render
    window.requestAnimationFrame(run);
    if (gameState != 0) {
		// stop if the game is not running
        return
    }
		// render background
    drawBackground()
		// render blocks
    drawAllBlock()
		// if the blocks has stopped being active, compute score, set up top position, game over, and start generating random blocks again:D
    if (active_blocks.stopActive) {
        computeScore()
        setTopCellPosition()
        gameOver()
				
        active_blocks = getRandomBlock();
    }
}

// Start the game
function start() {
    gameState = 0;
    over_element.style.display = "none";
		
    initBodyList()
		
    active_blocks = getRandomBlock();
    window.requestAnimationFrame(run);
}

// Run the start function
start();