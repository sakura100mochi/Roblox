return function(baseSize: UDim2, add: UDim2, onHover: boolean): UDim2
	return onHover == true and baseSize + add or baseSize
end