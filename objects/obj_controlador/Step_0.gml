// Garante que a energia não passe de 100
energia_bom = clamp(energia_bom, 0, 100);

// Controla se o botão de pulo deve aparecer
if (instance_exists(obj_botao_pulo)) {
    obj_botao_pulo.visible = (energia_bom >= 0);
}