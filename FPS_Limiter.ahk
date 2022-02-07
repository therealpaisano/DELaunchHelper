low := false
$*F9::
{
	ControlClick, x140 y180, RivaTunerStatisticsServer,,,
	if(low)
	{
		ControlClick, x480 y230, RivaTunerStatisticsServer,,,
		ControlSend, ahk_parent, {Numpad2}{Numpad5}{Numpad0}{enter}, RivaTunerStatisticsServer,,,
		low := false
	}
	else
	{
		ControlClick, x480 y230, RivaTunerStatisticsServer,,,
		ControlSend, ahk_parent, {Numpad6}{Numpad0}{enter}, RivaTunerStatisticsServer,,,
		low := true
	}
}