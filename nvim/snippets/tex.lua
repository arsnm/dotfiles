local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    s({ trig = "beg", dscr = "Begin - End environment" }, fmt([[
    \begin{{{}}}{}
        {}
    \end{{{}}}
    ]], {
        i(1, "env"),
        f(function(args)
            local op = args[1][1]
            return op ~= "" and ("[" .. op .. "]") or ""
        end, { 2 }),
        i(0),
        f(function(args) return args[1][1] end, { 1 }),
        i(2), -- The options node
    })),
}
