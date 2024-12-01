-- Yêu cầu thư viện GUI
local library = loadstring(game:HttpGet("https://pastebin.com/raw/w1UxNa8X"))() -- Thay URL bằng thư viện GUI của bạn

-- Tạo cửa sổ menu
local window = library:CreateWindow("Roblox Menu") -- Tên cửa sổ

-- Tạo folder chức năng
local actions = window:CreateFolder("Player Actions") -- Tên nhóm chức năng

-- Biến lưu giá trị
local speedValue = 16
local jumpValue = 50
local teleportPos = nil

-- Tạo các box và toggle
actions:Box("Speed", "number", function(value)
    speedValue = tonumber(value) or 16
end)

actions:Box("Jump", "number", function(value)
    jumpValue = tonumber(value) or 50
end)

actions:Toggle("Enable Speed", function(enabled)
    getgenv().EnableSpeed = enabled
    if enabled then
        while getgenv().EnableSpeed do
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = speedValue
            end
            wait()
        end
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 -- Tốc độ mặc định
    end
end)

actions:Toggle("Enable Jump", function(enabled)
    getgenv().EnableJump = enabled
    if enabled then
        while getgenv().EnableJump do
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.JumpPower = jumpValue
            end
            wait()
        end
    else
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50 -- JumpPower mặc định
    end
end)

-- Reset Character
local reset = window:CreateFolder("Reset Character")
reset:Toggle("Kill", function(state)
    if state then
        game.Players.LocalPlayer.Character.Humanoid.Health = 0 -- Tự sát
    else
        game.Players.LocalPlayer.Character.Humanoid.Health = 100 -- Hồi máu
    end
end)

-- Teleport chức năng
local teleport = window:CreateFolder("Teleport")
teleport:Box("Teleport X,Y,Z", "string", function(value)
    local coords = string.split(value, ",")
    if #coords == 3 then
        teleportPos = Vector3.new(tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3]))
    end
end)

teleport:Button("Teleport", function()
    if teleportPos then
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(teleportPos)
        end
    else
        print("Vui lòng nhập tọa độ chính xác!")
    end
end)

-- Kết thúc script
window:DestroyGui()