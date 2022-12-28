#include <cstddef>

#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/rcc.h>

namespace {
    constexpr auto LED_PORT = GPIOC;
    constexpr auto LED_PIN = GPIO13;
    constexpr auto LED_RCC = RCC_GPIOC;

    constexpr auto DELAY = 10000U;

    void
    delay(const std::size_t delay)
    {
        for (volatile std::size_t i = 0; i < delay; i = i + 1) {
        }
    }

    void
    gpio_setup()
    {
        rcc_periph_clock_enable(LED_RCC);

        gpio_set_mode(LED_PORT, GPIO_MODE_OUTPUT_2_MHZ,
                      GPIO_CNF_OUTPUT_PUSHPULL, LED_PIN);
    }
} // namespace

auto
main() -> int
{
    gpio_setup();

    gpio_set(LED_PORT, LED_PIN);

    while (true) {
        gpio_toggle(LED_PORT, LED_PIN);
        delay(DELAY);
        gpio_toggle(LED_PORT, LED_PIN);
    }
}
