# Recomendation System

**Disciplina**: FGA0210 - PARADIGMAS DE PROGRAMAÇÃO - T01 <br>
**Nro do Grupo**: 02<br>
**Paradigma**: Funcional<br>

## Alunos
|Matrícula | Aluno |
| -- | -- |
| 18/0016563  |  Filipe Santana Machado |
| 18/0014412  |  Cainã Valença de Freitas |
| 16/0015006  |  Mateus Oliveira Patricio |
| 18/0011308  |  Peniel Etèmana Désirez-Jésus Zannoukou |
| 17/0122468  |  Nilvan Peres Costa |
| 18/0105345  |  Lucas Lima Ferraz |
| 18/0078640  |  Yuri Alves Bacarias |
| 17/0141161  |  Erick Giffoni |

## Sobre 

O problema foi baseado em [Social networking and recommendation systems](https://courses.cs.washington.edu/courses/cse140/13wi/homework/hw4/homework4.html).
#### Sistema de recomendação de amizades para rede social utilizando grafos.
O projeto propôe dois algoritmos para recomendação de amizades em redes sociais, considerando os nós como os usuários e as arestas como a conexão de amizade entre eles. O objetivo do projeto é comparar os resultados e as diferenças dos algoritmos.

##### Algoritmo Padrão
O primeiro algoritmo, considerado padrão neste projeto, propôe recomendar amigos de amigos com base no número de amigos em comum que essa pessoa tem com você.
- Cada recomendação terá um score `>= 1` e é dada pelo número de amigos em comum com o nó inicial (você)

##### Algoritmo de Influência
O segundo algoritmo, que é o algoritmo de influência, considera a recomendação com base no valor de cada amizade, dando o valor da seguinte forma:
  Imagine que você tem dois amigos, um deles (amigo A) tem apenas 2 amigos (você e mais um) e o seu outro amigo (amigo B) tem 7 milhões de amigos, logo, a lógica mostra que o amigo A é muito mais seletivo com suas amizades do que o amigo B, logo, é melhor para o sistema te recomendar amigos do amigo A do que recomendar amigos que o amigo B adicionou aleatoriamente.
 - Cada recomendação terá o score de `somatório de 1/(numero de amigos) de cada amigo em comum da recomendação com o nó inicial(você)`

## Screenshots
![image](https://user-images.githubusercontent.com/40258400/153970165-d4c864cb-149d-4c20-beea-f8ccac8b2d0e.png)
![image](https://user-images.githubusercontent.com/40258400/153970286-533bb87a-16fb-4975-ba10-883408b9f4be.png)

## Instalação 
**Linguagens**: Haskell<br>
**Tecnologias**: Cabal, Hamlet e Scotty<br>

### Instação no Ubuntu
O cabal foi utilizado para empacotamento e distribuição dos pacotes do projeto.
Para instalar o cabal no ubuntu basta o comando:
```shell
$ sudo apt-get install -y cabal-install
$ cabal update
```
Agora na pasta raíz do projeto é necessário que o cabal instale as dependências:
```shell
$ cabal install
```
Pode levar alguns minutos até o cabal instalar todas as dependências do projeto.

## Uso 

Para inicializar o serviço web:
```shell
$ cabal run
```
O programa irá hospedar um serviço web na porta `3000`.
Para acessar a visualização dos dados:
acessar `localhost:3000`

O site te mostrará:
- Seu id e seu nome
- Sua lista de amigos
- Recomendação de amizades usando o algoritmo padrão
- Recomendação de amizades usando o algoritmo de influência
- Imagem do grafo atual

Para alterar o grafo e o seu nó inicial é necessário que se faça uma alteração no código fonte:
> Disclaimer:
>   O grupo tentou implementar essa alteração de dados no front-end porém encontramos bugs que atrapalharam o desenvolvimento, devido a deadline o grupo parou de tentar implementar esse ponto e focou em outros pontos do projeto.

O código a ser alterado é
[esse](https://github.com/UnBParadigmas2021-2/2021.2-G2_Solaire_Disciples_Functional_Recomendation_System/blob/ee6fdc9fff49d01474026c4a0ad35ed95c060df1/Main.hs#L111#L112):

São as variáveis `person_id` e `graph_id` presentes no arquivo `Main.hs`.
Após essas alterações, basta executar no shell `cabal run` e as alterações estarão presentes no site.

## Vídeo
https://youtu.be/SHrgjtrc78I

## Outros 
Há algumas implementações que ficaram pendentes, tais como:
- Seleção de grafo e nó pelo front-end
- Botão de adicionar pessoa no front-end, atualizando o grafo e gerando novas recomendações

Tais implementações são triviais no back-end, porém no front o grupo necessita de mais conhecimento e tempo para implementá-las.

## Fontes
> MALOV, Evgeniy. Graphs with Haskell (part 1). Youtube, 25/12/2021. Diponível em https://www.youtube.com/watch?v=RS7eIkETdIQ. Acesso em: 14/02/2022.

>  Social networking and recommendation systems. Disponível em https://courses.cs.washington.edu/courses/cse140/13wi/homework/hw4/homework4.html. Acesso em 14/02/2022.
