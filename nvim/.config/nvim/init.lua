if not vim.g.vscode then
-- Edit from https://github.com/mjlbach/defaults.nvim
-- Install packer
local execute = vim.api.nvim_command

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'			-- Package manager
  use 'tpope/vim-fugitive'				-- Git commands in nvim
  use 'tpope/vim-commentary'			-- "gc" to comment visual regions/lines
  use 'tpope/vim-surround'			-- Surround text with delimiters
  use 'tpope/vim-repeat'			-- Repeat last action
  use {'junegunn/fzf'}--, run =  "fzf#install()" }
  use 'junegunn/fzf.vim'
  use 'morhetz/gruvbox' -- gruvbox theme
  use 'srcery-colors/srcery-vim' -- srcery theme
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  use 'neovim/nvim-lspconfig'        -- Collection of configurations for built-in LSP client
  use 'onsails/lspkind-nvim'        -- Collection of configurations for built-in LSP client
  use 'dart-lang/dart-vim-plugin'    -- filetype detection, syntax highlighting, and indentation for Dart code in Vim.
  use 'mfussenegger/nvim-dap' -- debug tool
  use 'f-person/pubspec-assist-nvim' -- assist insert pubspec
  use 'f-person/nvim-sort-dart-imports' -- sort imports for dart
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground' -- playground with treesitter
  use 'tamago324/compe-zsh' --zsh source for compe
  use 'kevinhwang91/nvim-bqf' -- quickfix better
  use 'gennaro-tedesco/nvim-jqx' -- view json
  use {'kevinhwang91/nvim-hlslens'} -- search highlight
  use {'windwp/nvim-autopairs'} -- autopair
  use {"npxbr/glow.nvim", run = ":GlowInstall"} -- preview markdown
  use {'ggandor/leap.nvim'} -- quick jump
  use {
  'nvim-lualine/lualine.nvim',
  requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  -- Install nvim-cmp, and buffer source as a dependency
  use {
	"hrsh7th/nvim-cmp",
	commit = "99ef854322d0de9269044ee197b6c9ca14911d96",
	requires = {
		'neovim/nvim-lspconfig',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'SirVer/ultisnips',
		'quangnguyen30192/cmp-nvim-ultisnips',
	}
  }
  use {
  'kyazdani42/nvim-tree.lua', -- file manager
  requires = "kyazdani42/nvim-web-devicons",
  }
  use {'psf/black', tag='stable'}   -- python format
  use 'reisub0/hot-reload.vim' -- hot reload flutter when save
  use("petertriho/nvim-scrollbar") -- scrollbar
  use {
  "folke/trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("trouble").setup {
		mode = "document_diagnostics"
    }
  end
}
end)


--Incremental live completion
vim.o.inccommand = "nosplit"

--Set highlight on search
vim.o.hlsearch = true
vim.o.incsearch = true

--Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

--Do not save when switching buffers
vim.o.hidden = true

-- Some tab space
vim.o.tabstop=2
vim.o.softtabstop=2
vim.o.shiftwidth=2


--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.cmd[[set undofile]]

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn="yes"

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd[[colorscheme gruvbox]]
-- vim.cmd[[colorscheme srcery]]

--Remap tab on ultisnips so we can use tab for complete
vim.g.UltiSnipsExpandTrigger="C-<tab>"
vim.g.UltiSnipsJumpForwardTrigger="<c-b>"
vim.g.UltiSnipsJumpBackwardTrigger="<c-z>"
vim.g.UltiSnipsSnippetsDir = "~/.vim/ultisnip"
vim.g.UltiSnipsEditSplit="vertical"
--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap=true, expr = true, silent = true})
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", {noremap= true, expr = true, silent = true})

--Remap escape to leave terminal mode
vim.api.nvim_set_keymap('t', '<Esc>', [[<c-\><c-n>]], {noremap = true})

--Add map to enter paste mode
vim.o.pastetoggle="<F3>"

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile'}
vim.g.indent_blankline_char_highlight = 'LineNr'

-- Toggle to disable mouse mode and indentlines for easier paste
ToggleMouse = function()
  if vim.o.mouse == 'a' then
    vim.cmd[[IndentBlanklineDisable]]
    vim.wo.signcolumn='no'
    vim.o.mouse = 'v'
    vim.wo.number = false
    print("Mouse disabled")
  else
    vim.cmd[[IndentBlanklineEnable]]
    vim.wo.signcolumn='yes'
    vim.o.mouse = 'a'
    vim.wo.number = true
    print("Mouse enabled")
  end
end

-- leap
require('leap').set_default_keymaps()

vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua ToggleMouse()<cr>', { noremap = true })

--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader>f', [[<cmd>FZF<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>Buffers<cr>]], { noremap = true, silent = true})

-- Change preview window location
vim.g.splitbelow = true

-- add commentstring to tpope/vim-commentary
vim.api.nvim_exec([[
  augroup Commentary
    autocmd!
    autocmd FileType typescript setlocal commentstring=/*\ %s\ */
    autocmd FileType typescriptreact setlocal commentstring=/*\ %s\ */
  augroup end
]], false)

