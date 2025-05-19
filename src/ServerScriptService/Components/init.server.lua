for _, child in ipairs(script:GetDescendants()) do
	if child:IsA("ModuleScript") and child.Name:match("Component$") then
		require(child)
		print("Loaded component: " .. child.Name)
	end
end