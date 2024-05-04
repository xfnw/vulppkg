{ config
, pkgs
, ...
}:

with pkgs;

let
  gcfg = config.services.getty;
  fbflut = stdenv.mkDerivation rec {
    pname = "fbflut";
    version = "unstable-2024-05-04";

    src = fetchFromGitHub {
      owner = "xfnw";
      repo = "fbflut";
      rev = "d2577db115aee10f1d29e0ecd02cd8eaa1407a87";
      sha256 = "sha256-SvXDDyz0OV3HjTh8EoXAHcoReXed6wz0yF5qD+u0UNU=";
    };

    postConfigure = ''
      substituteInPlace Makefile --replace c99 $CC
    '';

    installPhase = ''
      install -D fbflut $out/bin/fbflut
    '';
  };
in
{
  users.users.fbflut = {
    isSystemUser = true;
    group = "video";
    shell = "${fbflut}/bin/fbflut";
  };

  systemd.services."getty@tty1".overrideStrategy = "asDropin";
  systemd.services."getty@tty1".serviceConfig.ExecStart = [
    ""
    "@${pkgs.util-linux}/sbin/agetty agetty --login-program ${gcfg.loginProgram} --autologin fbflut --noclear --keep-baud %I 115200,38400,9600 $TERM"
  ];
}
