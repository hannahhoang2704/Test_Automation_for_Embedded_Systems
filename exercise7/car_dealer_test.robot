*** Settings ***
Documentation     Test of car dealer site
Library             SeleniumLibrary
Library             OperatingSystem
Library             Dialogs
Library             Process
Library             Collections
Resource            keywords.resource
Suite Setup			Suite setup
Suite Teardown      Suite teardown

*** Variables ***
${DOCKER_COMPOSE_FILE}          ./car_dealer/docker-compose.yml
${BASE_URL}                     http://localhost:3000
${BROWSER}                      Chrome
${OUTPUTDIR}                    ./image
${BEFORE_ADDED_CAR_SCREENSHOT}      before_screenshot.png
${AFTER_ADDED_CAR_SCREENSHOT}       after_screenshot.png

&{CAR1}    make=Mercedes        model=A     mileage=2000        year=2010       plate=ABC-123
&{CAR2}    make=Volvo           model=B     mileage=35000       year=2014       plate=DNK-456
&{CAR3}    make=Audi            model=C     mileage=40000       year=2022       plate=FIN-789
@{CARS_LIST}     &{CAR1}      &{CAR2}     &{CAR3} 

*** Test Cases ***	
Add Cars Test
    Take screenshot         ${BEFORE_ADDED_CAR_SCREENSHOT}  
    Add cars
    Take screenshot         ${AFTER_ADDED_CAR_SCREENSHOT}
    [Teardown]    Close Browser

