local BinarySearch = {}

function BinarySearch.Find(array, key)
	local left = 1
	local right = #array

	while left <= right do
		local mid = math.floor((left + right) / 2)
		local value = array[mid]

		if value == key then
			return mid
		elseif value < key then
			left = mid + 1
		else
			right = mid - 1
		end
	end

	return nil
end

return BinarySearch
