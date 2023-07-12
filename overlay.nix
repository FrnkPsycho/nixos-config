inputs:
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

  })

]
