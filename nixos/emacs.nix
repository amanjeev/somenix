{ config, lib, pkgs, ... }:
                                                                                                      
with lib;                                                                                             
                                                                                                      
let                                                                                                   
  cfg = config.services.emacs;                                                                        
in                                                                                                    
{                                                                                                     
  options = {                                                                                         
    services.emacs = {                                                                                
      enable = mkOption {                                                                             
        default = false;                                                                              
        type = types.bool;                                                                            
        description = "Enable the per-user Emacs daemon.";                                            
      };                                                                                              
    };                                                                                                
  };                                                                                                  
                                                                                                      
  config = mkIf cfg.enable {                                                                          
    environment.systemPackages = [ pkgs.emacs ];                                                      
                                                                                                      
    systemd.user.services.emacs = {                                                                   
      description = "Emacs Daemon";                                                                   
      environment.GTK_DATA_PREFIX = config.system.path;                                               
      environment.SSH_AUTH_SOCK = "%t/ssh-agent";                                                     
      environment.GTK_PATH = "${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0";   
      environment.NIX_PROFILES = "${concatStringsSep " " (reverseList config.environment.profiles)}"; 
                                                                                                      
      wantedBy = [ "default.target" ];                                                                
      serviceConfig = {                                                                               
        Type = "forking";                                                                             
        ExecStart = "${pkgs.emacs}/bin/emacs --daemon";                                               
        ExecStop = "${pkgs.emacs}/bin/emacsclient --eval (kill-emacs)";                               
        Restart = "always";                                                                           
      };                                                                                              
    };                                                                                                
  };                                                                                                  
}                                                                                                     

