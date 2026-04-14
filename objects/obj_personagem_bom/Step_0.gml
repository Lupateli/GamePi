// No Evento STEP do obj_personagem_bom

switch(estado) {
    case "idle": 
        sprite_index = spr_parado; // Nome da sua sprite dele parado (image_7.png)
        break;
        
    case "morte": 
        sprite_index = spr_morte; // Nome da sua sprite dele caindo (image_5.png)
        // Opcional: image_speed = 1; // Garante que a velocidade está correta se mudou no botão
        break;
}
if (tremor > 0) {
    x = x_original + random_range(-tremor, tremor);
    tremor -= 1;
} else {
    x = x_original;
}