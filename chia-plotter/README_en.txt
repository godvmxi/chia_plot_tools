chia-plotter Usage：

  Boost action:
  -action string
        The action name. Support plotting,keys,sign (default "plotting")

  1.Plotting. Boost by：-action plotting
  -plotting-fpk string
        The farmer public key. Use -action=keys generate this. (default "0x866753d751b9f1ffb8e3a74f5cdc0c45231bfef2e59d17ad89d0d7056b8b6b815f5ae5064842ca1dc27a2d52099f2755")
  -plotting-ppk string
        The pool public key. Use -action=keys generate this. (default "0x86e821a162fb2819e5601abb2ce45be4e22d56cada7b8ac3d4b88d94daaa075e69ca375cdc94996a6d35bf55ef17151f")
  -plotting-cpu string
        Set CPU affinity. Example 0,1 will affinity 0 and 1 cores
  -plotting-exec string
        The ProofOfSpace executable path (default "./ProofOfSpace")
  -plotting-n int
        Batch plotting count (default 1)
  -b uint
        Megabytes to be used as buffer for sorting and plotting (default 3389)
  -d string
        Final directory (default ".")
  -e    Disable bitfield
  -k int
        Plot size (default 32)
  -2 string
         Second Temporary directory (default ".")
  -r uint
        Number of threads (default 2)
  -s uint
        Size of stripes (default 65536)
  -t string
        Temporary directory (default ".")
  -u uint
        Number of buckets (default 128)
  -p Display progress percentage during plotting

  2.Create Plotting Input. Boost by：-action keys
  -keys-mnemonic string
        The mnemonic word

  3.Create signature for pool mining. Boost by：-action sign
  -sign-address string
       The address (default "txch1f0ryxk6qn096hefcwrdwpuph2hm24w69jnzezhkfswk0z2jar7aqe99hgp")
  -sign-mnemonic string
       The mnemonic word
  -sign-rsapk string
       The rsa public key for signature encrypt. Optional
