// --- EVENTO CREATE (CRIAR) DO obj_controlador ---
// --- INICIALIZAÇÃO DOS STATUS DO COMBATE ---
vida_maxima_bom = 100;
vida_bom = 100;
energia_bom = 0;

vida_maxima_mau = 100;
vida_mau = 100;

vidas_bom = 2;
dano_no_bom = 50;

acertos_boss = 3;
dano_no_mau = 33.34;
dano_padrao = dano_no_mau;

pode_curar = false;
valor_cura = dano_no_bom;
pode_pular = false;
tremor = 0;


// Inicializa a lista de perguntas
lista_ativa = ds_list_create();
lista_todas_perguntas = ds_list_create();
pergunta_atual_dados = undefined;

// Função para recarregar as perguntas quando a lista esvaziar
recarregar_perguntas = function() {
    ds_list_clear(lista_ativa);
    for (var k = 0; k < ds_list_size(lista_todas_perguntas); k++) {
        ds_list_add(lista_ativa, lista_todas_perguntas[| k]);
    }
    ds_list_shuffle(lista_ativa);
    if (!ds_list_empty(lista_ativa)) {
        pergunta_atual_dados = lista_ativa[| 0];
    }
};

// Função para reiniciar a batalha sem causar tela preta
reiniciar_batalha = function() {
    vida_bom = vida_maxima_bom;
    vida_mau = vida_maxima_mau;
    energia_bom = 0;
    pode_curar = false;
    pode_pular = false;
    recarregar_perguntas();
    if (instance_exists(obj_personagem_bom)) {
        with(obj_personagem_bom) {
            estado = "idle";
            sprite_index = spr_id;
            image_speed = 1;
            image_index = 0;
            x_original = posicao_inicial_x;
            x = posicao_inicial_x;
        }
    }
    if (instance_exists(obj_personagem_mau)) {
        with(obj_personagem_mau) {
            estado = "idle";
            sprite_index = spr_personagem_mau;
            image_speed = 1;
            image_index = 0;
        }
    }
};

// Inicializa a fonte global do jogo (Usa o asset fnt_jogo do GameMaker)
global.fonte_jogo = fnt_jogo;

// Em produção, o Next.js lida com a Autenticação e passa o JSON pronto via Ponte JS
var json_str = obter_dados_fase_js();

if (is_string(json_str) && json_str != "") {
    try {
        var dados = json_parse(json_str);
        
        // Guarda as informações globais
        global.fase_id = dados[$ "id"]; 
        if (variable_struct_exists(dados, "_id")) global.fase_id = dados[$ "_id"];
        
        global.titulo_fase = dados[$ "titulo"];
        
        // 2. Troca de Skin do Personagem
        var skin = variable_struct_exists(dados, "personagem_selecionado") ? dados[$ "personagem_selecionado"] : "samurai";
        if (skin == "cavaleiro") {
            if (instance_exists(obj_personagem_bom)) {
                with(obj_personagem_bom) {
                    // ATENÇÃO: As sprites do cavaleiro estão faltando no projeto! 
                    // Usando as do samurai temporariamente para evitar crash
                    spr_id = spr_samuraiparado;
                    spr_atq = spr_cavaleiro_atack; // Esse existe!
                    spr_ult = spr_samuraiUlt; 
                }
            }
        } else {
            if (instance_exists(obj_personagem_bom)) {
                with(obj_personagem_bom) {
                    spr_id = spr_samuraiparado;
                    spr_atq = spr_samuraiAtaque;
                    spr_ult = spr_samuraiUlt;
                }
            }
        }

        // 3. Troca de Cenário (Background)
        var cenario = variable_struct_exists(dados, "cenario") ? dados[$ "cenario"] : "bg_dojo";
        var lay_id = layer_get_id("Background"); 
        var back_id = layer_background_get_id(lay_id);
        
        // Os fundos spr_fundo_castelo e spr_fundo_dojo NÃO EXISTEM no projeto.
        // O único fundo no projeto é spr_fundo_deserto.
        if (cenario == "bg_castelo") {
            // layer_background_sprite(back_id, spr_fundo_castelo);
            layer_background_sprite(back_id, spr_fundo_deserto);
        } else {
            // layer_background_sprite(back_id, spr_fundo_dojo);
            layer_background_sprite(back_id, spr_fundo_deserto);
        }

        // 4. Carrega as perguntas
        var perguntas_array = dados[$ "perguntas"];
        
        if (!is_undefined(perguntas_array) && is_array(perguntas_array)) {
            var total_p = array_length(perguntas_array);
            if (total_p > 0) {
                vidas_bom = (total_p >= 9) ? 3 : 2;
                dano_no_bom = 100 / vidas_bom;
                acertos_boss = max(2, min(total_p, ceil(total_p * 0.75)));
                dano_no_mau = 100 / acertos_boss;
                dano_padrao = dano_no_mau;
                valor_cura = dano_no_bom;
            }
            for (var i = 0; i < total_p; i++) {
                var p_banco = perguntas_array[i];
                var alt_array = p_banco[$ "alternativas"];
                var res_correta = p_banco[$ "respostaCorreta"];
                
                // Encontra qual é o índice da resposta correta (0, 1, 2 ou 3)
                var index_correta = 0;
                if (!is_undefined(alt_array) && is_array(alt_array)) {
                    for(var j = 0; j < array_length(alt_array); j++) {
                        if (alt_array[j] == res_correta) {
                            index_correta = j;
                            break;
                        }
                    }
                } else {
                    alt_array = ["A", "B", "C", "D"]; // Fallback de segurança
                }
                
                var estrutura_pergunta = {
                    enunciado: p_banco[$ "enunciado"],
                    alternativas: alt_array,
                    correta: index_correta 
                };
                
                ds_list_add(lista_ativa, estrutura_pergunta);
                ds_list_add(lista_todas_perguntas, estrutura_pergunta);
            }
        } else {
            show_debug_message("Aviso: 'perguntas' não encontrado no JSON.");
        }

        // Embaralha a ordem inicial das perguntas da fase
        ds_list_shuffle(lista_ativa);

        // Define a primeira pergunta para começar a partida
        if (!ds_list_empty(lista_ativa)) {
            pergunta_atual_dados = lista_ativa[| 0];
        }
        
        show_debug_message("Dados recebidos da Ponte JS e processados com sucesso!");

    } catch (e) {
        show_debug_message("Erro ao processar JSON da Ponte JS: " + string(e));
    }
} else {
    show_debug_message("Aviso: Ponte JS vazia. Rodando offline ou fora do Iframe.");
}