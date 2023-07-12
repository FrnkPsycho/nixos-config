{ config
, pkgs
, lib
, user
, ...
}:

{
    programs = {
        adb.enable = true;
        xwayland.enable = false;
    }
}