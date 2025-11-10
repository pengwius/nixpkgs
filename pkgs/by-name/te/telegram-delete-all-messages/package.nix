{
  lib,
  fetchFromGitHub,
  python3Packages,
}:

python3Packages.buildPythonApplication rec {
  pname = "telegram-delete-all-messages";
  version = "0-unstable-2025-11-08";

  src = fetchFromGitHub {
    owner = "pengwius";
    repo = "telegram-delete-all-messages";
    rev = "0e4560fa09b472fd3fa6510e30122a0c17aca6bb";
    sha256 = "10myiz69wc2dnvg8ms4c1s9qqnsx51jkjxabmsa8ksc7rmr8ii2k";
  };

  propagatedBuildInputs = with python3Packages; [
    pyrogram
    tgcrypto
  ];

  doCheck = false;
  buildPhase = "true";

  format = "other";

  installPhase = ''
        mkdir -p $out/lib/${pname}
        cp -r * $out/lib/${pname}/
        mkdir -p $out/bin
        cat > $out/bin/${pname} <<EOF
    #!${python3Packages.python.interpreter}
    import runpy, sys
    runpy.run_path("$out/lib/${pname}/cleaner.py", run_name="__main__")
    EOF
        chmod +x $out/bin/${pname}
  '';

  meta = {
    description = "Delete your Telegram messages in supergroups";
    homepage = "https://github.com/pengwius/telegram-delete-all-messages";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ pengwius ];
  };
}
