; Quick Launcher Appbar                                           :: By Skan - 28/Aug/2007
; Edited by qwerty12 24/Mar/2017
; Editing by ashtefere 17/Feb/2019

SetBatchLines -1

ABM := DllCall( "RegisterWindowMessage", Str,"AppBarMsg", "UInt" )
OnMessage( ABM, "ABM_Callback" )

VarSetCapacity( APPBARDATA , (cbAPPBARDATA := A_PtrSize == 8 ? 48 : 36), 0 )
Off :=  NumPut(  cbAPPBARDATA, APPBARDATA, "Ptr" )
Off :=  NumPut( hAB, Off+0, "Ptr" )
Off :=  NumPut( ABM, Off+0, "UInt" )
Off :=  NumPut(   1, Off+0, "UInt" ) 
Off :=  NumPut(  0, Off+0, "Int" ) 
Off :=  NumPut(  0, Off+0, "Int" ) 
Off :=  NumPut(  3440, Off+0, "Int" ) 
Off :=  NumPut(  32, Off+0, "Int" )
Off :=  NumPut(   1, Off+0, "Ptr" )

GoSub, RegisterAppBar

OnExit, QuitScript
Return

RegisterAppBar:
  DllCall("Shell32.dll\SHAppBarMessage", UInt,(ABM_NEW:=0x0)     , Ptr,&APPBARDATA )
  DllCall("Shell32.dll\SHAppBarMessage", UInt,(ABM_QUERYPOS:=0x2), Ptr,&APPBARDATA )
  DllCall("Shell32.dll\SHAppBarMessage", UInt,(ABM_SETPOS:=0x3)  , Ptr,&APPBARDATA )
Return

RemoveAppBar:
  DllCall("Shell32.dll\SHAppBarMessage", UInt,(ABM_REMOVE := 0x1), Ptr,&APPBARDATA )
Return

ABM_Callback( wParam, LParam, Msg, HWnd ) {
; Not much messages received. When Taskbar settings are
; changed the wParam becomes 1, else it is always 2
}

QuitScript:
  GoSub, RemoveAppbar
  ExitApp
Return