*** Settings ***
Library                            SeleniumLibrary    run_on_failure=Capture Page Screenshot

*** Variables ***
${URL_BASE}                        http://localhost:4000         # URL of the application
${user_input}                      //*[@name="email"]            # ID of the user input field    
${user_email}                      admin@prints.com.br
${user_email_invalido}             adminadmin


${password_input}                  //*[@name="password"]         # ID of the password input field
${user_password}                   admin

${btn_entrar}                      id=btn-entrar

*** Keywords ***

Dado que eu acesse o portal das startups
    Go to                          ${URL_BASE}
    Wait until page contains       Login

E insira os dados de login
    Element Should Be Visible      ${user_input}	
    Input text                     ${user_input}               ${user_email}     
    Sleep                          1s
    Element Should Be Visible      ${password_input}
    Input text                     ${password_input}           ${user_password}

E insira o email sem dominio
    Element Should Be Visible      ${user_input}	
    Input text                     ${user_input}               ${user_email_invalido}
    Sleep                          1s
    Element Should Be Visible      ${password_input}
    Input text                     ${password_input}           ${user_password}

E deixe o campo senha em branco
    Element Should Be Visible      ${user_input}
    Element Should Be Visible      ${password_input}
    Input text                     ${user_input}               ${user_email}

Quando eu clicar em entrar
    Click Element                  ${btn_entrar}

Então eu devo ver a mensagem de boas vindas
    Wait until page contains       Seja bem-vindo, @!
    Capture Page Screenshot

Então eu devo ver a mensagem erro
    Element Should Be Focused      ${user_input}
    #Page Should Contain       Inclua um "@" no endereço de email. "a" não contém um "@" faltando.

Então o botão entrar não deve estar habilitado
    Element Should Be Disabled     ${btn_entrar}


