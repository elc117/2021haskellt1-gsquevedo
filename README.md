
Generative Art com Programação Funcional em Haskell
Nome: Gabriele Soares Quevedo 
Curso: Ciência da Computação 

Como compilar:
Para compilar o arquivo utilizei os seguintes comandos
- ghci 
- :l Main.hs 
- main 
 
Como funciona: 
Deve-se informar as informações pedidas pelo programa (altura e largura da imagem, quantidade de figuras, raio e posição do círculo)
Fiz algumas alterações simples no Generative Art, a princípio a ideia foi desenhar círculos, retângulo e triângulos que serão controlados pelas coordenadas que o usuário informar pela linha de comando(raio e quantidade de figuras) ou no arquivo(a altura e largura do retângulo).

- O círculo são interligados pelo tamanho do raio. Tornei a posição do círculo dinâmica, o usuário digita a posição que desejar. Os círculos são desenhados um dentro do outro, pois a função genCircleInLine, modifica o raio a cada interação da list, também uso uma função para calcular o raio do círculo utilizando a constante Pi. Para mudar a cor do círculo, fiz a função rgbCirculo, deixando uma variável 'a' em aberto, que é utilizada para modificar a cor conforme o raio, nessa variável chamo a função(corCirc). Obs: Utilizei o tipo "screen" no style do circulo para deixar um efeito diferente. Uma maneira de conferir que o circulo está sendo desenhado um em cima do outro com raios diferentes.

- Os retângulos são interligados pelas coordenadas, optei por desenhar retângulo azuis porém em posições diferentes (vertical e horizontal).  Ambos tem tons degradê de azul, ao aumentar a quantidade de figuras. A imagem também é estática. Porém na imagem vertical, o usuário digita a largura e altura do retângulo na linha de comando, na outra pode ser modificado pelo arquivo.

- Os triângulos são desenhado sobreposto sobre sua coordenada. Suas cores variam conforme aumenta o número de triângulos. É desenhado conforme a largura e altura da imagem (apenas por opção, já que a modificação acontece em relação a cor), isto é, torna-se uma figura estática, a figura continuará na mesma posição, mas com imagem de tamanho diferente.

![img](/t1.svg)
![img](/t2.svg)
![img](/t3.svg)
![img](/t4.svg)
