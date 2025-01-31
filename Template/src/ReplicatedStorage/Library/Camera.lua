--Name		: Camera
--Explain	: カメラの位置を調整する
local camera = {}

--カメラのプレイヤーからの高さ
camera.HEIGHT_OFFSET = 2

local currentcamera = workspace.CurrentCamera
local player = game.Players.LocalPlayer

local function check_args(args)
    for i = 4, 6 do
        if args[i] == nil then
            args[i] = 0
        elseif args[i] ~= 0 and args[i] ~= 1 then
            print("Error: (Camera) invalid arguments | rx, ry, rz is a bool value")
            return false
        end
    end
    for i = 1, 6 do
        if typeof(args[i]) ~= "number" then
            print("Error: (Camera) invalid arguments | arguments must be a number")
            return false
        end
    end
    if args[1] == 0 and args[3] == 0 and args[4] == 0 and args[5] == 0 and args[6] == 0 then
        print("Error: (Camera) invalid arguments | you can't render camera")
        return false
    end
    return true
end

local function updateCamera(args)
    local character = player.Character
    if character then
        local root = character:FindFirstChild("HumanoidRootPart")
        if root then
            local rootPosition = root.Position + Vector3.new(0, camera.HEIGHT_OFFSET, 0)
            local x, y, z = args[1], args[2], args[3]
            if args[4] == 1 then
                x = x + rootPosition.X
            end
            if args[5] == 1 then
                y = y + rootPosition.Y
            end
            if args[6] == 1 then
                z = z + rootPosition.Z
            end
            local cameraPosition = Vector3.new(x, y, z)
            currentcamera.CFrame = CFrame.lookAt(cameraPosition, rootPosition)
        end
    end
end

--Function Name	: PlayerCamera
--Explain		: プレイヤーのカメラの位置を設定する
--Arguments| x	: (number)カメラのx座標
--Arguments| y	: (number)カメラのy座標
--Arguments| z	: (number)カメラのz座標
--Arguments| rx	: (bool or nil)x座標について、カメラがプレイヤーについていくようにするかの判定。
--                              1       : プレイヤーから第一引数（x）分離れてカメラがついていくようになる
--                              0 or nil: カメラは第一引数（x）の座標に固定される
--Arguments| ry	: (bool or nil)y座標について、カメラがプレイヤーについていくようにするかの判定。
--                              1       : プレイヤーから第ニ引数（y）分離れてカメラがついていくようになる
--                              0 or nil: カメラは第ニ引数（y）の座標に固定される
--Arguments| rz	: (bool or nil)z座標について、カメラがプレイヤーについていくようにするかの判定。
--                              1       : プレイヤーから第三引数（z）分離れてカメラがついていくようになる
--                              0 or nil: カメラは第三引数（z）の座標に固定される
--Return Value	: none
function camera.PlayerCamera(x, y, z, rx, ry, rz)
    local args = {x, y, z, rx, ry, rz}
    if (check_args(args) == false) then
        return
    end

    local RunService = game:GetService("RunService")
    RunService:BindToRenderStep("SidescrollingCamera", Enum.RenderPriority.Camera.Value + 1, function()updateCamera(args)end)
end

return camera

--*****Please put this LocalScript at StarterPlayerScript*****--

-- local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
-- local camera = lib.camera

-- camera.PlayerCamera(10, 10, 10, 1, 1, 1)

--***********************************************************--
