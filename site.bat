
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

@set ROOT=%~dp0
@set CONFIG_DEFAULT=%ROOT%_config.yml
@set CONFIG_LOCAL=%ROOT%_config_local.yml

@if '%1' EQU 'install' (
    rem add ruby check/installation
    rem gem install bundler
    bundle install
    goto DONE
)

@if '%1' EQU 'dev' (
    set JEKYLL_ENV=development
    bundle exec jekyll serve --watch --drafts --future --profile --incremental --config "%CONFIG_DEFAULT%" "%CONFIG_LOCAL%"
    goto DONE
)

@if '%1' EQU 'prod' (
    set JEKYLL_ENV=production
    bundle exec jekyll serve --watch --config "%CONFIG_DEFAULT%" "%CONFIG_LOCAL%"
    goto DONE
)

@if '%1' EQU 'update' (
    bundle update
    goto DONE
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
@echo    %0 [install^|update^|dev^|prod]
@echo.
@echo   Install:
@echo     Installs required dependencies.
@echo   Update:
@echo     Gets the latest Gems.
@echo   Dev:
@echo     Serves the site at "localhost/4000" with development settings.
@echo   Prod:
@echo     Serves the site at "localhost/4000" with production settings.
@echo.
@exit /B 1
