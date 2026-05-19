local mainMod = "SUPER"
local uwsm = "uwsm app -- "

-- Programs
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "fuzzel"
local browser = "google-chrome"

hl.bind(
    mainMod .. " + SHIFT + Q",
    hl.dsp.window.close()
)
hl.bind(
    mainMod .. " + SHIFT + M",
    hl.dsp.exit()
)
hl.bind(
    mainMod .. " + M",
    hl.dsp.exec_cmd(uwsm .. "hyprlock")
)

hl.bind(
    mainMod .. " + Return",
    hl.dsp.exec_cmd(uwsm .. terminal)
)
hl.bind(
    mainMod .. " + G",
    hl.dsp.exec_cmd(uwsm .. browser)
)
hl.bind(
    mainMod .. " + E",
    hl.dsp.exec_cmd(uwsm .. fileManager)
)
hl.bind(
    "ALT + space",
    hl.dsp.exec_cmd(uwsm .. menu)
)
hl.bind(
    mainMod .. " + V",
    hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy")
)

hl.bind(
    mainMod .. " + F",
    hl.dsp.window.fullscreen()
)
hl.bind(
    mainMod .. " + I",
    hl.dsp.window.float({ action = "toogle" })
)
hl.bind(
    mainMod .. " + P",
    hl.dsp.window.pseudo()
)
hl.bind(
    mainMod .. " + O",
    hl.dsp.layout("togglesplit")
)

hl.bind(
    mainMod .. " + J",
    hl.dsp.focus({ direction = "down"})
)
hl.bind(
    mainMod .. " + K",
    hl.dsp.focus({ direction = "up"})
)
hl.bind(
    mainMod .. " + H",
    hl.dsp.focus({ direction = "left"})
)
hl.bind(
    mainMod .. " + L",
    hl.dsp.focus({ direction = "right"})
)

hl.bind(
    mainMod .. " + SHIFT + J",
    hl.dsp.window.move({ direction = "down"})
)
hl.bind(
    mainMod .. " + SHIFT + K",
    hl.dsp.window.move({ direction = "up"})
)
hl.bind(
    mainMod .. " + SHIFT + H",
    hl.dsp.window.move({ direction = "left"})
)
hl.bind(
    mainMod .. " + SHIFT + L",
    hl.dsp.window.move({ direction = "right"})
)

for i = 1, 10 do
    local key = i % 10 -- 10 maps to 0
    hl.bind(
        mainMod .. " + " .. key,
        hl.dsp.focus({ workspace = i })
    )
    hl.bind(
        mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i })
    )
end

hl.bind(
    mainMod .. " + period",
    hl.dsp.focus({ workspace = "e+1" })
)
hl.bind(
    mainMod .. " + comma",
    hl.dsp.focus({ workspace = "e-1" })
)
hl.bind(
    mainMod .. " + mouse_up",
    hl.dsp.focus({ workspace = "e+1" })
)
hl.bind(
    mainMod .. " + mouse_down",
    hl.dsp.focus({ workspace = "e-1" })
)

hl.bind(
    mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true }
)
hl.bind(
    mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true }
)

-- Screen mode
-- 