-- Highlight on yank
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true})
--
-- LSP settings
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local nvim_lsp = require('lspconfig')
local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist({workspace = true})<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<esc><esc>', '<cmd>noh<CR>', opts)
end

local sumneko_root_path = vim.fn.getenv("HOME").."/dev/projects/lua-language-server" -- Change to your sumneko root installation
local sumneko_binary_path = "/bin/macOS/lua-language-server" -- Change to your OS specific output folder
nvim_lsp.sumneko_lua.setup {
  cmd = {sumneko_root_path .. sumneko_binary_path, "-E", sumneko_root_path.."/main.lua" };
  on_attach = on_attach,
  settings = {
      Lua = {
          runtime = {
              version = 'LuaJIT',
              path = vim.split(package.path, ';'),
          },
          diagnostics = {
              globals = {'vim'},
          },
          workspace = {
              library = {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
              },
          },
      },
  },
}
-- vuejs
nvim_lsp.vuels.setup{
	on_attach = on_attach;
	capabilities = capabilities;
}

-- swift
nvim_lsp.sourcekit.setup{
	on_attach = on_attach;
	capabilities = capabilities;
}
-- javascript
nvim_lsp.tsserver.setup{
	on_attach = on_attach;
	capabilities = capabilities;
}
-- rust
nvim_lsp.rust_analyzer.setup{
	on_attach = on_attach;
	capabilities = capabilities;
}

-- Setup flutter

nvim_lsp.dartls.setup{
  cmd = { "dart", vim.fn.getenv("FLUTTER").."/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp" };
	capabilities = capabilities;
  on_attach = on_attach;
  settings = {
    closingLabels  = true,
    flutterOutline = true,
  };
  init_options = {
	closingLabels = true,
	flutterOutline = true,
	onlyAnalyzeProjectsWithOpenFiles = false,
	outline = true,
	suggestFromUnimportedLibraries = true
  };
}
-- setup pyright
nvim_lsp.pyright.setup{
	on_attach = on_attach;
	capabilities = capabilities;
}
nvim_lsp.bashls.setup{
	on_attach = on_attach;
	capabilities = capabilities;
}
 -- setup kotlin
nvim_lsp.kotlin_language_server.setup{
	on_attach = on_attach;
	capabilities = capabilities;
}

-- setup gopls
nvim_lsp.gopls.setup{
  on_attach = on_attach;
	capabilities = capabilities;
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}
---@diagnostic disable-next-line: lowercase-global
function go_org_imports(wait_ms)
	local params = vim.lsp.util.make_range_params()
	params.context = {only = {"source.organizeImports"}}
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
	for cid, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
				vim.lsp.util.apply_workspace_edit(r.edit, enc)
			end
		end
	end
end

-- Map :Format to vim.lsp.buf.formatting()
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])

-- Set completeopt to have a better completion experience
vim.o.completeopt="menu,menuone,noselect"

-- format after save
-- autocmd BufWritePre *.py Black
-- autocmd BufWritePre *.dart lua vim.lsp.buf.formatting_sync(nil,1000)
vim.api.nvim_exec([[
  augroup FormatAfterSave
    autocmd!
	autocmd BufWrite *.dart :DartSortImports
	autocmd BufWritePre *.go lua go_org_imports()
	autocmd BufWritePre *.dart lua vim.lsp.buf.formatting_sync(nil,1000)
  augroup end
]], false)
---------------NVIM TREE---------------------------------
require'nvim-tree'.setup {
  hijack_cursor = true,
  update_cwd = false,
  actions = {
    open_file = {
      quit_on_open = true,
    },
    change_dir = {
      enable = false,
      global = false,
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  -- disables netrw completely
  disable_netrw       = true,
  -- hijack netrw window on startup
  hijack_netrw        = true,
  -- open the tree when running this setup function
  open_on_setup       = false,
  -- will not open on setup if the filetype is in this listtreesitter
  ignore_ft_on_setup  = {},
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = false,
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },
   -- show lsp diagnostics in the signcolumn
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },

  view = {
    -- width of the window, can be either a number (columns) or a string in `%`
    width = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {}
    }
  }
}

require'nvim-treesitter.configs'.setup{}

-- open nvim tree
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", {})
 -- setup key for trouble
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)

local wr_group = vim.api.nvim_create_augroup('WinResize', { clear = true })

vim.api.nvim_create_autocmd(
    'VimResized',
    {
        group = wr_group,
        pattern = '*',
        command = 'wincmd =',
        desc = 'Automatically resize windows when the host window size changes.'
    }
)

-- " a list of groups can be found at `:help nvim_tree_highlight`
-- highlight NvimTreeFolderIcon guibg=blue

require('nvim-autopairs').setup{}

-- config scrollbar
require('hlslens').setup({
    calm_down = true,
    nearest_only = true,
    nearest_float_when = 'always'
})
require("scrollbar").setup()
-- setup cmp
require("cmp_conf")
require("lualine_conf")
require("dap_conf")
end
