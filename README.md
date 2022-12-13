Funcionamento do processador:

A cpu recebe dois inputs:
1 - clock
2 - mir (micro instruction register)

E quatro outputs:
1 - on_c (olha o barramento c)
2 - on_b (olha o barramento b)
3 - on_ram_read (olha dados lidos da ram)
4 - on_ram_write (olha dados escritos da ram)

A microinstrução, de 28 bits, tem o seguinte formato:

00_000000_00_0000_0000000000_0000 => 2shif + 6ula + 2wr + 4addr + 10c + 4b = 28

- 2 bits para controlar o deslocador (shifter)
- 6 bits para controlar a ula (alu)
- 2 bits para habilitar escrever e ler na ram (wr = write and read)
- 4 bits indicando o endereço da ram (address)
- 10 bits que habilitam os registradores para receber dados (alguns recebem do barramento c, outros da memória)
- 4 bits que habilitam os registradores para escrever no barramento b

Funções específicas dos registradores:
(Os nomes dos registradores não necessáriamente condizem com sua função)

- MAR é específico para receber o endereço da memória (ram_addr), é importante que ele esteja habilitado para receber dados (in_enable) sempre que se quiser ler ou escrever na memória. Ele recebe diretamente da instrução o endereço e o envia para a memória.

- MDR é específico para ler dados da memória, para ler, é necessário dois sinais habilitadores, um recebido pela ram (read_enable) e outro para que o registrador receba a informação (in_enable). Ele recebe dados da memória e envia para o barramento B.

- PC é específico para receber o sinal que habilita a memória (ram_wr_enable), é importante que ele esteja habilitado para receber dados (in_enable) sempre que se quiser ler ou escrever na memória. Ele recebe diretamente da instrução o sinal e o envia para a memória.

- MBR é específico para escrever na memória, ele está sempre habilitado enviar dados, a escrita depende do sinal recebido pela ram (write_enable). Ele recebe dados do barramento C e envia para a memória.

- Os outros registradores funcionam na mesma forma, recebem informações o barramento C e enviam para o barramento B, exceto o registrador H, está sempre habilitado para enviar dados para a entrada A da ula.

Função dos barramentos:

O barramento B recebe dados dos registradores (exceto os que enviam dados para a ram), e os envia para a entrada B da ula.

O barramento C recebe o dado do deslocador, e os envia para os registradores (exceto o que recebe dados da ram).

Função da ula:

A ula opera os dados recebidos pelo registrador H e o barramento B, de acordo com o código recebido na instrução, e os envia para o deslocador.

Função do deslocador:

O deslocador (shifter), opera o dado recebido da ula e o envia para o barramento C.

Função da memória:

A RAM recebe os dados de endereço e de write/read, então envia ou armazena o dado de acordo com a instrução recebida.
