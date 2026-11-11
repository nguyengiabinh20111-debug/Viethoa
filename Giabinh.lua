-- Ajjans V3 gốc
local source = "https://raw.githubusercontent.com/gojosatoru751/scriptdz/refs/heads/main/AjjansV3.lua"
local ok, err = pcall(function()
    loadstring(game:HttpGet(source))()
end)

if not ok then
    warn("[Ajjans VN] Không tải được script gốc: " .. tostring(err))
    return
end

-- Lớp Việt hóa giao diện chạy sau script gốc
-- Ajjans Vietnamese UI helper (community translation layer)
-- Run AFTER the original Ajjans loader.
-- This only replaces visible Roblox TextLabel/TextButton/TextBox text.
-- It does not modify the original script's automation or game logic.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local translations = {
    ["Main"] = "Chính",
    ["Automation"] = "Tự động hóa",
    ["Events"] = "Sự kiện",
    ["Predictor"] = "Dự đoán",
    ["Misc"] = "Khác",
    ["Search..."] = "Tìm kiếm...",
    ["Search... "] = "Tìm kiếm...",
    ["Keep Eggs"] = "Giữ trứng",
    ["Eggs To Keep"] = "Trứng cần giữ",
    ["Keep Matching Eggs"] = "Giữ trứng phù hợp",
    ["Keep Min $/s"] = "Giữ mức thu nhập tối thiểu",
    ["Rarities To Keep"] = "Độ hiếm cần giữ",
    ["Keeping no eggs"] = "Không giữ trứng nào",
    ["Fuse Rarities"] = "Độ hiếm để hợp nhất",
    ["Fuse Mutations"] = "Đột biến để hợp nhất",
    ["Pick Group By"] = "Nhóm theo",
    ["Highest Rarity"] = "Độ hiếm cao nhất",
    ["Highest Value"] = "Giá trị cao nhất",
    ["Never Fuse Mutated"] = "Không hợp nhất trứng đột biến",
    ["Never Fuse Equipped"] = "Không hợp nhất thú đang trang bị",
    ["Auto Complete Reveal"] = "Tự động hoàn tất mở",
    ["Fuse Now"] = "Hợp nhất ngay",
    ["Rewards"] = "Phần thưởng",
    ["Presets"] = "Thiết lập sẵn",
    ["WEAKEST EQUIPPED"] = "YẾU NHẤT ĐANG TRANG BỊ",
    ["Slots"] = "Ô",
    ["Auto Complete Missing Index"] = "Tự hoàn tất mục lục còn thiếu",
    ["Leaderboard Mode"] = "Chế độ bảng xếp hạng",
    ["Eggs"] = "Trứng",
    ["Pets"] = "Thú cưng",
    ["Task Priority"] = "Ưu tiên nhiệm vụ",
    ["Reset"] = "Đặt lại",
    ["Top runs first"] = "Ưu tiên nhiệm vụ ở trên",
    ["Carried eggs are delivered first"] = "Trứng đang mang sẽ được giao trước",
    ["Steal Eggs"] = "Trộm trứng",
    ["Catch Shooting Stars"] = "Bắt sao băng",
    ["Cosmic Eclipse"] = "Nhật thực vũ trụ",
    ["Hit Players"] = "Đánh người chơi",
    ["Alien Fishing"] = "Câu cá ngoài hành tinh",
    ["Catch Butterflies"] = "Bắt bướm",
    ["Priority Settings"] = "Cài đặt ưu tiên",
    ["Queue:"] = "Hàng đợi:",
    ["Rotate Fishing And Treadmill"] = "Luân phiên câu cá và máy chạy bộ",
    ["Rotation Switch"] = "Chế độ luân phiên",
    ["Timer"] = "Bộ hẹn giờ",
    ["Fishing Minutes: 5 min"] = "Thời gian câu cá: 5 phút",
    ["Treadmill Minutes: 5 min"] = "Thời gian máy chạy bộ: 5 phút",
    ["Auto Hatch"] = "Tự động ấp",
    ["Categories"] = "Danh mục",
    ["Rarities"] = "Độ hiếm",
    ["Mutations"] = "Đột biến",
    ["Priority"] = "Mức ưu tiên",
    ["Min $/s (0 = any)"] = "Thu nhập tối thiểu (0 = bất kỳ)",
    ["Auto Hatch Selected"] = "Tự ấp mục đã chọn",
    ["Auto Hatch All"] = "Tự ấp tất cả",
    ["Auto Place"] = "Tự động đặt",
    ["Auto Place Selected"] = "Tự đặt mục đã chọn",
    ["Auto Place All"] = "Tự đặt tất cả",
    ["Place Eggs"] = "Đặt trứng",
    ["Mutate Eggs"] = "Tạo đột biến trứng",
    ["Treadmill Training"] = "Huấn luyện máy chạy bộ",
    ["Drop Eggs At Safe Zone"] = "Thả trứng tại vùng an toàn",
    ["Sell Cheapest Egg When Full"] = "Bán trứng rẻ nhất khi đầy",
    ["Only Below /s"] = "Chỉ dưới mức /giây",
    ["Steal Single Best Egg"] = "Trộm trứng tốt nhất",
    ["Tween To Safezone"] = "Di chuyển đến vùng an toàn",
    ["Server Hop"] = "Đổi máy chủ",
    ["Enable Server Hop"] = "Bật tự động đổi máy chủ",
    ["Hop When"] = "Đổi máy chủ khi",
    ["No Matching Eggs"] = "Không có trứng phù hợp",
    ["1 Player Server"] = "Máy chủ 1 người",
    ["Method"] = "Phương thức",
    ["Instant Steal"] = "Trộm tức thì",
    ["Auto Steal Selected"] = "Tự trộm mục đã chọn",
    ["Auto Steal All"] = "Tự trộm tất cả",
    ["Teleport To Egg"] = "Dịch chuyển đến trứng",
    ["Teleport Areas"] = "Khu vực dịch chuyển",
    ["Steal From Other Scripts"] = "Trộm từ script khác",
    ["Less Delivery Fails"] = "Giảm lỗi giao trứng",
    ["Auto Hit Player"] = "Tự động đánh người chơi",
    ["Steal Eggs"] = "Trộm trứng",
    ["Defense"] = "Phòng thủ",
    ["Trails"] = "Vệt hiệu ứng",
    ["Kill Aura"] = "Hào quang tấn công",
    ["Tool Swap"] = "Đổi công cụ",
    ["Use Index Tools"] = "Dùng công cụ trong mục lục",
    ["Auto Hit"] = "Tự động đánh",
    ["Hit Who"] = "Đánh ai",
    ["Nearest player"] = "Người chơi gần nhất",
    ["Chosen Player"] = "Người chơi được chọn",
    ["Chase Speed: 400"] = "Tốc độ đuổi: 400",
    ["Skip Friends"] = "Bỏ qua bạn bè",
    ["Anti-Ragdoll"] = "Chống ngã",
    ["Anti-Hit"] = "Chống bị đánh",
    ["Anti-Trap"] = "Chống bẫy",
    ["Upgrades"] = "Nâng cấp",
    ["Auto Equip Best Pet"] = "Tự trang bị thú cưng tốt nhất",
    ["Auto Treadmill Training"] = "Tự huấn luyện máy chạy bộ",
    ["Auto Treadmill Upgrade"] = "Tự nâng cấp máy chạy bộ",
    ["Auto Base Upgrade"] = "Tự nâng cấp căn cứ",
    ["Cash Reserve"] = "Tiền dự trữ",
    ["Select options..."] = "Chọn tùy chọn...",
    ["Select options... "] = "Chọn tùy chọn...",
    ["Off"] = "Tắt",
    ["Idle - nothing to do"] = "Chờ - không có việc",
    ["Idle"] = "Đang chờ",
    ["On"] = "Bật",
    ["off"] = "tắt",
}

