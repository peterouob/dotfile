return {
  'tribela/transparent.nvim',
  event = "VimEnter", 
  lazy = true,
  config = true,
     opts = {
       auto = true,
       extra_groups = { "NormalFloat", "NvimTreeNormal" },
       excludes = { "LineNr" },
     },
}
