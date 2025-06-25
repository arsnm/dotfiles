local keymap = vim.keymap

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

keymap.set("n", "J", "mzJ`z", { desc = "Join the current line with the next" })
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-d>", "<C-d>zz")

keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("n", "=ap", "ma=ap'a")

keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>", { desc = "Restart lsp" })
keymap.set("n", "<leader>ls", "<cmd>LspStart<cr>", { desc = "Start lsp" })
keymap.set("n", "<leader>lx", "<cmd>LspStop<cr>", { desc = "Stop lsp" })

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

keymap.set("x", "<leader>p", [["_dP]])
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])
keymap.set({ "n", "v" }, "<leader>d", "\"_d")

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlight" })

local function open_terminal_vertical()
    vim.cmd("vsplit")
    vim.cmd("terminal")
end

keymap.set(
    "n",
    "<leader>nt",
    "<cmd> lua open_terminal_vertical()<CR>",
    { noremap = true, silent = true, desc = "Open a new terminal in a vertical split" }
)
