--------------------------------------------------
-- Bootstrap lazy.nvim
--------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------
-- Plugins
--------------------------------------------------
vim.g.lazy_install = true

require("lazy").setup({
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup({
          highlight = { enable = true },
        })
      end,
    },
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("telescope").setup({})
      end,
    },
    {
      "numToStr/Comment.nvim",
      opts = {},	
    }
}, {install = { missing = true}} )

--------------------------------------------------
-- Core settings
--------------------------------------------------
vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.updatetime = 200
vim.opt.clipboard = "unnamedplus"

--------------------------------------------------
-- LSP (built-in, no plugins)
--------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }
  end,
})

--------------------------------------------------
-- Keymaps
--------------------------------------------------
-- Save
vim.keymap.set({ "n", "i" }, "<C-s>", "<Esc>:w<CR>")

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files)
vim.keymap.set("n", "<C-S-f>", builtin.live_grep)
vim.keymap.set("n", "<C-S-o>", require("telescope.builtin").lsp_workspace_symbols)

-- LSP stuff
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)

-- Toggle comment (Ctrl+/)
vim.keymap.set("n", "<C-/>", "gcc", { remap = true })
vim.keymap.set("v", "<C-/>", "gc",  { remap = true })
