FOR /F %%a IN ('POWERSHELL -COMMAND "$([guid]::NewGuid().ToString().ToUpper())"') DO ( SET NEWGUID={%%a} )
