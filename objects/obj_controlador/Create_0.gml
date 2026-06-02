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
            for (var i = 0; i < array_length(perguntas_array); i++) {
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
            }
        } else {
            show_debug_message("Aviso: 'perguntas' não encontrado no JSON.");
        }

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