#Run-offs
#Miko Vaaranmaa, Antti Anttola, Jesse Termonen, Valtteri Nissinen
*** Settings ***
Library    SeleniumLibrary
Library    String

*** Test Cases ***

1. Onko kaikilla tuotealueilla Landing Page
    Open Browser    http://www.jimms.fi    chrome    options=add_experimental_option("detach", True)
    Maximize Browser Window
    Sleep    2
    #haetaan menussa olevat elementit css elementin kautta
    ${menu_items} =   Get WebElements    css:#sitemegamenu > nav > ul
    #Haetaan loopissa menun sisältämät tekstit ja tehdään niistä lista
    FOR    ${landing}    IN    @{menu_items}
        ${landing_text}=    Get Text    ${landing}
        ${landing_text}=    Split String    ${landing_text}
        Create List    ${landing_text}            
        FOR    ${element}    IN    @{landing_text}
            Sleep    1
            Go To    https://www.jimms.fi/fi/Product/${element}
            #tarkastetaan että landingpage elementti löytyy sivulta
            Sleep    1
            Run Keyword And Ignore Error    Element Should Be Visible    xpath://*[@id="ocCategories"]
            #haetaan id elementistä ja tarkastetaan että se on "ocCategories"
            ${for_value}=    Get Element Attribute    //*[@id="ocCategories"]    id
            Run Keyword And Ignore Error    Should Be Equal As Strings    ${for_value}    ocCategories
            Log    ${element}
        END    
    END


2. Testaa hakutoimintoa tuotteen pääsivulta (hakusana ps5)
    Go To    http://www.jimms.fi    
    ${ps}    Set Variable    PS5
    #klikataan hakukenttää ja syötetään teksti
    Click Element    xpath://*[@id="searchinput"]
    Input Text    xpath://*[@id="searchinput"]    ${ps}
    Sleep    2
    #klikataan hakulinkkiä
    Click Link    xpath://*[@id="quickproductsearch"]/div/div/div/div[1]/p[1]/a
    Sleep    2
    Capture Element Screenshot    xpath://*[@id="productsearchpage"]/div[2]/div[5]/div/div[1]/product-box/div[2]/div[1]/a/div/img
    #klikataan ensinmäistä tuotetta ja tarkastetaan löytyykö sivulta teksti PS5
    Click Element    xpath://*[@id="productsearchpage"]/div[2]/div[5]/div/div[1]/product-box/div[2]/div[2]/h5/a/span
    Sleep    2
    Page Should Contain    ${ps}


3. Löytyykö tuotesivulta linkki "Lisää koriin"
    Element Should Be Visible    xpath:/html/body/main/div[1]/div[2]/div/jim-product-cta-box/div/div[2]/div[2]/addto-cart-wrapper/div/a


4. Löytyykö "Lisää koriin" -linkkiin liittyvä ikoni. Robotti ottaa ikonista kuvankaappauksen.
    Element Should Be Visible    xpath:/html/body/main/div[1]/div[2]/div/jim-product-cta-box/div/div[2]/div[2]/addto-cart-wrapper/div/a/span
    Capture Element Screenshot    xpath:/html/body/main/div[1]/div[2]/div/jim-product-cta-box/div/div[2]/div[2]/addto-cart-wrapper/div/a/span


5. Robotti lisää tuotteen ostoskoriin
    Click Element    xpath=//a[contains(@title, 'Lisää koriin')]


6. Tuotenumeron poimiminen RMA hakemusta varten
    ${tuoteNumero}=    Get Text    xpath:/html/body/main/div[1]/div[2]/div/div/jim-product-sku-ean-warranty-info/div[1]/span
    Log    ${tuoteNumero}
    Set Global Variable    ${tuoteNumero}


7. Tuotenimen poimiminen RMA hakemusta varten
    ${tuoteNimi}    Get Text    xpath:/html/body/main/div[1]/div[2]/div/jim-product-cta-box/div/h1/span[2]
    Log    ${tuoteNimi}
    Set Global Variable    ${tuoteNimi}


8. Tarkistetaan tuoteen saatavuus
    ${saatavuus}=    Get Text    xpath://*[@id="product-cta-box"]/div/div[2]/div[3]/availability-product/span/span
    Log     ${saatavuus}
    

9. Yhteystiedon tarkastaminen yhteystietosivulta
    Go To    https://www.jimms.fi
    Sleep    3
    Click Element    xpath:/html/body/div[1]/div/a[4]
    Sleep    2
    ${yhteystietonumero}=    Get Text    xpath://*[@id="jim-main"]/div[2]/div/div[2]/div/div/div[2]/div[1]/div/div/p[2]
    Log    ${yhteystietonumero}
    Run Keyword And Ignore Error    Should Contain    ${yhteystietonumero}    +358


10. Jimms RMA lomake
    Go To    https://www.jimms.fi
    Sleep    2
    Run Keyword And Ignore Error    Scroll Element Into View    xpath:/html/body/footer/div[2]
    #klikataan takuupalautus ja palautuslomake auki
    Sleep    2
    Click Element    xpath:/html/body/footer/div[1]/div[2]/div[1]/ul/li[3]/a
    Sleep    2
    Click Element    xpath:/html/body/main/div[2]/div/div[2]/div/div/ol/li[2]/a

    #täytetään tiedot lomakkeeseen ja lisätään halutut tiedot aikaisemmin haetuilla muuttujilla
    
    Select From List By Label    id:RmaTypeID    Tuotteen takuu
    Input Text    id:pf-SalesID    12345
    Input Text    id:pf-Name    Aku Ankka
    Input Text    id:pf-StreetAddress    Katuosoite 69
    Input Text    id:pf-PostalCode    00000
    Input Text    id:pf-City    Ankkalinna
    Input Text    id:pf-Email    d@d.com
    Input Text    id:pf-Phone    0401234567
    Input Text    id:pf-RmaProductCode    ${tuoteNumero}
    Input Text    id:pf-RmaProductName    ${tuoteNimi}
    Input Text    id:RmaMessage    Tuoteessa on 
    Input Text    id:pf-BankAccount    FI2180000012345678
    
    #scrollataan lisaa alas
    Run Keyword And Ignore Error    Scroll Element Into View    xpath:/html/body/main/div[2]/div/div[2]/div/div/form/input[2]

#Run-offs
#Miko Vaaranmaa, Antti Anttola, Jesse Termonen, Valtteri Nissinen


