#include "main.h"
#include "SimulatorWin.h"
#include <shellapi.h>

//#define USING_SIMULATOR

#ifndef USING_SIMULATOR
USING_NS_CC;
#endif

int WINAPI _tWinMain(HINSTANCE hInstance,
	HINSTANCE hPrevInstance,
	LPTSTR    lpCmdLine,
	int       nCmdShow)
{
	UNREFERENCED_PARAMETER(hPrevInstance);
	UNREFERENCED_PARAMETER(lpCmdLine);
	
#ifdef USING_SIMULATOR
    auto simulator = SimulatorWin::getInstance();
    int ret = simulator->run();
#else
	AllocConsole();
	freopen("CONIN$", "r", stdin);
	freopen("CONOUT$", "w", stdout);
	freopen("CONOUT$", "w", stderr);

	AppDelegate app;
	int ret = Application::getInstance()->run();

	if (!ret)
	{
		system("pause");
	}
	FreeConsole();
#endif

	return ret;
}
