# Minesweeper API

A API for build web apps or mobile app where your only has that implement an UI(and Rest API, obviously).

# Overview: Problem to resold

## Goal/Objectives

Build a API with the logic game Minesweeper.

### Stakeholders

- Project owner: @Jesús Millán
- Users: Any person that want create an web app or mobile app where only should implement an interface interactive for the game.0
- Open-source community: Any person that want use this repository with education purposes.

## Alcance(Scope)

### Supported use-cases

- When a cell with no adjacent mines is revealed, all adjacent squares will be revealed (and repeat)
- Ability to 'flag' a cell with a question mark or red flag
- Detect when game is over
- Dont continue in the game if the game is over
- The data game should be persistence for each user
- Ability to start a new game and preserve/resume the old ones
- Ability to select the game parameters: number of rows, columns and mines.
- The total mines is between 1 and 1/3 of the cells
- Show the all mines when the game is over

### Out of Scope (Dont supported use-cases)

- Dont count time game
- Dont init automatic game when the last game is over
- Dont show the score game

# Arquitectura

## Diagrams

<!-- # TODO: Create a diagrams sequence, uml, etc -->

## Data models

<!-- # TODO: Create a uml with data model -->

# Documentation API
<!-- # TODO: Implement OpenAPI -->
## Response Interface

### Success

```json
{
    "board": [
        ["H", "H", "H", "1", "0"],
        ["Q", "H", "R", "1", "0"],
        ["H", "H", "2", "1", "0"],
        ["H", "R", "1", "0", "0"],
        ["1", "H", "1", "0", "0"]
    ],
    "msg": "A generic message",
}
```

**What's is the mean the letters?**

- H: Hide
- Q: A question flag
- R: A red flag
- 0..8: The number of mines around

### Fail

```json
{
    "error" : {
        "msg": "This is a generic info about the error",
    }
}
```

## EndPoints

### Create a new game

Create a new game for a user
**Path:** `/v1/games/`
**Headers:** `Authorization: {username}`
**Body:**

```json
{
    "rows": 10, // Integer: Rows of board
    "cols": 10, // Integer: Cols of board
    "mines": 10, // Integer: Mines in the board. The total mines should be less that (1/3)*rows*cols
}
```

### Toogle Flags

Active o disable the flag in any cell
**Path:** `/v1/flags/`
**Headers:** `Authorization: {username}`
**Body:**

```json
{
    "x": 10, // Integer:
    "y": 10, // Integer:
    "type": 10, // "R" for red flag or "Q" for question flag
}
```

### Explorer a new cell

Explorer a cell and discover if is a mine or not
**Path:** `/v1/explorer/`
**Headers:** `Authorization: {username}`
**Body:**

```json
{
    "x": 10, // Integer:
    "y": 10, // Integer:
}
```

# Deploy server on local

1. Install docker and docker-compose
2. `docker-compose up --build`
