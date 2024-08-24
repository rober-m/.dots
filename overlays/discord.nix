self: super: {
  discord = super.discord.override rec {
    version = "0.0.62";
    src = super.fetchurl {
      url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
      hash = "sha256-KtVX9EJPYmzDQd2beV/dDW8jjLDjacKZDrD72kLUwKo=";
    };
  };
}
