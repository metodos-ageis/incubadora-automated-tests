# Automação de testes para o projeto da disciplina de metodologias ágeis em desenvolvimento de software

## **Ferramentas utilizadas para automação dos testes**

## Selenium Web Driver
A Selenium Web Driver é uma ferramenta utilizada para automação de testes de sistemas que permite ao usuário reproduzi-los no ambiente real da aplicação, em função da sua integração direta com o navegador.

## Robot
O Robot é um framework para automação de testes. É open source e independente de sistema operacional. Nativamente implementado para Python e Java.

**Entendendo um pouco mais sobre a sintaxe com seções do Robot Framework:**

1.  Na seção chamada ***Settings*** temos a definição das páginas ou recursos que serão utilizados para o teste.

2.  Ainda na seção de Settings, declaramos as keywords que serão consideradas como ***pré-requisitos*** tanto para dar início a uma suíte de teste, quanto para serem executadas antes de cada caso de teste. Essa declaração é feita através do bloco contendo os nossos ***Setups***.

3.  Já na seção de ***Test Cases*** podemos ter um ou mais casos de teste, que deverão possuir um conjunto de keywords para que seja realizado o nosso caso de teste.

4.  Na seção ***Variables*** iremos declarar as variáveis que serão utilizadas pelos nossos testes, podendo ser definidas como variáveis globais, para nosso conjunto de testes, apenas para um caso de teste ou como variáveis locais.

5.  Por fim, a seção de ***Keywords*** representa os passos que iremos realizar nos nossos casos de teste, ou seja, a construção do nosso caso de teste deverá possuir vários keywords que criamos até atingir o objetivo daquele cenário de teste. Além dessas keywords que estamos criando, também existem as keywords já existentes nas bibliotecas que estamos utilizando, essas deverão ser utilizadas para realizar alguma ação com a página, tela, sistema operacional ou com o software que estamos querendo testar.

# Componentes necessários para rodar a automação Web (Instalações)

 # 1. Instalar Python
Acessar [www.python.org](http://www.python.org)

		Baixar a última versão para o seu sistema
            Executar o install
            Selecionar install launcher for all users e add python 3.X to path
                E clicar em customize installation
                Selecionar as Optional Features
                Selecionar install for all users
            Next
            Install
            Close
            
	Abrir prompt e verificar instalação do python

		Python --version [ENTER]

	Verifica se instalou a versão baixada.

		pip --version [ENTER]

    Instalar o Robot Framework

        pip install robotframework

	Instalar Selenium

		pip install robotframework-seleniumlibrary [ENTER]

# 4. Instalar ChromeDriver

	Baixar ChromeDriver para a sua versão do seu chrome e colocar o caminho dele no PATH do seu sistema.

