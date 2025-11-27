-- Hyprland pin management for fullscreen
-- Intercepts fullscreen toggle to unpin first, then re-pin on exit

local was_pinned = false
local msg = mp.msg  -- for logging

local function is_hyprland()
    return os.getenv("HYPRLAND_INSTANCE_SIGNATURE") ~= nil
end

local function run_cmd(cmd)
    local handle = io.popen(cmd .. " 2>/dev/null")
    if handle then
        local result = handle:read("*a"):gsub("%s+$", "")
        handle:close()
        return result
    end
    return nil
end

local function get_window_address()
    return run_cmd("hyprctl activewindow -j | jq -r '.address'")
end

local function is_pinned(addr)
    if not addr then return false end
    local result = run_cmd(string.format(
        "hyprctl clients -j | jq -r '.[] | select(.address == \"%s\") | .pinned'", addr))
    return result == "true"
end

local function set_pin(addr, should_pin)
    if not addr then return end
    local currently_pinned = is_pinned(addr)
    if currently_pinned ~= should_pin then
        msg.info("Setting pin to " .. tostring(should_pin) .. " for " .. addr)
        os.execute(string.format("hyprctl dispatch pin address:%s", addr))
    end
end

local function toggle_fullscreen_with_pin()
    if not is_hyprland() then
        -- Not Hyprland, use default behavior
        mp.command("cycle fullscreen")
        return
    end

    local addr = get_window_address()
    local is_fs = mp.get_property_bool("fullscreen")

    msg.info("toggle_fullscreen: addr=" .. tostring(addr) .. " is_fs=" .. tostring(is_fs))

    if not is_fs then
        -- Entering fullscreen
        was_pinned = is_pinned(addr)
        msg.info("Entering fullscreen, was_pinned=" .. tostring(was_pinned))
        if was_pinned then
            set_pin(addr, false)
            -- Small delay to let Hyprland process the unpin
            mp.add_timeout(0.05, function()
                mp.set_property_bool("fullscreen", true)
            end)
        else
            mp.set_property_bool("fullscreen", true)
        end
    else
        -- Exiting fullscreen
        msg.info("Exiting fullscreen, was_pinned=" .. tostring(was_pinned))
        mp.set_property_bool("fullscreen", false)
        if was_pinned then
            -- Re-pin after exiting fullscreen
            mp.add_timeout(0.05, function()
                set_pin(addr, true)
                was_pinned = false
            end)
        end
    end
end

-- Override fullscreen key bindings
mp.add_key_binding("f", "hypr-fullscreen", toggle_fullscreen_with_pin)
mp.add_key_binding("F", "hypr-fullscreen-f", toggle_fullscreen_with_pin)
mp.add_key_binding("ENTER", "hypr-fullscreen-enter", toggle_fullscreen_with_pin)

msg.info("hyprland-pin.lua loaded, Hyprland=" .. tostring(is_hyprland()))
