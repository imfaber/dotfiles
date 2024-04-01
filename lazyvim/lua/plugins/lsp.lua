return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tsserver = {

        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = "C:\\Users\\fabri\\AppData\\Roaming\\npm\\node_modules\\@vue\\language-server\\node_modules\\@vue\\typescript-plugin",
              languages = { "javascript", "typescript", "vue" },
            },
          },
        },
        filetypes = {
          "javascript",
          "typescript",
          "vue",
        },
      },
      volar = {
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
      },
    },
  },
}
