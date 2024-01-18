::关闭回显
@ECHO OFF
::设置软件路径
::SET debussy=C:\Novas\Debussy\bin\Debussy.exe
SET vsim=D:\modeltech_10.1a\win32\vsim.exe
::Modelsim Command
start %vsim% -c -do sim.do

::删除Modelsim生成的相关文件
::RD work /s /q
::DEL transcript vsim.wlf /q

::Debussy Command
::START %debussy% -f top.f +define+SIM -ssf test.fsdb -2001

::退出命令行
EXIT
