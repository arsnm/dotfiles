local ls = require("luasnip")
local s = ls.snippet

return {
    s({ trig = "arm_head", dscr = "ARM Cortex-M4 assembly header" }, {
        ".syntax unified",
        ".arch armv7e-m",
        ".cpu cortex-m4",
        "",
        ".thumb",
        "",
        ".global _start",
        "",
        "_start:",
        "\t"
    })
}
