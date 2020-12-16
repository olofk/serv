/*
 * Copyright (c) 2020 Olof Kindgren <olof.kindgren@gmail.com>
 *
 * SPDX-License-Identifier: Apache-2.0
 */

/*
  This is basically a 32-bit version of riscv_machine_timer.c fro Zephyr
*/
#include <drivers/timer/system_timer.h>
#include <sys_clock.h>
#include <spinlock.h>
#include <soc.h>

#define CYC_PER_TICK ((uint32_t)((uint32_t)sys_clock_hw_cycles_per_sec()	\
			      / (uint32_t)CONFIG_SYS_CLOCK_TICKS_PER_SEC))
#define MAX_CYC 0xffffffffu
#define MAX_TICKS ((MAX_CYC - CYC_PER_TICK) / CYC_PER_TICK)
#define MIN_DELAY 1000

#define TICKLESS IS_ENABLED(CONFIG_TICKLESS_KERNEL)

static struct k_spinlock lock;
static uint32_t last_count;

static ALWAYS_INLINE void set_mtimecmp(uint32_t time)
{
  sys_write32(time, SERV_TIMER_BASE);
}

static ALWAYS_INLINE uint32_t mtime(void)
{
  return sys_read32(SERV_TIMER_BASE);
}

static void timer_isr(void *arg)
{
	ARG_UNUSED(arg);

	k_spinlock_key_t key = k_spin_lock(&lock);
	uint32_t now = mtime();
	uint32_t dticks = ((now - last_count) / CYC_PER_TICK);

	last_count += dticks * CYC_PER_TICK;

	if (!TICKLESS) {
		uint32_t next = last_count + CYC_PER_TICK;

		if ((int32_t)(next - now) < MIN_DELAY) {
			next += CYC_PER_TICK;
		}
		set_mtimecmp(next);
	}

	k_spin_unlock(&lock, key);
	z_clock_announce(IS_ENABLED(CONFIG_TICKLESS_KERNEL) ? dticks : 1);
}

int z_clock_driver_init(const struct device *device)
{
	ARG_UNUSED(device);

	IRQ_CONNECT(RISCV_MACHINE_TIMER_IRQ, 0, timer_isr, NULL, 0);
	set_mtimecmp(mtime() + (uint32_t)CYC_PER_TICK);
	irq_enable(RISCV_MACHINE_TIMER_IRQ);
	return 0;
}

void z_clock_set_timeout(int32_t ticks, bool idle)
{
	ARG_UNUSED(idle);

#if defined(CONFIG_TICKLESS_KERNEL)
	/* RISCV has no idle handler yet, so if we try to spin on the
	 * logic below to reset the comparator, we'll always bump it
	 * forward to the "next tick" due to MIN_DELAY handling and
	 * the interrupt will never fire!  Just rely on the fact that
	 * the OS gave us the proper timeout already.
	 */
	if (idle) {
		return;
	}

	ticks = ticks == K_TICKS_FOREVER ? MAX_TICKS : ticks;
	ticks = MAX(MIN(ticks - 1, (int32_t)MAX_TICKS), 0);

	k_spinlock_key_t key = k_spin_lock(&lock);
	uint32_t now = mtime();
	uint32_t adj, cyc = ticks * CYC_PER_TICK;

	/* Round up to next tick boundary. */
	adj = (now - last_count) + (CYC_PER_TICK - 1);
	if (cyc <= MAX_CYC - adj) {
		cyc += adj;
	} else {
		cyc = MAX_CYC;
	}
	cyc = (cyc / CYC_PER_TICK) * CYC_PER_TICK;

	if ((int32_t)(cyc + last_count - now) < MIN_DELAY) {
		cyc += CYC_PER_TICK;
	}

	set_mtimecmp(cyc + last_count);
	k_spin_unlock(&lock, key);
#endif
}

uint32_t z_clock_elapsed(void)
{
	if (!IS_ENABLED(CONFIG_TICKLESS_KERNEL)) {
		return 0;
	}

	k_spinlock_key_t key = k_spin_lock(&lock);
	uint32_t ret = (mtime() - last_count) / CYC_PER_TICK;

	k_spin_unlock(&lock, key);
	return ret;
}

uint32_t z_timer_cycle_get_32(void)
{
	return mtime();
}
