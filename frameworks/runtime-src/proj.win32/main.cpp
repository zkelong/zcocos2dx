#include "main.h"
#include "SimulatorWin.h"
#include "AppDelegate.h"
#include <shellapi.h>

//#define USING_SIMULATOR
#define USING_WIN32_CONSOLE

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
#ifdef USING_WIN32_CONSOLE
	AllocConsole();
	freopen("CONIN$", "r", stdin);
	freopen("CONOUT$", "w", stdout);
	freopen("CONOUT$", "w", stderr);
#endif

	AppDelegate app;
	int ret = Application::getInstance()->run();

#ifdef USING_WIN32_CONSOLE
	if (!ret)
	{
		system("pause");
	}
	FreeConsole();
#endif
#endif

	return ret;
}
