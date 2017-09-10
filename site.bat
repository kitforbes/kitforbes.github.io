
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

@if '%1' EQU 'install' (
    rem add ruby check/installation
    gem install bundler
    bundle install
)

@if '%1' EQU 'start' (
    bundle exec jekyll serve --watch
)

@if '%1' EQU 'update' (
    bundle update
) else (
    goto USAGE
)

:DONE
@echo.
@echo ^> Script complete.
@echo.
@exit /B 0

:FAILED
@echo An error occured in "%0"
@exit /B 1

:USAGE
@echo.
@echo Usage:
@echo    %0 [install^|update^|start]
@echo.
@echo   Install:
@echo     Installs required dependencies.
@echo   Update:
@echo     Get the latest Gems.
@echo   Start:
@echo     Serves the site at "localhost/4000".
@echo.
@exit /B 1
