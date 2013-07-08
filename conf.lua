function love.conf(t)
    t.title = "Perudo"        -- The title of the window the game is in (string)
    t.author = "TechTuts"        -- The author of the game (string)

    t.console = false           -- Attach a console (boolean, Windows only)
    t.release = false           -- Enable release mode (boolean)
    t.screen.vsync = true       -- Enable vertical sync (boolean)
    t.screen.fsaa = 2           -- The number of FSAA-buffers (number)
end