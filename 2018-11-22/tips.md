## 通过lvm为机器新增磁盘

LVM 允许为已经存在的逻辑分区进行扩容



1. fdisk -l 查看未挂载的硬盘信息。如果硬盘没有分区信息，则说明是新加的硬盘

    ```
       Disk /dev/sdc: ............
       ..........
       Device Boot Start End Blocks Id System
    
       Disk /dev/sda: ..............
       Device Boot Start End Blocks Id System
       /dev/sda1 *
       /dev/sda2 
    ```

   *上面确认/dev/sdc是新加硬盘*

2. 使用fdisk /dev/sdc 进行磁盘分区，分别输入

   1. 分区

      n ->p (primary)->直接enter  (default 1) ->enter  (default 2048) ->enter  (default) 

   2. 修改类型为LVM

      t -> 8e

   3. 保存

      w

3. fdisk -l /dev/sdc查看新建的分区

   ```
   Disk /dev/sdc: ......
   Device Boot Start End Blocks Id System
   /dev/sdc1 
   ```

4. 新建物理卷(PV) && 查看pv信息

   ```bash
   pvcreate /dev/sdc1
     Physical volume "/dev/sdc1" successfully created
   pvdisplay /dev/sdc1
   ```

5. 创建卷组(VG)

   ```bash
   vgcreate VolData /dev/sdc1
   vgdisplay VolData
   ```

6. 创建逻辑卷(LV)

   ``` bash
   # 65535是上述vgdiplay看到的Total PE大小，这样就会使用整个硬盘
   # lvcreate -l65535 -n lv_data VolData
   
   # 创建100G大小的LV
   lvcreate -L 100G -n lv_data VolData
   ```

7. 格式化和挂载逻辑卷

   ```bash
   mkfs.xfs /dev/VolData/lv_data
   mkdir /data/
   mount /dev/VolData/lv_data /data/
   ```

8. 修改vim /etc/fstab,最后添加.

   ```bash
   /dev/mapper/VolData-lv_data /data xfs defaults 0 0
   ```

   这样启动后会自动挂载到/data



*参考资料：*

[Linux LVM简明教程](https://linux.cn/article-3218-1.html)
[Linux LVM硬盘管理及LVM扩容](http://www.cnblogs.com/gaojun/archive/2012/08/22/2650229.html)

