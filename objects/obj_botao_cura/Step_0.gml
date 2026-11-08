// Apenas controla a aparência visual
if (instance_exists(obj_personagem_bom) && instance_exists(obj_controlador)) {
    if (obj_personagem_bom.pode_curar == true && obj_controlador.energia_bom >= 50 && obj_controlador.vida_bom < obj_controlador.vida_maxima_bom && obj_personagem_bom.estado == "idle") {
        sprite_index = spr_botao_cura; // Sprite ativa
    } else {
        sprite_index = spr_botao_cura_inat; // Sprite inativa
    }
}
