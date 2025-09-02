-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local lspconfig = require "lspconfig"
-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"
local base = require "nvchad.configs.lspconfig"
-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.gopls.setup {
  cmd = { "gopls" },
  filetypes = { "go", "gomod" },
  root_dir = require("lspconfig").util.root_pattern("go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
      usePlaceholders = true,
      completeUnimported = true, -- 自動導入未使用的 package
      semanticTokens = true,
      directoryFilters = { "-node_modules" }, -- 避免載入 node_modules
      expandWorkspaceToModule = true, -- 允許模組內跳轉
    },
  },
}
lspconfig.clangd.setup {
  cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed", "--header-insertion=iwyu" },
  filetypes = { "c", "cpp", "c++" },
  root_dir = require("lspconfig.util").root_pattern("compile_commands.json", ".git"),
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

lspconfig.ts_ls.setup {
  on_attach = base.on_attach,
  capabilities = base.capabilities,
}

lspconfig.tailwindcss.setup {
  on_attach = base.on_attach,
  capabilities = base.capabilities,
}

lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false }, -- 禁用 pycodestyle（避免與 flake8 衝突）
        mccabe = { enabled = false }, -- 禁用代碼複雜度檢查
        pyflakes = { enabled = true }, -- 啟用 Pyflakes
        yapf = { enabled = true }, -- 啟用自動格式化
      },
    },
  },
}

lspconfig.lua_ls.setup {
  on_attach = base.on_attach,
  capabilities = base.capabilities,

  -- 👇 避免 LSP 把整個 home 當專案 root
  root_dir = function(fname)
    local util = require "lspconfig.util"
    local root = util.root_pattern(".git", ".luarc.json", "init.lua")(fname)
    if root == vim.loop.os_homedir() then
      return nil -- 返回 nil 會讓 LSP 不啟用
    end
    return root
  end,

  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath "config" .. "/lua",
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
