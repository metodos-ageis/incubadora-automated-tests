*** Settings ***
Library                            SeleniumLibrary    run_on_failure=Capture Page Screenshot

*** Variables ***
${URL_BASE}                        http://localhost:4000         # URL of the application
${gerente_email}                   gerente@gmail.com
${gerente_emailinvalido}           gerente#gmail.com
${gerente_password}                123456

#Locators
${form_login}                      id=login-form                   
${form_login_title}                id=login-title
${form_login_fields}               id=login-inputs

${user_input_field}                id=email-input            # ID of the user input field    
${password_input_field}            id=password-input         # ID of the password input field

${register_link}                   id=register-link          # ID of the register link
${forgot_password_link}            id=forgot-password-link   # ID of the forgot password link

${btn_entrar}                      id=login-button

#Textos da pagina de Login
@{Textos do login}                Bem vindo ao PRINTS.    (Programa de Inovação e Tecnologia)    Programa de Incubação.    Parceria entre:
${erro_message_senha_incorreta}   Usuário ou senha inválidos

*** Keywords ***

Dado que eu acesse o portal das startups
    Go to                               ${URL_BASE}
    Wait Until Page Contains Element    ${form_login}
    Wait Until Page Contains Element    ${form_login_title}
    Wait Until Page Contains Element    ${form_login_fields}
    Wait Until Page Contains Element    ${user_input_field}
    Wait Until Page Contains Element    ${password_input_field}
    Wait Until Page Contains Element    ${register_link}
    Wait Until Page Contains Element    ${forgot_password_link}
    Wait Until Page Contains Element    ${btn_entrar}
    FOR  ${i}  IN  @{Textos do login}
        Page Should Contain    ${i}
    END
    Page Should Contain Image      assets/logo.jpeg
    Page Should Contain Image      assets/logo-senac-pe.png
    Page Should Contain Image      assets/logo-ufrpe.jpg

E insira os dados de login
    Element Should Be Disabled     ${btn_entrar}
    Element Should Be Visible      ${user_input_field}	
    Input text                     ${user_input_field}               ${gerente_email}     
    Sleep                          1s
    Element Should Be Visible      ${password_input_field}
    Input text                     ${password_input_field}        ${gerente_password} 
    Element Should Be Enabled      ${btn_entrar}

E insira os dados de login errados
    Element Should Be Disabled     ${btn_entrar}
    Element Should Be Visible      ${user_input_field}	
    Input text                     ${user_input_field}               ${gerente_email}     
    Sleep                          1s
    Element Should Be Visible      ${password_input_field}
    Input text                     ${password_input_field}           SenhaInvalida
    Element Should Be Enabled      ${btn_entrar}

E insira o email sem dominio
    Element Should Be Visible      ${user_input_field}	
    Input text                     ${user_input_field}                  ${gerente_email_invalido}
    Element Should Be Visible      ${password_input_field}
    Input text                     ${password_input_field}                    ${gerente_password}

E deixe o campo senha em branco
    Element Should Be Visible      ${user_input_field}
    Element Should Be Visible      ${password_input_field}
    Input text                     ${user_input_field}               ${gerente_email}

Quando eu clicar em entrar
    Wait Until Page Contains Element    ${btn_entrar}
    Click Element                       ${btn_entrar}

Então eu devo ver a mensagem de boas vindas
    Wait until page contains       Seja bem-vindo, @!
    Capture Page Screenshot

Então não devo ver a mensagem de boas vindas
    Wait until page does not contain       Seja bem-vindo, @!
    Capture Page Screenshot

Então eu devo ver a mensagem erro
    Sleep                         3
    Capture Page Screenshot
    Alert Should Be Present       Inclua um "@" no endereço de e-mail. "${gerente_emailinvalido}" está com um "@" faltando.

Então o botão entrar não deve estar habilitado
    Element Should Be Disabled     ${btn_entrar}


