// Mude de Sin(...) para sin(...)
var escala = 1 + sin(current_time / 200) * 0.05; 

draw_self();
draw_sprite_ext(sprite_index, image_index, x, y, escala, escala, 0, c_white, 1);