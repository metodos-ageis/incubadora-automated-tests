*** Settings ***
Resource                  ${EXECDIR}/resources/keywords.robot

Documentation             Esta é uma suite de testes para o projeto da disciplina de Metodologias Ágeis de Desenvolvimento de Software. 

#General functions only
*** Keywords ***
Open Session
    Open Browser          about:blank        chrome
    Maximize Browser Window

Close Session
    Capture Page Screenshot
    Close All Browsers