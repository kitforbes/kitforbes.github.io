
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
@set CONFIG_DEFAULT=_config.yml
@set CONFIG_LOCAL=_config_local.yml
@set JEKYLL_ENV=
@set JEKYLL_ARGS=

@if '%1' EQU 'dev' (
    set JEKYLL_ENV=development
    set "JEKYLL_ARGS=--drafts --future --profile"
    goto RUN
)

@if '%1' EQU 'prod' (
    set JEKYLL_ENV=production
    goto RUN
)

@goto USAGE

:RUN
@rm -rf "%ROOT%_site"
@docker run --rm -it --name=site --label=jekyll ^
    "--volume=%ROOT%:/srv/jekyll" ^
    "--volume=%ROOT%\vendor\bundle:/usr/local/bundle" ^
    -p 127.0.0.1:4000:4000 ^
    jekyll/jekyll ^
    jekyll serve --watch --force_polling %JEKYLL_ARGS% ^
    --config "%CONFIG_DEFAULT%" "%CONFIG_LOCAL%"
@goto DONE

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
@echo    %0 [dev^|prod]
@echo.
@echo   Dev:
@echo     Serves the site at "localhost/4000" with development settings.
@echo   Prod:
@echo     Serves the site at "localhost/4000" with production settings.
@echo.
@exit /B 1
