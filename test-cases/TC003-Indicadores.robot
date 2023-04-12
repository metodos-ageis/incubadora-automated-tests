*** Settings ***
Resource                  ${EXECDIR}/resources/base.robot

Test Setup                Open Session
Test Teardown             Close Session

*** Test Cases ***

Login com sucesso
    Dado que eu logue como gerente
    Quando eu selecionar a sessão de indicadores
    Então deve ser exibida a tela de indicadores da startup