@echo off&cls
set tit=多功能系统工具箱 Ultimate
color 0f&title %tit% -正在启动
setlocal enabledelayedexpansion
echo %tit% 正在启动，请稍候...
mode con lines=25 cols=80
rem ===开关=========================================
set statson=::
set tipson=0
rem ================================================
if exist "%windir%\taskmgr\bootauto.bat" call "%windir%\taskmgr\bootauto.bat"

:start
%statson%for /f %%a in (%windir%\taskmgr\boot.stats) do (set /a bootnum=%%a+1)&echo !bootnum!>"%windir%\taskmgr\boot.stats"
:insup
if not exist "%windir%\taskmgr\update.bat" goto chk
"%myfiles%\cido.exe" /msg "发现未安装的更新，是否安装？" "%tit%" "4"
if %errorlevel%==6 goto ins_y
if %errorlevel%==7 goto chk
goto insup
:ins_y
echo 按任意键开始安装.
pause>nul
call "%windir%\taskmgr\update.bat">nul
del /f "%windir%\taskmgr\update.bat">nul 2>nul
echo 安装完成
pause
:chk
if not exist tmrupdate.ini goto upn
echo 正在加载更新...
echo.
for /f "delims=, tokens=1" %%a in (tmrupdate.ini) do set f1=%%a
for /f "delims=, tokens=2" %%a in (tmrupdate.ini) do set f2=%%a
for /f "delims=, tokens=3" %%a in (tmrupdate.ini) do set f3=%%a
for /f "delims=, tokens=4" %%a in (tmrupdate.ini) do set f4=%%a
goto chkupok
:upn
set f1=0
set f2=0
set f3=0
set f4=0
:chkupok
if !f1!==1 (set flist="%windir%\taskmgr\flist.bat") else (set flist="%myfiles%\flist.bat")
if !f2!==1 (set lmlist="%windir%\taskmgr\lmlist.bat") else (set lmlist="%myfiles%\lmlist.bat")
if !f3!==1 (set pinfof="%windir%\taskmgr\pinfo") else (set pinfof="%myfiles%\pinfo")
if !f4!==1 (set danpf="%windir%\taskmgr\danp.bat") else (set danpf="%myfiles%\danp.bat")
set uperr=0
if !f1!==1 if not exist "%windir%\taskmgr\flist.bat" echo 垃圾文件数据更新出错，将使用默认垃圾文件数据.&set uperr=1&set flist="%myfiles%\flist.bat"
if !f2!==1 if not exist "%windir%\taskmgr\lmlist.bat" echo 流氓软件数据更新出错，将使用默认流氓软件数据.&set uperr=1&set lmlist="%myfiles%\lmlist.bat"
if !f3!==1 if not exist "%windir%\taskmgr\pinfo" echo 进程信息数据更新出错，将使用默认进程信息数据.&set uperr=1&set pinfof="%myfiles%\pinfo.bat"
if !f4!==1 if not exist "%windir%\taskmgr\danp.bat" echo 危险进程数据更新出错，将使用默认危险进程数据.&set uperr=1&set danpf="%myfiles%\danp.bat"
if !uperr!==1 echo.&echo 发现更新错误，修复错误的方法见说明文件.&pause

if exist "%windir%\taskmgr\date" (for /f "delims=# tokens=1" %%a in (%windir%\taskmgr\date) do set ljdate=%%a) else (set ljdate=2011年7月4日)
if exist "%windir%\taskmgr\date" (for /f "delims=# tokens=2" %%a in (%windir%\taskmgr\date) do set danpdate=%%a) else (set danpdate=2011年7月4日)

