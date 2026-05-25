local MinHeap = {}
MinHeap.__index = MinHeap

function MinHeap.new()
	local self = setmetatable({}, MinHeap)
	self.elements = {}
	return self
end

function MinHeap:Parent(i)
	return math.floor(i / 2)
end

function MinHeap:Left(i)
	return 2 * i
end

function MinHeap:Right(i)
	return 2 * i + 1
end

function MinHeap:Swap(i, j)
	self.elements[i], self.elements[j] = self.elements[j], self.elements[i]
end

function MinHeap:Compare(a, b)
	-- assumes objects with .fCost (for A*)
	return a.fCost < b.fCost
end

function MinHeap:HeapifyDown(i)
	local smallest = i
	local left = self:Left(i)
	local right = self:Right(i)

	if left <= #self.elements and self:Compare(self.elements[left], self.elements[smallest]) then
		smallest = left
	end

	if right <= #self.elements and self:Compare(self.elements[right], self.elements[smallest]) then
		smallest = right
	end

	if smallest ~= i then
		self:Swap(i, smallest)
		self:HeapifyDown(smallest)
	end
end

function MinHeap:HeapifyUp(i)
	while i > 1 do
		local parent = self:Parent(i)

		if self:Compare(self.elements[i], self.elements[parent]) then
			self:Swap(i, parent)
			i = parent
		else
			break
		end
	end
end

function MinHeap:Insert(node)
	table.insert(self.elements, node)
	self:HeapifyUp(#self.elements)
end

function MinHeap:Pop()
	if #self.elements == 0 then return nil end

	local root = self.elements[1]
	self.elements[1] = self.elements[#self.elements]
	table.remove(self.elements)

	self:HeapifyDown(1)

	return root
end

function MinHeap:Peek()
	return self.elements[1]
end

return MinHeap
