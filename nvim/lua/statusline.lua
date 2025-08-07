local M = {}

-- Diagnostics summary (errors and warnings only)
function M.diagnostics()
    local diags = vim.diagnostic.get(0, {
        severity = { min = vim.diagnostic.severity.WARN }
    })

    local num_errors = 0
    for _, v in ipairs(diags) do
        if v.severity == vim.diagnostic.severity.ERROR then
            num_errors = num_errors + 1
        end
    end

    local num_warnings = #diags - num_errors

    if num_errors == 0 and num_warnings == 0 then
        return ""
    elseif num_warnings == 0 then
        return string.format("E: %d ", num_errors)
    elseif num_errors == 0 then
        return string.format("W: %d ", num_warnings)
    else
        return string.format("E: %d W: %d ", num_errors, num_warnings)
    end
end

-- Format buffer name for display
function M.filename(buf, fancy)
    local name = vim.api.nvim_buf_get_name(buf)
    if name == "" then
        name = "Untitled"
    else
        name = name:gsub("%%", "%%%%") -- escape %
    end

    local fname = vim.fn.fnamemodify(name, ":~:.")
    local parent = fname:match("^(.*/)")
    local tail = vim.fn.fnamemodify(name, ":t")

    local parent_hl, tail_hl
    if vim.bo.modified then
        parent_hl, tail_hl = "%1*", "%1*"
    elseif fancy then
        parent_hl, tail_hl = "%2*", "%3*"
    else
        parent_hl, tail_hl = "", ""
    end

    return string.format("%s %%<%s%s%s %%*", parent_hl, parent or "", tail_hl, tail)
end

-- Tabline builder
function M.tabline()
    local items = {}
    local current_tab = vim.fn.tabpagenr()

    for i = 1, vim.fn.tabpagenr("$") do
        local hi = (i == current_tab) and "TabLineSel" or "TabLine"
        local cwd = vim.fn.getcwd(-1, i)
        cwd = vim.fn.fnamemodify(cwd, ":~")
        cwd = vim.fn.pathshorten(cwd)

        table.insert(items, string.format("%%#%s#%%%dT %d %s ", hi, i, i, cwd))
    end

    table.insert(items, "%#TabLineFill#%T")
    return table.concat(items)
end

-- Statusline builder
function M.statusline()
    local buf = vim.api.nvim_get_current_buf()
    local win = vim.api.nvim_get_current_win()
    local term = vim.bo[buf].buftype == "terminal"
    local curwin = tonumber(vim.g.actual_curwin or -1) == win
    local fancy = curwin and not term

    local items = {}

    -- Session info
    if vim.v.this_session ~= "" then
        table.insert(items, " $")
    end

    -- File name
    table.insert(items, M.filename(buf, fancy))

    -- Readonly/Preview flags
    if vim.bo.readonly then table.insert(items, "%r ") end
    if vim.wo.previewwindow then table.insert(items, "%w ") end

    -- Align right
    table.insert(items, "%=")

    -- Diagnostics
    table.insert(items, M.diagnostics())

    if fancy then table.insert(items, "%4*") end

    -- Fileformat and encoding
    if vim.bo.modifiable and not vim.bo.readonly then
        local t = {}

        if vim.bo.fileformat ~= "unix" then
            table.insert(t, vim.bo.fileformat == "dos" and "CRLF" or "CR")
        end

        local fenc = vim.bo.fileencoding
        if fenc ~= "utf-8" and fenc ~= "" then
            table.insert(t, fenc)
        end

        if #t > 0 then
            table.insert(items, " " .. table.concat(t, " ") .. " ")
        end
    end

    if fancy then table.insert(items, "%8*") end

    -- Filetype and LSP client name
    local ft = vim.bo.filetype
    if ft ~= "" then
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then
            table.insert(items, string.format(" %s ", ft))
        else
            local lsp_names = {}
            for _, client in ipairs(clients) do
                table.insert(lsp_names, client.name)
            end
            local lsp_str = table.concat(lsp_names, ",")
            table.insert(items, string.format(" %s/%s ", ft, lsp_str))
        end
    end

    if fancy then table.insert(items, "%9*") end

    -- Cursor position
    table.insert(items, " %l:%c %P ")

    return table.concat(items)
end

return M
