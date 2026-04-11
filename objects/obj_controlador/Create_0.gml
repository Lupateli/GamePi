randomize();

// 1. Banco de Dados de Perguntas (Adicionei mais para você)
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

// 2. Cálculo de Vida 70%
dano_padrao = 10;
total_perguntas = array_length(perguntas_base);

// Se ele errar mais de 30%, ele perde. 
// A vida do vilão será o equivalente a acertar 70% das perguntas.
vida_maxima_mau = total_perguntas * dano_padrao; 
vida_mau = vida_maxima_mau;

// A vida do jogador será menor: se ele errar o equivalente a 30% das perguntas, ele morre.
vida_maxima_bom = (total_perguntas * 0.3) * dano_padrao; 
vida_bom = vida_maxima_bom;

energia_bom = 0;

// 2. Status do Jogo
dano_padrao = 10;
vida_maxima = array_length(perguntas_base) * dano_padrao;

vida_bom = vida_maxima;
vida_mau = vida_maxima;
energia_bom = 0;

// 3. Sistema de Fila (Baralho)
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