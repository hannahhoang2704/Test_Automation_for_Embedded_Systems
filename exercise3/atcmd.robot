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
Only Uppercase				ABCDEFG					ABCDEFG
Lower, Uppercase letters	tHis Is a test			THIS IS A TEST
Only numbers				1234					1234
Both numbers and letters	number is 12			NUMBER IS 12
Empty						${EMPTY}				${EMPTY}
Only Space					${SPACE*10}				${SPACE*10}
Only Tab					\t						${SPACE}
Only Characters				*!#?;&@					XXXXXXX
Only Quotation				\'\'					XX
Only Double Quotation		\"\"					${EMPTY}
Printable ASCII  			! # $ % & ' ...			X X X X X X XXX
Letters, Numbers			abc123					ABC123
Characters and numbers		!*%4!22?				XXX4X22X
Combining Different Char	Hello*/ world!12?		HELLOXX WORLDX12X
Letters, Numbers, Char		thIs iS STRiNG && 123	THIS IS STRING XX 123
Long text					this is very long long long long long long long long text
...							THIS IS VERY LONG LONG LONG LONG LONG LONG LONG LONG TEXT