if not exist "taskmgr.ini" goto check
for /f "delims=" %%a in (taskmgr.ini) do set syst=%%a
if "!syst!"=="" echo %random%>taskmgr.ini&goto start
goto syst_1
:check
ver|findstr /i XP>nul &&goto xpy
ver|findstr /i /c:"[6.1.">nul &&goto win7y ||goto xpn
:xpy
set choice="%myfiles%\choicexp.exe"
set syst=0
goto wel
:win7y
set choice=choice
set syst=1
goto wel
:xpn
cls
echo 
echo 您的系统可能不是Windows XP，请选择您的操作系统:
echo [0] Windows XP
echo [1] Windows 7
set /p syst=请输入您的操作系统代号并按回车键确认.
echo !syst!>"taskmgr.ini"
:syst_1
if %syst%==0 goto xpy
if %syst%==1 set choice=choice&goto wel
goto xpn

:wel
mode con lines=25 cols=80
title %tit%  ◎内测版◎ --By:(╯‵□′)╯︵┻━┻
set cfgf="%windir%\taskmgrcfg.ini"
set tmpf="%windir%\taskmgrtmp.ini"
ping /l 1 /n 1 /w 100 61.135.169.105>nul &&set ntw=连接 ||set ntw=断开
if exist "%windir%\taskmgr\bootauto1.bat" call "%windir%\taskmgr\bootauto1.bat"
cls
echo.
echo.
echo                          多功能系统工具箱 Ultimate
echo.
echo                             [1] 电脑体检
echo                             [2] 进程管理
echo                             [3] 查找危险进程
echo                             [4] 扫描垃圾文件
echo                             [5] 查看系统配置信息
echo                             [6] 系统服务优化
echo                             [7] 插件
echo                             [8] 设置
echo                             [9] 关于
echo                             [U] 在线更新
echo                             [0] 退出
echo.
if !syst!==0 echo 当前模式：Windows XP
if !syst!==1 echo 当前模式：Windows 7
if exist "tmrupdate.ini" (for /f "skip=1" %%a in (tmrupdate.ini) do set ver=%%a)
if "!ver!"=="1,1,1,1" set ver=4.0.0.0
if "%ver%"=="" set ver=4.0.0.0
echo 当前版本：%ver%
echo 网络状况：%ntw%
echo.
%choice% /c 123456789u0 /n /m "请选择要进行的操作："
if %errorlevel%==1 goto test
if %errorlevel%==2 goto task
if %errorlevel%==3 goto danp
if %errorlevel%==4 goto trash
if %errorlevel%==5 goto info
if %errorlevel%==6 goto sc
if %errorlevel%==7 goto plugins
if %errorlevel%==8 set a1=1&goto config
if %errorlevel%==9 goto about
if %errorlevel%==10 goto chkup
if %errorlevel%==11 exit
:test
title %tit% -电脑体检
cls
echo.
echo 按任意键开始体检.
pause>nul
"%myfiles%\CIdo.exe" /bs 80 300
%statson%for /f %%a in (%windir%\taskmgr\test.stats) do (set /a testnum=%%a+1)&echo !testnum!>%windir%\taskmgr\test.stats
echo 正在扫描系统盘...
dir %systemdrive%\ /s /b>"%windir%\dir.tmr"
echo.
echo ================================================================================
echo 正在检测垃圾文件...
call %flist%>"%windir%\trashlst.tmr"
call %flist%
set numa=
for /f  %%a in ('type %windir%\trashlst.tmr') do set /a numa+=1
echo.
echo !numa!个垃圾文件
echo ================================================================================
echo 正在检测额外的启动项...
if %syst%==0 dir "%userprofile%\「开始」菜单\程序\启动\" /b>"%windir%\bootlst.tmr"
if %syst%==1 dir "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\" /b>"%windir%\bootlst.tmr"
set numb=
for /f  %%a in ('type %windir%\bootlst.tmr') do set /a numb+=1
if "!numb!"=="" set /a numb=0
echo.
echo !numb!个启动项

::流氓软件
echo ================================================================================
echo 正在检测流氓软件...
set numc=0
call %lmlist%>"%windir%\lmlst.tmr"
call %lmlist%
set numc=
for /f  %%a in ('type %windir%\lmlst.tmr') do set /a numc+=1
if "!numc!"=="" set /a numc=0
echo.
echo !numc!个流氓软件
echo ================================================================================

