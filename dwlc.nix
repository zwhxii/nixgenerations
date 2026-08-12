{ pkgs, ... }:

{
  programs.dwl = {
    enable = true;
    package = (pkgs.dwl.override {
      configH = ./config.h; 
    }).overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++ [
        ./patches/dwl-fibonacci-6.2.patch
        ./patches/dwl-ruaps-20230816-dc046fb.patch
      ];

      # 3. Добавление зависимостей, если патч их требует
      buildInputs = oldAttrs.buildInputs ++ [ pkgs.libdrm pkgs.fcft ];
    });
  };

  (pkgs.dwl.overrideAttrs (oldAttrs: {
    src = inputs.dwl;
  }))

}
