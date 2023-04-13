*** Settings ***
Resource                  ${EXECDIR}/resources/base.robot

Test Setup                Dado que eu logue como gerente - Setup
Test Teardown             Close Session

*** Test Cases ***

Login com sucesso
    Dado que eu esteja logado no sistema
    Quando eu selecionar a sessão de indicadores
    Então deve ser exibida a tela de indicadores da startup