/* This function provides a generic Python package builder.  It is
   intended to work with packages that use `setuptools'
   (http://pypi.python.org/pypi/setuptools/), which represents a large
   number of Python packages nowadays.  */

{ python, setuptools, wrapPython, lib }:

{ name, namePrefix ? "python-"

, buildInputs ? []

, # List of packages that should be added to the PYTHONPATH
  # environment variable in programs built by this function.  Packages
  # in the standard `propagatedBuildInputs' variable are also added.
  # The difference is that `pythonPath' is not propagated to the user
  # environment.  This is preferrable for programs because it doesn't
  # pollute the user environment.
  pythonPath ? []

, installCommand ?
    ''
      easy_install --prefix="$out" .
    ''
    
, buildPhase ? "true"

, doCheck ? true

, checkPhase ?
    ''
      runHook preCheck
      python setup.py test
      runHook postCheck
    ''

, postInstall ? ""

, ... } @ attrs:

# Keep extra attributes from ATTR, e.g., `patchPhase', etc.
python.stdenv.mkDerivation (attrs // {
  inherit doCheck buildPhase checkPhase;

  name = namePrefix + name;

  buildInputs = [ python wrapPython setuptools ] ++ buildInputs ++ pythonPath;

  pythonPath = [ setuptools] ++ pythonPath;

  # XXX: Should we run `easy_install --always-unzip'?  It doesn't seem
  # to have a noticeable impact on small scripts.
  installPhase = ''
    mkdir -p "$out/lib/${python.libPrefix}/site-packages"

    echo "installing \`${name}' with \`easy_install'..."
    export PYTHONPATH="$out/lib/${python.libPrefix}/site-packages:$PYTHONPATH"
    ${installCommand}

    ${postInstall}
  '';

  postFixup =
    ''
      wrapPythonPrograms
    
      # If a user installs a Python package, she probably also wants its
      # dependencies in the user environment (since Python modules don't
      # have something like an RPATH, so the only way to find the
      # dependencies is to have them in the PYTHONPATH variable).
      if test -e $out/nix-support/propagated-build-inputs; then
          ln -s $out/nix-support/propagated-build-inputs $out/nix-support/propagated-user-env-packages
      fi
    '';
})