::空闲
echo 正在检测系统盘可用空间...
dir %systemdrive%\|findstr 可用字节>"%windir%\free2.tmr"
for /f "delims=" %%x in (%windir%\free2.tmr) do (set a=%%x&echo !a:,=!>"%windir%\free2.tmr")
for /f "tokens=3" %%a in (%windir%\free2.tmr) do set free2=%%a
set free2=%free2:~0,-9%
echo 系统盘可用空间:!free2!GB
echo ================================================================================
echo 检测完成.

set /a score=150-!numa!-!numb!-!numc!+!free2!
echo 电脑体检得分：!score!
if not exist "%windir%\tijian.tmr" echo 此分数仅供参考，没有最高分和最低分。&echo %random%>"%windir%\tijian.tmr"
echo.
echo ==建议:=========================================================================
if !numa! geq 80 echo 垃圾文件过多.建议扫描垃圾文件.
if !numb! geq 3 echo Startup中的启动项过多.建议手动清除"「开始」菜单\程序\启动\"中的启动项.
if !numc! geq 5 echo 流氓软件过多。建议使用杀毒软件清除.
if !free2! leq 5 echo 系统盘剩余空间小于5GB.建议释放系统盘空间.
echo ================================================================================
echo.
if !score! gtr 70 echo 按任意键返回.&pause>nul&goto wel
echo "%myfiles%\cido.exe" /msg "体检得分较低，建议使用专业软件进行修复." "%tit%" "0"
echo 按任意键返回.
pause>nul
goto wel

:task
title %tit% -进程管理
cls
if exist "%cfgf%" goto task1
echo.
echo 您是第一次使用进程管理，请进行设置.&set a1=0&goto config1
:task1
"%myfiles%\CIdo.exe" /bs 80 300
set p=
echo.
for /f "delims=, tokens=1" %%a in (%windir%\taskmgrcfg.ini) do (set p=%%a)
for /f "delims=, tokens=2" %%a in (%windir%\taskmgrcfg.ini) do (set p1=%%a)
if %p%==-- set p=
tasklist%p%%p1%
echo [1] 刷新 [2] 结束进程 [3] 查看进程简介 [0] 返回主菜单
%choice% /c 1230 /m "请选择要进行的操作："
if %errorlevel%==1 goto task
if %errorlevel%==2 goto kill
if %errorlevel%==3 goto jianjie
if %errorlevel%==4 goto wel

:kill
echo.
echo 结束进程
echo .
echo 请选择结束进程的方式.
echo [1] 用进程名方式结束
echo [2] 用PID方式结束（用于强行结束，慎用）
echo [0] 返回
%choice% /c 120 /m "请选择："
if %errorlevel%==1 goto kill_name
if %errorlevel%==2 goto kill_pid
if %errorlevel%==3 goto task

:kill_name
cls
tasklist%p%%p1%
echo.
echo 用进程名方式结束进程.
set pname=
set /p pname=请输入进程名并按回车键结束进程：
if "%pname%"=="" goto kill_name
if %pname%==cmd.exe echo 无法结束cmd.exe!&echo 按任意键返回.&pause>nul&goto task
taskkill /f /im %pname%
echo 请按任意键返回.
pause>nul
goto task

:kill_pid
cls
tasklist%p%%p1%
echo.
if %syst%==1 "%myfiles%\cido.exe" /msg "Windows 7下不能使用此方式结束进程." "%tit%" "0"&goto kill
echo 用PID方式结束进程.
echo 警告：此方式用于强行结束进程。
echo 如果系统进程被结束，有发生蓝屏的危险！
set pid=
set /p pid=请输入进程PID：
if "%pid%"=="" goto kill_pid
ntsd -c q -p %pid%
if errorlevel 1 echo 进程PID:%pid%不存在,请重新输入.
if errorlevel 0 echo 进程%pid%已被终止.
echo 请按任意键返回.
pause>nul
goto task

