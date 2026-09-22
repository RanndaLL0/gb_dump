ANTES DE QUALQUER COISA!

O texto abaixo não é uma documentação técnica de nada, nem do projeto e nem do processador, são anotações minhas enquanto estudava pela refencia técnica do Cowgod.
Pode acabar servindo como referência e pode acabar sendo pertinente também para tirar duvidas sobre a implementação. A interface gráfica foi gerada com IA, sinceramente
não faço ideia de como funciona, somente que a mesma esta utilizando o buffer de video da CPU.

(Link para a referencia)
https://devernay-free-fr.translate.goog/hacks/chip8/C8TECH10.HTM?_x_tr_sl=en&_x_tr_tl=pt&_x_tr_hl=pt&_x_tr_pto=tc&_x_tr_sch=http#2nnn


O chip-8 possue 16 registradores (V0 A VF) sendo que cada um pode armazenar os valores 0x00 a 0xFF, e especial o registrador VF é utilizado para armazenar
informações sobre as operações.

O chip oito possue 4kb de memoria (4096 bits ou também 0XFFF), os endereços da memoria são indexados da seguinte maneira

0x000-0x1FF: Reservado para o interpretador do CHIP-8
0x050-0x0A0: Espaco de memoria para os 16 caracteres integrados
0x200-0xFFF: Espaço dedicado para o armazenado das informações da ROM do jogo, qualquer espaço depois disso é livre na memória


Registro de índice (16 bits)
O registrador de índice aponta para endereços na memoria que serão utilizados nas operações, ele possue 16 bits pois a memoria é grande demais para ser indexada com
8 bit (0xFFF).

Program Counter (PC)
Sera utilizado para o indexamento das instruções do programa, de maneira similar ao neogeo, as instruções de 16bits serão armazenadas em endereços de 8 bits aonde estas serão concatenadas
na leitura e separadas na gravação

Pilha de 16 níveis

O CHIP-8 possue 16 níveis de pilha, o que significa que o mesmo possue 16 Program Counters, Com a instrução CALL o Program Counter é armazenado e o programa executa a função em outro ponto,
aonde com a instrução return o Programa volta ao ponto anterior do Program Counter.

Exemplo de assembly

$200: CALL $208
$202: JMP $20E
$204: LD V1, $1
$206: RET
$208: LD V3, $3
$20A: CALL $204
$20C: RET
$20E: LD V4, $4

Call para o endereço 208, executa LD, Call para o endereço 204, executa LD, Retorna para 20A, Retorna para 200, execulta o JMP para 20E, executa LD

temporizador de atraso:
O temporizador quando carrega um valor o decrementa para uma taxa de 60hz. (O mesmo possue um temporizador de SOM).
O CHIP-8 Possue 16 teclas de entrada.


O CHIP-8 Também possue um Buffer de memória dedicado ao armazenamento gráfico que sera exibido em tela. Ele tem 64 x 32 de Altura, aonde a instrução de desenho faz um XOR com o pixel que esta em tela com o pixel do sprite,
O CHIP-8 é monocromático também, então o mesmo só renderiza branco ou preto, o mesmo ira ser representado posteriormente com um uint32 para facilitar a compatibilidade com o SDL
