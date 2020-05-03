slim_vis_animation <- function(processed_data) {
  gganim <- ggplot2::ggplot(processed_data, ggplot2::aes(.data$x, .data$y)) +
    ggplot2::geom_point(ggplot2::aes(colour = .data$sexes)) +
    ggplot2::labs(title = 'Generation: {frame}', colour = "Sex") +
    gganimate::transition_states(.data$generation) +
    gganimate::enter_appear() +
    ggplot2::coord_equal(xlim = c(-1.5, 1.5), ylim = c(-1.5, 1.5)) +
    ggplot2::theme_void()

  gganim_ob <- gganimate::animate(gganim, renderer = gganimate::gifski_renderer(),
                                  fps = 20, duration = 10, height = 480, width = 520,
                                  detail = 1)

}
