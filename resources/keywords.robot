*** Settings ***
Library                            SeleniumLibrary    run_on_failure=Capture Page Screenshot
Resource                           ${EXECDIR}/resources/base.robot

*** Variables ***
${URL_BASE}                                    http://localhost:4000         # URL of the application
${gerente_email}                               gerente@gmail.com
${gerente_emailinvalido}                       gerente#gmail.com
${gerente_password}                            123456
            
#Locators            
${form_login}                                  id=login-form                   
${form_login_title}                            id=login-title
${form_login_fields}                           id=login-inputs
${user_input_field}                            id=email-input            # ID of the user input field    
${password_input_field}                        id=password-input         # ID of the password input field
${register_link}                               id=register-link          # ID of the register link
${forgot_password_link}                        id=forgot-password-link   # ID of the forgot password link          
${btn_entrar}                                  id=login-button
@{login_elements}                              ${form_login}    ${form_login_title}    ${form_login_fields}    ${user_input_field}    ${password_input_field}    ${register_link}    ${forgot_password_link}    ${btn_entrar}

#Imagens da pagina de Login
${login_image_logo}                            assets/logo.jpeg
${login_image_senac}                           assets/logo-senac-pe.png
${login_image_ufrpe}                           assets/logo-ufrpe.jpg
@{login_images}                                ${login_image_logo}    ${login_image_senac}    ${login_image_ufrpe}

#Textos da pagina de Login
@{Textos do login}                             Bem vindo ao PRINTS.    
...                                            (Programa de Inovação e Tecnologia)    
...                                            Programa de Incubação.    
...                                            Parceria entre:

${erro_message_senha_incorreta}                Usuário ou senha inválidos
${message_boas_vindas}                         Seja bem-vindo, @!

#HomePage
${home_header}                                 id=header
${home_logo}                                   id=logo
${home_logout}                                 id=logoutButton
${home_indicator}                              id=indicator-button
${home_feedback}                               id=feedback-button
${home_upload}                                 id=file-upload-button        
${homepage_image_feedback}                     assets/icons/feedback.svg
${homepage_image_upload}                       assets/icons/upload.svg
${homepage_image_indicator}                    assets/icons/indicator.svg
@{home_elements}                               ${home_header}    ${home_logo}    ${home_logout}    ${home_indicator}    ${home_feedback}    ${home_upload}
@{home_images}                                 ${homepage_image_feedback}    ${homepage_image_upload}    ${homepage_image_indicator}
@{homepage_textos}                             Indicadores    
...                                            Feedback
...                                            Envio de Arquivos

#indicatorPage
${indicator_icon}                              id=startup-icon
${indicator_info}                              id=startup-info
${indicator_name}                              id=startup-name
${indicator_details}                           id=startup-details
@{indicator_elements}                          ${indicator_icon}    ${indicator_info}    ${indicator_name}    ${indicator_details}

*** Keywords ***
#Aux Functions
Validar textos
    [Arguments]    @{Textos}
    FOR  ${texto}  IN  @{Textos}
        Wait Until Page Contains              ${texto}
    END

Validar elementos
    [Arguments]    @{Elementos}
    FOR  ${elemento}  IN  @{Elementos}
        Wait Until Page Contains Element      ${elemento}
    END

Validar imagens
    [Arguments]    @{Imagens}
    FOR  ${imagem}  IN  @{Imagens}
        Page Should Contain Image             ${imagem}
    END

#Given keys
Dado que eu acesse o portal das startups
    Go to                                      ${URL_BASE}
    Validar elementos                          @{login_elements}
    Validar imagens                            @{login_images}
    Validar textos                             @{Textos do login}

Dado que eu logue como gerente - Setup
    Open Session
    Dado que eu acesse o portal das startups
    E insira os dados de login
    Quando eu clicar em entrar
    Então eu devo ver a mensagem de boas vindas

Dado que eu esteja logado no sistema
    ${url}    Get Location
    Should Be Equal As Strings                 ${url}    ${URL_BASE}/

#And keys
E insira os dados de login            
    Element Should Be Disabled                 ${btn_entrar}
    Element Should Be Visible                  ${user_input_field}	
    Input text                                 ${user_input_field}               ${gerente_email}     
    Sleep                                      1s
    Element Should Be Visible                  ${password_input_field}
    Input text                                 ${password_input_field}           ${gerente_password} 
    Element Should Be Enabled                  ${btn_entrar}

E insira os dados de login errados            
    Element Should Be Disabled                 ${btn_entrar}
    Element Should Be Visible                  ${user_input_field}	
    Input text                                 ${user_input_field}               ${gerente_email}     
    Sleep                                      1s
    Element Should Be Visible                  ${password_input_field}
    Input text                                 ${password_input_field}           SenhaInvalida
    Element Should Be Enabled                  ${btn_entrar}
    
E insira o email sem dominio            
    Element Should Be Visible                  ${user_input_field}	
    Input text                                 ${user_input_field}               ${gerente_email_invalido}
    Element Should Be Visible                  ${password_input_field}
    Input text                                 ${password_input_field}           ${gerente_password}

E deixe o campo senha em branco            
    Element Should Be Visible                  ${user_input_field}
    Element Should Be Visible                  ${password_input_field}
    Input text                                 ${user_input_field}               ${gerente_email}

E deve ser exibido o menu de opções
    Validar textos                             @{homepage_textos}                   
    Validar elementos                          @{home_elements}
    Validar imagens                            @{home_images}             

#When keys
Quando eu clicar em entrar
    Validar elementos                          ${btn_entrar}
    Click Element                              ${btn_entrar}

Quando eu clicar em sair
    Validar elementos                          ${home_logout}
    Click Element                              ${home_logout}

Quando eu selecionar a sessão de indicadores
    Validar elementos                          ${home_indicator}
    Click Element                              ${home_indicator}
    ${url}=                                    Get Location
    Should Be Equal As Strings                 ${url}    ${URL_BASE}/dashboard

#Then keys
Então eu devo ver a mensagem de boas vindas
    Wait until page contains                   ${message_boasvindas}
    Capture Page Screenshot

Então não devo ver a mensagem de boas vindas
    Wait until page does not contain           ${message_boasvindas}
    Capture Page Screenshot

Então eu devo ver a mensagem erro
    Page Should Not Contain                    ${message_boas_vindas}

Então o botão entrar não deve estar habilitado
    Element Should Be Disabled                 ${btn_entrar}

Então deve ser exibida a tela de indicadores da startup
    Validar elementos                          ${indicator_icon}
    Validar elementos                          ${indicator_info}
    Validar elementos                          ${indicator_name}
    Validar elementos                          ${indicator_details}

Então devo ser redirecioando a tela de login
    ${url} =                                   Get Location
    Should Be Equal As Strings                 ${url}    ${URL_BASE}/login
    Validar elementos                          @{login_elements}
    Validar textos                             @{Textos do login}
    Validar imagens                            @{login_images}
