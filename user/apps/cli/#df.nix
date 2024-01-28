{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  
  programs.nixvim = {
    enable = true;
    enableMan = true;
    options = {
        number = true;
        relativenumber = true;
    };
    

    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      oil.enable = true;
      treesitter.enable = true;
      toggleterm.enable = true;
      #nvim-tree.enable = true;
      cmp_luasnip.enable = true;
    };



    plugins.lsp = {
      enable = true;
      servers = {
        tsserver.enable = true;
        lua-ls.enable = true;
        rust-analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
      };
    };

    plugins.nvim-cmp = {
      enable = true;
      autoEnableSources = true;
      sources = [
        {name = "nvim_lsp";}
        {name = "path";}
	{name = "luasnip";}
        {name = "buffer";}
      ];
      mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<Tab>" = {
          action = ''
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expandable() then
                luasnip.expand()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif check_backspace() then
                fallback()
              else
                fallback()
              end
            end
          '';
          modes = [ "i" "s" ];
        };
        
      };

      snippet.expand = "luasnip";

    };

    plugins.luasnip = {
      enable = true;
      extraConfig = { enable_autosnippets = true; store_selection_keys = "<Tab>";};
      fromVscode = [ {} ];
    };

    highlight = {
      Comment.underline = false;
      Comment.bold = true;
    };

    keymaps = [{
      action = "<cmd>Telescope live_grep<CR>";
      key = "<C-g>";
    }
    {
      action = "<cmd>ToggleTerm<CR>";
      key = "<C-t>";
    }];


  };

}
