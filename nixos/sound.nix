{
  config = {
    sound.enable = true;
    security.rtkit.enable = true;

    services.pipewire = {
      # enable = false;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    hardware.pulseaudio = {
      enable = false;
    };
  };
}
