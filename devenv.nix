{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  # env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [
    pkgs.git
    pkgs.omnisharp-roslyn
  ];

  # https://devenv.sh/scripts/
  # scripts.hello.exec = "echo hello from $GREET";

  enterShell = ''
    dotnet tool restore
  '';

  # https://devenv.sh/languages/
  languages.dotnet.enable = true;
  languages.dotnet.package = pkgs.dotnet-sdk_8;

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks = {
    editorconfig-checker.enable = true;
    csharpier = {
      enable = true;
      entry = "dotnet csharpier";
      files = "\.cs$";
    };
  };

  # https://devenv.sh/processes/
  processes.watch.exec = "dotnet watch";

  services.postgres = {
    enable = true;
    package = pkgs.postgresql_16;
    listen_addresses = "127.0.0.1";
    initialScript = ''
      CREATE USER postgres SUPERUSER PASSWORD 'password';
    '';
  };

  # See full reference at https://devenv.sh/reference/options/
}
