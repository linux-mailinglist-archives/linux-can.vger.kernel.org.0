Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 536807813A
	for <lists+linux-can@lfdr.de>; Sun, 28 Jul 2019 21:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfG1Tha (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 28 Jul 2019 15:37:30 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36953 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfG1Th3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 28 Jul 2019 15:37:29 -0400
Received: by mail-lf1-f66.google.com with SMTP id c9so40475020lfh.4
        for <linux-can@vger.kernel.org>; Sun, 28 Jul 2019 12:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=capp-tech-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eR1SDzDd2XHVeb+8nKnPVv9jL3fbppU64OO8UOMv8bQ=;
        b=m/kbU1hbmqjWMjrFz2PauPmIipRD/XxOOw715AeQ93xindVKR+yLIOy6xApRvesLz+
         rTug8hrTAY5ZlXCVbxLLyuPbDLZODkD6F8O9JObzZOgJH5wHo4fyzxoO6Qer07OSlz/V
         xZln5kUtlx/db3p/yj53b9DReyLT3AYGD/aglxgoTiQlMtvcMTwVKD6t0LLIX2Z0pSCC
         0lPzicrvon4x1qo/FHcLIoJCPbI9ilvv+ADrySb5OgsCHY1CmG1O5OVivf3gxx0+0IPu
         GVycDxgnnZvnpHjGit6sSl4acWlVWx21P78SsuUoMtu9fp/9co7nszvztAbb6z0AU2iA
         8Pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eR1SDzDd2XHVeb+8nKnPVv9jL3fbppU64OO8UOMv8bQ=;
        b=D6rRusisHL/F3love+rAW/UtQ9CRrLrNuOyA85kFNKYnqdQyHBqoP/edrnLQwzPVXH
         cwjilGRe1tl5ZLpDf6TjmOcocHapEtO8+YPH7IttQJdlD47N0yX1DfMQh5SIecM0flT8
         KvuKsUSVp5x2jfLqlf4JNb7h/vSrpcUjs8lvletBJoHHxhN10uqknxwQxR0bqaFJ7ABr
         Z91jusdevkuMKdGy9S02kXKF1GsOopgVitOAqNOBPKjZtUUQnS2wwNO731r4uYu0t/E/
         OONZoB2+7tjZHKeBscQKZIBhRMhe32iyB/XAzvWnYH+8jkVTgwB9KHz2EzSrg0yqjlb5
         IDSQ==
X-Gm-Message-State: APjAAAX5yQDdE4Ymt2OdIwKJ9eCiBxyo613dLg2sOO1Ag7wNSpVTTehh
        jv7lT9/1mYzfaEbmdH/Sit3oF7XvS/aUBUr/rRwlPg==
X-Google-Smtp-Source: APXvYqytF1EueJrVyBbE3pyrID3ITjcrTfrSW6JacCgFzHsvNBigr3IvUOlWtgflZlw7bLu/me1Ez6dpMEQ1eUJJwaI=
X-Received: by 2002:a19:6e4d:: with SMTP id q13mr8318329lfk.6.1564342646231;
 Sun, 28 Jul 2019 12:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <CANRGksjUg8r5zwCpnat_UhX0EP3PDcyazApNSxqc6R_iu0Tqtg@mail.gmail.com>
 <d48e0b11-2fa7-eafe-6ec5-fe4a84e33c14@pengutronix.de> <CANRGksi1Wk2qoeSGTG+q4KBjRDxa_qZQCxyamr5PXOeM62witA@mail.gmail.com>
 <5cf240d7-f9bc-1cff-5ce0-bd3f5f437d9c@pengutronix.de>
In-Reply-To: <5cf240d7-f9bc-1cff-5ce0-bd3f5f437d9c@pengutronix.de>
From:   Tom Prohaszka <tprohaszka@capp-tech.com>
Date:   Sun, 28 Jul 2019 15:37:14 -0400
Message-ID: <CANRGkshiaL9QXMt8s15FydRdL9uF-zBqKw07fVn6JvJaob0umw@mail.gmail.com>
Subject: Re: Microchip mcp25xxfd can controller driver- BUG: using
 __this_cpu_add() in preemptible
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@martin.sperl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hey Marc,
I added the options below, but it doesn't look like the stack is dumping.

check_preemption_disabled: 143 callbacks suppressed
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
caller is __this_cpu_preempt_check+0x1c/0x20
CPU: 0 PID: 805 Comm: irq/194-mcp25xx Tainted: G           O
4.9.65-dey+gf832589 #44
Hardware name: Freescale i.MX6 UltraLite (Device Tree)
[<80111790>] (unwind_backtrace) from [<8010d6cc>] (show_stack+0x20/0x24)
[<8010d6cc>] (show_stack) from [<804c1c94>] (dump_stack+0xa0/0xcc)
[<804c1c94>] (dump_stack) from [<804e1ad8>]
(check_preemption_disabled+0x130/0x134)
[<804e1ad8>] (check_preemption_disabled) from [<804e1b1c>]
(__this_cpu_preempt_check+0x1c/0x20)
[<804e1b1c>] (__this_cpu_preempt_check) from [<80804284>]
(__netif_receive_skb_core+0x118/0xa60)
[<80804284>] (__netif_receive_skb_core) from [<80806ffc>]
(__netif_receive_skb+0x38/0x94)
[<80806ffc>] (__netif_receive_skb) from [<808070e8>]
(netif_receive_skb_internal+0x90/0x21c)
[<808070e8>] (netif_receive_skb_internal) from [<808072e4>]
(netif_receive_skb+0x70/0x1f4)
[<808072e4>] (netif_receive_skb) from [<8065006c>]
(mcp25xxfd_can_int+0x8f8/0x9cc)
[<8065006c>] (mcp25xxfd_can_int) from [<8019d2e4>] (irq_thread_fn+0x2c/0x64)
[<8019d2e4>] (irq_thread_fn) from [<8019d644>] (irq_thread+0x180/0x24c)
[<8019d644>] (irq_thread) from [<801529f4>] (kthread+0x11c/0x134)
[<801529f4>] (kthread) from [<80108650>] (ret_from_fork+0x14/0x24)
  can1  456   [8]  0F 00 00 00 00 00 00 00
  can1  456   [8]  0F 00 00 00 00 00 00 00
  can1  121   [8]  0F 00 00 00 00 00 00 00
  can1  354   [8]  0F 00 00 00 00 00 00 00
  can1  099   [8]  0F 00 00 00 00 00 00 00
  can1  331   [8]  0F 00 00 00 00 00 00 00
  can1  123   [8]  00 0E 00 00 00 00 00 00
  can1  003   [8]  00 00 00 04 00 00 00 00
  can1  099   [8]  00 00 00 00 00 0A 00 00
  can1  011   [8]  00 00 0D 00 00 00 00 00
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
caller is __this_cpu_preempt_check+0x1c/0x20
CPU: 0 PID: 805 Comm: irq/194-mcp25xx Tainted: G           O
4.9.65-dey+gf832589 #44
Hardware name: Freescale i.MX6 UltraLite (Device Tree)
[<80111790>] (unwind_backtrace) from [<8010d6cc>] (show_stack+0x20/0x24)
[<8010d6cc>] (show_stack) from [<804c1c94>] (dump_stack+0xa0/0xcc)
[<804c1c94>] (dump_stack) from [<804e1ad8>]
(check_preemption_disabled+0x130/0x134)
[<804e1ad8>] (check_preemption_disabled) from [<804e1b1c>]
(__this_cpu_preempt_check+0x1c/0x20)
[<804e1b1c>] (__this_cpu_preempt_check) from [<80804284>]
(__netif_receive_skb_core+0x118/0xa60)
[<80804284>] (__netif_receive_skb_core) from [<80806ffc>]
(__netif_receive_skb+0x38/0x94)
[<80806ffc>] (__netif_receive_skb) from [<808070e8>]
(netif_receive_skb_internal+0x90/0x21c)
[<808070e8>] (netif_receive_skb_internal) from [<808072e4>]
(netif_receive_skb+0x70/0x1f4)
[<808072e4>] (netif_receive_skb) from [<8065006c>]
(mcp25xxfd_can_int+0x8f8/0x9cc)
[<8065006c>] (mcp25xxfd_can_int) from [<8019d2e4>] (irq_thread_fn+0x2c/0x64)
[<8019d2e4>] (irq_thread_fn) from [<8019d644>] (irq_thread+0x180/0x24c)
[<8019d644>] (irq_thread) from [<801529f4>] (kthread+0x11c/0x134)
[<801529f4>] (kthread) from [<80108650>] (ret_from_fork+0x14/0x24)
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
caller is __this_cpu_preempt_check+0x1c/0x20
CPU: 0 PID: 805 Comm: irq/194-mcp25xx Tainted: G           O
4.9.65-dey+gf832589 #44
Hardware name: Freescale i.MX6 UltraLite (Device Tree)
[<80111790>] (unwind_backtrace) from [<8010d6cc>] (show_stack+0x20/0x24)
[<8010d6cc>] (show_stack) from [<804c1c94>] (dump_stack+0xa0/0xcc)
[<804c1c94>] (dump_stack) from [<804e1ad8>]
(check_preemption_disabled+0x130/0x134)
[<804e1ad8>] (check_preemption_disabled) from [<804e1b1c>]
(__this_cpu_preempt_check+0x1c/0x20)
[<804e1b1c>] (__this_cpu_preempt_check) from [<80804284>]
(__netif_receive_skb_core+0x118/0xa60)
[<80804284>] (__netif_receive_skb_core) from [<80806ffc>]
(__netif_receive_skb+0x38/0x94)
[<80806ffc>] (__netif_receive_skb) from [<808070e8>]
(netif_receive_skb_internal+0x90/0x21c)
[<808070e8>] (netif_receive_skb_internal) from [<808072e4>]
(netif_receive_skb+0x70/0x1f4)
[<808072e4>] (netif_receive_skb) from [<8065006c>]
(mcp25xxfd_can_int+0x8f8/0x9cc)
[<8065006c>] (mcp25xxfd_can_int) from [<8019d2e4>] (irq_thread_fn+0x2c/0x64)
[<8019d2e4>] (irq_thread_fn) from [<8019d644>] (irq_thread+0x180/0x24c)
[<8019d644>] (irq_thread) from [<801529f4>] (kthread+0x11c/0x134)
[<801529f4>] (kthread) from [<80108650>] (ret_from_fork+0x14/0x24)
  can1  331   [8]  0F 00 00 00 00 00 00 00
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805

CONFIG_VIRTUALIZATION=y
CONFIG_DEBUG_KERNEL=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_KPROBES=y
CONIFG_DEBUG_BUGVERBOSE=y
CONFIG_UNWIND_INFO=y
CONIFG_STACK_UNWIND=y
CONFIG_OF_DYNAMIC=y
CONFIG_FRAME_POINTER=y
#
# Debug Lockups and Hangs
#
# CONFIG_LOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHED_INFO is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_TIMER_STATS is not set
CONFIG_DEBUG_PREEMPT=y

#

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=400
# CONFIG_DEBUG_KMEMLEAK_TEST is not set
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SHIRQ is not set


On Thu, Jul 25, 2019 at 6:50 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 7/25/19 12:27 PM, Tom Prohaszka wrote:
> > Here is the backtrace:
> >
> >  can1  456   [8]  0F 00 00 00 00 00 00 00
> >   can1  354   [8]  0F 00 00 00 00 00 00 00
> >   can1  331   [8]  0F 00 00 00 00 00 00 00
> >   can1  234   [8]  01 00 00 00 00 00 00 00
> >   can1  044   [8]  00 00 00 00 00 00 07 00
> >   can1  354   [8]^C  can1  456   [8]  0F 00 00 00 00 00 00 00
>
> Do you reproduce the problem by pressing Ctrl+c?
>
> > root@ccimx6ulcvdp:~/tmp# BUG: using __this_cpu_add() in preemptible
> > [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
>
> Hmm according to the code, it should print a backtrace here...
>
> See https://elixir.bootlin.com/linux/v4.9.65/source/lib/smp_processor_id.c#L46
>
> >         preempt_disable_notrace();
> >
> >         if (!printk_ratelimit())
> >                 goto out_enable;
> >
> >         printk(KERN_ERR "BUG: using %s%s() in preemptible [%08x] code: %s/%d\n",
> >                 what1, what2, preempt_count() - 1, current->comm, current->pid);
> >
> >         print_symbol("caller is %s\n", (long)__builtin_return_address(0));
> >         dump_stack();
>
> Can you enable some of the in-kernel debugging stuff:
>
> Kernel hacking
>         -> Memory Debugging
>                 -> Debug object operations              (everyting)
>                 -> Kernel memory leak detector          (enable)
>         -> Debug preemptible kernel                     (enable)
>         -> Lock Debugging (spinlocks, mutexes, etc...)  (everything, but not the self tests)
>         -> Stack backtrace support                      (enable)
>
> .. and send output when it breaks.
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
