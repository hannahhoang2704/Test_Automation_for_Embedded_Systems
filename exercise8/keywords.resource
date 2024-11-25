*** Settings ***
Library         CarGenerator.py

*** Keywords ***
Suite setup
    Remove screenshot if exists        ${OUTPUTDIR}/${AFTER_ADDED_CAR_SCREENSHOT}
    Remove screenshot if exists        ${OUTPUTDIR}/${AFTER_DELETED_CAR_SCREENSHOT}
    Remove screenshot if exists        ${OUTPUTDIR}/${AFTER_ADDED_TEN_CARS_SCREENSHOT}
    Remove screenshot if exists        ${OUTPUTDIR}/${AFTER_REMOVED_SKODA_CARS_SCREENSHOT}
    Start Docker Container
    
Test setup
    
    Open Browser        ${BASE_URL}    ${BROWSER}
    Title Should Be     Car store

Test teardown
    Delete All Elements
    Close Browser
    #Close Docker Container

Suite teardown
    Close Docker Container
    
Start Docker Container
    ${result} =    Run Process    docker compose -f ${DOCKER_COMPOSE_FILE} up -d    shell=True
    Log To Console    Starting docker container
    Should Be Equal As Integers    ${result.rc}    0    Failed to start docker
    Sleep    5s 

Close Docker Container
    ${result} =    Run Process    docker compose -f ${DOCKER_COMPOSE_FILE} down    shell=True
    Sleep   12s
    Log to Console      Closing container   ${result.stdout}
    Should Be Equal As Integers    ${result.rc}    0    Failed to stop docker

Remove screenshot if exists
    [Arguments]     ${file_name}
    TRY
        Remove File        ${file_name}
    EXCEPT
        Log     Can't remove file   ${file_name}
    END

Take Screenshot
    [Arguments]                 ${image_name}
    Capture Page Screenshot     ${OUTPUTDIR}/${image_name}
    File Should Exist           ${OUTPUTDIR}/${image_name}

Add cars
    [Arguments]         ${car_list}
    #Log To Console    Car list that added to application: ${car_list}
    FOR  ${car_info}  IN    @{car_list}
        Click Link              Add a car
        Location Should Be      ${BASE_URL}/add    
        Fill Car Form           ${car_info}
        Submit Form
        Log to Console          Car info ${car_info} submitted
        Sleep   0.5
    END

Fill Car Form
    [Arguments]     ${car}
    ${car_make}     Get From Dictionary     ${car}         make
    ${model}        Get From Dictionary     ${car}         model
    ${mileage}      Get From Dictionary     ${car}         mileage
    ${year}         Get From Dictionary     ${car}         year
    ${plate}        Get From Dictionary     ${car}         plate


    Input Text      id=make-input       ${car_make} 
    Input Text      id=model-input      ${model} 
    Input Text      id=mileage-input    ${mileage}
    Input Text      id=year-input       ${year}  
    Input Text      id=plate-input      ${plate}

Submit Form
    Click Button    Add a new car

Remove Car By Car Plate
    [Arguments]     ${plate_nr}
    Log To Console  Removing car with plate: ${plate_nr}
    ${car_element}=    Get WebElement    xpath=//div[@id='car-container']//div[contains(@class, 'car')]//div[@class='car-specs car-plate']//span[@class='field-value' and text()='${plate_nr}']
    Remove Car          ${car_element}
    Element Should Not Be Visible    xpath=//div[@id='car-container']//div[contains(@class, 'car')]//div[@class='car-specs car-plate']//span[@class='field-value' and text()='${plate_nr}']

Remove Car
    [Arguments]    ${element}
    Open Context Menu    ${element}
    Alert Should Be Present

Remove Cars By Make
    [Arguments]     ${make}       
    Log To Console  Removing all Skoda Cars
    ${elements}=   Get WebElements    xpath=//div[@id='car-container']//div[contains(@class, 'car')]//div[@class='car-specs car-make']//span[@class='field-value' and text()='${make}']
    ${count}=   Get Length   ${elements}
    WHILE    ${count} > 0
        ${element}=    Get WebElement    xpath=//div[@id='car-container']//div[contains(@class, 'car')]//div[@class='car-specs car-make']//span[@class='field-value' and text()='${make}']
        Open Context Menu    ${element}
        Alert Should Be Present
        Sleep    0.5   
        ${elements}=   Get WebElements    xpath=//div[@id='car-container']//div[contains(@class, 'car')]//div[@class='car-specs car-make']//span[@class='field-value' and text()='${make}']
        ${count}=   Get Length   ${elements}
        Log To Console  Remaining cars: ${count}
    END
    Element Should Not Be Visible   xpath=//div[@id='car-container']//div[contains(@class, 'car')]//div[@class='car-specs car-make']//span[@class='field-value' and text()='${make}']

Delete All Elements
    Log To Console  Removing all cars from the page
    ${elements}=   Get WebElements    xpath=//div[@id='car-container']//div[contains(@class, 'car')]
    ${count}=   Get Length   ${elements}
    WHILE    ${count} > 0
        ${element}=    Get WebElement    xpath=//div[@id='car-container']//div[contains(@class, 'car')]
        Open Context Menu    ${element}
        Alert Should Be Present
        ${elements}=   Get WebElements    xpath=//div[@id='car-container']//div[contains(@class, 'car')]
        ${count}=   Get Length   ${elements}
        Log To Console  Remaining cars: ${count}
    END
    Log To Console  All cars have been removed
    Element Should Not Be Visible   xpath=//div[@id='car-container']//div[contains(@class, 'car')]



