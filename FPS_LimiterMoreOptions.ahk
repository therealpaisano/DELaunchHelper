low := true
$*4::
{
	ControlClick, x140 y180, RivaTunerStatisticsServer,,,
	if(low)
	{
		ControlClick, x480 y230, RivaTunerStatisticsServer,,,
		ControlSend, ahk_parent, {Numpad2}{Numpad5}{Numpad0}{enter}, RivaTunerStatisticsServer,,,
		low := false
	}
}
$*F2::
{
	ControlClick, x140 y180, RivaTunerStatisticsServer,,,
	if(low)
	{
		ControlClick, x480 y230, RivaTunerStatisticsServer,,,
		ControlSend, ahk_parent, {Numpad1}{Numpad7}{Numpad0}{enter}, RivaTunerStatisticsServer,,,
		low := false
	}
}
$*5::
{
	ControlClick, x140 y180, RivaTunerStatisticsServer,,,
	if(low)
	{
		ControlClick, x480 y230, RivaTunerStatisticsServer,,,
		ControlSend, ahk_parent, {Numpad1}{Numpad4}{Numpad4}{enter}, RivaTunerStatisticsServer,,,
		low := false
	}
}
$*2::
{
	ControlClick, x140 y180, RivaTunerStatisticsServer,,,
	if(low)
	{
		ControlClick, x480 y230, RivaTunerStatisticsServer,,,
		ControlSend, ahk_parent, {Numpad6}{Numpad0}{enter}, RivaTunerStatisticsServer,,,
		low := false
	}
}
$*7::
{
	ControlClick, x140 y180, RivaTunerStatisticsServer,,,
	if(low)
	{
		ControlClick, x480 y230, RivaTunerStatisticsServer,,,
		ControlSend, ahk_parent, {Numpad3}{Numpad0}{enter}, RivaTunerStatisticsServer,,,
		low := false
	}
}
$*6::
{
	ControlClick, x140 y180, RivaTunerStatisticsServer,,,
	if(low)
	{
		ControlClick, x480 y230, RivaTunerStatisticsServer,,,
		ControlSend, ahk_parent, {Numpad1}{Numpad0}{enter}, RivaTunerStatisticsServer,,,
		low := false
	}
}
$*F1::
{
	ControlClick, x140 y180, RivaTunerStatisticsServer,,,
	if(low)
	{
		ControlClick, x480 y230, RivaTunerStatisticsServer,,,
		ControlSend, ahk_parent, {Numpad1}{Numpad0}{Numpad0}{enter}, RivaTunerStatisticsServer,,,
		low := false
	}
}
low := true