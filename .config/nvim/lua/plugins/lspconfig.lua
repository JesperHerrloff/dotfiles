return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssls = {},
        css_variables = {},
        somesass_ls = {},
        intelephense = {
          settings = {
            intelephense = {
              files = {
                maxSize = 5000000, -- 5MB
              },
              environment = {
                includePaths = { "/Users/jesperherrloff/PhpstormProjects/NmcTest" },
              },
            },
          },
        },
      },
    },
  },
}
