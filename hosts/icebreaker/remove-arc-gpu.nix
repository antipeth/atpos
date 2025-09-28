{lib, ...}: {
  services.udev.extraRules = let
    mkRule = as: lib.concatStringsSep ", " as;
    mkRules = rs: lib.concatStringsSep "\n" rs;
  in
    mkRules [
      (mkRule [
        ''ACTION=="add"''
        ''KERNEL=="0000:03:00.0"''
        ''SUBSYSTEM=="pci"''
        # ''ATTR{vendor}=="0x8086"''
        # ''ATTR{device}=="0x56a0"''
        ''ATTR{remove}="1"''
      ])
      (mkRule [
        ''ACTION=="add"''
        ''KERNEL=="0000:04:00.0"''
        ''SUBSYSTEM=="pci"''
        ''ATTR{remove}="1"''
      ])
    ];
}
