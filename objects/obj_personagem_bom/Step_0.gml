// No Evento STEP do obj_personagem_bom

switch(estado) {
    case "idle": 
        sprite_index = spr_samuraiparado; // Nome da sua sprite dele parado (image_7.png)
        break;
        
    case "morte": 
        sprite_index = spr_morte; // Nome da sua sprite dele caindo (image_5.png)
        // Opcional: image_speed = 1; // Garante que a velocidade está correta se mudou no botão
        break;
	case "ultimate":
		sprite_index = spr_samuraiUlt;
		break;
}
if (tremor > 0) {
    x = x_original + random_range(-tremor, tremor);
    tremor -= 1;
} else {
    x = x_original;
}

// --- MOVIMENTO DE IDA ---
if (sprite_index == spr_samuraiUlt) {
    // Se o avanço termina no frame 10, use:
    if (image_index >= 2 && image_index <=7) {
        x_original += 14; 
    }
    // A partir do frame 11, ele parará de somar no x_original e ficará fixo dando o golpe.
}

if (estado == "idle" && x_original > posicao_inicial_x) {
    x_original -= 30; // Velocidade da volta
    
    // Para ele não passar do ponto e ficar vibrando
    if (x_original < posicao_inicial_x) {
        x_original = posicao_inicial_x;
    }
}
