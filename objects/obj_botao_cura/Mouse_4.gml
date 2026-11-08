// Só executa a ação se a condição de cura for verdadeira, tiver pelo menos 50 de energia, vida não cheia e samurai em idle
if (instance_exists(obj_personagem_bom) && obj_personagem_bom.pode_curar == true && instance_exists(obj_controlador)) {
    if (obj_controlador.energia_bom >= 50 && obj_controlador.vida_bom < obj_controlador.vida_maxima_bom && obj_personagem_bom.estado == "idle") {
        var valor_cura = obj_controlador.vida_maxima_bom * 0.20; // Calcula 20% da vida total
        obj_controlador.vida_bom += valor_cura;
        
        // Garante que não ultrapasse o máximo
        if (obj_controlador.vida_bom > obj_controlador.vida_maxima_bom) {
            obj_controlador.vida_bom = obj_controlador.vida_maxima_bom;
        }
        
        // Gasta 50 de energia
        obj_controlador.energia_bom -= 50;
        if (obj_controlador.energia_bom < 0) obj_controlador.energia_bom = 0;
        
        // Se a vida ficou cheia ou a energia ficou menor que 50, desativa imediatamente
        if (obj_controlador.energia_bom < 50 || obj_controlador.vida_bom >= obj_controlador.vida_maxima_bom) {
            obj_personagem_bom.pode_curar = false;
            sprite_index = spr_botao_cura_inat;
        }
        
        show_debug_message("Curou 20%!");
    }
}