:jianjie
cls
tasklist%p%%p1%
echo.
set /p pinfo=请输入要查看的进程：
if "%pinfo%"=="" goto jianjie
findstr /i /c:"%pinfo%" %pinfof%
if errorlevel 1 echo 没有找到此进程的简介.
echo 请按任意键返回.
pause>nul
goto task

:info
"%myfiles%\CIdo.exe" /bs 80 300
title %tit% -系统配置信息
cls
echo 正在收集系统信息...
echo ===============================================================================
systeminfo
echo ===============================================================================
%choice% /c 10 /m "[1] 将系统信息保存到文件 [0] 返回"
if %errorlevel%==1 goto info_y
if %errorlevel%==2 goto wel

:info_y
echo 请输入目标文件路径或将目标文件拖拽到此窗口内并按回车键确认.
set outf=
set /p outf=
systeminfo>>%outf%
echo 输出已完成,请按任意键返回.
pause>nul
goto wel



:danp
title %tit% -查找危险进程
cls
echo 危险进程数据更新日期：%danpdate%
echo.
echo 请按任意键开始扫描.
pause>nul
"%myfiles%\CIdo.exe" /bs 80 300
echo 正在查找危险进程，请耐心等待...
set num=0
echo ===============================================================================
call %danpf%
echo ===============================================================================
echo.
echo 扫描结果：
%statson%for /f %%a in (%windir%\taskmgr\danp.stats) do (set /a danpnum=%%a+!num!)&echo !danpnum!>%windir%\taskmgr\danp.stats
if !num!==0 echo 没有发现危险进程.您的系统安全状况：安全.
if !num! geq 1 if !num! lss 5 echo 共发现!num!个危险进程.您的系统安全状况：一般.
if !num! geq 5 if !num! lss 10 echo 共发现!num!个危险进程.您的系统安全状况：危险，建议立即全盘杀毒.
if !num! geq 10 echo 共发现!num!个危险进程.您的系统安全状况：高危，建议重装系统.
%choice% /c 10 /m "[1] 查看当前进程 [0] 返回主菜单"
if %errorlevel%==1 goto task
if %errorlevel%==2 goto wel

:config
title %tit% -设置
cls
echo.
echo 设置
echo.
:config1
echo.
echo 1.进程信息中显示的项目：
echo [1] 默认
echo [2] 进程加载的模块(DLL)
echo [3] 进程使用的服务
echo [4] 进程详细信息

echo 请输入要在进程信息中显示的项目的序号（不可多选）.
%choice% /c 1234 /m "请选择："
if %errorlevel%==1 set choi1=--
if %errorlevel%==2 set choi1= /m
if %errorlevel%==3 set choi1= /svc
if %errorlevel%==4 set choi1= /v
echo.
echo 2.进程信息显示格式：
echo [1] 标准（默认）
echo [2] 列表
echo [3] 清单
echo 请输入您选择的显示格式的序号（不可多选）.
%choice% /c 123 /m "请选择："
if %errorlevel%==1 set choi2= /fo table
if %errorlevel%==2 set choi2= /fo list
if %errorlevel%==3 set choi2= /fo csv
echo 按任意键保存设置.
pause>nul
echo !choi1!,!choi2!>%cfgf%
echo 设置已保存,按任意键返回.
pause>nul
if %a1%==0 goto task
if %a1%==1 goto wel



