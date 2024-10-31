*** Settings ***
Library            OperatingSystem
Library            Collections
Library            String
Library            Dialogs
Library            FakerLibrary    locale=fi_FI

*** Variables ***
${FILE_PATH}            ${CURDIR}/file.txt

***Test Cases***
Remove Address File Test If Exist
    Remove Existing Address File  ${FILE_PATH}

Create New Address File
    @{name_list}        Get Random Names           ${5}
    ${selected_name}    Get Selection From User    Choose a name from list below    @{name_list}
    ${address}        FakerLibrary.address
    Log To Console    Creating new file with path  ${FILE_PATH}
    Create File       ${FILE_PATH}                 ${selected_name}${\n}${address}

Check file content
    ${file_content}    Get File    ${FILE_PATH}
    ${lines}           Split To Lines    ${file_content}
    Log                ${lines}
    ${cnt}             Get length      ${lines}
    Log To Console     ${cnt} lines in files ${FILE_PATH}
    Should Be Equal As Numbers    ${cnt}    ${3}


*** Keywords ***
Get Random Names
    [Documentation]    Return a list of random names.
    [Arguments]        ${random_nr}
    @{random_list}     Create List    
    FOR  ${i}  IN RANGE  ${random_nr}
        ${name} =       FakerLibrary.Name
        Append To List  ${random_list}  ${name}
    END
    RETURN        ${random_list}


Remove Existing Address File
    [Documentation]    Remove an existing specific file.
    [Arguments]        ${file_name}
    ${file_exists}     Run Keyword and Return Status    File Should Exist  ${file_name}
    IF    ${file_exists}
        ${file_content}    Get File    ${file_name}
        Log     file content: ${file_content}
        ${first_line}    Get Line    ${file_content}  0
        Log To Console   Removing address file of person name: ${first_line}
        Remove File    ${file_name}
    END


