*** Settings ***
Library  SeleniumLibrary

*** Test Cases ***
Open Jimms.fi and GetLinks
    Open Browser    https://www.jimms.fi
    ...    Chrome    options=add_experimental_option("detach", True)
    Maximize Browser Window
    Sleep    2
    #tuotealueiden urlien loppupäätteet listassa
    ${urllist}=    Create List    Tietokoneet   Komponentit    Oheislaitteet    Pelaaminen    Verkkotuotteet    Tarvikkeet    Erikoistuotteet    Ohjelmistot    Palvelut
    #silmukassa siirrytään jokaiselle tuotealueelle ja tarkastetaan löytyykö jokaiselta sivulta sama id elementistä
    FOR    ${element}    IN    @{urllist}
        Sleep    1
        Go To    https://www.jimms.fi/fi/Product/${element}
        #tarkastetaan että landingpage elementti löytyy sivulta
        Element Should Be Visible    xpath://*[@id="ocCategories"]
        #haetaan id elementistä ja tarkastetaan että se on "ocCategories"
        ${for_value}=    Get Element Attribute    //*[@id="ocCategories"]    id
        Should Be Equal As Strings    ${for_value}    ocCategories
        Log    ${element}
    END

    Close Browser