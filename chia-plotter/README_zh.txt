chia-plotter 用法：

  执行的命令具体动作
  -action string
        The action name. Support plotting,keys,sign (default "plotting")

  1.P盘 命令参数：-action plotting
  -plotting-fpk string      这个不用设置，用默认的。
        The farmer public key. Use -action=keys generate this. (default "0x866753d751b9f1ffb8e3a74f5cdc0c45231bfef2e59d17ad89d0d7056b8b6b815f5ae5064842ca1dc27a2d52099f2755")
  -plotting-ppk string      这个不用设置，用默认的。
        The pool public key. Use -action=keys generate this. (default "0x86e821a162fb2819e5601abb2ce45be4e22d56cada7b8ac3d4b88d94daaa075e69ca375cdc94996a6d35bf55ef17151f")
  -plotting-cpu string      CPU关联。0,1,2,3,4... 多个用英文逗号隔开。应该与-r参数搭配使用。
        Set CPU affinity. Example 0,1 will affinity 0 and 1 cores
  -plotting-exec string     ProofOfSpace 程序的路径。ProofOfSpace 为Chia真正的P盘软件，不用手动启动。
        The ProofOfSpace executable path (default "./ProofOfSpace")
  -plotting-n int           生成文件的数量。
        Batch plotting count (default 1)
  -b uint
        Megabytes to be used as buffer for sorting and plotting (default 3389)
  -d string                 最终生成的文件目录。
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
  -t string                 缓存目录。最好是SSD。
        Temporary directory (default ".")
  -u uint
        Number of buckets (default 128)
  -p Display progress percentage during plotting

  2.生成P盘参数 命令参数：-action keys
  -keys-mnemonic string     chia钱包的脑密码。
        The mnemonic word

  3.制作参与到矿池挖矿签名 命令参数：-action sign
  -sign-address string      矿池的地址。
       The address (default "txch1f0ryxk6qn096hefcwrdwpuph2hm24w69jnzezhkfswk0z2jar7aqe99hgp")
  -sign-mnemonic string     chia钱包的脑密码。
       The mnemonic word
  -sign-rsapk string        签名的公钥。不用填写。
       The rsa public key for signature encrypt. Optional
