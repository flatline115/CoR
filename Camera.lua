repeat wait() until game.Players.LocalPlayer.Character;
local Player = game.Players.LocalPlayer;
local mouse = Player:GetMouse();
local Character = Player.Character;
local Camera = Workspace.CurrentCamera;
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
-- Setting Stuff
Camera.CameraType = Enum.CameraType.Scriptable;
Camera.CoordinateFrame = CFrame.new(16.613121, 25.0358391, -8.28312492, -0.88647145, -0.457085848, 0.0723953396, 1.4901163e-008, 0.156434596, 0.987688303, -0.462783486, 0.875557482, -0.138674766);
Character.Parent = game.ReplicatedFirst;
local MoveRight, MoveLeft, MoveForward, MoveBackward = false, false, false, false;
local RotateCamera, Vec = false, ...;
UserInputService.InputBegan:connect(function(InputObject)
	if InputObject.KeyCode == Enum.KeyCode.W then
			MoveForward = not(MoveForward);
		elseif InputObject.KeyCode == Enum.KeyCode.A then
			MoveRight = not(MoveRight);
		elseif InputObject.KeyCode == Enum.KeyCode.S then
			MoveBackward = not(MoveBackward);
		elseif InputObject.KeyCode == Enum.KeyCode.D then
			MoveLeft = not(MoveLeft);
		elseif InputObject.KeyCode == Enum.KeyCode.LeftAlt then
			RotateCamera = not(RotateCamera);		
	end;
 end);

UserInputService.InputEnded:connect(function(InputObject)
	if InputObject.KeyCode == Enum.KeyCode.W then
			MoveForward = not(MoveForward);
		elseif InputObject.KeyCode == Enum.KeyCode.A then
			MoveRight = not(MoveRight);
		elseif InputObject.KeyCode == Enum.KeyCode.S then
			MoveBackward = not(MoveBackward);
		elseif InputObject.KeyCode == Enum.KeyCode.D then
			MoveLeft = not(MoveLeft);
		elseif InputObject.KeyCode == Enum.KeyCode.LeftAlt then
			RotateCamera = not(RotateCamera);	
	end;
end);

local rayCast = function(origin, vector)
	local newRay = Ray.new(origin, vector.unit);
	local part = Workspace:FindPartOnRay(newRay);
 	return part;
end;

local moveCamera = function(forward, backward, left, right)
	local initial = Vector3.new(0, 0, 0);
	if forward then initial = initial + Vector3.new(0, 0, 1); end;
	if backward then initial = initial + Vector3.new(0, 0, -1); end;
	if left then initial = initial + Vector3.new(-1, 0, 0); end;
	if right then initial = initial + Vector3.new(1, 0, 0); end;
	if not(rayCast(Camera.CoordinateFrame.p, initial)) then
		Camera.CoordinateFrame = Camera.CoordinateFrame + initial;
	end
end;

while true do
	moveCamera(MoveForward, MoveBackward, MoveLeft, MoveRight);
	RunService.RenderStepped:wait()
end;