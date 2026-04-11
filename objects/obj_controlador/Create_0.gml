randomize();

// 1. Banco de Dados
perguntas_base = [
    { enunciado: "Qual comando exibe algo na tela em Python?", opcoes: ["print()", "echo", "cout", "system"], correta: 0 },
    { enunciado: "O que significa HTML?", opcoes: ["Hyperlinks", "HyperText Markup Language", "Home Tool", "Hyperlinks Text"], correta: 1 },
    { enunciado: "Qual símbolo inicia um ID no CSS?", opcoes: [".", "@", "#", "$"], correta: 2 },
    { enunciado: "Em JavaScript, qual palavra declara uma variável constante?", opcoes: ["var", "let", "const", "static"], correta: 2 },
    { enunciado: "Qual tag HTML é usada para criar um link?", opcoes: ["<link>", "<a>", "<href>", "<url>"], correta: 1 },
    { enunciado: "No CSS, qual propriedade muda a cor do texto?", opcoes: ["background-color", "text-style", "font-color", "color"], correta: 3 },
    { enunciado: "Qual destes é um banco de dados Relacional?", opcoes: ["MongoDB", "MySQL", "Redis", "JSON"], correta: 1 },
    { enunciado: "Como se comenta uma linha em C# ou Java?", opcoes: ["#", "--", "//", "/*"], correta: 2 },
    { enunciado: "Qual tag define o título da aba do navegador?", opcoes: ["<head>", "<title>", "<meta>", "<header>"], correta: 1 },
    { enunciado: "O que o comando 'ls' faz no terminal Linux?", opcoes: ["Deleta", "Cria pasta", "Lista arquivos", "Move arquivos"], correta: 2 }
];

// 1. Definições de Dano
dano_padrao = 10;
total_perguntas = array_length(perguntas_base);

// 2. Definir a VIDA INICIAL e a VIDA MÁXIMA de cada um
// O vilão começa com 70% da vida total do baralho
vida_mau = (total_perguntas * 0.7) * dano_padrao; 
vida_maxima_mau = vida_mau; // Esta é a referência para a barra dele

// O herói começa com 30% da vida total do baralho
vida_bom = (total_perguntas * 0.3) * dano_padrao;
vida_maxima_bom = vida_bom; // Esta é a referência para a barra dele

energia_bom = 0;

// 3. Sistema de Fila
lista_ativa = ds_list_create();

function recarregar_perguntas() {
    ds_list_clear(lista_ativa);
    for (var i = 0; i < array_length(perguntas_base); i++) {
        ds_list_add(lista_ativa, perguntas_base[i]);
    }
    ds_list_shuffle(lista_ativa);
}

recarregar_perguntas();
pergunta_atual_dados = lista_ativa[| 0];