return {
   {
      "williamboman/mason.nvim",
      config = function()
	 require('mason').setup()
      end
   },
   {
      "williamboman/mason-lspconfig.nvim",
      config = function()
	 require('mason-lspconfig').setup()
      end
   },
   {
      "neovim/nvim-lspconfig",
      config = function()
	 vim.lsp.enable('pyright')
	 vim.lsp.enable('lua_ls')
	 vim.lsp.enable('bashls')
	 vim.lsp.enable('ruff')
	 vim.lsp.enable('html')
	 vim.lsp.enable('r_language_server')
	 vim.lsp.enable('cssls')
	 vim.lsp.enable('air')


	 vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
	 vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
	 vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
	 vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
	 vim.keymap.set({'n','v'}, '<leader>ca', vim.lsp.buf.code_action, {})
      end
   },
}
