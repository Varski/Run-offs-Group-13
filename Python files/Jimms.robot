*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Jimms RMA lomake
    Open Browser    https://www.jimms.fi
    ...    Chrome    options=add_experimental_option("detach", True)
    Maximize Browser Window
    Sleep    2
    Run Keyword And Ignore Error    Scroll Element Into View    xpath:/html/body/footer/div[2]
    # Tämä toimii oikein, mutta error tulee siitä huolimatta t. antti
    
    #klikataan takuupalautus ja palautuslomake auki
    Sleep    2
    Click Element    xpath:/html/body/footer/div[1]/div[2]/div[1]/ul/li[3]/a
    Sleep    2
    Click Element    xpath:/html/body/main/div[2]/div/div[2]/div/div/ol/li[2]/a

    #täytetään tiedot. muuttujat voidaan laittaa myöhemmin t. valtteri
    
    Select From List By Label    id:RmaTypeID    Tuotteen takuu
    Input Text    id:pf-SalesID    12345
    Input Text    id:pf-Name    Aku Ankka
    Input Text    id:pf-StreetAddress    Katuosoite 69
    Input Text    id:pf-PostalCode    00000
    Input Text    id:pf-City    Ankkalinna
    Input Text    id:pf-Email    d@d.com
    Input Text    id:pf-Phone    0401234567
    Input Text    id:pf-RmaProductCode    tuotekooditahan
    Input Text    id:pf-RmaProductName    tuotenimitahan
    Input Text    id:RmaMessage    tähän porhaltaa tekstiä miksi palautetaan
    Input Text    id:pf-BankAccount    FI2180000012345678
    
    #scrollataan lisaa alas
    Run Keyword And Ignore Error    Scroll Element Into View    xpath:/html/body/main/div[2]/div/div[2]/div/div/form/input[2]