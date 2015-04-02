local player = game.Players.LocalPlayer;
local mouse = player:GetMouse();
-- other stuff
local module = require(game.ReplicatedStorage.Misc);
local module2 = require(game.ReplicatedStorage.SquadSpecific);
local checkForOwnership = false; -- testing blah...
local squadNames = {"Volk"};
local selected = {nil};
mouse.Button1Down:connect(function()
	local target = mouse.Target.Parent.Parent;
	local changeSelected = module:ObjTableCheck(target, squadNames, "Name");
	if changeSelected then
		selected = {target};
	 else
		local paths = {}
		local units = {}
		for _, model in next, selected do	
			for num, unit in next, model:GetChildren() do	
				if unit:IsA("Model") then
					local difference = model.one.Torso.Position-unit.Torso.Position;
					units[#units + 1] = unit;
					paths[#units] = module2:CalculatePath(unit.Torso.Position, mouse.Hit.p - difference, true):GetPointCoordinates();		
				end;			
			end;
		game.ReplicatedStorage.Callback:FireServer("MoveSquad", {models = units, paths = paths});
		end;
	end;
end);