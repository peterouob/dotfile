return {
  { "MeanderingProgrammer/render-markdown.nvim",
    lazy = false,
    ft = { "markdown", "Avante" },
    config = function()
      require('obsidian').get_client().opts.ui.enable = false
      vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_get_namespaces()['ObsidianUI'], 0, -1)
      require("render-markdown").setup({
        callout = {
          abstract = {
            raw = "[!abstract]",
            rendered = "󰯂 abstract",
            highlight = "rendermarkdowninfo",
            category = "obsidian",
          },
          summary = {
            raw = "[!summary]",
            rendered = "󰯂 summary",
            highlight = "rendermarkdowninfo",
            category = "obsidian",
          },
          tldr = { raw = "[!tldr]", rendered = "󰦩 tldr", highlight = "rendermarkdowninfo", category = "obsidian" },
          failure = {
            raw = "[!failure]",
            rendered = " failure",
            highlight = "rendermarkdownerror",
            category = "obsidian",
          },
          fail = { raw = "[!fail]", rendered = " fail", highlight = "rendermarkdownerror", category = "obsidian" },
          missing = {
            raw = "[!missing]",
            rendered = " missing",
            highlight = "rendermarkdownerror",
            category = "obsidian",
          },
          attention = {
            raw = "[!attention]",
            rendered = " attention",
            highlight = "rendermarkdownwarn",
            category = "obsidian",
          },
          warning = {
            raw = "[!warning]",
            rendered = " warning",
            highlight = "rendermarkdownwarn",
            category = "github",
          },
          danger = {
            raw = "[!danger]",
            rendered = " danger",
            highlight = "rendermarkdownerror",
            category = "obsidian",
          },
          error = { raw = "[!error]", rendered = " error", highlight = "rendermarkdownerror", category = "obsidian" },
          bug = { raw = "[!bug]", rendered = " bug", highlight = "rendermarkdownerror", category = "obsidian" },
          quote = { raw = "[!quote]", rendered = " quote", highlight = "rendermarkdownquote", category = "obsidian" },
          cite = { raw = "[!cite]", rendered = " cite", highlight = "rendermarkdownquote", category = "obsidian" },
          todo = { raw = "[!todo]", rendered = " todo", highlight = "rendermarkdowninfo", category = "obsidian" },
          wip = { raw = "[!wip]", rendered = "󰦖 wip", highlight = "rendermarkdownhint", category = "obsidian" },
          done = { raw = "[!done]", rendered = " done", highlight = "rendermarkdownsuccess", category = "obsidian" },
        },
        sign = { enabled = false },
        code = {
          -- general
          width = "block",
          min_width = 80,
          -- borders
          border = "thin",
          left_pad = 1,
          right_pad = 1,
          -- language info
          position = "right",
          language_icon = true,
          language_name = true,
          -- avoid making headings ugly
          highlight_inline = "rendermarkdowncodeinfo",
        },
        heading = {
          icons = { " 󰼏 ", " 󰎨 ", " 󰼑 ", " 󰎲 ", " 󰼓 ", " 󰎴 " },
          border = true,
          render_modes = true, -- keep rendering while inserting
        },
        checkbox = {
          unchecked = {
            icon = "󰄱",
            highlight = "rendermarkdowncodefallback",
            scope_highlight = "rendermarkdowncodefallback",
          },
          checked = {
            icon = "󰄵",
            highlight = "rendermarkdownunchecked",
            scope_highlight = "rendermarkdownunchecked",
          },
          custom = {
            question = {
              raw = "[?]",
              rendered = "",
              highlight = "rendermarkdownerror",
              scope_highlight = "rendermarkdownerror",
            },
            todo = {
              raw = "[>]",
              rendered = "󰦖",
              highlight = "rendermarkdowninfo",
              scope_highlight = "rendermarkdowninfo",
            },
            canceled = {
              raw = "[-]",
              rendered = "",
              highlight = "rendermarkdowncodefallback",
              scope_highlight = "@text.strike",
            },
            important = {
              raw = "[!]",
              rendered = "",
              highlight = "rendermarkdownwarn",
              scope_highlight = "rendermarkdownwarn",
            },
            favorite = {
              raw = "[~]",
              rendered = "",
              highlight = "rendermarkdownmath",
              scope_highlight = "rendermarkdownmath",
            },
          },
        },
        pipe_table = {
          alignment_indicator = "─",
          border = { "╭", "┬", "╮", "├", "┼", "┤", "╰", "┴", "╯", "│", "─" },
        },
        link = {
          wiki = { icon = " ", highlight = "rendermarkdownwikilink", scope_highlight = "rendermarkdownwikilink" },
          image = " ",
          custom = {
            github = { pattern = "github", icon = " " },
            gitlab = { pattern = "gitlab", icon = "󰮠 " },
            youtube = { pattern = "youtube", icon = " " },
            cern = { pattern = "cern.ch", icon = " " },
          },
          hyperlink = " ",
        },
        anti_conceal = {
          disabled_modes = { "n" },
          ignore = {
            bullet = true, -- render bullet in insert mode
            head_border = true,
            head_background = true,
          },
        },
        -- https://github.com/meanderingprogrammer/render-markdown.nvim/issues/509
        win_options = { concealcursor = { rendered = "nvc" } },
        completions = {
          blink = { enabled = true },
          lsp = { enabled = true },
        },
      })
    end,
  },
  {
    "AndrewRadev/switch.vim",
    config = function()
      vim.keymap.set("n", "`", function()
        vim.cmd [[Switch]]
      end, { desc = "Switch strings" })
      vim.g.switch_custom_definitions = {
        { "> [!TODO]", "> [!WIP]", "> [!DONE]", "> [!FAIL]" },
      }
    end,
  },
  {
    "bullets-vim/bullets.vim",
    ft = { "markdown" },
  },
  {
    "HakonHarnes/img-clip.nvim",
    ft = { "tex", "markdown", "typst" },
    opts = {
      default = {
        dir_path = "./attachments",
        use_absolute_path = false,
        copy_images = true,
        prompt_for_file_name = false,
        file_name = "%y%m%d-%H%M%S",
        extension = "avif",
        process_cmd = "magick convert - -quality 75 avif:-",
      },
      filetypes = {
        markdown = {
          template = "![image$CURSOR]($FILE_PATH)",
        },
        tex = {
          dir_path = "./figs",
          extension = "png",
          process_cmd = "",
          template = [[
    \begin{figure}[h]
      \centering
      \includegraphics[width=0.8\textwidth]{$FILE_PATH}
    \end{figure}
        ]], ---@type string | fun(context: table): string
        },
        typst = {
          dir_path = "./figs",
          extension = "png",
          process_cmd = "magick convert - -density 300 png:-",
        },
      },
    },
    keys = {
      { "<leader>P", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
}
