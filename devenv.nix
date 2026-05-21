{ pkgs, ... }:

{
  packages = with pkgs; [
    openssl
    cargo-zigbuild
    zig
    perl
  ];
  languages.rust = {
    enable = true;
    channel = "stable";
    targets = [
      "x86_64-unknown-linux-gnu"
      "x86_64-unknown-linux-musl"
    ];
  };
  env = {
    OPENSSL_STATIC = "1";
    OPENSSL_LIB_DIR = "${pkgs.pkgsStatic.openssl.out}/lib";
    OPENSSL_INCLUDE_DIR = "${pkgs.pkgsStatic.openssl.dev}/include";
  };
  scripts.build-static.exec = ''
    cargo zigbuild --release --target x86_64-unknown-linux-musl
    ldd target/x86_64-unknown-linux-musl/release/vllm-router"
  '';
}
