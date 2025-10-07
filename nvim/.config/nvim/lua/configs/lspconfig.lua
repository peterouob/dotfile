-- NVChad 既有預設（仍可保留，主要是 on_attach / on_init 等）
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"
local base  = require "nvchad.configs.lspconfig"

-- capabilities：沿用你的 foldingRange 與 blink.cmp
local capabilities = {
  textDocument = {
    foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
  },
}
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

-- 一次宣告想啟用的伺服器（會在下方統一 enable）
local simple_servers = { "html", "cssls", "ts_ls", "tailwindcss", "pylsp" }

-- 1) 先覆寫/擴充各伺服器的設定（新 API）
for _, name in ipairs(simple_servers) do
  vim.lsp.config(name, {
    on_attach    = base.on_attach,
    on_init      = nvlsp.on_init,
    capabilities = capabilities,
    -- 需要額外自訂時再加，例如 filetypes / settings / root_markers
  })
end

-- gopls：對應你原本的設定
vim.lsp.config("gopls", {
  on_attach    = nvlsp.on_attach,
  on_init      = nvlsp.on_init,
  capabilities = capabilities,
  filetypes    = { "go", "gomod" },
  -- root_markers 取代傳統 root_dir 寫法；也可保留 root_dir 函式
  root_markers = { "go.mod", ".git" },
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
      gofumpt = true,
      usePlaceholders = true,
      completeUnimported = true,
      semanticTokens = true,
      directoryFilters = { "-node_modules" },
      expandWorkspaceToModule = true,
    },
  },
})

-- clangd：等價你原本的參數
vim.lsp.config("clangd", {
  on_attach    = base.on_attach,
  on_init      = nvlsp.on_init,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
  },
  filetypes = { "c", "cpp", "c++" },
  -- 若需要嚴格根目錄規則，也可用 root_markers = { "compile_commands.json", ".git" }
})

-- pylsp：關閉 pycodestyle / mccabe，開啟 pyflakes / yapf
vim.lsp.config("pylsp", {
  on_attach    = base.on_attach,
  on_init      = nvlsp.on_init,
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },
        mccabe      = { enabled = false },
        pyflakes    = { enabled = true  },
        yapf        = { enabled = true  },
      },
    },
  },
})

-- lua_ls：避免把 $HOME 誤當成專案 root，並保留你的 workspace/diagnostics
vim.lsp.config("lua_ls", {
  on_attach    = base.on_attach,
  on_init      = nvlsp.on_init,
  capabilities = capabilities,

  -- 仍可使用 root_dir 函式（新 API 也支援）
  root_dir = function(fname)
    local util = require("lspconfig.util")
    local root = util.root_pattern(".git", ".luarc.json", "init.lua")(fname)
    if root == vim.loop.os_homedir() then
      return nil
    end
    return root
  end,

  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath("config") .. "/lua",
        },
      },
      telemetry = { enable = false },
    },
  },
})

-- 2) 啟用所有定義好的設定（新 API）
for _, name in ipairs(vim.tbl_flatten({ simple_servers, { "gopls", "clangd", "lua_ls" } })) do
  vim.lsp.enable(name)
end

