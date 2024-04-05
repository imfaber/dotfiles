return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")

      dap.adapters.coreclr = {
        type = "executable",
        command = "C:\\Users\\fabri\\AppData\\Local\\netcoredb\\gnetcoredbg.exe",
        args = { "--interpreter=vscode" },
      }

      vim.g.dotnet_build_project = function()
        local default_path = vim.fn.getcwd() .. "/"
        if vim.g["dotnet_last_proj_path"] ~= nil then
          default_path = vim.g["dotnet_last_proj_path"]
        end
        local path = vim.fn.input({ prompt = "Path to your *proj file: ", default = default_path, completion = "file" })
        vim.g["dotnet_last_proj_path"] = path
        -- local cmd = 'dotnet build -c Debug "' .. path .. '" 2> /tmp/dap-debug-nvim-dotnet.log'
        local cmd = 'dotnet build -c Debug "' .. path .. '"'
        print("\n")
        print("Cmd to execute: " .. cmd)
        local f = os.execute(cmd)
        if f == 0 then
          print("\nBuild: " .. vim.g.gsign("✔️ ", "OK"))
        else
          print("\nBuild: " .. vim.g.gsign("❌", "ERR") .. "(code: " .. f .. ")")
        end
      end

      vim.g.dotnet_get_dll_path = function()
        local request = function()
          return vim.fn.input({
            prompt = "Path to dll: ",
            default = vim.fn.getcwd() .. "/bin/Debug/",
            completion = "file",
          })
        end

        if vim.g["dotnet_last_dll_path"] == nil then
          vim.g["dotnet_last_dll_path"] = request()
        else
          if
            vim.fn.confirm("Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"], "&yes\n&no", 2)
            == 1
          then
            vim.g["dotnet_last_dll_path"] = request()
          end
        end
        return vim.g["dotnet_last_dll_path"]
      end

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          console = "integratedTerminal",
          program = function()
            if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
              vim.g.dotnet_build_project()
            end
            return vim.g.dotnet_get_dll_path()
          end,
        },
      }
    end,
  },
}
