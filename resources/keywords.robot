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
${message_boas_vindas}            Seja bem-vindo, @!

#HomePage
${home_header}                    id=header
${home_logo}                      id=logo
${home_logout}                    id=logoutButton
${home_indicator}                 id=indicator-button
${home_feedback}                  id=feedback-button
${home_upload}                    id=file-upload-button
${indicator_icon}                 id=startup-icon
${indicator_info}                 id=startup-info
${indicator_name}                 id=startup-name
${indicator_details}              id=startup-details

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

E deve ser exibido o menu de opções
    Wait Until Page Contains                   Indicadores
    Wait Until Page Contains                   Feedback
    Wait Until Page Contains                   Envio de Arquivos
    Page Should Contain Image                  assets/icons/feedback.svg
    Page Should Contain Image                  assets/icons/upload.svg
    Page Should Contain Image                  assets/icons/indicator.svg

Quando eu clicar em entrar
    Wait Until Page Contains Element    ${btn_entrar}
    Click Element                       ${btn_entrar}

Então eu devo ver a mensagem de boas vindas
    Wait until page contains               ${message_boasvindas}
    Capture Page Screenshot

Então não devo ver a mensagem de boas vindas
    Wait until page does not contain       ${message_boasvindas}
    Capture Page Screenshot

Então eu devo ver a mensagem erro
    Page Should Not Contain        ${message_boas_vindas}

Então o botão entrar não deve estar habilitado
    Element Should Be Disabled     ${btn_entrar}

Dado que eu logue como gerente
    Dado que eu acesse o portal das startups
    E insira os dados de login
    Quando eu clicar em entrar
    Então eu devo ver a mensagem de boas vindas

Quando eu selecionar a sessão de indicadores
    Wait Until Page Contains Element    ${home_indicator}
    Click Element                       ${home_indicator}

Então deve ser exibida a tela de indicadores da startup
    Wait Until Page Contains Element    ${indicator_icon}
    Wait Until Page Contains Element    ${indicator_info}
    Wait Until Page Contains Element    ${indicator_name}
    Wait Until Page Contains Element    ${indicator_details}

Quando eu clicar em sair
    Wait Until Page Contains Element    ${home_logout}
    Click Element                       ${home_logout}

Então devo ser redirecioando a tela de login
    Wait Until Page Contains Element    ${form_login}
    ${url} =                            Get Location
    Should Be Equal As Strings         ${url}    ${URL_BASE}/login
