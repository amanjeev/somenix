/* Overlays in somenix are inspired by LIBKOOKIE (spacekookie)
 * 
 * patches: upstream but with cool stuff
 */

self: super: {
  openfortivpn = self.callPackage ./patches/openfortivpn { inherit (super) openfortivpn; };
}
