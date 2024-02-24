hs.hotkey.bind({}, "²", function()
    local app = hs.application.get("kitty")

    if app then
        if not app:mainWindow() then
            app:selectMenuItem({"kitty", "New OS window"})
        elseif app:isFrontmost() then
            app:hide()
        else
            app:activate()
        end
    else
        hs.application.launchOrFocus("kitty")
        app = hs.application.get("kitty")
    end

    app:mainWindow().setShadows(false)
  end)

hs.hotkey.bind({"ctrl", "alt"}, "R", function()
    hs.execute("/Users/andrei/drive/bin/randomtab", true)
end)
