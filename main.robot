*** Settings ***
Test Setup          UI Login
Test Teardown       Close Browser
Resource            web-locators.robot
Library             SeleniumLibrary
Library             String

*** Variables ***
${APPLICATION_URL}          https://jupiter.cloud.planittesting.com/
${CHROME_DRIVER_FILE}       C://Program Files (x86)//Google//Chrome//Application//chromedriver.exe
${TEST_FORENAME}            Jerome
${TEST_SURNAME}             Aquino
${TEST_EMAIL}               jvaquino4@up.edu.ph
${TEST_TEL_NUMBER}          02 1234 5678
${STUFFED_FROG_COUNT}       2
${FLUFFY_BUNNY_COUNT}       5
${VALENTAINE_BEAR_COUNT}    3

*** Test Cases ***
Test 1
    Click Element    ${HOME_CONTACT_BUTTON}
    Wait Until Page Contains    We welcome your feedback
    Click Element    ${CONTACT_SUBMIT_BUTTON}
    Wait Until Page Contains    but we won't get it unless you complete the form correctly
    Page Should Contain    Forename is required
    Page Should Contain    Email is required
    Page Should Contain    Message is required
    Input Text    ${CONTACT_FORENAME_TXTBOX}    ${TEST_FORENAME}
    Page Should Not Contain    Forename is required
    Input Text    ${CONTACT_SURNAME_TXTBOX}     ${TEST_SURNAME}
    Input Text    ${CONTACT_EMAIL_TXTBOX}     ${TEST_EMAIL}
    Page Should Not Contain    Email is required
    Page Should Not Contain    Please enter a valid email
    Input Text    ${CONTACT_TELEPHONE_TXTBOX}    ${TEST_TEL_NUMBER}
    Page Should Not Contain    Please enter a valid telephone number
    ${sampleFeedback}     Generate Random String    23
    Input Text    ${CONTACT_FEEDBACK_TXTBOX}     ${sampleFeedback}
    Page Should Not Contain    Message is required
    Click Element    ${CONTACT_SUBMIT_BUTTON}
    Wait Until Page Contains    Thanks ${TEST_FORENAME}, we appreciate your feedback    timeout=1m

Test 2
    FOR    ${index}     IN RANGE    0    5
        Click Element    ${HOME_CONTACT_BUTTON}
        Wait Until Page Contains    We welcome your feedback
        Input Text    ${CONTACT_FORENAME_TXTBOX}    ${TEST_FORENAME}
        Page Should Not Contain    Forename is required
        Input Text    ${CONTACT_SURNAME_TXTBOX}     ${TEST_SURNAME}
        Input Text    ${CONTACT_EMAIL_TXTBOX}     ${TEST_EMAIL}
        Page Should Not Contain    Email is required
        Page Should Not Contain    Please enter a valid email
        Input Text    ${CONTACT_TELEPHONE_TXTBOX}    ${TEST_TEL_NUMBER}
        Page Should Not Contain    Please enter a valid telephone number
        ${sampleFeedback}     Generate Random String    23
        Input Text    ${CONTACT_FEEDBACK_TXTBOX}     ${sampleFeedback}
        Page Should Not Contain    Message is required
        Click Element    ${CONTACT_SUBMIT_BUTTON}
        Wait Until Page Contains    Thanks ${TEST_FORENAME}, we appreciate your feedback    timeout=1m
        Sleep    1s
        Click Element    ${CONTACT_BACK_BUTTON}
    END

Test 3
    Click Element    ${HOME_SHOP_BUTTON}
    Wait Until Page Contains    Buy
    ${totalItems}    Set Variable    0
    ${stuffedFrogPrice}    Get Price For Specific Item    ${SHOP_BUY_STUFFED_FROG_PRICE}
    ${fluffyBunnyPrice}    Get Price For Specific Item    ${SHOP_BUY_FLUFFY_BUNNY_PRICE}
    ${valentineBearPrice}    Get Price For Specific Item    ${SHOP_BUY_VALENTINE_BEAR_PRICE}
    ${stuffedFrogSubtotal}    Set Variable    0
    ${fluffyBunnySubtotal}    Set Variable    0
    ${valentineBearSubtotal}    Set Variable    0
    FOR    ${index}     IN RANGE    1    ${STUFFED_FROG_COUNT}+1
        Click Element    ${SHOP_BUY_STUFFED_FROG}
        ${totalItems}    Evaluate    ${totalItems} + 1
        ${stuffedFrogSubtotal}    Evaluate    ${stuffedFrogSubtotal} + ${stuffedFrogPrice}
        Wait Until Page Contains Element    //span[contains(@class,'cart-count') and text()='${totalItems}']
    END
    FOR    ${index}    IN RANGE    1    ${FLUFFY_BUNNY_COUNT}+1
        Click Element    ${SHOP_BUY_FLUFFY_BUNNY}
        ${totalItems}    Evaluate    ${totalItems} + 1
        ${fluffyBunnySubtotal}     Evaluate    ${fluffyBunnySubtotal} + ${fluffyBunnyPrice}
        Wait Until Page Contains Element    //span[contains(@class,'cart-count') and text()='${totalItems}']
    END
    FOR    ${index}    IN RANGE    1    ${VALENTAINE_BEAR_COUNT}+1
        Click Element    ${SHOP_BUY_VALENTINE_BEAR}
        ${totalItems}    Evaluate    ${totalItems} + 1
        ${valentineBearSubtotal}    Evaluate    ${valentineBearSubtotal} + ${valentineBearPrice}
        Wait Until Page Contains Element    //span[contains(@class,'cart-count') and text()='${totalItems}']
    END
    Click Element    ${SHOP_CART_BUTTON}
    Wait Until Page Contains Element    ${SHOP_CHECKOUT_BUTTON}
    Page Should Contain Element    //td[contains(text(), 'Stuffed Frog')]/parent::tr/td[text()='$${stuffedFrogPrice}']
    Page Should Contain Element    //td[contains(text(), 'Fluffy Bunny')]/parent::tr/td[text()='$${fluffyBunnyPrice}']
    Page Should Contain Element    //td[contains(text(), 'Valentine Bear')]/parent::tr/td[text()='$${valentineBearPrice}']
    Page Should Contain Element    //td[contains(text(), 'Stuffed Frog')]/parent::tr/td[text()='$${stuffedFrogSubtotal}']
    Page Should Contain Element    //td[contains(text(), 'Fluffy Bunny')]/parent::tr/td[text()='$${fluffyBunnySubtotal}']
    Page Should Contain Element    //td[contains(text(), 'Valentine Bear')]/parent::tr/td[text()='$${valentineBearSubtotal}']
    ${totalToPay}    Evaluate    ${stuffedFrogSubtotal} + ${fluffyBunnySubtotal} + ${valentineBearSubtotal}
    Page Should Contain    Total: ${totalToPay}

*** Keywords ***
UI Login
    ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Create Webdriver    Chrome      executable_path=${CHROME_DRIVER_FILE}    chrome_options=${chrome_options}
    Go To      ${APPLICATION_URL}
    Maximize Browser Window
    Wait Until Page Contains     Welcome to Jupiter Toys

Get Price For Specific Item
    [Arguments]    ${priceLocator}
    ${singlePriceText}    Get Text    ${priceLocator}
    ${priceResult}    Fetch From Right   ${singlePriceText}    $
    [Return]    ${priceResult}
