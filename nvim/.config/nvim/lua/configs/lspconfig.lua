local nvlsp = require("nvchad.configs.lspconfig")

-- 1. 準備 Capabilities (包含 Blink.cmp)
local capabilities = nvlsp.capabilities
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
-- 整合 Blink
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

-- 2. 定義共用設定 (On Attach / On Init)
local defaults = {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = capabilities,
}

-- 3. 定義輔助函數：註冊並啟用伺服器
-- 這是 Neovim 0.11 的標準寫法
local function setup_server(name, config)
  -- 合併預設值與客製化設定
  local final_config = vim.tbl_deep_extend("force", defaults, config or {})
  
  -- A. 定義設定 (Config)
  vim.lsp.config(name, final_config)
  
  -- B. 啟用伺服器 (Enable)
  vim.lsp.enable(name)
end

-- =================================================================
-- 4. 伺服器配置區
-- =================================================================

-- [Golang] gopls
setup_server("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  -- 0.11 使用 root_markers 取代 root_dir
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

-- [C/C++] clangd
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

-- [Python] pylsp
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

-- [Lua] lua_ls
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

-- [Assembly] asm_lsp
setup_server("asm_lsp", {
  -- Mason 安裝後 binary 名稱為 "asm-lsp"
  cmd = { "asm-lsp" },
  filetypes = { "asm", "vmasm", "s", "S" },
  -- 0.11 原生寫法：定義如何找到專案根目錄
  -- 建議加入 .asm-lsp.toml，這是官方推薦的專案標記檔
  root_markers = { ".asm-lsp.toml", ".git" },
})

-- [Web] HTML / CSS / TS / Tailwind
-- 這裡直接給定指令，確保穩定啟動
setup_server("html", { cmd = { "vscode-html-language-server", "--stdio" } })
setup_server("cssls", { cmd = { "vscode-css-language-server", "--stdio" } })
setup_server("ts_ls", { cmd = { "typescript-language-server", "--stdio" } })
setup_server("tailwindcss", { cmd = { "tailwindcss-language-server", "--stdio" } })
