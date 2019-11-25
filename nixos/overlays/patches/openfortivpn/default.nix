{ openfortivpn, fetchFromGitHub }:

openfortivpn.overrideAttrs ({ src, ...}: {
  src = fetchFromGitHub {
    owner = "adrienverge";
    repo = "openfortivpn";
    rev = "f2f084602971426ec45f7c4753240563d858a9f5";
    sha256 = "0afy51l57afba5ziivhqs1m47x0qb65fi1qvbgvvw9j7zwlfpfdi";
  };
})
