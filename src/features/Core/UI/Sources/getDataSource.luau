local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vide = require(ReplicatedStorage.Packages.Vide)
local DataService = require(ReplicatedStorage.Packages.DataService).client

local dataSources = {} :: { [string]: Vide.source<any> }

return function(path: string)
	if dataSources[path] then
		return dataSources[path]
	end

	DataService:waitForData()

	local dataSource = Vide.source(DataService:get({ path }))
	dataSources[path] = dataSource

	DataService:getChangedSignal({ path }):Connect(function(newValue: any)
		dataSource:update(newValue)
	end)

	return dataSource
end
