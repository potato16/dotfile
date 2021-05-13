-------------------- HELPERS -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-------------------- PLUGINS -------------------------------
cmd 'packadd paq-nvim'               -- load the package manager
local paq = require('paq-nvim').paq  -- a convenient alias
paq {'savq/paq-nvim', opt = true}    -- paq-nvim manages itself
paq {'shougo/deoplete-lsp'}
paq {'shougo/deoplete.nvim', run = fn['remote#host#UpdateRemotePlugins']}
paq {'nvim-treesitter/nvim-treesitter'}
paq {'nvim-lua/plenary.nvim'} -- require for flutter-tools, telescope, dap
paq {'akinsho/flutter-tools.nvim'}
paq {'neovim/nvim-lspconfig'}
paq {'junegunn/fzf', run = fn['fzf#install']}
paq {'junegunn/fzf.vim'}
paq {'ojroques/nvim-lspfuzzy'}
paq {'morhetz/gruvbox'}
paq {'mfussenegger/nvim-dap'}
paq {'rcarriga/nvim-dap-ui'}
paq {'lewis6991/gitsigns.nvim'}
paq {'kosayoda/nvim-lightbulb'}
paq {'nvim-lua/popup.nvim'} -- require for telescope
paq {'nvim-telescope/telescope.nvim'}
paq {'preservim/nerdtree'}
g['deoplete#enable_at_startup'] = 1  -- enable deoplete at startup

-------------------- OPTIONS -------------------------------
local indent = 4
cmd 'colorscheme desert'                              -- Put your favorite colorscheme here
opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
opt('o', 'completeopt', 'menuone,noinsert,noselect')  -- Completion options (for deoplete)
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('o', 'ignorecase', true)                          -- Ignore case
opt('o', 'joinspaces', false)                         -- No double spaces with join after a dot
opt('o', 'scrolloff', 4 )                             -- Lines of context
opt('o', 'shiftround', true)                          -- Round indent
opt('o', 'sidescrolloff', 8 )                         -- Columns of context
opt('o', 'smartcase', true)                           -- Don't ignore case with capitals
opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current
opt('o', 'termguicolors', true)                       -- True color support
opt('o', 'wildmode', 'list:longest')                  -- Command-line completion mode
opt('w', 'list', true)                                -- Show some invisible characters (tabs...)
opt('w', 'number', true)                              -- Print line number
opt('w', 'relativenumber', true)                      -- Relative line numbers
opt('w', 'wrap', false)                               -- Disable line wrap

-------------------- MAPPINGS ------------------------------
-- map('', '<leader>c', '"+y')       -- Copy to clipboard in normal, visual, select and operator modes
-- map('i', '<C-u>', '<C-g>u<C-u>')  -- Make <C-u> undo-friendly
-- map('i', '<C-w>', '<C-g>u<C-w>')  -- Make <C-w> undo-friendly

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<C-l>', '<cmd>noh<CR>')    -- Clear highlights
map('n', '<leader>o', 'm`o<Esc>``')  -- Insert a newline in normal mode

-------------------- TREE-SITTER ---------------------------
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}

-------------------- LSP -----------------------------------
local lsp = require 'lspconfig'
local lspfuzzy = require 'lspfuzzy'

-- For golang lsp
lsp.gopls.setup{
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        }
    }
}


-- LSP for dart lang
-- lsp.dartls.setup{
--     cmd = { "dart", "/Users/thaohan/dev/projects/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp" },
--}
require("flutter-tools").setup {
  experimental = { -- map of feature flags
    lsp_derive_paths = false, -- experimental: Attempt to find the user's flutter SDK
  },
  debugger = { -- experimental: integrate with nvim dap
    enabled = true,
  },
  flutter_path = "/home/sai/dev/projects/flutter/bin/flutter", -- <-- this takes priority over the lookup
  flutter_lookup_cmd ="dirname $(which flutter)", -- example "dirname $(which flutter)" or "asdf where flutter"
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    -- highlight = "ErrorMsg", -- highlight for the closing tag
    -- prefix = ">", -- character to use for close tag e.g. > Widget
    enabled = true -- set to false to disable
  },
  dev_log = {
    open_cmd = "tabedit", -- command to use to open the log buffer
  },
  outline = {
    open_cmd = "30vnew", -- command to use to open the outline buffer
  },
  lsp = {
    on_attach = my_custom_on_attach,
    capabilities = my_custom_capabilities, -- e.g. lsp_status capabilities
    settings = {
      showTodos = true,
      completeFunctionCalls = true -- NOTE: this is WIP and doesn't work currently
    }
  }
}

require("dapui").setup({
  icons = {
    expanded = "⯆",
    collapsed = "⯈",
    circular = "↺"
  },
  mappings = {
    expand = "<CR>",
    open = "o",
    remove = "d"
  },
  sidebar = {
    elements = {
      -- You can change the order of elements in the sidebar
      "scopes",
      "stacks",
      "watches"
    },
    width = 40,
    position = "left" -- Can be "left" or "right"
  },
  tray = {
    elements = {
      "repl"
    },
    height = 10,
    position = "bottom" -- Can be "bottom" or "top"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil   -- Floats will be treated as percentage of your screen.
  }
})

-- root_dir is where the LSP server will start: here at the project root otherwise in current folder
lsp.pyls.setup {root_dir = lsp.util.root_pattern('.git', fn.getcwd())}
lspfuzzy.setup {}  -- Make the LSP client use FZF instead of the quickfix list
require('gitsigns').setup() -- git helper

map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

-- map for telescope
map('','<leader>ff','<cmd>lua require("telescope.builtin").find_files()<cr>')
map('','<leader>fg','<cmd>lua require("telescope.builtin").live_grep()<cr>')
map('','<leader>fb','<cmd>lua require("telescope.builtin").buffers()<cr>')
map('','<leader>fh','<cmd>lua require("telescope.builtin").help_tags()<cr>')
map('','<leader>fe','<cmd>lua require("telescope.builtin").file_browser()<cr>')

-------------------- COMMANDS ------------------------------
cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'  -- disabled in visual mode
cmd 'autocmd vimenter * colorscheme gruvbox' -- set theme gruvbox
cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]] -- show a lightbulb if a code action is available at the current cursor position
