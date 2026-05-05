// No Evento STEP do obj_personagem_bom

switch(estado) {
    case "idle": 
        sprite_index = spr_samuraiparado;
        image_speed = 1;
        // Sistema de volta suave que você já tem
        if (x_original > posicao_inicial_x) {
            x_original -= 30;
            if (x_original < posicao_inicial_x) x_original = posicao_inicial_x;
        }
        break;

    case "avanco":
        sprite_index = spr_samuraiAtaque; 
        image_index = 0; // Trava no primeiro frame (preparação)
        image_speed = 0;
        
        // Ele corre até o destino antes de começar a bater
        x_original += 25; // Aumentei a velocidade para ser mais fluido

        // Quando chegar na cara do vilão
        if (x_original >= posicao_inicial_x + 200) { 
            x_original = posicao_inicial_x + 200; // Garante posição exata
            estado = "ataque";
            image_index = 0;
            image_speed = 1; // Agora sim ele solta o braço
        }
        break;

    case "ataque":
        sprite_index = spr_samuraiAtaque;
        // Aqui ele fica parado no X, apenas rodando a animação
        break;
        
    case "ultimate":
        sprite_index = spr_samuraiUlt;
        // Se a Ult ainda precisar de deslocamento por frame, mantenha a lógica abaixo
        break;
}

// MANTENHA o código do tremor
if (tremor > 0) {
    x = x_original + random_range(-tremor, tremor);
    tremor -= 1;
} else {
    x = x_original;
}

// --- MOVIMENTO DE IDA (Apenas para a Ultimate agora) ---
if (sprite_index == spr_samuraiUlt) {
    if (image_index >= 2 && image_index <= 7) {
        x_original += 14; 
    }
}

if (estado == "idle" && x_original > posicao_inicial_x) {
    x_original -= 30; // Velocidade da volta
    
    // Para ele não passar do ponto e ficar vibrando
    if (x_original < posicao_inicial_x) {
        x_original = posicao_inicial_x;
    }
}
