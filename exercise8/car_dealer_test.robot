*** Settings ***
Documentation       Test of car dealer site
Library             FakerLibrary
Library             SeleniumLibrary
Library             OperatingSystem
Library             Collections
Library             Process
Library             CarGenerator.py
Resource            keywords.resource
Suite Setup		    Suite setup
Test Setup          Test setup
Test Teardown       Test teardown
Suite Teardown      Suite teardown

*** Variables ***
${DOCKER_COMPOSE_FILE}          ../car_dealer/docker-compose.yml
${BASE_URL}         http://localhost:3000
${BROWSER}          Chrome
${OUTPUTDIR}        ./image
${AFTER_ADDED_CAR_SCREENSHOT}           after_screenshot.png
${AFTER_DELETED_CAR_SCREENSHOT}         after_deleted_car_screenshot.png
${AFTER_ADDED_TEN_CARS_SCREENSHOT}      after_added_ten_car_screenshot.png
${AFTER_REMOVED_SKODA_CARS_SCREENSHOT}  after_removed_skoda_screenshot.png

@{CAR_MAKE_LIST}        Skoda   Toyota  Audi

*** Test Cases ***	
Add Cars Test
    ${car_list}     Generate Random Car List        ${3}
    Add cars                 ${car_list}
    ${tested_car}   Generate Random Car List        ${1}    car_plate=ABC-123
    Add cars                ${tested_car}
    ${car_list}     Generate Random Car List        ${2}
    Add cars                ${car_list}
    Take screenshot         ${AFTER_ADDED_CAR_SCREENSHOT}
    Remove Car By Car Plate     ABC-123
    Take screenshot         ${AFTER_DELETED_CAR_SCREENSHOT}
    #[Teardown]    Close Browser

Add Ten Cars and Remove Skoda
    ${ten_car_list}     Random Car List Included Selected Car Make        ${10}
    Add cars            ${ten_car_list}
    Take screenshot     ${AFTER_ADDED_TEN_CARS_SCREENSHOT}
    Remove Cars By Make     Skoda
    Take screenshot     ${AFTER_REMOVED_SKODA_CARS_SCREENSHOT}





