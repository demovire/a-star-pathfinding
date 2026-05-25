local GridSystem = require(game:GetService("ServerScriptService").Modules.GridSystem)

local function ReconstructPath(current)
	local totalPath = {current}
	while current.parent do
		current = current.parent
		table.insert(totalPath, 1, current)
	end
	return totalPath
end


function AStarPathfinding(startPosition : Vector3, goalPosition : Vector3, pathWidth : IntValue, pathHeight : IntValue, pathDepth : IntValue)
	local AStarGrid = GridSystem.new(pathWidth, pathHeight, pathDepth)
	AStarGrid:Generate3DGrid(goalPosition)
	AStarGrid:Generate3DNeighbors()

	local startNode = AStarGrid.nodes[startPosition.X][startPosition.Y][startPosition.Z]
	local goalNode  = AStarGrid.nodes[goalPosition.X][goalPosition.Y][goalPosition.Z]

	local openSet   = {startNode}
	local closedSet = {}

	startNode.gCost = 0
	startNode:CalculateHCost()
	startNode:CalculateFCost()

	local function findCheapestNode(openSet)
		local cheapestNode = openSet[1]
		for _, node in ipairs(openSet) do
			if node.fCost < cheapestNode.fCost 
				or (node.fCost == cheapestNode.fCost and node.hCost < cheapestNode.hCost) then
				cheapestNode = node
			end
		end
		return cheapestNode
	end

	while #openSet > 0 do
		local current = findCheapestNode(openSet)

		if (current.position - goalNode.position).Magnitude < 0.001 then
			return ReconstructPath(current)
		end

		table.remove(openSet, table.find(openSet, current))
		table.insert(closedSet, current)

		for _, neighbor in ipairs(current.neighbors) do
			if not neighbor.walkable or table.find(closedSet, neighbor) then
				continue
			end

			local tentativeG = current.gCost + (neighbor.position - current.position).Magnitude

			if tentativeG < neighbor.gCost or not table.find(openSet, neighbor) then
				neighbor.parent = current
				neighbor.gCost = tentativeG
				neighbor:CalculateHCost()
				neighbor:CalculateFCost()

				if not table.find(openSet, neighbor) then
					table.insert(openSet, neighbor)
				end
			end
		end
	end

	return nil
end
