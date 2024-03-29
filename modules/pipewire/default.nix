{ pkgs
, config
, lib
, inputs
, system
, user
, ...
}:
with lib;
let
  cfg = config.services.pipewire;
in
{
services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # config.pipewire = {
    #   "context.properties" = {
    #     "default.clock.rate" = 44100;
    #     "default.clock.allowed-rates" = [ 44100 48000 88200 96000 176000 352800 384000 705600 768000];
    #     "default.clock.min-quantum" = 16;
    #   };
    #   "stream.properties" = {
    #     "resample.quality" = 10;
    #   };
    # };



    # High quality BT calls
    # media-session.config.bluez-monitor.rules = [
    #   {
    #     # Matches all cards
    #     matches = [{ "device.name" = "~bluez_card.*"; }];
    #     actions = {
    #       "update-props" = {
    #         "bluez5.auto-connect" = [ "a2dp_sink" ];
    #       };
    #     };
    #   }
    #   {
    #     matches = [
    #       # Matches all sources
    #       { "node.name" = "~bluez_input.*"; }
    #       # Matches all outputs
    #       { "node.name" = "~bluez_output.*"; }
    #     ];
    #     actions = {
    #       "node.pause-on-idle" = false;
    #     };
    #   }
    # ];
  };
    environment.etc = {
	"wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
		bluez_monitor.properties = {
			["bluez5.enable-sbc-xq"] = true,
			["bluez5.enable-msbc"] = true,
			["bluez5.enable-hw-volume"] = true,
			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
		}
	'';
  
  "pipewire/pipewire.conf.d/pipewire.conf".text = ''
    context.properties = {
        ["default.clock.rate"] = 44100,
        ["default.clock.allowed-rates"] = [ 44100 48000 88200 96000 176000 352800 384000 705600 768000],
        ["default.clock.min-quantum"] = 16
      },
    stream.properties = {
        "resample.quality" = 10
      }
  '';
};
}