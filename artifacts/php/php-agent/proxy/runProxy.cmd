@Echo off
SETLOCAL EnableDelayedExpansion

REM This should always be 120m or larger.
set maxHeapSize=120m
set minHeapSize=50m

set verbose=

REM Set proxyDebugPort to a valid TCP port number to attach a java
REM debugger to the proxy.
set proxyDebugPort=5005

REM Set startSuspended to a non empty string to debug proxy startup
REM with a java debugger.
REM set startSuspended=y

REM set httpProxyHost=
REM set httpProxyPort=

REM set commTcpPort=

:: pushd "%0%\*%" >NUL
set containingDir=%cd%
:: popd >NUL

set proxyDir=%containingDir%
set logsDir=
set ok=1
set optspec=":r:d:j:vh-:"
set defaultProxyControlPort=10101

if "%1" == "-d" (
    set proxyDir=%2
    shift
    shift
)

if "%1" == "-r" (
    set proxyRuntimeDir=%2
    shift
    shift
)

if "%1" == "-j" (
    set jreDir=%2
    shift
    shift
)

if "%1" == "--" (
    shift
)

REM counting the number of arguments
set argC=0
for %%x in (%*) do Set /A argC+=1

if %argC% LSS 1 (
    echo "Missing required logs directory argument, using %proxyDir%\logs " >&2
    mkdir %proxyDir%\logs >nul 2>&1
    set logsDir=%proxyDir%\logs
) else (
    set logsDir=%1
    shift
)

if %argC% LSS 2 (
    echo "Missing defaultProxyPort, using 10101 " >&2
    set defaultProxyControlPort=10101
) else (
    set defaultProxyControlPort=%1
    shift
)

if not defined logsDir (
    echo "Proxy logs directory, \"%logsDir%\", does not exist or is not a directory." >&2
    set ok=0
)

if not defined proxyDir (
    echo "Proxy installation directory, \"%proxyDir%\", does not exist or is not a directory." >&2
    set ok=0
)

if "%ok%" == "0" (
    echo usage
    pause
    exit 1
)

if not defined jreDir set jreDir=%proxyDir%\jre

set javaExe=%jreDir%\bin\java.exe
if not exist %javaExe% (
    echo "Java executable, %javaExe%, is not an executable file." >&2
    echo "Please specify the location of the proxy installation directory with -d or the JRE directory with -j." >&2
    set ok=0
)

if defined httpProxyHost (
    if not defined httpProxyPort (
        echo "If httpProxyHost is specified then httpProxyPort must also be specified!" >&2
        set ok=0
    )
)

if "%ok%" == "0" (
    echo usage
    pause
    exit 1
)

set libraryPath=%proxyDir%\lib\tp
if defined proxyDebugPort (
    if "%proxyDebugPort%" GTR "0" (
            if defined startSuspended (
                echo "startSuspended set"
                set startSuspended=y
            ) else (
                echo "startSuspended not set"
                set startSuspended=n
            )
            set debugOpt="-agentlib:jdwp=transport=dt_socket,server=y,suspend="!startSuspended!",address=%proxyDebugPort%"
        )
    )

    set cmdLine=%javaExe%
REM    set cmdLine=%javaExe% -server
REM    if defined debugOpt (
REM        set cmdLine=%cmdLine% %debugOpt%
REM    )
    set cmdLine=%cmdLine% -Xmx%maxHeapSize%
    set cmdLine=%cmdLine% -Xms%minHeapSize%
    set cmdLine=%cmdLine% -classpath
    set cmdLine=%cmdLine% %proxyDir%\conf\logging;%proxyDir%\*;%proxyDir%\..\jzmq\perf;%proxyDir%\lib\*;%proxyDir%\lib\tp\*;
    set cmdLine=%cmdLine% -Djava.library.path=%libraryPath%;%proxyDir%\..\jzmq\;%proxyDir%\..\zeromq\;
    set cmdLine=%cmdLine% -Dappdynamics.agent.logs.dir=%logsDir%
    set cmdLine=%cmdLine% -Dcommtcp=%defaultProxyControlPort%
    set cmdLine=%cmdLine% -DagentType=PHP_APP_AGENT
    set cmdLine=%cmdLine% -Dappdynamics.agent.runtime.dir=%proxyDir%
    set cmdLine=%cmdLine% -Dlog4j.ignoreTCL=true
    set cmdLine=%cmdLine% -Dcount=1
    set cmdLine=%cmdLine% -Dregister=false
    set cmdLine=%cmdLine% -XX:MaxPermSize=120m
REM    set cmdLine=%cmdLine% -verbose:class"
REM    for param in "$@" ; do
REM        set cmdLine=%cmdLine% %param%"
REM    done
    set cmdLine=%cmdLine% com.appdynamics.ee.agent.proxy.bootstrap.ProxyControlEntryPoint
echo %cmdLine%
%cmdLine%
ENDLOCAL
