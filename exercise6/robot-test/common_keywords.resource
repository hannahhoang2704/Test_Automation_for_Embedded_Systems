*** Settings ***
Library             AtCommandLibrary.py         ${COM_PORT}

***Keywords***
Suite setup
    Send AT command
    Switch local echo off
    Check echo status       OFF

Suite teardown
    Switch local echo on
    Check echo status       ATE
    Response should be      ON

Send text to Pico
	[Arguments]		        ${command}		${response}
	Send text  				${command}
	Response should be		SENT="${response}"
	Response should be		OK

Send AT command
    Send command            AT
    Response should be      AT
    Response should be      OK

Switch local echo off
    Send command            ATE0
    Response should be      ATE0
    Response should be      OK

Switch local echo on
    Send command            ATE1
    Response should be      OK

Check echo status
    [Arguments]         ${expected_status}
    Send command            ATE
    Response should be      ${expected_status}
