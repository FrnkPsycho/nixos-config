{inputs, system}:
[
  (final: prev: {

    picom = prev.picom.overrideAttrs (old: {
      src = prev.fetchFromGitHub {
        owner = "yshui";
        repo = "picom";
        rev = "0fe4e0a1d4e2c77efac632b15f9a911e47fbadf3";
        sha256 = "sha256-daLb7ebMVeL+f8WydH4DONkUA+0D6d+v+pohJb2qjOo=";
      };
    });

    sway-unwrapped = inputs.nixpkgs-wayland.packages.${system}.sway-unwrapped;

    save-clipboard-to = prev.writeShellScriptBin "save-clipboard-to" ''
        wl-paste > $HOME/Pictures/screenshot/$(date +'shot_%Y-%m-%d-%H%M%S.png')
    '';

    screen-recorder-toggle = prev.writeShellScriptBin "screen-recorder-toggle" ''
        pid=`${prev.procps}/bin/pgrep wf-recorder`
        status=$?
        if [ $status != 0 ]
        then
          ${prev.wf-recorder}/bin/wf-recorder -g "$(${prev.slurp}/bin/slurp)" -f $HOME/Videos/record/$(date +'recording_%Y-%m-%d-%H%M%S.mp4') --pixel-format yuv420p -t;
        else
          ${prev.procps}/bin/pkill --signal SIGINT wf-recorder
        fi;
    '';

    systemd-run-app = prev.writeShellApplication {
        name = "systemd-run-app";
        text = ''
          name=$(${prev.coreutils}/bin/basename "$1")
          id=$(${prev.openssl}/bin/openssl rand -hex 4)
          exec systemd-run \
            --user \
            --scope \
            --unit "$name-$id" \
            --slice=app \
            --same-dir \
            --collect \
            --property PartOf=graphical-session.target \
            --property After=graphical-session.target \
            -- "$@"
        '';
    };

  })

]
