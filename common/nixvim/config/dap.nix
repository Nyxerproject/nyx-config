{
  plugins = {
    dap-ui = {enable = true;};
    dap-python.enable = true;
    dap-virtual-text.enable = true;
    dap = {
      enable = true;
      adapters = {};
      signs = {
        dapBreakpoint = {
          text = "●";
          texthl = "DapBreakpoint";
        };
        dapBreakpointCondition = {
          text = "●";
          texthl = "DapBreakpointCondition";
        };
        dapLogPoint = {
          text = "◆";
          texthl = "DapLogPoint";
        };
      };
      adapters.executables.gdb = {
        command = "gdb";
        args = ["-i" "dap"];
      };

      configurations = {
        cpp = [
          {
            name = "C gdb launch";
            type = "gdb";
            request = "launch";
            program = "build/main";
          }
        ];
        c = [
          {
            name = "C gdb launch";
            type = "gdb";
            request = "launch";
            program = "build/main";
          }
        ];
      };

      # keymaps = let
      #   bindingPrefix = "<Leader>d";
      #   mkDAPBinding = binding: settings:
      #     {
      #       mode = "n";
      #       key = "${bindingPrefix}${binding}";
      #     }
      #     // settings;
      # in
      #   lib.mapAttrsToList mkDAPBinding
      #   {
      #     "b" = {
      #       options.desc = "Toggle breakpoint";
      #       action = helpers.mkRaw "require('dap').toggle_breakpoint";
      #     };
      #
      #     "B" = {
      #       options.desc = "Set breakpoint";
      #       action = helpers.mkRaw "require('dap').set_breakpoint";
      #     };
      #
      #     "Bp" = {
      #       options.desc = "Set breakpoint with log message";
      #       action = helpers.mkRaw ''
      #         function()
      #           require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
      #         end
      #       '';
      #     };
      #
      #     "n" = {
      #       options.desc = "Continue";
      #       action = helpers.mkRaw "require('dap').continue";
      #     };
      #
      #     "," = {
      #       options.desc = "Pause";
      #       action = helpers.mkRaw "require('dap').pause";
      #     };
      #
      #     "d" = {
      #       options.desc = "Terminate";
      #       action = helpers.mkRaw "require('dap').terminate";
      #     };
      #
      #     "l" = {
      #       options.desc = "Step over";
      #       action = helpers.mkRaw "require('dap').step_over";
      #     };
      #
      #     "j" = {
      #       options.desc = "Step into";
      #       action = helpers.mkRaw "require('dap').step_into";
      #     };
      # "J" = { options.desc = "Go up"; action = helpers.mkRaw "require('dap').up";
      #     };
      #
      #     "k" = {
      #       options.desc = "Step out";
      #       action = helpers.mkRaw "require('dap').step_out";
      #     };
      #
      #     "K" = {
      #       options.desc = "Go down";
      #       action = helpers.mkRaw "require('dap').down";
      #     };
      #
      #     "rs" = {
      #       options.desc = "Restart session";
      #       action = helpers.mkRaw "require('dap').restart";
      #     };
      #
      #     "rr" = {
      #       options.desc = "Open debugging REPL";
      #       action = helpers.mkRaw "require('dap').repl.open";
      #     };
      #
      #     "rl" = {
      #       options.desc = "Run last configuration";
      #       action = helpers.mkRaw "require('dap').run_last";
      #     };
      #
      #     "ph" = {
      #       options.desc = "View the value under the cursor";
      #       action = helpers.mkRaw "require('dap.ui.widgets').hover";
      #       mode = ["n" "v"];
      #     };
      #
      #     "pp" = {
      #       options.desc = "See value in preview window";
      #       action = helpers.mkRaw "require('dap.ui.widgets').preview";
      #       mode = ["n" "v"];
      #     };
      #   }
      #   ++ lib.mapAttrsToList mkDAPBinding {
      #     "<F5>" = {
      #       options.desc = "Continue";
      #       action = helpers.mkRaw "require('dap').continue";
      #     };
      #
      #     "<F10>" = {
      #       options.desc = "Step over";
      #       action = helpers.mkRaw "require('dap').step_over";
      #     };
      #
      #     "<F11>" = {
      #       options.desc = "Step into";
      #       action = helpers.mkRaw "require('dap').step_into";
      #     };
      #
      #     "<F12>" = {
      #       options.desc = "Step out";
      #       action = helpers.mkRaw "require('dap').step_out";
      #     };
      #  };
    };
  };
}
