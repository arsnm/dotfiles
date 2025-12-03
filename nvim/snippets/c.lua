local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local function get_guard_name()
    -- Get filename without extension (e.g., "MyCamelCaseFile")
    local filename = vim.fn.expand("%:t:r")

    -- Regex: Find a lowercase letter followed by an uppercase letter
    -- and insert an underscore between them.
    local snake_case = filename:gsub("(%l)(%u)", "%1_%2")

    -- Convert to uppercase and append _H
    return string.upper(snake_case) .. "_H"
end

return {
    s({ trig = "hhead", dscr = "Header Guard with auto-name" }, fmt([[
        #ifndef {}
        #define {}

        {}

        #endif // {}
    ]], {
        f(get_guard_name), -- Generate name
        f(get_guard_name), -- Repeat name
        i(0),              -- Cursor position
        f(get_guard_name)  -- Repeat name
    })),

    s({ trig = "dhead", dscr = "Doxygen File Header" }, fmt([[
        /**
         * @file {}
         * @author {}
         * @brief {}
         * @date {}
         *
         * @copyright Copyright (c) {}
         */

        {}
    ]], {
        f(function() return vim.fn.expand("%:t") end),

        i(1, "arsnm"),

        i(2, "Brief description of the file"),

        f(function() return os.date("%Y-%m-%d") end),

        f(function() return os.date("%Y") end),

        i(0)
    }))
}
