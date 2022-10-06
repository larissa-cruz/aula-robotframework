*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}                      chrome
${URL}                          https://www.amazon.com.br/
${MENU_MAISVENDIDOS}            //a[@href='/gp/bestsellers/?ref_=nav_cs_bestsellers'][contains(.,'Mais Vendidos')]
${HEADER_MAISVENDIDOS}          //span[contains(@class,'a-size-extra-large a-color-base _p13n-zg-banner-landing-page-header_style_zgLandingPageBannerText__3HlJo')]


*** Keywords ***

Abrir o navegador
    Open Browser    browser=${BROWSER}  
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser

Acessar a home page do site Amazon.com.br
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${MENU_MAISVENDIDOS} 

Entrar no menu "Mais Vendidos"
    Click Element    locator=${MENU_MAISVENDIDOS}

Verificar se aparece a frase "${FRASE}"
    Wait Until Page Contains    text=${FRASE}
    Wait Until Element Is Visible    locator=${HEADER_MAISVENDIDOS}

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible    locator=//a[@href='/gp/bestsellers/grocery/ref=zg_bs_nav_0'][contains(.,'${NOME_CATEGORIA}')]

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text    locator=twotabsearchtextbox    text=${PRODUTO}

Clicar no botão de pesquisa
    Click Element    locator=nav-search-submit-button

Verificar se o resultado da pesquisa está listando o produto "${PRODUTO}" 
    Wait Until Element Is Visible    locator=//span[@class='a-size-base a-color-base a-text-normal'][contains(.,'${PRODUTO}')]
    Click Element    locator=//span[@class='a-size-base a-color-base a-text-normal'][contains(.,'${PRODUTO}')]

Adicionar o produto "Xbox Series S" no carrinho
    Wait Until Element Is Visible    locator=//input[contains(@name,'submit.add-to-cart')]
    Click Button    locator=//input[contains(@name,'submit.add-to-cart')]

Verificar se o produto "Xbox Series S" foi adicionado com sucesso
    Element Should Be Visible    locator=//span[@class='a-size-medium-plus a-color-base sw-atc-text a-text-bold'][contains(.,'Adicionado ao carrinho')]

Remover o produto "Xbox Series S" do carrinho
    Wait Until Element Is Visible    locator=//input[contains(@title,'Excluir')]
    Click Button    locator=//input[contains(@title,'Excluir')]

Verificar se o carrinho fica vazio
    Wait Until Element Is Visible    locator=//span[@class='a-size-base a-color-price a-text-bold'][contains(.,'R$ 0,00')]
    Element Should Be Visible    locator=//span[@class='a-size-base a-color-price a-text-bold'][contains(.,'R$ 0,00')]

#GHERKIN STEPS

Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br

Quando acessar o menu "Mais Vendidos"
    Entrar no menu "Mais Vendidos"

Então o título da página deve ficar "Amazon.com.br Mais Vendidos: Os itens mais populares na Amazon"
    Verificar se o título da página fica "Amazon.com.br Mais Vendidos: Os itens mais populares na Amazon"

E o texto "Mais Vendidos" deve ser exibido na página
    Verificar se aparece a frase "Mais Vendidos"

E a categoria "Alimentos e Bebidas" deve ser exibida na página
    Verificar se aparece a categoria "Alimentos e Bebidas"

Quando pesquisar pelo produto "Xbox Series S"
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa

Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    Wait Until Element Is Visible    locator=//img[contains(@alt,'Console Xbox Series S')]
    Verificar se o título da página fica "Amazon.com.br : Xbox Series S"

E um produto da linha "Xbox Series X" deve ser mostrado na página 
    Verificar se o resultado da pesquisa está listando o produto "Console Xbox Series S"

Quando adicionar o produto "Console Xbox Series S" no carrinho
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa
    Verificar se o resultado da pesquisa está listando o produto "Console Xbox Series S" 
    Adicionar o produto "Xbox Series S" no carrinho

Então o produto "Console Xbox Series S" deve ser mostrado no carrinho
    Verificar se o produto "Xbox Series S" foi adicionado com sucesso

E existe o produto "Console Xbox Series S" no carrinho
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa
    Verificar se o resultado da pesquisa está listando o produto "Console Xbox Series S" 
    Adicionar o produto "Xbox Series S" no carrinho
    Verificar se o produto "Xbox Series S" foi adicionado com sucesso

Quando remover o produto "Console Xbox Series S" do carrinho
    Remover o produto "Xbox Series S" do carrinho

Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio
