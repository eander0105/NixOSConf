{ pkgs, ... } :
{
  imports = [
    ./dconf.nix
  ];

  programs.gnome-terminal = {
    enable = true;
    showMenubar = false;
    profile = {
      "9e6bced8-89d4-4c52-aead-bbd59cbaad09" = {
        default = true;
        audibleBell = false;
        transparencyPercent = 25;
        colors.palette = [
          "rgb(46,52,54)"
          "rgb(204,0,0)"
          "rgb(78,154,6)"
          "rgb(196,160,0)"
          "rgb(52,101,164)"
          "rgb(117,80,123)"
          "rgb(6,152,154)"
          "rgb(211,215,207)"
          "rgb(85,87,83)"
          "rgb(239,41,41)"
          "rgb(138,226,52)"
          "rgb(252,233,79)"
          "rgb(114,159,207)"
          "rgb(173,127,168)"
          "rgb(52,226,226)"
          "rgb(238,238,236)"
        ];
        colors.backgroundColor = "rgb(50,50,50)";
        colors.foregroundColor = "rgb(255,255,255)";
        visibleName = "Default 2";
      };
    };
  };
}
