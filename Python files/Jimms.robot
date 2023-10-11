*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Jimms RMA lomake
    Open Browser    https://www.jimms.fi
    ...    Chrome    options=add_experimental_option("detach", True)
    Maximize Browser Window
    Run Keyword And Ignore Error    Scroll Element Into View    xpath:/html/body/footer/div[2]
    # Tämä toimii oikein, mutta error tulee siitä huolimatta t. antti
    
    #klikataan takuupalautus ja palautuslomake auki
    Click Element    xpath:/html/body/footer/div[1]/div[2]/div[1]/ul/li[3]/a
    Click Element    xpath:/html/body/main/div[2]/div/div[2]/div/div/ol/li[2]/a

    #täytetään tiedot. muuttujat voidaan laittaa myöhemmin t. valtteri
    Click Element    id:RmaTypeID
    Select From List By Label    id:RmaTypeID    Tuotteen takuu
    Click Element    id:pf-SalesID
    Input Text    id:pf-SalesID    12345
    Click Element    pf-Name
    Input Text    id:pf-Name    Aku Ankka
    Click Element    id:pf-StreetAddress
    Input Text    id:pf-StreetAddress    Katuosoite 69
    Click Element    id:pf-PostalCode
    Input Text    id:pf-PostalCode    00000
    Click Element    id:pf-City
    Input Text    id:pf-City    Ankkalinna
    #Click Element    id:pf-Email
    Input Text    id:pf-Email    d@d.com
    #Click Element    id:pf-Phone
    Input Text    id:pf-Phone    0401234567
    #Click Element    id:pf-RmaProductCode
    Input Text    id:pf-RmaProductCode    tuotekooditahan
    #Click Element    id:pf-RmaProductName
    Input Text    id:pf-RmaProductName    tuotenimitahan
    #Click Element    id:RmaMessage
    Input Text    id:RmaMessage    tähän porhaltaa tekstiä miksi palautetaan
    #Click Element    id:pf-BankAccount
    Input Text    id:pf-BankAccount    FI2180000012345678
    
    #scrollataan lisaa alas
    Run Keyword And Ignore Error    Scroll Element Into View    xpath:/html/body/main/div[2]/div/div[2]/div/div/form/input[2]