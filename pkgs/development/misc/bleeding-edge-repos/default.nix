args: 
  with args;
  let inherit (builtins) pathExists; in
  rec {
  /*
    tries to get source in this order
    1) Local .tar.gz in ${HOME}/managed_repos/dist/name.tar.gz (-> see nixRepositoryManager)
    2) By importing                                           
        pkgs/misc/bleeding-edge-fetch-info/name.nix
        (generated by nixRepositoryManager --publish)
    3) Fall back to fetch_xy given with information given by A) But
      the sum wil propably be wrong..
      (not everything is implemented now)
  */ 

  managedRepoDir = getConfig [ "bleedingEdgeRepos" "managedRepoDir" ] (builtins.getEnv "HOME" + "/managed_repos");

  sourceByName = name : (
    let localTarGZ = managedRepoDir+"/dist/${name}.tar.gz"; 
        fetchUrlInfoFile = ../../../misc/bleeding-edge-fetch-info + "/${name}.nix"; in
    if pathExists localTarGZ
    then localTarGZ
    else if pathExists fetchUrlInfoFile
         then (import fetchUrlInfoFile) { inherit fetchurl; }
         else builtins.trace "warning, no bleeding edge source info (${fetchUrlInfoFile}) found for ${name}, hash will propably be wrong"
               (let attr = __getAttr name repos;
                 in if (attr.type == "darcs")
                   then fetchdarcs2 { inherit (attr) url md5; }
                   else throw "TODO") );

  repos = {
    # each repository has 
    # a type, url and maybe a tag
    # you can add groups names to update some repositories at once
    # see nix_repository_manager expression in all-packages.nix

      nix_repository_manager = { type = "darcs"; url = "http://mawercer.de/~marc/repos/nix-repository-manager"; };

      plugins = { type = "darcs"; url="http://code.haskell.org/~dons/code/hs-plugins/"; groups="haskell"; };

      # darcs repositories haskell 
      http =  { type= "darcs"; url="http://darcs.haskell.org/http/"; groups="happs"; };
      syb_with_class =  { type="darcs"; url="http://happs.org/HAppS/syb-with-class"; groups="happs"; };
      happs_data =  { type="darcs"; url=http://happs.org/repos/HAppS-Data; groups="happs"; };
      happs_util =  { type="darcs"; url=http://happs.org/repos/HAppS-Util; groups="happs"; };
      happs_state =  { type="darcs"; url=http://happs.org/repos/HAppS-State; groups="happs"; };
      happs_plugins =  { type="darcs"; url=http://happs.org/repos/HAppS-Plugins; groups="happs"; };
      happs_ixset =  { type="darcs"; url=http://happs.org/repos/HAppS-IxSet; groups="happs"; };
      happs_server =  { type="darcs"; url=http://happs.org/repos/HAppS-Server; groups="happs"; };
      happs_hsp = { type="darcs"; url="http://code.haskell.org/HSP/happs-hsp"; groups="happs haskell hsp"; };
      happs_hsp_template = { type="darcs"; url="http://code.haskell.org/HSP/happs-hsp-template"; groups="happs haskell hsp"; };
      # haskell_src_exts_metaquote = { type="darcs"; url=http://code.haskell.org/~morrow/code/haskell/haskell-src-exts-metaquote; groups="happs haskell hsp"; };
      haskell_src_exts = { type="darcs"; url=http://code.haskell.org/HSP/haskell-src-exts/; groups="happs haskell hsp"; };
      
      hsp = { type="darcs"; url="http://code.haskell.org/HSP/hsp"; groups="happs haskell hsp"; };
      hsp_xml = { type="darcs"; url="http://code.haskell.org/HSP/hsp-xml"; groups="happs haskell hsp"; };
      hspCgi = { type="darcs"; url="http://code.haskell.org/HSP/hsp-cgi"; groups="happs haskell hsp"; };
      hjscript = { type="darcs"; url="http://code.haskell.org/HSP/hjscript"; groups="happs haskell hsp"; };
      hjquery = { type="darcs"; url="http://code.haskell.org/HSP/hjquery"; groups="happs haskell hsp"; };
      hjavascript = { type="darcs"; url="http://code.haskell.org/HSP/hjavascript"; groups="happs haskell hsp"; };
      takusen = { type="darcs"; url=http://darcs.haskell.org/takusen/; };
      cabal = { type="darcs"; url=http://darcs.haskell.org/cabal; };
      haxml = { type="darcs"; url=http://www.cs.york.ac.uk/fp/darcs/HaXml; groups = "pg_haskell"; };


      # git repositories 
      hypertable =  { type="git"; url="git://scm.hypertable.org/pub/repos/hypertable.git"; groups=""; };
    } // getConfig [ "bleedingEdgeRepos" "repos" ] {};
}
