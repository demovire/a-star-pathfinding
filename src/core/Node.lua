local Node = {}
Node.__index = Node

function Node.new(properties: table)
	local self = setmetatable({}, Node)

	for key, value in pairs(properties) do
		self[key] = value
	end

	return self
end

function Node:CalculateGCost()
	if not self.parent then
		self.gCost = 0
		return
	end

	local parentCost = self.parent.gCost or 0
	local dist = (self.parent.position - self.position).Magnitude

	self.gCost = parentCost + dist
end

function Node:CalculateHCost()
	self.hCost = (self.position - self.goal).Magnitude
end

function Node:CalculateFCost()
	self.fCost = self.gCost + self.hCost
end

function Node:AddNeighbor(neighbor)
	table.insert(self.neighbors, neighbor)
end

function Node:Visualize(color: Color3)
	local part = Instance.new("Part")
	part.Anchored = true
	part.Size = Vector3.new(1, 1, 1)
	part.Shape = Enum.PartType.Ball
	part.Color = color
	part.Position = self.position
	part.Parent = workspace

	return part
end

return Node
