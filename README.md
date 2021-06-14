<h1 align="center"> Generative Art com Programação Funcional em Haskell</h1>
Nome: Gabriele Soares Quevedo <br/>
Curso: Ciência da Computação <br/>

<h4> Como compilar: </h4>
Para compilar o arquivo utilizei os seguintes comandos <br/>
      - ghci <br/>
      - :l Main.hs <br/>
      - main <br/>
 
<h4>Como funciona: </h4>
Fiz algumas alterações simples no Generative Art, a princípio a ideia foi desenhar círculos, retângulo e triângulos que serão controlados pelas coordenadas que o usuário modificar no arquivo. Pelo raio, lado e quantidade de figuras. </br>
- O <b>círculo</b> são interligados pelo tamanho do raio. Tornei o 'x' do círculo estático (apenas por opção), para modificar a posição do círculo deixei o 'y' em aberto, ou seja,o círculo será desenhado apenas na coordenada y. Os círculos são desenhados um dentro do outro, pois a função genCircleInLine, modifica o raio a cada interação da list, também uso uma função para calcular o raio do círculo utilizando a constante Pi. Para mudar a cor do círculo, fiz a função rgbCirculo, deixando uma variável 'a' em aberto, que é utilizada para modificar a cor conforme o raio, nessa variável chamo a função(raioCirc). Obs: Utilizei o tipo "screen" no style do circulo para deixar um efeito diferente. Uma maneira de conferir que o circulo está sendo desenhado um em cima do outro.</br>
- Os <b>retângulos</b> são interligados pelas coordenadas, utilizo uma função(maxLado) para mudar a cor do retângulo, que ao ir aumentando esse valor retorna um retângulo com tons de rosa e também será desenhado retângulos maiores. Obs: Utilizei o tipo "difference" no style do retângulo para deixar um efeito. É desenhado conforme a largura e altura da imagem (apenas por opção, já que a modificação acontece em relação ao tamanho do lado e a cor), isto é, torna-se uma figura estática, ao modificar essas coordenadas, a figura continuará na mesma posição.</br>
- Os <b>triângulos</b> são desenhado sobreposto sobre sua coordenada. Suas cores variam conforme aumenta o número de triângulos ou se modificar a variável 'b' em sua função(rgbTriangulo), por exemplo b = 5, retorna tons de vermelho. É desenhado conforme a largura e altura da imagem (apenas por opção, já que a modificação acontece em relação a cor), isto é, torna-se uma figura estática, ao modificar essas coordenadas, a figura continuará na mesma posição, mas com imagem de tamanho diferente. <br>
![img](/t1.svg)
![img](/t2.svg)
![img](/t3.svg)

