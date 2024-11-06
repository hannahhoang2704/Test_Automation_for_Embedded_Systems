*** Settings ***
Documentation     Example of morse transmitter test
...
...               Change this example to use data driven style 
...               Test with different texts and speeds
Suite Setup			Suite setup
Suite Teardown		Suite teardown
Test Template		Send text to Pico
Resource			common_keywords.robot

*** Variables ***
${COM_PORT}         /dev/tty.usbmodem144201

*** Test Cases ***			INPUT					EXPECTED RESPONSE           
Only letters lowecase		this is a test			THIS IS A TEST              
    [Tags]                  text_only

Only Uppercase				ABCDEFG					ABCDEFG                   
    [Tags]                  text_only

Lower, Uppercase letters	tHis Is a test			THIS IS A TEST              
    [Tags]                  text_only

Only numbers				1234					1234                      
    [Tags]                  numerical

Both numbers and letters	number is 12			NUMBER IS 12
    [Tags]                  mixed
Empty						${EMPTY}				${EMPTY}
    [Tags]                  mixed

Only Space					${SPACE*10}				${SPACE*10}
    [Tags]                  mixed

Only Tab					\t						${SPACE}
    [Tags]                  mixed

Only Characters				*!#?;&@					XXXXXXX
    [Tags]                  mixed

Only Quotation				\'\'					XX
    [Tags]                  mixed

Only Double Quotation		\"\"					${EMPTY}
    [Tags]                  mixed

Printable ASCII  			! # $ % & ' ...			X X X X X X XXX
    [Tags]                  mixed

Letters, Numbers			abc123					ABC123
    [Tags]                  mixed

Characters and numbers		!*%4!22?				XXX4X22X
    [Tags]                  mixed

Combining Different Char	Hello*/ world!12?		HELLOXX WORLDX12X
    [Tags]                  mixed

Letters, Numbers, Char		thIs iS STRiNG && 123	THIS IS STRING XX 123
    [Tags]                  mixed

Long text					this is very long long long long long long long long text
...							THIS IS VERY LONG LONG LONG LONG LONG LONG LONG LONG TEXT
    [Tags]                  text_only

