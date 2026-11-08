// No STEP do obj_botao_pulo
if (instance_exists(obj_personagem_bom) && instance_exists(obj_controlador)) {
    if (obj_personagem_bom.estado == "idle" && obj_personagem_bom.pode_pular == true && obj_controlador.energia_bom >= 100) {
        sprite_index = spr_botao_puloE_1;
    } else {
        sprite_index = spr_botao_pulo_inat;
    }
}
