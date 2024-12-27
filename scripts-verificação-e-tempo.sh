# VERIFICACAO:

!/bin/bash

# Captura a data e hora atual no formato Ano-Mês-Dia Hora:Minuto:Segundo.
DATA=$(date '+%Y-%m-%d %H:%M:%S')

# Define o nome do serviço a ser verificado.
SERVICO="nginx"

# Verifica o status do serviço Nginx usando o systemctl e armazena o resultado ("active", "inactive", "failed", etc.).
STATUS=$(systemctl is-active $SERVICO)

# Inicia uma estrutura condicional: se o status for "active"...
if [ $STATUS == "active" ]; then
    # ...grava uma mensagem de serviço ONLINE no arquivo nginx_online.log.
    echo "$DATA - $SERVICO - ONLINE - O serviço está funcionando corretamente" > /var/log/nginx_online.log
else
    # ...senão (se o status NÃO for "active"), grava uma mensagem de serviço OFFLINE no arquivo nginx_offline.log.
    echo "$DATA - $SERVICO - OFFLINE - O serviço não está funcionando" > /var/log/nginx_offline.log
fi 
# Finaliza a estrutura condicional if.



# TEMPO:


#Execute o script /home/ec2-user/scripts/check_nginx.sh a cada 5 minutos, no qual, cada "*" signfica uma determinada data (horas, semanas, dias, meses), ou seja, execute em todas as horas, todos os dias do mês, todos os meses e todos os dias da semana.
*/5 * * * * /home/ec2-user/check_nginx.sh
