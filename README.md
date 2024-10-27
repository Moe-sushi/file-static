# README!!
`file` command needs an extra file that defines magic info of file types,      
so that the `file` command actually calls `file-static` (the real file command) with `--magic-file magic.mgc` argument, so that `file-static` knows where to read `magic.mgc`.            
So, you need to install `file` `file-static` and `magic.mgc` to the same folder in your $PATH.        
