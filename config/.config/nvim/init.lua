if not vim.g.vscode then
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
  use 'numToStr/Comment.nvim'			-- "gc" to comment visual regions/lines
  use 'tpope/vim-surround'			-- Surround text with delimiters
  use 'tpope/vim-repeat'			-- Repeat last action
  use 'morhetz/gruvbox' -- gruvbox theme
	use 'windwp/nvim-ts-autotag' -- autoclose and autorename html tag
  use 'srcery-colors/srcery-vim' -- srcery theme
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
}
  use 'neovim/nvim-lspconfig'        -- Collection of configurations for built-in LSP client
  use 'onsails/lspkind-nvim'        -- Collection of configurations for built-in LSP client
  use 'dart-lang/dart-vim-plugin'    -- filetype detection, syntax highlighting, and indentation for Dart code in Vim.
  use 'mfussenegger/nvim-dap' -- debug tool
  use 'f-person/nvim-sort-dart-imports' -- sort imports for dart
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'kevinhwang91/nvim-bqf' , ft = 'qf'} -- quickfix better
  use {'junegunn/fzf', run = function()
    vim.fn['fzf#install']()
	end
	}
  use 'junegunn/fzf.vim'
  use {'windwp/nvim-autopairs'} -- autopair
  use {'phelipetls/jsonpath.nvim'} -- json path view

  use {"npxbr/glow.nvim", run = ":GlowInstall"} -- preview markdown
  use {'wakatime/vim-wakatime'}
  use({
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	tag = "v1.2.1",
	-- install jsregexp (optional!:).
	run = "make install_jsregexp"
})
  -- Install nvim-cmp, and buffer source as a dependency
  use {
		"hrsh7th/nvim-cmp",
		requires = {
			'neovim/nvim-lspconfig',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			-- 'SirVer/ultisnips',
			-- 'quangnguyen30192/cmp-nvim-ultisnips',
            'saadparwaiz1/cmp_luasnip',
		}
  }
  use {
		'nvim-tree/nvim-tree.lua',
		tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}
  use {'psf/black', tag='stable'}   -- python format
  use {'kyazdani42/nvim-web-devicons'}   -- python format
  -- use 'reisub0/hot-reload.vim' -- hot reload flutter when save
  use {
		'folke/trouble.nvim',
        requires = {
        "kyazdani42/nvim-web-devicons", -- optional, for file icons
        },
		config = function()
			require('trouble').setup {}
		end
	}
  use({
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
		end,
  })
  use {
      "nvim-neotest/neotest",
      requires = {
          "nvim-lua/plenary.nvim",
          "nvim-treesitter/nvim-treesitter",
          'sidlatau/neotest-dart',
      }
  }
  use {
     'nvim-telescope/telescope.nvim', tag = '0.1.0',
  }
  use {'mfussenegger/nvim-jdtls'} -- java lsp
end)

-- disable netrw at the very start of your init.lua (strongly advised)
-- for config nvim-tree
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

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
vim.o.tabstop=4
vim.o.softtabstop=0
vim.o.shiftwidth=2
vim.cmd[[set expandtab]]
vim.cmd[[set autoindent]]
vim.cmd[[set smarttab]]


--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.cmd[[set undofile]]
-- vim.cmd[[set clipboard=unnamed]]

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
-- vim.g.UltiSnipsExpandTrigger="C-<tab>"
-- vim.g.UltiSnipsJumpForwardTrigger="<c-b>"
-- vim.g.UltiSnipsJumpBackwardTrigger="<c-z>"
-- vim.g.UltiSnipsSnippetsDir = "~/.vim/ultisnip"
-- vim.g.UltiSnipsEditSplit="vertical"
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


vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua ToggleMouse()<cr>', { noremap = true })

--Add leader shortcuts
local tele = require('telescope.builtin')

vim.keymap.set('n', '<leader>f', tele.find_files, {})
vim.keymap.set('n', '<leader><space>',function() tele.buffers({sort_mru = true}) end, {})
vim.keymap.set('n', '<leader>aa', function() tele.grep_string({search = vim.fn.expand("<cword>")}) end, {})
vim.keymap.set('n', '<leader>as',  tele.live_grep, {})

-- vim.api.nvim_set_keymap('n', '<leader>f', [[<cmd>FZF<cr>]], { noremap = true, silent = true})
-- vim.cmd[[nnoremap <leader>a :Rg <c-r><c-w><cr>]]
-- vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>Buffers<cr>]], { noremap = true, silent = true})

-- Change preview window location
vim.g.splitbelow = true

-- add commentstring to tpope/vim-commentary
-- vim.api.nvim_exec([[
--   augroup Commentary
--     autocmd!
--     autocmd FileType typescript setlocal commentstring=/*\ %s\ */
--     autocmd FileType typescriptreact setlocal commentstring=/*\ %s\ */
--   augroup end
-- ]], false)

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
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local nvim_lsp = require('lspconfig')
local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.keymap.set('n', '<leader>fo', function()
      vim.lsp.buf.format { async = true }
    end, opts)
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
nvim_lsp.lua_ls.setup {
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
-- toml cargo install --features lsp --locked taplo-cli
nvim_lsp.taplo.setup{}
-- css, tailwindcss
nvim_lsp.tailwindcss.setup{
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
	autocmd BufWritePre *.dart lua vim.lsp.buf.format({async=true})
  augroup end
]], false)
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
-- config lsp lines
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = {
    only_current_line = true
  }
})
vim.keymap.set(
  "",
  "<Leader>l",
  require("lsp_lines").toggle,
  { desc = "Toggle lsp_lines" }
)
require('Comment').setup()
-- neo test
-- setup cmp
require("nvim_tree_conf")
require("cmp_conf")
require("lualine_conf")
require("dap_conf")
require("neotest_conf")
require("json_path_visualize")
require("luasnip_conf")
end
