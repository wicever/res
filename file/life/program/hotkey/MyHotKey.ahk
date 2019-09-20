#NoTrayIcon
#n::run notepad
!a::Run D:\Develop\IBM\Notes\admin.exe
!b::Run www.baidu.com
!c::
Run D:\Program\GoogleChromePortable\ChromePortable.exe
WinWait 打开新的标签页,,0
Send baidu.com{space}{Enter}
Return
!d::Run D:\Develop\eclipse\eclipse.exe -nl "en_US"
!e::Run D:\Program\Other\Everything.exe
!f::Run D:\Develop\Workspaces
!g::Run D:\Develop\PortableGit\git-bash.exe
!h::Run D:\Program\Other\iHosts.exe
!k::Run D:\Program\Other\KillNotes.exe
#!m::Run mstsc
!m::Run D:\Develop\MobaXterm\crack\MobaXterm.exe
!n::Run notepad
!p::Send password
!q::Run D:\Program\QQ\Bin\QQ.exe
!r::Run D:\Program\FSCapture 8.2\FSCapture.exe
!s::Run D:\Develop\SublimeText 33095\SublimeText.exe
!t::Run C:\Program Files (x86)\TeamViewer\TeamViewer.exe
!v::Send (https://raw.githubusercontent.com/wicever/res/master/img/work/)
!w::Run D:\Program\WizNote\Wiz.exe
!y::Run D:\Program\YY\YY.exe
!2::Send 20509521*{Enter}