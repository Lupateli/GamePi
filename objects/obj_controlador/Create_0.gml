// --- EVENTO CREATE (CRIAR) DO obj_controlador ---
// --- INICIALIZAÇÃO DOS STATUS DO COMBATE ---
vida_maxima_bom = 100;
vida_bom = 100;
energia_bom = 0;

vida_maxima_mau = 100;
vida_mau = 100;
dano_padrao = 25;

pode_curar = false;
valor_cura = 20;
pode_pular = false;
tremor = 0;


// Inicializa a lista de perguntas
lista_ativa = ds_list_create();
pergunta_atual_dados = undefined;

// Executa a função da Extensão que criamos no Bloco de Notas
var json_str = obter_dados_fase_js();

if (json_str != "") {
    // Transforma a string JSON em uma Struct do GameMaker
    var dados = json_parse(json_str);
    
    // Guarda as informações globais que o seu site enviou
    global.fase_id = dados.faseId;
    global.titulo_fase = dados.titulo;
    
    // --- [APLICAÇÃO DE SKIN] ---
    var skin = dados.personagem_selecionado; 
    if (instance_exists(obj_personagem_bom)) {
        with(obj_personagem_bom) {
            if (skin == "cavaleiro") {
                spr_id = spr_cavaleiro_parado;
                spr_atq = spr_cavaleiro_atack;
                spr_ult = spr_cavaleiro_especial;
            } else {
                spr_id = spr_samuraiparado;
                spr_atq = spr_samuraiAtaque;
                spr_ult = spr_samuraiUlt;
            }
        }
    }

    // --- [APLICAÇÃO DE CENÁRIO] ---
    var cenario = dados.cenario;
    var lay_id = layer_get_id("Background"); // Verifique se o nome na sua Room é esse
    var back_id = layer_background_get_id(lay_id);
    
    if (cenario == "bg_castelo") {
        layer_background_sprite(back_id, spr_fundo_castelo);
    } else {
        layer_background_sprite(back_id, spr_fundo_dojo);
    }

    // --- [CARREGAMENTO DAS PERGUNTAS] ---
    // Percorre o Array que veio do JavaScript e alimenta o jogo
    for (var i = 0; i < array_length(dados.perguntas); i++) {
        var p_banco = dados.perguntas[i];
        
        var estrutura_pergunta = {
            enunciado: p_banco.enunciado,
            alternativas: p_banco.alternativas,
            correta: p_banco.indiceRespostaCorreta // Índice numérico de 0 a 3
        };
        
        ds_list_add(lista_ativa, estrutura_pergunta);
    }

    // Define a primeira pergunta para começar a partida
    if (!ds_list_empty(lista_ativa)) {
        pergunta_atual_dados = lista_ativa[| 0];
    }

} else {
    show_debug_message("Aviso: Rodando offline ou fora do Iframe. Carregando dados locais para teste.");
    // Opcional: crie perguntas fictícias aqui para conseguir testar direto pelo GameMaker
}