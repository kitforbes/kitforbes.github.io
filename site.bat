
@rem Capture help parameters.
@if '%1' EQU '/?' goto USAGE
@if '%1' EQU '-?' goto USAGE
@if '%1' EQU '--?' goto USAGE
@if '%1' EQU '/h' goto USAGE
@if '%1' EQU '-h' goto USAGE
@if '%1' EQU '--h' goto USAGE
@if '%1' EQU '/help' goto USAGE
@if '%1' EQU '-help' goto USAGE
@if '%1' EQU '--help' goto USAGE

@if '%1' EQU 'up' (
    rm -rf "%~dp0_site"
    docker-compose up -d
    if ERRORLEVEL 0 goto DONE
    goto FAILED
)

@if '%1' EQU 'down' (
    docker-compose down
    if ERRORLEVEL 0 goto DONE
    goto FAILED
)

@if '%1' EQU 'logs' (
    docker logs blog
    goto DONE
)

:DONE
@echo.
@echo ^> Script complete.
@echo.
@exit /B 0

:FAILED
@echo.
@echo ^> An error occured in "%0"
@exit /B 1

:USAGE
@echo.
@echo Usage:
@echo    %0 [up^|down^|logs]
@echo.
@echo   Up:
@echo     Create and start containers
@echo.
@echo   Down:
@echo     Stop and remove containers, networks, images, and volumes
@echo.
@echo   Logs:
@echo     Fetch the logs of the container
@echo.
@exit /B 1
