// Garante que a energia não passe de 100
energia_bom = clamp(energia_bom, 0, 100);

// Verifica se o herói morreu
if (vida_bom <= 0) {
    if (instance_exists(obj_personagem_bom) && obj_personagem_bom.estado != "morte") {
        obj_personagem_bom.estado = "morte";
        obj_personagem_bom.sprite_index = spr_morte;
        obj_personagem_bom.image_index = 0;
        obj_personagem_bom.image_speed = 0.5;
        notificar_derrota_js();
    }
}

// Lógica de Ativação do Pulo (Apenas com 100% de energia e samurai em idle)
if (instance_exists(obj_personagem_bom)) {
    if (energia_bom >= 100 && obj_personagem_bom.estado == "idle") {
        obj_personagem_bom.pode_pular = true;
    } else {
        obj_personagem_bom.pode_pular = false;
    }
}

// Lógica de Ativação da cura (Apenas com pelo menos 50% de energia, vida não cheia e samurai em idle)
if (instance_exists(obj_personagem_bom)) {
    if (energia_bom >= 50 && vida_bom < vida_maxima_bom && obj_personagem_bom.estado == "idle") {
        obj_personagem_bom.pode_curar = true;
    } else {
        obj_personagem_bom.pode_curar = false;
    }
}
