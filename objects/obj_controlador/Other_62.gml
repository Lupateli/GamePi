// Evento Async HTTP
if (ds_map_find_value(async_load, "id") == requisicao_perguntas) {
    if (ds_map_find_value(async_load, "status") == 0) {
        var resultado_json = ds_map_find_value(async_load, "result");
        
        // 1. Decodifica o JSON
        var mapa_dados = json_decode(resultado_json);
        
        // --- TUDO deve estar aqui dentro agora ---

        // 2. Troca de Skin do Personagem
        var skin = mapa_dados[? "personagem_selecionado"];

        if (skin == "cavaleiro") {
            if (instance_exists(obj_personagem_bom)) {
                with(obj_personagem_bom) {
                    spr_id = spr_cavaleiro_parado;
                    spr_atq = spr_cavaleiro_atack; // Nome exato da sua sprite
                    spr_ult = spr_cavaleiro_especial; 
                }
            }
        } else if (skin == "samurai") {
            if (instance_exists(obj_personagem_bom)) {
                with(obj_personagem_bom) {
                    spr_id = spr_samuraiparado;
                    spr_atq = spr_samuraiAtaque;
                    spr_ult = spr_samuraiUlt;
                }
            }
        }

        // 3. Troca de Cenário (Background)
        var cenario = mapa_dados[? "cenario"];
        var lay_id = layer_get_id("Background"); 
        var back_id = layer_background_get_id(lay_id);

        if (cenario == "bg_castelo") {
            layer_background_sprite(back_id, spr_fundo_castelo);
        } else {
            layer_background_sprite(back_id, spr_fundo_dojo);
        }

        // 4. Carrega as perguntas (Exemplo de como costuma vir do MongoDB)
        // lista_ativa = mapa_dados[? "perguntas"]; 
        
        show_debug_message("Dados carregados e visual atualizado!");

    } else {
        show_debug_message("Erro na requisição HTTP");
    }
}