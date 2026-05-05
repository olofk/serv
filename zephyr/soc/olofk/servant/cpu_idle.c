#include <zephyr/irq.h>
#include <zephyr/tracing/tracing.h>

// Override arch_cpu_idle() and arch_cpu_atomic_idle() to prevent insertion
// of `wfi` instructions, which lock up our system. This was introduced in
// Zephyr 3.6.0 with commit 5fb6e267f629dedb8382da6bcad8018b1bb8930a.
//
// This is probably a hardware bug in SERV. This issue is tracked as #131.
// https://github.com/olofk/serv/issues/131

void arch_cpu_idle(void)
{
	sys_trace_idle();
	irq_unlock(MSTATUS_IEN);
}

void arch_cpu_atomic_idle(unsigned int key)
{
	sys_trace_idle();
	irq_unlock(key);
}

