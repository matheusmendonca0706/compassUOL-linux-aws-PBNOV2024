# compassUOL-linux-aws-PBNOV2024
## Objetivos

Os objetivos deste projeto são:

1.  Criar um ambiente Linux no Windows utilizando o WSL (Windows Subsystem for Linux).
2.  Instalar o Ubuntu 20.04 (ou superior) como subsistema WSL.
3.  Implementar as seguintes atividades no ambiente Linux:
    *   Subir um servidor Nginx.
    *   Criar um script para validar o status do serviço Nginx.
    *   O script deve registrar data, hora, nome do serviço, status (ONLINE/OFFLINE) e uma mensagem personalizada.
    *   O script deve gerar dois arquivos de log: um para status ONLINE e outro para OFFLINE.
    *   Automatizar a execução do script a cada 5 minutos.
# Configuração de Ambiente Linux no Windows Usando WSL

## Criando uma Máquina Virtual Windows no macOS: (note que se o seu SO nao é um MacOS assim como o meu, nao será necessário fazer esse passo)

### Passo 1: Instalar o VirtualBox no macOS

1. **Baixe o VirtualBox**:
   - Acesse [VirtualBox.org](https://www.virtualbox.org/wiki/Downloads) e baixe a versão para macOS. 

2. **Instale o VirtualBox**:
   - Siga as instruções do instalador e, em instantes, você estará pronto para criar suas máquinas virtuais!

### Passo 2: Baixar a ISO do Windows

1. **Baixe a ISO do Windows**:
   - Visite [Microsoft.com](https://www.microsoft.com/pt-br/software-download/windows10ISO) e baixe a imagem ISO do Windows.

### Passo 3: Configurar a Máquina Virtual no VirtualBox

1. **Abra o VirtualBox e crie uma nova VM**:
   - Clique em "New".
   - Defina o nome como "Windows 10".
   - Tipo: Microsoft Windows.
   - Versão: Windows 10 (64-bit).

2. **Configure a Memória**:
   - Aloque pelo menos 4 GB de RAM (quanto mais, melhor!).

3. **Crie um Disco Rígido Virtual**:
   - Siga as instruções para criar um novo disco.

### Passo 4: Instalar o Windows na Máquina Virtual

1. **Inicie a VM e selecione a ISO do Windows**.
2. **Siga as instruções de instalação do Windows**.

## Configurando o WSL no Windows:

### Passo 1: Instalar o WSL

1. **Abra o PowerShell como Administrador**:
   - Clique com o botão direito no menu Iniciar e selecione "Windows PowerShell (Admin)".

2. **Executar o Comando para Instalar o WSL**:
   ```bash
   wsl --install
### Passo 2: Instalar o Ubuntu 20.04 ou Superior

1. **No PowerShell, instale o Ubuntu**:
   ```bash
   wsl --install -d Ubuntu-20.04

### Passo 3: Se certificar que o WSL foi instalado, por meio da sua versao

1. *No PowerShell*
   ```bash
   wsl --list --verbose
   
## Para esse projeto eu resolvi utilizar a AWS, afim de praticar o conteúdo aprendido na Sprint.


# Configuração de um Internet Gateway e EC2 na VPC

## Criando um Internet Gateway

Pelo fato da AWS está constantemente atualizando o design das "telas" dos seus serviços, eu resolvi nao colocar imagens nesse repositorio, entretanto, detalhei cada componente no qual voces devem clicar para seguir o passo a passo.

Primeiro, vamos criar um gateway da Internet para a VPC (Nuvem Privada Virtual).

1. No painel de navegação à esquerda, selecione "Internet Gateways" -> Clique em "Create internet gateway" -> Insira um nome para o Internet Gateway (opcional) -> clique em "Create internet gateway".

## Associando o Internet Gateway à VPC

Após criar o Internet Gateway:

1. Clique no botão "Actions" -> "Attach to VPC" -> Selecione a VPC à qual deseja associar o Internet Gateway -> clique em "Attach internet gateway".

## Configurando a Tabela de Rotas

1. No painel de navegação à esquerda, clique em "Route Tables" -> Escolha a tabela de rotas vinculada à sua sub-rede pública -> Vá até a aba "Routes" -> clique em "Edit routes" -> Clique em "Add route" -> insira `0.0.0.0/0` no campo "Destination" -> selecione o Internet Gateway no campo "Target" -> Clique em "Save routes".

Seguindo esses passos, você terá um Internet Gateway configurado e associado à sua VPC, permitindo o tráfego de dados da Internet.

## Criando a Instância EC2

Após completar essas etapas, o próximo passo é criar a instância EC2 (Nuvem de Computação Elástica).

# Como Criar uma Instância EC2

1. **Acesse o EC2:**
   - Digite "EC2" na barra de pesquisa.

2. **Inicie a Instância:**
   - Clique em "Launch Instance".

3. **Escolha uma AMI:**
   - Selecione a imagem desejada.

4. **Defina o Tipo de Instância:**
   - Escolha "t2.micro" (gratuito).
   - Selecione ou crie um par de chaves para SSH.

5. **Configurações da Instância:**
   - Ajuste os parâmetros.
   - Escolha a VPC e sub-rede.
   - Configure o grupo de segurança (por exemplo, SSH na porta 22).

6. **Adicione Tags:**
   - Insira tags para organização.

7. **Alocar IP Elástico:**
   - Clique em "Elastic IPs" no menu.
   - Selecione "Allocate Elastic IP address" e confirme.

8. **Associar IP Elástico:**
   - Selecione o IP, clique em "Actions" e escolha "Associate Elastic IP address".
   - Selecione a instância e clique em "Associate".

Pronto! Sua instância EC2 estará criada e com IP elástico associado.

Para se conectar com a instancia via SSH.

No terminal, navegue até o diretório onde o arquivo de chave está localizado e execute:


```sh
chmod 400 KeyPair.pem

ssh -i KeyPair.pem ec2-user@< ippublicoEC2 >
```

## 2. Atividade no Linux: Subindo um Servidor Nginx

Esta seção descreve os passos para configurar e monitorar um servidor Nginx em um sistema Linux.

### Subindo o Servidor Nginx

1.  **Atualizar o repositório de pacotes e instalar o Nginx:**

    ```bash
    sudo apt update
    sudo apt install nginx -y
    ```

2.  **Iniciar o serviço Nginx e garantir que ele está rodando na inicialização do sistema:**

    ```bash
    sudo systemctl start nginx
    ```
    ```bash
    sudo systemctl enable nginx
    ```

3.  **Verificar se o serviço está online:**

    ```bash
    sudo systemctl status nginx
    ```

### Criando um Script de Validação do Serviço Nginx

Para monitorar o status do Nginx, um script de validação é criado e configurado para executar a cada 5 minutos.

1.  **Criar o script:**

    ```bash
    nano check_nginx.sh
    ```

2.  **Adicionar o seguinte código ao script (`check_nginx.sh`):**

    ```bash
    #!/bin/bash
    DATA=$(date '+%Y-%m-%d %H:%M:%S')
    SERVICO="nginx"
    STATUS=$(systemctl is-active $SERVICO)
    if [ $STATUS == "active" ]; then
    echo "$DATA - $SERVICO - ONLINE - O serviço está funcionando corretamente" > /var/log/nginx_online.log
    else
    echo "$DATA - $SERVICO - OFFLINE - O serviço não está funcionando" > /var/log/nginx_offline.log
    fi
    ```
3.  **Tornar o script executável:**

    ```bash
    chmod +x check_nginx.sh
    ```

# Verificação do Serviço NGINX

Este script verifica o status do serviço `nginx` e grava um log em um diretório especificado, com a data e hora atuais, além do status do serviço.

## Funcionamento

- **Serviço Ativo (Online):**  
  Se o serviço `nginx` estiver ativo, a saída será gravada no arquivo `nginx_online.log` no diretório especificado. O conteúdo do arquivo será:

  ```plaintext
  2024-12-27 01:41:00 - nginx - ONLINE - O serviço está funcionando corretamente
  2024-12-27 01:46:02 - nginx - ONLINE - O serviço está funcionando corretamente
  2024-12-27 01:51:03 - nginx - ONLINE - O serviço está funcionando corretamente
  2024-12-27 01:56:02 - nginx - ONLINE - O serviço está funcionando corretamente
- **Serviço Inativo (Offline):**  
  Se o serviço `nginx` estiver inativo, a saída será gravada no arquivo `nginx_offline.log` no diretório especificado. O conteúdo do arquivo será:

  ```plaintext
  2024-12-27 01:56:12 - nginx - OFFLINE - O serviço não está funcionando
  2024-12-27 02:11:43 - nginx - OFFLINE - O serviço não está funcionando
  2024-12-27 03:22:42 - nginx - OFFLINE - O serviço não está funcionando
  2024-12-27 03:51:00 - nginx - OFFLINE - O serviço não está funcionando
### Preparar a Execução Automatizada do Script (Cron)

O script será executado automaticamente a cada 5 minutos usando o `cron`.

1.  **Editar o crontab:**

    ```bash
    crontab -e
    ```

2.  **Adicionar a seguinte linha ao crontab:**

    ```
    */5 * * * *  bash ~/home/ec2-user/check_nginx.sh
    ```

## Versionamento do Projeto utilizando o git.

Para fazer o versionamento do Script de monitoramento usa-se o Git. Siga o passo a passo abaixo:

1. Inicialize o repositório Git:
    ```bash
    git init
    ```
    Este comando inicializa um repositório Git local na pasta onde você está. Sem isso, o Git não será capaz de rastrear as alterações nos arquivos.

2. Adicione o script ao repositório:
    ```bash
    git add check_nginx.sh
    ```
    Adiciona o arquivo `check_nginx.sh` ao índice (staging area), preparando-o para ser incluído no próximo commit. Esse passo é necessário para informar ao Git quais arquivos você quer versionar.

3. Faça o commit do script:
    ```bash
    git commit -m "mensagem descritiva a sua escolha"
    ```
    Cria um commit com as mudanças adicionadas no índice. Um commit é como um ponto de controle no histórico do repositório.

4. Crie um repositório no GitHub e adicione o repositório remoto na sua máquina:
    ```markdown
    Criar um repositório no GitHub
    ```
    Você precisa de um lugar remoto para hospedar seu repositório. O GitHub é um dos serviços mais populares para isso.
    ```bash
    git remote add origin "https://github.com/matheusmendonca0706/compassUOL-linux-aws-PBNOV2024"
    ```
    Vincula o repositório Git local ao repositório remoto que você criou no GitHub. Isso é necessário para que o Git saiba onde enviar os arquivos.

5. Envie os arquivos para o repositório remoto:
    ```bash
    git push -u origin main
    ```
    Envia os commits do repositório local para o repositório remoto no branch principal (`main`). O argumento `-u` configura o branch local para rastrear o branch remoto correspondente.