:trash
title %tit% -扫描垃圾文件
cls
echo 垃圾文件数据更新日期：%ljdate%
set dirtmp="%windir%\dir.tmr"
set str=C D E F G H I J K L M N O P Q R S T U V W X Y Z
echo 当前存在的磁盘分区有：
for %%i in (%str%) do if exist %%i: echo %%i
set drive=
set /p drive=请输入要扫描的盘符(不需要冒号)并按回车键确认.
if "%drive%"=="" goto trash
"%myfiles%\CIdo.exe" /bs 80 300
echo 正在扫描...
echo.
echo 垃圾文件：
echo ================================================================================
dir %drive%:\ /s /b>"%windir%\dir.tmr"
call %flist%
echo ================================================================================
echo 正在进行收尾工作，请稍候...
call %flist%>"%windir%\trashlst.tmr"
echo 扫描完成.
dir %drive%:\|findstr 可用字节>"%windir%\free0.tmr"
for /f "delims=" %%x in (%windir%\free0.tmr) do (set a=%%x&echo !a:,=!>"%windir%\free0.tmr")
for /f "tokens=3" %%a in (%windir%\free0.tmr) do set free0=%%a
set free0=%free0:~0,-3%
set num=
for /f  %%a in ('type %windir%\trashlst.tmr') do set /a num+=1
%statson%for /f %%a in (%windir%\taskmgr\lj.stats) do (set /a ljnum=%%a+!num!)&echo !ljnum!>%windir%\taskmgr\lj.stats
if !num!==0 echo 没有发现垃圾文件.您的系统状况：良好.
if !num! geq 1 if !num! lss 30 echo 共发现!num!个垃圾文件.您的系统状况：良好.
if !num! geq 30 if !num! lss 120 echo 共发现!num!个垃圾文件.您的系统状况：一般，建议清除垃圾文件.
if !num! geq 120 if !num! lss 300 echo 共发现!num!个垃圾文件.您的系统状况：较差，建议使用专业清理软件清除.
if !num! geq 300 echo 共发现!num!个垃圾文件.您的系统安全状况：极差，建议重装系统.
%choice% /c 120 /m "[1] 清除垃圾文件 [2] 保存垃圾文件列表 [0] 返回主菜单"
if %errorlevel%==1 goto clear
if %errorlevel%==2 goto savelog
if %errorlevel%==3 goto wel

:clear
echo.
echo 选择一种清理方式.
%choice% /c 120 /m "[1] 刚才扫描出的垃圾文件 [2] 导入垃圾文件列表 [0] 返回主菜单"
if %errorlevel%==1 goto clear_01
if %errorlevel%==2 goto clear_02
if %errorlevel%==3 goto wel

:clear_02
echo 请选择垃圾文件列表文件（输入或拖拽）.
set /p logf=
for /f "delims=" %%a in (%logf%) do echo %%a>"%windir%\clear.tmr"
goto clear_03
:clear_01
echo 按任意键开始清理.
pause>nul
echo.
echo 正在清理，请稍候...
call %flist%>"%windir%\clear.tmr"
:clear_03
for /f "delims=" %%a in (%windir%\clear.tmr) do del /f /q "%%a"
dir %drive%:\|findstr 可用字节>"%windir%\free1.tmr"
for /f "delims=" %%x in (%windir%\free1.tmr) do (set a=%%x&echo !a:,=!>"%windir%\free1.tmr")
for /f "tokens=3" %%a in (%windir%\free1.tmr) do set free1=%%a
set free1=%free1:~0,-3%
set /a free=%free1%-%free0%
echo.
echo 清除成功，共释放%free%KB磁盘空间.
%statson%for /f %%a in (%windir%\taskmgr\free.stats) do (set /a freenum=%%a+!free!)&echo !freenum!>%windir%\taskmgr\free.stats
echo 按任意键返回主菜单.
pause>nul
goto wel
:savelog
echo 请选择目标文件（输入或拖拽）并按回车键确认:
set /p tgtf=
call %flist%>>"%tgtf%"
echo 结果已保存,
%choice% /c 10 /m "[1] 返回垃圾文件清理 [0] 返回主菜单"
if %errorlevel%==1 goto trash
if %errorlevel%==2 goto wel

