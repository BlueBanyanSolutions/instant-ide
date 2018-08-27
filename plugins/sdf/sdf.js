define(function(require, exports, module) {
    main.consumes = ["Plugin", "commands", "ui", "menus", "proc", "console", "tabManager"];
    main.provides = ["bb.sdf"];
    return main;

    function main(options, imports, register) {
        var Plugin = imports.Plugin;
        var commands = imports.commands;
        var ui = imports.ui;
        var menus = imports.menus;
        var proc = imports.proc;
        var tabManager = imports.tabManager;
        var consl = imports.console;
        
        /***** Initialization *****/
        
        var plugin = new Plugin("Ajax.org", main.consumes);
        var emit = plugin.getEmitter();
        
        
        
        var loaded = false;
        function load() {
            if(loaded) return false;
            loaded = true;
            
            commands.addCommand({
                name: "sdf_deploy",
                exec: function() {
                    deploy();
                }
            }, plugin);
            
            menus.addItemByPath("Run/~", new ui.divider(), 10900, plugin);
        
            menus.addItemByPath("Run/SDF Deploy", new ui.item({
                command: "sdf_deploy"
            }), 10901, plugin);
        }
        
        /***** Methods *****/
        function deploy(){
            // alert("deploy!");
            console.log(tabManager.getTabs());
            tabManager.openEditor("terminal", true, function(err, tab) {
                if (err) throw err;
            
                var terminal = tab.editor;
                var sdfcli = proc.spawn(
                  'sdfcli', 
                  { 
                      stdio: ['pipe'],
                      args: []
                  }, function (err, process) {
                      if (err) return terminal.write(err);
                      
                      process.stdout.on('data', data => {
                        terminal.write(data);
                      });
                  }
                );
            });
        }
        
        
        /***** Lifecycle *****/
        
        
        plugin.on("load", function() {
            load();
        });
        plugin.on("unload", function() {
            loaded = false;
        });
        
        /***** Register and define API *****/
        
        plugin.freezePublicAPI({
            
        });
        
        register(null, {
            "bb.sdf": plugin
        });
    }
});