local function translate(text)
    if translations[text] then
        return translations[text]
    end

    -- Common dynamic labels with changing numbers/values.
    local n = text:match("^Slots (%d+/%d+)$")
    if n then return "Ô " .. n end

    local idx = text:match("^Index (%d+)$")
    if idx then return "Mục lục " .. idx end

    local ping = text:match("^PING:%s*(%d+ms)$")
    if ping then return "PING: " .. ping end

    local ver = text:match("^VER:%s*(.+)$")
    if ver then return "PHIÊN BẢN: " .. ver end

    local selected = text:match("^(%d+) selected$")
    if selected then return "Đã chọn " .. selected end

    local min = text:match("^Min %$/(s.*)$")
    if min then return "Thu nhập tối thiểu /" .. min end

    return text
end

local function translateObject(obj)
    if not (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) then
        return
    end

    local ok, current = pcall(function() return obj.Text end)
    if not ok or type(current) ~= "string" or current == "" then return end

    local replacement = translate(current)
    if replacement ~= current then
        pcall(function() obj.Text = replacement end)
    end

    -- Re-translate if the original UI updates this text later.
    if not obj:GetAttribute("VNTranslatorConnected") then
        pcall(function() obj:SetAttribute("VNTranslatorConnected", true) end)
        obj:GetPropertyChangedSignal("Text"):Connect(function()
            local success, value = pcall(function() return obj.Text end)
            if not success or type(value) ~= "string" then return end
            local newValue = translate(value)
            if newValue ~= value then
                pcall(function() obj.Text = newValue end)
            end
        end)
    end
end

local function scan(root)
    for _, obj in ipairs(root:GetDescendants()) do
        translateObject(obj)
    end
    root.DescendantAdded:Connect(function(obj)
        task.defer(translateObject, obj)
        for _, child in ipairs(obj:GetDescendants()) do
            task.defer(translateObject, child)
        end
    end)
end

-- Scan both common executor UI containers.
pcall(function() scan(CoreGui) end)
pcall(function()
    if player and player:FindFirstChildOfClass("PlayerGui") then
        scan(player:FindFirstChildOfClass("PlayerGui"))
    end
end)

-- Re-scan briefly because some hubs create their UI after the loader runs.
task.spawn(function()
    for _ = 1, 20 do
        task.wait(1)
        pcall(function() scan(CoreGui) end)
        pcall(function()
            if player and player:FindFirstChildOfClass("PlayerGui") then
                scan(player:FindFirstChildOfClass("PlayerGui"))
            end
        end)
    end
end)

print("[Ajjans VN] Đã bật lớp Việt hóa giao diện. Nếu một số chữ không đổi, UI có thể không dùng TextLabel/TextButton/TextBox.")
