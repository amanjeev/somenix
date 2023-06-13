{ lib, rustPlatform, fetchFromGitHub, pkg-config, libusb1 }:

rustPlatform.buildRustPackage rec {
  pname = "nrfdfu-rs";
  version = "v0.1.3";

  
  src = fetchFromGitHub {
    owner = "ferrous-systems";
    repo = pname;
    rev = version;
    hash = "sha256-7BXXwF7AmAdNso4cQ6lWeT+VscwePtDY1t/JrcPvBB0=";
  };

  doCheck = false;

  cargoSha256 = "sha256-lGWEEg9Bvi+vYRw6vk0gQYZix9xIlfEo2F+PSiwJbaw=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ libusb1 ];

  meta = with lib; {
    description = "Flasher";
    homepage = "https://github.com/ferrous-systems/nrfdfu-rs";
    license = with licenses; [ asl20 /* or */ mit ];
    maintainers = with maintainers; [ amanjeev ];
  };
}