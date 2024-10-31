*** Settings ***
Library             AtCommandLibrary.py         ${COM_PORT}

***Keywords***
Suite setup
    Send At Command
    Switch local echo off

Suite teardown
    Switch local echo on

Send text to Pico
	[Arguments]		${command}		${response}
	Send text  				${command}
	Response should be		SENT="${response}"
	Response should be		OK

Switch local echo off
    Send ate0 command
    Response should be      ATE0
    Response should be      OK

Switch local echo on
    Send ate1 command
    Response should be      OK
