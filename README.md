# git-new-old-file

## 说明

这个脚本用于生成两笔 git 提交之间的新老文件。

## 使用

执行脚本，并使用两个参数，第一个参数是开始提交的hash值，第二个是结束时提交的hash值，例如：

```BASH
$ ./git-new-old-file.sh 939341c34897f0a018b396493f8bb3389f806048 de4d0c34f3db018fe807b3834b91ef938fa62cc8
```

执行完成后会在本地生成一个 `patch` 文件夹，里面包含开始提交时候的文件 `old`，和提交后的文件 `new`。

例如：

```TEXT
├───📄 git-new-old-file.sh
└───📁 patch
    ├───📁 new/
    │   └───...
    └───📁 old/
        └───...
```

如果想包含起始的提交，可以在第一个参数位置添加 `^` 符号：

```BASH
$ ./git-new-old-file.sh 939341c34897f0a018b396493f8bb3389f806048^ de4d0c34f3db018fe807b3834b91ef938fa62cc8
```