-- =========================================================================
-- BANANA HUB - DIRECT LAUNCH
-- Không Key / Không GetKey / Không Trial / Không vòng quay
-- Chạy trực tiếp script chính.
-- =========================================================================

local TARGET_SCRIPT_URL = "https://raw.githubusercontent.com/napun67/freemiu/refs/heads/main/bana.lua"

local function LaunchMainMenu()
    local ok, source = pcall(function()
        return game:HttpGet(TARGET_SCRIPT_URL)
    end)

    if not ok or type(source) ~= "string" or source == "" then
        warn("[Banana Hub] Không thể tải script chính: " .. tostring(source))
        return
    end

    local compileOk, execute = pcall(loadstring, source)
    if not compileOk or type(execute) ~= "function" then
        warn("[Banana Hub] Không thể biên dịch script chính: " .. tostring(execute))
        return
    end

    local runOk, runError = pcall(execute)
    if not runOk then
        warn("[Banana Hub] Lỗi khi chạy script chính: " .. tostring(runError))
    end
end

LaunchMainMenu()
