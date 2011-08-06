{cabal, QuickCheck, vector} :

cabal.mkDerivation (self : {
  pname = "repa";
  version = "2.1.1.2";
  sha256 = "0lvhcq46abby69i6sgcqrxljykayp1sr3rmy2nlg5cccxlj94sqi";
  propagatedBuildInputs = [ QuickCheck vector ];
  meta = {
    homepage = "http://repa.ouroborus.net";
    description = "High performance, regular, shape polymorphic parallel arrays.";
    license = self.stdenv.lib.licenses.bsd3;
    maintainers = [self.stdenv.lib.maintainers.andres];
  };
})

