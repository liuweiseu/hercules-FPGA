::�رջ���
@ECHO OFF
::�������·��
::SET debussy=C:\Novas\Debussy\bin\Debussy.exe
SET vsim=D:\modeltech_10.1a\win32\vsim.exe
::Modelsim Command
start %vsim% -c -do sim.do

::ɾ��Modelsim���ɵ�����ļ�
::RD work /s /q
::DEL transcript vsim.wlf /q

::Debussy Command
::START %debussy% -f top.f +define+SIM -ssf test.fsdb -2001

::�˳�������
EXIT
