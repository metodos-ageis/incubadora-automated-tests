*** Settings ***
Resource                  ${EXECDIR}/resources/base.robot

Test Setup                Open Session
Test Teardown             Close Session

*** Test Cases ***

Logout com sucesso
    Dado que eu logue como gerente
    Quando eu clicar em sair
    Então devo ser redirecioando a tela de login