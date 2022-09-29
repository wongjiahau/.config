require("plugins")
local o = vim.o
local g = vim.g
local function nnoremap(key, cmd)
	vim.api.nvim_set_keymap("n", key, cmd, { noremap = true })
end

local function vnoremap(key, cmd)
	vim.api.nvim_set_keymap("v", key, cmd, { noremap = true })
end

-- Set leader
g.mapleader = " "

-- Tree sitter settings
require("nvim-treesitter.configs").setup({
	autotag = { enable = true },
	ensure_installed = "all",
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {}, -- list of language that will be disabled
	},
})

-- Autopair settings
require("nvim-autopairs").setup({})

-- Make sure all types of *.graphql files get syntax highlighting.
-- This is necessary for coc-prettier to work
vim.cmd("autocmd BufNewFile,BufRead *.graphql set ft=graphql")

-- lualine settings
require("lualine").setup({
	options = { theme = "ayu_mirage" },
	sections = {
		lualine_a = { { "filename", path = 1 } },
		lualine_b = { "g:coc_status" },
		lualine_c = { { "diagnostics", sources = { "nvim_lsp" } } },
		lualine_x = {},
		lualine_y = { "progress" },
		lualine_z = { "branch" },
	},
})

-- diffview settings
require("diffview").setup({
	file_panel = { win_config = { tree_options = { flatten_dirs = false } } },
})

-- telescope settings
require("telescope").setup({ defaults = { preview = false } })

-- https://github.com/alvarosevilla95/luatab.nvim
require("luatab").setup({})

-- key mappings
nnoremap("<CR>", ":wa<CR>")
nnoremap("<C-j>", ":cnext<CR>")
nnoremap("<C-k>", ":cprev<CR>")
-- Open [g]it dashboard
nnoremap("<Leader>g", ":tab Git<CR>")
-- Open [G]it diffs
nnoremap("<Leader>G", ":DiffviewOpen<CR>")
-- For opening Git [d]iff of current file vertically
nnoremap("<Leader>d", ":vert Gdiff<CR>")
-- [s]earch and replace
nnoremap("<leader>s", ':lua require("spectre").open() <CR>')
-- [s]earch current highlighted word
vnoremap("<leader>s", ':lua require("spectre").open_visual() <CR>')
-- Open file search (follows VSCode Cmd+p)
nnoremap("<Leader>p", ":Telescope git_files<CR>")
-- Open command pallete (follows VSCode Cmd+shift+p)
nnoremap("<Leader>P", ":Telescope commands<CR>")
-- Open registers search
nnoremap('<Leader>"', ":Telescope registers<CR>")
-- Open [b]uffer search
nnoremap("<Leader>b", ":Telescope buffers<CR>")
-- Global [f]ind
nnoremap("<Leader>f", ":Telescope live_grep<cr>")
-- Open current file [h]istory
nnoremap("<Leader>h", ":DiffviewFileHistory %<CR>")
-- Toggle hop.nvim
nnoremap("<Leader>t", ":HopWord<CR>")
-- Toggle code action
nnoremap("<Leader>,", ":CodeActionMenu<CR>")

-- vim settings
o.clipboard = o.clipboard .. "unnamedplus"
o.number = true
o.autowrite = true
o.smartcase = true
o.ignorecase = true
o.tabstop = 2
o.shiftwidth = 2
o.shell = "fish"
o.expandtab = true
o.wrap = false
o.swapfile = false
o.cursorline = true
o.cursorcolumn = true
o.hlsearch = true
o.incsearch = true
o.ttimeoutlen = 10
o.mouse = "a"
o.inccommand = "nosplit" -- For viewing live substitution
o.hidden = true -- to ensure terminal remains alive
o.relativenumber = true

-- colorscheme
vim.o.background = "light"
vim.g.vscode_transparent = 1
vim.cmd([[colorscheme vscode]])

-- tabline colors
vim.cmd([[
hi TabLine guibg=#A89984
hi TabLineFill guibg=#3C3836
]])

-- floating windows color
vim.cmd([[
hi NormalFloat guibg=#fbf1c7
hi Visual guibg=yellow
]])

-- Treat dash as part of a word
-- Refer https://vi.stackexchange.com/a/13813/31905
vim.cmd([[
set iskeyword+=-
]])

-- Auto format on save
-- Refer https://github.com/sbdchd/neoformat#basic-usage
vim.cmd([[
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
]])

-- https://github.com/lewis6991/gitsigns.nvim
require("gitsigns").setup()

-- https://github.com/kyazdani42/nvim-tree.lua
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()
nnoremap("<Leader>n", ":NvimTreeFindFileToggle<CR>")

-- https://github.com/williamboman/mason.nvim#installation
require("mason").setup({})

-- https://github.com/williamboman/mason-lspconfig.nvim#setup
require("mason-lspconfig").setup()

-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua-language-server",
		"prettierd",
		"rust-analyzer",
		{ "sql-formatter", version = "4.0.2" },
		"stylua",
		"typescript-language-server",
		"graphql-language-service-cli",
	},

	-- if set to true this will check each tool for updates. If updates
	-- are available the tool will be updated. This setting does not
	-- affect :MasonToolsUpdate or :MasonToolsInstall.
	-- Default: false
	auto_update = false,

	-- automatically install / update on startup. If set to false nothing
	-- will happen on startup. You can use :MasonToolsInstall or
	-- :MasonToolsUpdate to install tools and check for updates.
	-- Default: true
	run_on_start = true,

	-- set a delay (in ms) before the installation starts. This is only
	-- effective if run_on_start is set to true.
	-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
	-- Default: 0
	start_delay = 3000, -- 3 second delay
})

-- LSP Setup https://github.com/neovim/nvim-lspconfig

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "ge", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<space>E", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, opts)
vim.keymap.set("n", "<space>W", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
end, opts)
vim.keymap.set("n", "<space>e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)
vim.keymap.set("n", "<space>w", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
end, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gh", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>r", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_options = {
	on_attach = on_attach,
	capabilities,
}
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
require("lspconfig")["tsserver"].setup(lsp_options)

require("lspconfig")["rust_analyzer"].setup(lsp_options)

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
require("lspconfig").sumneko_lua.setup({
	settings = {
		on_attach,
		capabilities,
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#graphql
require("lspconfig").graphql.setup({
	on_attach = on_attach,
	capabilities,
	filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript" },
})

-- https://github.com/lighttiger2505/sqls
require("lspconfig").sqls.setup({
	on_attach,
	capabilities,
	settings = {
		sqls = {
			connections = {
				{
					driver = "postgresql",
					dataSourceName = "host=127.0.0.1 port=5432 user=postgres password='' dbname=postgres sslmode=disable",
				},
			},
		},
	},
})

-- https://github.com/hrsh7th/nvim-cmp
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- LSP Lines (https://git.sr.ht/~whynothugo/lsp_lines.nvim#installation)
require("lsp_lines").setup()
-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
	virtual_text = false,
})

-- https://github.com/j-hui/fidget.nvim
require("fidget").setup({})

-- https://github.com/NvChad/nvim-colorizer.lua
require("colorizer").setup()

-- https://github.com/weilbith/nvim-code-action-menu#window-appearance
vim.g.code_action_menu_show_details = false
vim.g.code_action_menu_show_diff = false
