if (tremor > 0) {
    x = x_original + random_range(-tremor, tremor);
    tremor -= 1;
} else {
    x = x_original;
}