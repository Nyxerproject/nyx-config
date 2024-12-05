{pkgs, ...}: {
  plugins = {
    luasnip = {
      enable = pkgs.lib.mkDefault true;
      settings = {
        enable_autosnippets = pkgs.lib.mkDefault true;
      };
    };
    cmp-nvim-lsp.enable = true;
    cmp-dap.enable = true;
    cmp-treesitter.enable = true;
    cmp-path.enable = true;
    cmp_luasnip.enable = true;
    # cmp-nvim-lsp-signature-help.enable = true;
    # cmp-nvim-lua.enable = true;
    # cmp-tabby.enable = true;
    # cmp-buffer.enable = true;
    # cmp-cmdline.enable = true;
    cmp = {
      enable = pkgs.lib.mkDefault true;
      autoEnableSources = pkgs.lib.mkDefault true;
      settings = {
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

        sources = [
          {
            name = "nvim_lsp";
            # max_item_count = 10;
            # keywordLength = 2;
            option = {
              markdown_oxide = {
                keyword_pattern = "[[\(\k\| \|\/\|#\)\+]]";
              };
            };
          }
          {name = "treesitter";}
          {name = "luasnip";}
          {name = "path";}
          {name = "buffer";}
          {name = "git";}
          {name = "calc";}
          # {name = "nvim_lsp_signature_help";}
          # {name = "mkdnflow";}
          # { name = "buffer";
          #   # Words from other open buffers can also be suggested.
          #   # option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          #   indexing_internal = 1000;
          #   max_item_count = 5;
          #   keywordLength = 3;
          # }
          # {name = "cmp_tabby";}
          # {name = "nvim_lua";}
        ];

        window = {
          completion = {
            border = [
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
            ];
          };
          documentation = {
            border = [
              "╭"
              "─"
              "╮"
              "│"
              "╯"
              "─"
              "╰"
              "│"
            ];
          };
        };

        mapping = {
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          # "<C-k>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          # "<C-j>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          # "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          # "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        };
        # formatting = {
        #   fields = ["abbr" "kind" "menu"];
        # };
        # experimental = {
        #   native_menu = false;
        #   ghost_text = false;
        # };
        # matching = {
        #   disallow_fuzzy_matching = true;
        #   disallow_fullfuzzy_matching = true;
        #   disallow_partial_fuzzy_matching = true;
        #   disallow_prefix_unmatching = true;
        # };
        # performance = {
        #   debounce = 10;
        #   fetchingTimeout = 1000;
        #   maxViewEntries = 7;
        #   throttle = 10;
        # };
        #
        # sorting = {
        #   comparators = [
        #     "require('cmp.config.compare').recently_used"
        #     "require('cmp.config.compare').exact"
        #     "require('cmp.config.compare').offset"
        #     "require('cmp.config.compare').score"
        #     "require('cmp.config.compare').kind"
        #     "require('cmp.config.compare').locality"
        #     "require('cmp.config.compare').length"
        #     "require('cmp.config.compare').order"
        #   ];
        # };
      };
    };
  };
}
