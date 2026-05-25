local Nodes = require(game:GetService("ServerScriptService").Modules.Nodes)

local Grid = {}
Grid.__index = Grid

function Grid.new(width: number, height: number, depth: number)
	local self = setmetatable({}, Grid)

	self.width = width
	self.height = height
	self.depth = depth
	self.nodes = {}

	return self
end

function Grid:Generate3DGrid(goalPosition: Vector3)
	for x = 1, self.width do
		self.nodes[x] = {}

		for y = 1, self.height do
			self.nodes[x][y] = {}

			for z = 1, self.depth do
				self.nodes[x][y][z] = Nodes.new({
					goal = goalPosition,
					position = Vector3.new(x, y, z),
					parent = nil,

					gCost = math.huge,
					hCost = 0,
					fCost = 0,

					walkable = true,
					neighbors = {}
				})
			end
		end
	end
end

function Grid:Generate3DNeighbors()
	local directions = {
		{ 1, 0, 0 }, { -1, 0, 0 },
		{ 0, 1, 0 }, { 0, -1, 0 },
		{ 0, 0, 1 }, { 0, 0, -1 }
	}

	for x = 1, self.width do
		for y = 1, self.height do
			for z = 1, self.depth do

				local node = self.nodes[x][y][z]

				for _, dir in ipairs(directions) do
					local nx, ny, nz = x + dir[1], y + dir[2], z + dir[3]

					if nx >= 1 and nx <= self.width
						and ny >= 1 and ny <= self.height
						and nz >= 1 and nz <= self.depth then

						node:AddNeighbor(self.nodes[nx][ny][nz])
					end
				end
			end
		end
	end
end

return Grid
