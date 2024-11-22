*** Keywords ***
Suite setup
    Start Docker Containers
    Open Browser        ${BASE_URL}    ${BROWSER}
    Title Should Be     Car store
    Remove screenshot if exists        ${OUTPUTDIR}/${BEFORE_ADDED_CAR_SCREENSHOT}
    Remove screenshot if exists        ${OUTPUTDIR}/${AFTER_ADDED_CAR_SCREENSHOT}

Suite teardown
    ${result} =    Run Process    docker compose -f ${DOCKER_COMPOSE_FILE} down    shell=True
    Log to Console      Closing container   ${result.stdout}
    Should Be Equal As Integers    ${result.rc}    0    Failed to stop docker

Start Docker Containers
    ${result} =    Run Process    docker compose -f ${DOCKER_COMPOSE_FILE} up -d    shell=True
    Log To Console    Starting docker container
    Should Be Equal As Integers    ${result.rc}    0    Failed to start docker
    Sleep    5s 

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
    Log     Car dict ${CARS_LIST}
    FOR  ${car_info}  IN    @{CARS_LIST}
        Click Link              Add a car
        Location Should Be      ${BASE_URL}/add    
        Fill Car Form           ${car_info}
        Submit Form
        Log to Console          Car info ${car_info} submitted
        Sleep   1
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

