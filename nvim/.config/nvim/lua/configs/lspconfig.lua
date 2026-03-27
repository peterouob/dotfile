local nvlsp = require("nvchad.configs.lspconfig")

-- 1. 準備基本的 Capabilities
local capabilities = nvlsp.capabilities
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- 建立心理韌性：輕柔地試探 Blink 是否存在，不強求
-- 使用 pcall 就像是「受保護的探詢」，即使找不到也不會引發恐慌
local is_blink_ready, blink = pcall(require, "blink.cmp")

if is_blink_ready then
  -- 如果夥伴在場，我們就愉快地整合
  capabilities = blink.get_lsp_capabilities(capabilities)
end

-- 2. 定義共用設定 (On Attach / On Init)
local defaults = {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = capabilities,
}

-- 3. 定義輔助函數：註冊並啟用伺服器
local function setup_server(name, config)
  local final_config = vim.tbl_deep_extend("force", defaults, config or {})
  vim.lsp.config(name, final_config)
  vim.lsp.enable(name)
end

-- =================================================================
-- 4. 伺服器配置區 (保持你原本優秀的設定)
-- =================================================================

setup_server("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
      gofumpt = true,
      usePlaceholders = true,
      completeUnimported = true,
      semanticTokens = true,
    },
  },
})

setup_server("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", ".git" },
})

setup_server("pylsp", {
  cmd = { "pylsp" },
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },
        mccabe = { enabled = false },
        pyflakes = { enabled = true },
        yapf = { enabled = true },
      },
    },
  },
})

setup_server("lua_ls", {
  cmd = { "lua-language-server" },
  root_markers = { ".luarc.json", ".stylua.toml", "stylua.toml", ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
      telemetry = { enable = false },
    },
  },
})

setup_server("html", { cmd = { "vscode-html-language-server", "--stdio" } })
setup_server("cssls", { cmd = { "vscode-css-language-server", "--stdio" } })
setup_server("ts_ls", { cmd = { "typescript-language-server", "--stdio" } })
setup_server("tailwindcss", { cmd = { "tailwindcss-language-server", "--stdio" } })
