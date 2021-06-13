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
- O <b>círculo</b> são interligados pelo tamanho do raio: ao aumentar o raio, o style desenha o circulo conforme a função que compara o raio(tipoRaio), sendo possível gerar 4 tipos de style do circulo, sendo eles: difference, screen, luminosity e exclusion. Tornei o 'x' do círculo estático (apenas por opção), para modificar a posição do círculo deixei o 'y' em aberto, sendo possível modificar, logo o círculo será desenhado apenas na coordenada y. Os círculos são desenhados um dentro do outro, pois a função genCircleInLine, modifica o raio a cada interação da list, também uso uma função para calcular o raio do círculo utilizando a constante Pi. Para mudar a cor do círculo, fiz a função rgbCirculo, deixando uma variável 'a' em aberto, que é utilizada para modificar a cor. Sendo possível, gerar cores como tons de azul (a = 0 ),tons de vermelho (a = 5), tons de laranja (a = 10), tons de amarelo (a=50) esses são meus testes.</br>
  <img src="/b1.png" width="150" heigth="150"/> <img src="/b2.png" width="150" heigth="150"/> 
- O <b>retângulo</b> são interligados pelos pontos do retângulo: ao aumentar o lado do retângulo, o style desenha o retângulo conforme a função que compara os lados, 

<img src="/t1.svg" width="400" heigth="500"/> <img src="/t1.svg" width="400" heigth="500"/><img src="/t2.svg" width="400" heigth="500"/><img src="/t3.svg" width="400" heigth="500"/>
 
