local remote = Instance.new("RemoteEvent", game.ReplicatedStorage);
remote.Name = "Callback";
remote.OnServerEvent:connect(function(player, Functioncall, data)
	local functions = {
		CreateInstance = function(data)
			for Type, Properties in next, data.Instance do
				print(Type)
				local newInstance = Instance.new(Type);
				for Property, Value in next, Properties do
					if not(Property == "Parent") then
					newInstance[Property] = Value;
					else
						if type(Value) == "table" then
							coroutine.resume(coroutine.create(function()
								while not(newInstance.Parent) do 
									newInstance.Parent = Value.Find:FindFirstChild(Value.Name);
									wait()
								end;
							end));
						else
							newInstance[Property] = Value;
						end;
					end;
				end;
			end;
		end;
	};
	functions[Functioncall](data);
end);