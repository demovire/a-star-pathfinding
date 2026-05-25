# A* Pathfinding in 3D (Roblox)

## Overview
This is a basic 3D implementation of the A* pathfinding algorithm for Roblox Studio.

I built this as a learning project to understand how pathfinding systems work under the hood.

**Note:** This is a minimal implementation. It does not include advanced features such as collision detection, dynamic obstacles, or path smoothing.

---

## Setup

This is designed for Roblox Studio using ModuleScripts inside `ServerScriptService`.

### Create Modules

1. Open **ServerScriptService** in Explorer
2. Create a folder called `Modules`
3. Inside it, create two ModuleScripts:
   - `GridSystem`
   - `Nodes`
4. Paste the corresponding code into each module

---

## Usage Example

```lua
local startPosition = Vector3.new(1, 1, 1)
local goalPosition = Vector3.new(5, 5, 5)

local gridWidth, gridHeight, gridDepth = 5, 5, 5

local Path = AStarPathfinding(startPosition, goalPosition, gridWidth, gridHeight, gridDepth)

if Path then
	for _, node in ipairs(Path) do
		print(node.position)
		node:Visualize(Color3.fromRGB(0, 255, 0))
	end
else
	warn("No path found")
end
