// No STEP do obj_botao_pulo
if (obj_personagem_bom.estado == "idle" && obj_personagem_bom.pode_pular == true) {
    sprite_index = spr_botao_pulo;
} else {
    sprite_index = spr_botao_pulo_inat;
}