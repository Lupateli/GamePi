var ctrl = obj_controlador;

// "Vence" a questão atual
ctrl.vida_mau -= ctrl.dano_padrao;
ctrl.energia_bom = 0; // Gasta a energia
if (instance_exists(obj_personagem_mau)) obj_personagem_mau.tremor = 20;

// Pula

if (instance_exists(obj_personagem_bom)) {
    obj_personagem_bom.estado = "ultimate"; // MUDANÇA AQUI
    obj_personagem_bom.image_index = 0;   // Garante que começa no frame 1
    obj_personagem_bom.image_speed = 0.68; // Velocidade lenta para drama
            
            
    // Diz ao controlador para ESPERAR a animação acabar antes de reiniciar
    ctrl.alarm[1] = 60; // 2 segundos (se seu jogo rodar a 60fps)
}
ds_list_delete(ctrl.lista_ativa, 0);
if (ds_list_empty(ctrl.lista_ativa)) ctrl.recarregar_perguntas();
ctrl.pergunta_atual_dados = ctrl.lista_ativa[| 0];

if (ctrl.vida_mau <= 0) { show_message("Vitória com Pulo!"); game_restart(); }