:sc
title %tit% -系统服务优化
cls
mode con lines=25 cols=80
set errorlevel=
if !syst!==1 (set dis=（禁用）) else (set dis=)
if !syst!==0 set moren=Windows XP默认&set morenf="%myfiles%\moren.bat"
if !syst!==1 set moren=Windows 7最佳方案&set morenf="%myfiles%\moren7.bat"
echo.
echo 请选择一个优化方案：
echo [1] %moren%
echo [2] 办公室模式%dis%
echo [3] 笔记本模式%dis%
echo [4] 网吧模式%dis%
echo [5] 校园模式%dis%
echo [6] 查看说明
echo [0] 返回
echo.
%choice% /c 1234560 /m "请选择:"
if %errorlevel%==1 echo 按任意键开始优化&pause>nul&call %morenf%&echo 优化完成,按任意键返回主菜单&pause>nul&goto wel
if %errorlevel%==2 if !syst!==1 (goto svcdis) else (echo 按任意键开始优化&pause>nul&call "%myfiles%\office.bat"&echo 优化完成,按任意键返回主菜单&pause>nul&goto wel)
if %errorlevel%==3 if !syst!==1 (goto svcdis) else (echo 按任意键开始优化&pause>nul&call "%myfiles%\laptop.bat"&echo 优化完成,按任意键返回主菜单&pause>nul&goto wel)
if %errorlevel%==4 if !syst!==1 (goto svcdis) else (echo 按任意键开始优化&pause>nul&call "%myfiles%\netbar.bat"&echo 优化完成,按任意键返回主菜单&pause>nul&goto wel)
if %errorlevel%==5 if !syst!==1 (goto svcdis) else (echo 按任意键开始优化&pause>nul&call "%myfiles%\school.bat"&echo 优化完成,按任意键返回主菜单&pause>nul&goto wel)
if %errorlevel%==6 "%myfiles%\CIdo.exe" /bs 80 300&type "%myfiles%\screadme"&echo.&echo 按任意键返回&pause>nul&goto sc
if %errorlevel%==7 goto wel

:svcdis
echo.
"%myfiles%\cido.exe" /msg "此方案不适用于Windows 7" "%tit%" "0"
goto sc



:about
cls
title %tit% -关于
echo.
echo                             关于软件
echo 多功能系统工具箱 Ultimate
echo 版本号：%ver%




echo                                        设计制作：(╯‵□′)╯︵┻━┻
echo                                   百度空间：http://hi.baidu.com/(╯‵□′)╯︵┻━┻/
echo                                   网盘：http://(╯‵□′)╯︵┻━┻.ys168.com
echo.
%choice% /c 120 /m "[1] 打开百度空间 [2] 打开网盘 [0] 返回"
if %errorlevel%==1 start "" "http://hi.baidu.com/(╯‵□′)╯︵┻━┻/"&goto about
if %errorlevel%==2 start "" "http://(╯‵□′)╯︵┻━┻.ys168.com"&goto about
if %errorlevel%==3 goto wel
pause
goto wel

:plugins
cls
title %tit% -插件
"%myfiles%\CIdo.exe" /bs 80 300
echo.
echo 插件
echo.
echo    [A] 下载新插件
echo    [0] 返回
echo ==插件列表======================================================================
if exist "%windir%\taskmgr\pluginlst" (
for /f "delims=" %%a in (%windir%\taskmgr\pluginlst) do echo %%a
) else (
echo 没有安装任何插件)
echo ================================================================================
set /p plgid=请输入插件的序号并按回车键确认：
if %plgid%==a start "" "http://(╯‵□′)╯︵┻━┻.ys168.com"&goto plugins
if %plgid%==0 goto wel
if not exist "%windir%\taskmgr\plg%plgid%.bat" "%myfiles%\cido.exe" /msg "插件不存在." "%tit%" "0"&goto plugins
call "%windir%\taskmgr\plg%plgid%.bat"
goto plugins




















  
