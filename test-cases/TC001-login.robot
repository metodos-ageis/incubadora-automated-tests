*** Settings ***
Resource                  ${EXECDIR}/resources/base.robot

Test Setup                Open Session
Test Teardown             Close Session

*** Test Cases ***
Campo email obrigatório
    Dado que eu acesse o portal das startups
    E insira o email sem dominio
    Quando eu clicar em entrar
    Então eu devo ver a mensagem erro

Campo senha obrigatório
    Dado que eu acesse o portal das startups
    E deixe o campo senha em branco
    Quando eu clicar em entrar
    Então o botão entrar não deve estar habilitado

Login com sucesso
    Dado que eu acesse o portal das startups
    E insira os dados de login
    Quando eu clicar em entrar
    Então eu devo ver a mensagem de boas vindas