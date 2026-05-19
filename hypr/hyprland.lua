-- Hyprland global configuration
-- by @arsnm

-- Monitors
hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@240",
    position = "0x0",
    scale = "1",
})

-- Programs
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "fuzzel"
local browser = "google-chrome"

-- Environment variables
hl.env("XCURSOR_SIZE", "8")
hl.env("XCURSOR_THEME", "Cross-overwrite")
hl.env("HYPRCURSOR_SIZE", "8")
hl.env("HYPRCURSOR_THEME", "Cross-overwrite")

-- Look and feel
hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 2,

        border_size = 1,

        col = {
            active_border = "rgba(ffdd33ee)",
            inactive_border = "rgba(181818aa)",
        },

        resize_on_border = false,
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 1,
        rounder_power = 2.,

        active_opacity = 1.,
        inactive_opacity = 0.8,
        fullscreen_opacity = 1.,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled = false,
        },

        animations = {
            enabled = false,
        },
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },

    -- Input
    input = {
        kb_layout = "us, us",
        kb_varient = ", intl",
        kb_options = "caps:swapescape, grp:rctrl_rshift_toggle",
        repeat_delay = 140,
        repeat_rate = 45,

        follow_mouse = 1,

        sensitivity = 0,
    },
})

-- Binds
require("binds")

