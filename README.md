<h1 align="center"> Generative Art com Programação Funcional em Haskell</h1>
Nome: Gabriele Soares Quevedo <br/>
Curso: Ciência da Computação <br/>

<h4> Como compilar: </h4>
Para compilar o arquivo utilizei os seguintes comandos <br/>
      - ghci <br/>
      - :l Main.hs <br/>
      - main <br/>
 
<h4>Como funciona: </h4>
Fiz algumas alterações simples no Generative Art, a princípio a ideia foi desenhar círculos, retângulo e triângulos que serão controlados pelas coordenadas que o usuário modificar no arquivo.</br>
- O <b>círculo</b> são interligados pelo tamanho do raio: Tornei o 'x' do círculo estático (apenas por opção), para modificar a posição do círculo deixei o 'y' em aberto, ou seja,o círculo será desenhado apenas na coordenada y. Os círculos são desenhados um dentro do outro, pois a função genCircleInLine, modifica o raio a cada interação da list, também uso uma função para calcular o raio do círculo utilizando a constante Pi. Para mudar a cor do círculo, fiz a função rgbCirculo, deixando uma variável 'a' em aberto, que é utilizada para modificar a cor conforme o raio, nessa variável chamo a função(raioCirc).</br>
  <img scr="/t1.svg" width="400" heigth="400"/>
- O <b>retângulo</b> são interligados pelos pontos do retângulo: ao aumentar o lado do retângulo, o style desenha o retângulo conforme a função que compara os lados, 
 
