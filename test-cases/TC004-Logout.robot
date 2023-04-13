*** Settings ***
Resource                  ${EXECDIR}/resources/base.robot

Test Setup                Dado que eu logue como gerente - Setup
Test Teardown             Close Session

*** Test Cases ***

Logout com sucesso
    Dado que eu esteja logado no sistema
    Quando eu clicar em sair
    Então devo ser redirecioando a tela de login