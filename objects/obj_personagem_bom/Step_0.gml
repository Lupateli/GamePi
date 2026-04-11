if (tremor > 0) {
    x = x_original + random_range(-tremor, tremor);
    tremor -= 1;
} else {
    x = x_original;
}

switch(estado) {
    case "idle": sprite_index = spr_idle; break;
    case "atacando": sprite_index = spr_atacando; break;
    case "dano": sprite_index = spr_sofrendo_dano; break;
    case "morte": sprite_index = spr_morte; break;
    case "fatality": sprite_index = spr_fatality; break;
}