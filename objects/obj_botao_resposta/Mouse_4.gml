var ctrl = obj_controlador;
var dados = ctrl.pergunta_atual_dados;

// 1. Lógica de Acerto ou Erro
if (indice == dados.correta) {
    // Acertou: Dano no vilão e ganha energia
    ctrl.vida_mau -= ctrl.dano_padrao;
    ctrl.energia_bom += 25;
    if (instance_exists(obj_personagem_mau)) obj_personagem_mau.tremor = 15;
} else {
    // Errou: Dano no herói
    ctrl.vida_bom -= ctrl.dano_padrao;
    if (instance_exists(obj_personagem_bom)) obj_personagem_bom.tremor = 15;
}

// 2. Remove a pergunta atual da lista
ds_list_delete(ctrl.lista_ativa, 0);

// ... (Código anterior de processamento de acerto/erro e remoção de pergunta) ...

// 3. Verifica se a lista esvaziou (Fim do Jogo/Turno)
if (ds_list_empty(ctrl.lista_ativa)) {
    
    // FATALITY/DERROTA FINAL
    if (ctrl.vida_mau > 0) {
        // O herói falhou. Ativa a animação de morte.
        if (instance_exists(obj_personagem_bom)) {
            obj_personagem_bom.estado = "morte"; // MUDANÇA AQUI
            obj_personagem_bom.image_index = 0;   // Garante que começa no frame 1
            obj_personagem_bom.image_speed = 0.5; // Velocidade lenta para drama
            
            //Toca um efeito sonoro (opcional)
             audio_play_sound(snd_fatality, 10, false);
            
            // Diz ao controlador para ESPERAR a animação acabar antes de reiniciar
            ctrl.alarm[1] = 120; // 2 segundos (se seu jogo rodar a 60fps)
        }
    } else {
        // VITÓRIA
        show_message("Vitória! Você derrotou o vilão!");
        game_restart();
    }
} else {
    // 4. Se a lista ainda tem perguntas, continua normalmente
    ctrl.pergunta_atual_dados = ctrl.lista_ativa[| 0];
    
    // GAME OVER PREMATURO (Vida chegou a 0 no meio)
    if (ctrl.vida_bom <= 0) {
        // Mesma lógica de animação de morte
        if (instance_exists(obj_personagem_bom)) {
            obj_personagem_bom.estado = "morte"; // MUDANÇA AQUI
            obj_personagem_bom.image_index = 0;   // Começa no frame 1
            obj_personagem_bom.image_speed = 1;   // Velocidade normal
            
            // O controlador espera a animação acabar
            ctrl.alarm[1] = 90; // 1.5 segundos
        }
    }
}