local function toogle_terminal()
    if vim.bo.buftype == "terminal" then
        vim.cmd("wincmd p")
        return
    end

    local term_buf = nil;
    local term_win = nil;

    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].buftype == "terminal" then
            term_win = win
            break
        end
    end

    if term_win then
        vim.api.nvim_set_current_win(term_win)
    else
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[buf].buftype == "terminal" then
                term_buf = buf
                break
            end
        end

        if term_buf then
            vim.cmd("vsplit")
            vim.api.nvim_win_set_buf(0, term_buf)
        else
            vim.cmd("vsplit | terminal")
        end
    end
end

vim.keymap.set("n", "<leader>t", toogle_terminal, { noremap = true, silent = true })
