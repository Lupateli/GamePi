// Apenas controla a aparência visual
if (instance_exists(obj_personagem_bom)) {
    if (obj_personagem_bom.pode_curar == true) {
        sprite_index = spr_botao_cura; // Sprite ativa
    } else {
        sprite_index = spr_botao_cura_inat; // Sprite inativa
    }
}