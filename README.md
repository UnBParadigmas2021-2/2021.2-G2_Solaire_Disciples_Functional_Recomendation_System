# RepositorioTemplate

# Recomendation System

**Disciplina**: FGA0210 - PARADIGMAS DE PROGRAMAÇÃO - T01 <br>
**Nro do Grupo**: 02<br>
**Paradigma**: Funcional<br>

## Alunos

| Matrícula  | Aluno                                  |
| ---------- | -------------------------------------- |
| 18/0016563 | Filipe Santana Machado                 |
| 18/0014412 | Cainã Valença de Freitas               |
| 16/0015006 | Mateus Oliveira Patricio               |
| 18/0011308 | Peniel Etèmana Désirez-Jésus Zannoukou |
| 17/0122468 | Nilvan Peres Costa                     |
| 18/0105345 | Lucas Lima Ferraz                      |
| 18/0078640 | Yuri Alves Bacarias                    |
| 17/0141161 | Erick Giffoni                          |

## Sobre

Descreva o seu projeto em linhas gerais.

## Screenshots

Adicione 2 ou mais screenshots do projeto em termos de interface e/ou funcionamento.

## Instalação

**Linguagens**: Haskell<br>
**Tecnologias**: gi-gtk<br>
Descreva os pré-requisitos para rodar o seu projeto e os comandos necessários.
Insira um manual ou um script para auxiliar ainda mais.

Instalação dos pacotes:
Please see [gi-gtk](https://github.com/haskell-gi/haskell-gi)

### Ubuntu

```
sudo apt-get install libghc-gtk-dev
sudo apt-get install libcanberra-gtk-module
cabal update
cabal install gtk2hs-buildtools
cabal install gtk
```

### Mac OSX

Install [Homebrew](https://brew.sh/) and install GTK+ and GObject Introspection:

```
brew install gobject-introspection gtk+ gtk+3
```

Ensure the path to libffi (probably `/usr/local/opt/libffi/lib/pkgconfig`) is in the PKG_CONFIG_PATH environment variable.

## Uso

Explique como usar seu projeto, caso haja algum passo a passo após o comando de execução.

exemplos de comandos:

```haskell
*Main> adj g 'a'
output: "bxw"

*Main> isAdj g 'a' 'b'
output: True

*Main> isWalk g ['a', 'b', 'c']
output: True

*Main> connectNearestUe ['a', 'b', 'c']
output: [Ue ('a','b'),Ue ('b','c')]

*Main> isTrail g ['a', 'b', 'c']
output: True

*Main> open g ['a', 'b']
output: True

*Main> close g ['a', 'b', 'y']
output: True

*Main> paths g [] 'a' 'c'
output: ["cba","czba","cwa"]

*Main> dfs g 'b'
output: "baxwcz"

*Main> bfs g [] ['a']
output: "abxwcz"

*Main> bfsL g [] [('a',0)]
output: [('a',0),('b',1),('x',1),('w',1),('c',2),('z',2)]

*Main> sPaths g 'a' 'c'
output: Just ["cba","cwa"]

```

## Vídeo

Adicione 1 ou mais vídeos com a execução do projeto.

## Outros

Quaisquer outras informações sobre seu projeto podem ser descritas a seguir.

## Fontes

Caso utilize materiais de terceiros, referencie-os adequadamente.
