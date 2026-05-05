if (tremor > 0) {
    x = x_original + random_range(-tremor, tremor);
    tremor -= 1;
} else {
    x = x_original;
}

if (estado == "ataque") {
    sprite_index = spr_cavaleiro_atack; // Sprite de ataque
} else {
    sprite_index = spr_personagem_mau;   //Arte do vilão parado
}