Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3FB7206D2
	for <lists+linux-can@lfdr.de>; Fri,  2 Jun 2023 18:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjFBQGP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Jun 2023 12:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbjFBQGN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Jun 2023 12:06:13 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37131AB;
        Fri,  2 Jun 2023 09:06:10 -0700 (PDT)
Received: from fpc (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id 3501944C1018;
        Fri,  2 Jun 2023 16:06:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3501944C1018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1685721967;
        bh=WkPGlu7uffOzFW2P46Q5YpneXdP5+zaFtMiibuBD29Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yse7c51SyzN8q/E8cM0ipBIcESp3+C0rv5qr0XNh/6eOFSBsbq5QSJUyepQaO28qF
         Ds51W+ICQFdCXn43F7cMawr2HLQVj3jM6QeUF7pMSBvbMj1U7+KVNpyMF8gIt+QLWn
         /olPNqlpTvmGDHJ6hrLn7fXoLgc4wTIYdXp0YU7Q=
Date:   Fri, 2 Jun 2023 19:06:02 +0300
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Oleksij Rempel <linux@rempel-privat.de>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        lvc-project@linuxtesting.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-can@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] can: j1939: avoid possible use-after-free when
 j1939_can_rx_register fails
Message-ID: <20230602160602.myfk52mxs25mekzb@fpc>
References: <20230526171910.227615-1-pchelkin@ispras.ru>
 <20230526171910.227615-3-pchelkin@ispras.ru>
 <20230602123519.GH17237@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602123519.GH17237@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Jun 02, 2023 at 02:35:19PM +0200, Oleksij Rempel wrote:
> On Fri, May 26, 2023 at 08:19:10PM +0300, Fedor Pchelkin wrote:
> > Syzkaller reports the following failure:
> > 
> > BUG: KASAN: use-after-free in kref_put include/linux/kref.h:64 [inline]
> > BUG: KASAN: use-after-free in j1939_priv_put+0x25/0xa0 net/can/j1939/main.c:172
> > Write of size 4 at addr ffff888141c15058 by task swapper/3/0
> > 
> > CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.10.144-syzkaller #0
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > Call Trace:
> >  <IRQ>
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x107/0x167 lib/dump_stack.c:118
> >  print_address_description.constprop.0+0x1c/0x220 mm/kasan/report.c:385
> >  __kasan_report mm/kasan/report.c:545 [inline]
> >  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
> >  check_memory_region_inline mm/kasan/generic.c:186 [inline]
> >  check_memory_region+0x145/0x190 mm/kasan/generic.c:192
> >  instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
> >  atomic_fetch_sub_release include/asm-generic/atomic-instrumented.h:220 [inline]
> >  __refcount_sub_and_test include/linux/refcount.h:272 [inline]
> >  __refcount_dec_and_test include/linux/refcount.h:315 [inline]
> >  refcount_dec_and_test include/linux/refcount.h:333 [inline]
> >  kref_put include/linux/kref.h:64 [inline]
> >  j1939_priv_put+0x25/0xa0 net/can/j1939/main.c:172
> >  j1939_sk_sock_destruct+0x44/0x90 net/can/j1939/socket.c:374
> >  __sk_destruct+0x4e/0x820 net/core/sock.c:1784
> >  rcu_do_batch kernel/rcu/tree.c:2485 [inline]
> >  rcu_core+0xb35/0x1a30 kernel/rcu/tree.c:2726
> >  __do_softirq+0x289/0x9a3 kernel/softirq.c:298
> >  asm_call_irq_on_stack+0x12/0x20
> >  </IRQ>
> >  __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
> >  run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
> >  do_softirq_own_stack+0xaa/0xe0 arch/x86/kernel/irq_64.c:77
> >  invoke_softirq kernel/softirq.c:393 [inline]
> >  __irq_exit_rcu kernel/softirq.c:423 [inline]
> >  irq_exit_rcu+0x136/0x200 kernel/softirq.c:435
> >  sysvec_apic_timer_interrupt+0x4d/0x100 arch/x86/kernel/apic/apic.c:1095
> >  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:635
> > 
> > Allocated by task 1141:
> >  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
> >  kasan_set_track mm/kasan/common.c:56 [inline]
> >  __kasan_kmalloc.constprop.0+0xc9/0xd0 mm/kasan/common.c:461
> >  kmalloc include/linux/slab.h:552 [inline]
> >  kzalloc include/linux/slab.h:664 [inline]
> >  j1939_priv_create net/can/j1939/main.c:131 [inline]
> >  j1939_netdev_start+0x111/0x860 net/can/j1939/main.c:268
> >  j1939_sk_bind+0x8ea/0xd30 net/can/j1939/socket.c:485
> >  __sys_bind+0x1f2/0x260 net/socket.c:1645
> >  __do_sys_bind net/socket.c:1656 [inline]
> >  __se_sys_bind net/socket.c:1654 [inline]
> >  __x64_sys_bind+0x6f/0xb0 net/socket.c:1654
> >  do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
> >  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> > 
> > Freed by task 1141:
> >  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
> >  kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
> >  kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
> >  __kasan_slab_free+0x112/0x170 mm/kasan/common.c:422
> >  slab_free_hook mm/slub.c:1542 [inline]
> >  slab_free_freelist_hook+0xad/0x190 mm/slub.c:1576
> >  slab_free mm/slub.c:3149 [inline]
> >  kfree+0xd9/0x3b0 mm/slub.c:4125
> >  j1939_netdev_start+0x5ee/0x860 net/can/j1939/main.c:300
> >  j1939_sk_bind+0x8ea/0xd30 net/can/j1939/socket.c:485
> >  __sys_bind+0x1f2/0x260 net/socket.c:1645
> >  __do_sys_bind net/socket.c:1656 [inline]
> >  __se_sys_bind net/socket.c:1654 [inline]
> >  __x64_sys_bind+0x6f/0xb0 net/socket.c:1654
> >  do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
> >  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> > 
> > It can be caused by this scenario:
> > 
> > CPU0					CPU1
> > j1939_sk_bind(socket0, ndev0, ...)
> >   j1939_netdev_start()
> > 					j1939_sk_bind(socket1, ndev0, ...)
> >                                           j1939_netdev_start()
> >   mutex_lock(&j1939_netdev_lock)
> >   j1939_priv_set(ndev0, priv)
> >   mutex_unlock(&j1939_netdev_lock)
> > 					  if (priv_new)
> > 					    kref_get(&priv_new->rx_kref)
> > 					    return priv_new;
> > 					  /* inside j1939_sk_bind() */
> > 					  jsk->priv = priv
> >   j1939_can_rx_register(priv) // fails
> >   j1939_priv_set(ndev, NULL)
> >   kfree(priv)
> > 					j1939_sk_sock_destruct()
> > 					j1939_priv_put() // <- uaf
> > 
> > To avoid this, call j1939_can_rx_register() under j1939_netdev_lock so
> > that a concurrent thread cannot process j1939_priv before
> > j1939_can_rx_register() returns.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> > 
> > Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> 
> Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> Thank you!
> 

Great!

Thanks for testing the patches!
