-- Hyprland pin management for fullscreen
-- Use script-binding in input.conf to bind keys to these commands

local utils = require "mp.utils"
local msg = mp.msg

local was_pinned = false
local window_addr = nil

local function is_hyprland()
    return os.getenv("HYPRLAND_INSTANCE_SIGNATURE") ~= nil
end

local function run_hyprctl(args)
    local cmd = {"hyprctl"}
    for _, arg in ipairs(args) do
        table.insert(cmd, arg)
    end
    local result = utils.subprocess({args = cmd, capture_stdout = true, capture_stderr = true})
    if result.status == 0 then
        return result.stdout:gsub("%s+$", "")
    end
    msg.warn("hyprctl failed: " .. tostring(result.stderr))
    return nil
end

local function run_hyprctl_json(args)
    local full_args = {}
    for _, arg in ipairs(args) do
        table.insert(full_args, arg)
    end
    table.insert(full_args, "-j")
    local output = run_hyprctl(full_args)
    if output then
        local ok, data = pcall(utils.parse_json, output)
        if ok then return data end
    end
    return nil
end

local function get_window_address()
    local data = run_hyprctl_json({"activewindow"})
    if data and data.address then
        return data.address
    end
    return nil
end

local function get_window_info(addr)
    local clients = run_hyprctl_json({"clients"})
    if clients then
        for _, client in ipairs(clients) do
            if client.address == addr then
                return client
            end
        end
    end
    return nil
end

local function is_pinned(addr)
    local info = get_window_info(addr)
    return info and info.pinned == true
end

local function toggle_pin(addr)
    if addr then
        run_hyprctl({"dispatch", "pin", "address:" .. addr})
    end
end

local function toggle_fullscreen_with_pin()
    if not is_hyprland() then
        mp.command("cycle fullscreen")
        return
    end

    local addr = get_window_address()
    local is_fs = mp.get_property_bool("fullscreen")

    msg.info("toggle_fullscreen: addr=" .. tostring(addr) .. " is_fs=" .. tostring(is_fs))

    if not is_fs then
        -- Entering fullscreen
        local pinned = is_pinned(addr)
        msg.info("Entering fullscreen, pinned=" .. tostring(pinned))

        if pinned then
            was_pinned = true
            window_addr = addr
            toggle_pin(addr)
            -- Delay to let Hyprland process the unpin
            mp.add_timeout(0.1, function()
                mp.set_property_bool("fullscreen", true)
            end)
        else
            was_pinned = false
            mp.set_property_bool("fullscreen", true)
        end
    else
        -- Exiting fullscreen
        msg.info("Exiting fullscreen, was_pinned=" .. tostring(was_pinned))
        mp.set_property_bool("fullscreen", false)

        if was_pinned and window_addr then
            mp.add_timeout(0.1, function()
                toggle_pin(window_addr)
                was_pinned = false
                window_addr = nil
            end)
        end
    end
end

-- Register as script-binding (no key - bind in input.conf)
mp.add_key_binding(nil, "hypr-fullscreen", toggle_fullscreen_with_pin)

msg.info("hyprland-pin.lua loaded - use 'script-binding hyprland_pin/hypr-fullscreen' in input.conf")
