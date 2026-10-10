return function(props, default)
	local resolvedProps = table.clone(default)
	for key, value in props or {} do
		if value ~= nil then
			(resolvedProps :: any)[key] = value
		end
	end
	return resolvedProps
end