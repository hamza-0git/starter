
-- CoC + LSP共存配置
return {
  -- 保留LazyVim的LSP，但限制其功能
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- 只为特定文件类型启用LSP
      servers = {
        rust_analyzer = {},
        gopls = {},
      },
    },
  },

  -- 安装CoC
  {
    "neoclide/coc.nvim",
    branch = "release",
    init = function()
      vim.g.coc_disable_startup_warning = true
      -- CoC只接管特定文件类型
      vim.g.coc_filetype_map = {
        typescript = "typescript",
        javascript = "javascript",
        python = "python",
        json = "json",
        vue = "vue",
      }
    end,
    config = function()
      -- CoC快捷键（仅在CoC buffer中生效）
      local function coc_keymaps()
        vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { buffer = true })
        vim.keymap.set("n", "gr", "<Plug>(coc-references)", { buffer = true })
        vim.keymap.set("n", "K", "<Plug>(coc-hover)", { buffer = true })
        vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", { buffer = true })
        vim.keymap.set("n", "<leader>ca", "<Plug>(coc-codeaction)", { buffer = true })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "CocAttach",
        callback = coc_keymaps,
      })

      -- 使用Tab补全
      vim.api.nvim_set_keymap("i", "<Tab>",
        [[coc#pum#visible() ? coc#pum#confirm() : "<Tab>"]],
        { expr = true, silent = true }
      )
    end,
  },

  -- 禁用nvim-cmp避免冲突
  { "hrsh7th/nvim-cmp", enabled = false },
  { "L3MON4D3/LuaSnip", enabled = false },
}
