-- Hyprland pin management for fullscreen
-- Automatically unpins window before fullscreen, restores after

local was_pinned = false

local function is_hyprland()
    return os.getenv("HYPRLAND_INSTANCE_SIGNATURE") ~= nil
end

local function get_window_address()
    local handle = io.popen("hyprctl activewindow -j 2>/dev/null | jq -r '.address'")
    if handle then
        local result = handle:read("*a"):gsub("%s+", "")
        handle:close()
        if result ~= "" and result ~= "null" then
            return result
        end
    end
    return nil
end

local function is_pinned(addr)
    local handle = io.popen(string.format("hyprctl clients -j | jq -r '.[] | select(.address == \"%s\") | .pinned'", addr))
    if handle then
        local result = handle:read("*a"):gsub("%s+", "")
        handle:close()
        return result == "true"
    end
    return false
end

local function set_pin(addr, pin)
    local current = is_pinned(addr)
    if current ~= pin then
        os.execute(string.format("hyprctl dispatch pin address:%s", addr))
    end
end

local function on_fullscreen_change(name, value)
    if not is_hyprland() then return end

    local addr = get_window_address()
    if not addr then return end

    if value then
        -- Entering fullscreen: remember and unpin
        was_pinned = is_pinned(addr)
        if was_pinned then
            set_pin(addr, false)
        end
    else
        -- Exiting fullscreen: restore pin state
        if was_pinned then
            set_pin(addr, true)
            was_pinned = false
        end
    end
end

mp.observe_property("fullscreen", "bool", on_fullscreen_change)
