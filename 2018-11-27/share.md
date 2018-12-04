## What's a CPU to do when it has nothing to do?

link: https://lwn.net/Articles/767630/

当cpu空闲空转的时候，系统会让cpu进入睡眠状态来降低功耗。

但不是所有cpu空转的时候都会让它进入睡眠，因为cpu进入睡眠状态和从睡眠状态中唤醒，都会消耗比平时多的电量。
所以如果cpu空转时间较短，系统不进入睡眠模式反而更省电。
所有一般系统会有些测略来预估cpu进入空转时间的长短，

idle-> scheduler -> stop/running

在4.16之前的linux版本，在进入调度器前会先停止tick（cpu时钟）
在4.17之后的版本，tick是在调度器作出决定后再启动或停止。
文中的核心就是这一点，重写调度机制后，linux耗能降低了很多。
