// No LEFT PRESSED do obj_botao_pulo
if (instance_exists(obj_personagem_bom) && obj_personagem_bom.estado == "idle" && obj_personagem_bom.pode_pular == true && instance_exists(obj_controlador) && obj_controlador.energia_bom >= 100) {
    
    var ctrl = obj_controlador;

    // "Vence" a questão atual
    ctrl.vida_mau -= ctrl.dano_padrao;
    ctrl.energia_bom = 0; 
    
    if (instance_exists(obj_personagem_mau)) obj_personagem_mau.tremor = 20;

    // Aciona o Pulo / Ultimate
    obj_personagem_bom.estado = "ultimate";
    obj_personagem_bom.image_index = 0;
    obj_personagem_bom.image_speed = 0.68;
    obj_personagem_bom.pode_pular = false; // DESATIVA AQUI
    
    ctrl.alarm[1] = 60;

    // Lógica das perguntas
    ds_list_delete(ctrl.lista_ativa, 0);
    if (ds_list_empty(ctrl.lista_ativa)) ctrl.recarregar_perguntas();
    ctrl.pergunta_atual_dados = ctrl.lista_ativa[| 0];

    if (ctrl.vida_mau <= 0) { 
        notificar_vitoria_js(); 
    }
}
