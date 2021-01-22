Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B773300337
	for <lists+linux-can@lfdr.de>; Fri, 22 Jan 2021 13:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbhAVJY6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 22 Jan 2021 04:24:58 -0500
Received: from mail-yb1-f175.google.com ([209.85.219.175]:39222 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbhAVJKF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Jan 2021 04:10:05 -0500
Received: by mail-yb1-f175.google.com with SMTP id k4so4819266ybp.6
        for <linux-can@vger.kernel.org>; Fri, 22 Jan 2021 01:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TaXCEuX1vcBhb5hXPDDGwSi8alU9TXYm3W7PMl+PtQU=;
        b=pmH+jhHf7L77Vy/ifZjZcdL7VrY9S7+zPq1SuDiOuxH16uH6xWwgt/ooW80gr15ydz
         jmbmC0PvCGVQMjl46v4b0dYzzlFhlu2eyroYQXnHWxIxwX83wHzGGIRHokklsvKFMyXc
         HABTlDdHMxp56Oh6BvhTTmBi6LrI6npv8YaWQ8i1q3Z4UEMCvimGP8MeDgAvK1wGJnIa
         YNCFGkpXlsy1lKMbCkJQUmFtBjjLwC1J0kDGPEE5AViMD6yY7fJ6ub/0BWm0j1tnedii
         REyx9+91K3X461G9Av4THg78vjHFuW4ngC/4AdtAoE/3uJa2fHMM5SYzklStXttgqTqx
         u16A==
X-Gm-Message-State: AOAM531OHFNBSVGbOSqYvvbVvCc5YDfmgb62vbKgyS1/Wb8Rn6TsHUus
        GnUTq1JJtMaAq4nqiokVt9KtXnOANc/+JSIZ9hg=
X-Google-Smtp-Source: ABdhPJyqHX+y0zZF3UG5Dgv4GN3LdfnYBUWBa4AjA/QtrhCKpeqwDSqwYzBcqmZV7fG3rhaaXfPEjwKQ2GddbPNHQtI=
X-Received: by 2002:a25:bc89:: with SMTP id e9mr857821ybk.514.1611306509308;
 Fri, 22 Jan 2021 01:08:29 -0800 (PST)
MIME-Version: 1.0
References: <DB8PR04MB6795E0155F4523CA9D4AAC1CE6A10@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <DB8PR04MB679559428DCCA341EE53A6E4E6A00@DB8PR04MB6795.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB679559428DCCA341EE53A6E4E6A00@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 22 Jan 2021 18:08:18 +0900
Message-ID: <CAMZ6RqLuL_BzQisQ0kGEnj7zPTe3iKnsd6n2ivZQ+bPnZW_VhA@mail.gmail.com>
Subject: Re: [5.10 CAN BUG report] kernel dump about echo skb
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 22 Jan 2021 at 16:53, Joakim Zhang <qiangqing.zhang@nxp.com> wrote:
> @Marc Kleine-Budde, @Oleksij Rempel, any comments? Thanks a lot.
>
> Best Regards,
> Joakim Zhang
>
> > -----Original Message-----
> > From: Joakim Zhang <qiangqing.zhang@nxp.com>
> > Sent: 2021年1月21日 16:38
> > To: Marc Kleine-Budde <mkl@pengutronix.de>; Oleksij Rempel
> > <o.rempel@pengutronix.de>; Oliver Hartkopp <socketcan@hartkopp.net>
> > Cc: kernel@pengutronix.de; linux-can@vger.kernel.org
> > Subject: [5.10 CAN BUG report] kernel dump about echo skb
> >
> >
> > Hi Marc, Oleksij, Oliver,
> >
> > Our auto test scripts reports below kernel dump, after revert Oleksij Rempel
> > patch "286228d382ba can: can_create_echo_skb(): fix echo skb generation:
> > always use skb_clone()", this issue disappeared.
> > What strange is that, commit message intends to fix this issue. Report it here
> > to see if anyone meets the same issue or can give some suggestions. I will
> > continue to dig how to reproduce it manually, now I don't know how to do it.
> > Thanks.

Even if you can not reproduce, could you share some hints of how it
first occurred?
Did you use the same command as Oleksij:
>     testj1939 -B -r can0: &
>     cansend can0 1823ff40#0123
or did you use something else?

> > 1. Kernel dump log:
> > [  101.688327] ------------[ cut here ]------------ [  101.692968] refcount_t:
> > addition on 0; use-after-free.

The skb already had its refcount at zero when reaching
can_put_echo_skb(). It is as if it was already freed/consumed!

If you remove Oleksij’s patch, can_put_echo_skb() will probably not
clone the skb and thus not check the refcount: this means that you
will not see the warning, however, it does not necessarily mean that
the bug did not occur.

So far, it seems to me to be another bug which was invisible until
now and which Oleksij’s patch just uncovered. But I do not yet fully
understand what the root cause could be.

> > [  101.698210] WARNING: CPU: 0 PID: 0 at lib/refcount.c:25
> > refcount_warn_saturat
> > e+0x98/0x140
> > [  101.706386] Modules linked in:
> > [  101.709446] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> > 5.10.4-100715-gc60abf9c 2110-dirty #376 [  101.717881] Hardware name:
> > NXP i.MX8MPlus EVK board (DT) [  101.723193] pstate: 40000005 (nZcv daif
> > -PAN -UAO -TCO BTYPE=--) [  101.729200] pc :
> > refcount_warn_saturate+0x98/0x140 [  101.733990] lr :
> > refcount_warn_saturate+0x98/0x140 [  101.738778] sp : ffff800011bcbcd0
> > [  101.742090] x29: ffff800011bcbcd0 x28: ffff0000c16b7000 [  101.747405]
> > x27: 0000000000000000 x26: ffff0000c1718000 [  101.752718] x25:
> > 00000000048c0000 x24: ffff0000c1e54c00 [  101.758031] x23:
> > 0000000000000000 x22: ffff0000c1718900 [  101.763345] x21:
> > ffff0000c1718000 x20: ffff0000c1f00800 [  101.768661] x19: ffff0000c1985e00
> > x18: 0000000000000010 [  101.773974] x17: 0000000000000000 x16:
> > 0000000000000000 [  101.779287] x15: 0000000000000229 x14:
> > ffff8000119d2cb8 [  101.784600] x13: 00000000ffffffea x12: ffff800011a51b60
> > [  101.789914] x11: 0000000000000003 x10: ffff800011a39b78 [  101.795227]
> > x9 : 0000000000017fe8 x8 : ffff800011a39b20 [  101.800543] x7 :
> > c0000000ffffefff x6 : 0000000000000001 [  101.805858] x5 :
> > 0000000000000000 x4 : ffff00017f36f900 [  101.811174] x3 : ffff00017f376830
> > x2 : ffff00017f36f900 [  101.816487] x1 : 5ead5e088841e800 x0 :
> > 0000000000000000 [  101.821800] Call trace:
> > [  101.824248]  refcount_warn_saturate+0x98/0x140 [  101.828694]
> > can_put_echo_skb+0x154/0x190 [  101.832704]

Could you share the output of:
eu-addr2line -f -i -e drivers/net/can/dev.o can_put_echo_skb+0x154

> > flexcan_start_xmit+0x188/0x240 [  101.836888]
> > dev_hard_start_xmit+0xe0/0x1a8 [  101.841072]
> > sch_direct_xmit+0x11c/0x338 [  101.844995]  __qdisc_run+0x118/0x5d8
> > [  101.848570]  net_tx_action+0x110/0x1a8 [  101.852319]
> > efi_header_end+0x120/0x264 [  101.856156]  irq_exit+0xb8/0xd8
> > [  101.859298]  __handle_domain_irq+0x64/0xb8 [  101.863396]
> > gic_handle_irq+0x54/0x118 [  101.867145]  el1_irq+0xc0/0x180
> > [  101.870288]  cpuidle_enter_state+0x130/0x2e8 [  101.874560]
> > cpuidle_enter+0x34/0x48 [  101.878136]  call_cpuidle+0x18/0x38
> > [  101.881627]  do_idle+0x1f4/0x258 [  101.884854]
> > cpu_startup_entry+0x20/0x68 [  101.888778]  rest_init+0xd4/0xe0
> > [  101.892008]  arch_call_rest_init+0xc/0x14 [  101.896019]
> > start_kernel+0x470/0x4a4 [  101.899681] ---[ end trace
> > 8de9661669c150a6 ]--- [  101.908725] ------------[ cut here ]------------
> > [  101.913379] refcount_t: underflow; use-after-free.
> > [  101.918360] WARNING: CPU: 0 PID: 9 at lib/refcount.c:28
> > refcount_warn_saturat
> > e+0xec/0x140
> > [  101.926544] Modules linked in:
> > [  101.929605] CPU: 0 PID: 9 Comm: ksoftirqd/0 Tainted: G        W
> > 5.10.
> > 4-100715-gc60abf9c2110-dirty #376
> > [  101.939603] Hardware name: NXP i.MX8MPlus EVK board (DT)
> > [  101.944914] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
> > [  101.950921] pc : refcount_warn_saturate+0xec/0x140 [  101.955709] lr :
> > refcount_warn_saturate+0xec/0x140 [  101.960497] sp : ffff800011c73b00
> > [  101.963809] x29: ffff800011c73b00 x28: 000000000000003d [  101.969123]
> > x27: ffff00017f37a880 x26: ffff800011c73d48 [  101.974435] x25:
> > 000000000000012c x24: ffff800011c73d58 [  101.979748] x23:
> > ffff0000c1718000 x22: 0000000000000000 [  101.985061] x21:
> > ffff800011affcc0 x20: ffff0000c13eeb80 [  101.990374] x19: ffff0000c1f00800
> > x18: 0000000000000010 [  101.995686] x17: 0000000000000000 x16:
> > 0000000000000000 [  102.000999] x15: 0000000000000258 x14:
> > ffff0000c007f278 [  102.006311] x13: 00000000ffffffea x12: ffff800011a51b60
> > [  102.011624] x11: 0000000000000003 x10: ffff800011a39b78 [  102.016936]
> > x9 : 0000000000017fe8 x8 : ffff800011a39b20 [  102.022249] x7 :
> > c0000000ffffefff x6 : 0000000000000001 [  102.027562] x5 :
> > 0000000000000000 x4 : ffff00017f36f900 [  102.032874] x3 : ffff00017f376830
> > x2 : ffff00017f36f900 [  102.038187] x1 : b6fa97510f7af300 x0 :
> > 0000000000000000 [  102.043500] Call trace:
> > [  102.045947]  refcount_warn_saturate+0xec/0x140 [  102.050391]
> > sock_efree+0x6c/0x78 [  102.053707]  skb_release_head_state+0x40/0xb0
> > [  102.058065]  skb_release_all+0x14/0x30 [  102.061813]
> > kfree_skb+0x2c/0x88 [  102.065041]  can_receive+0xb4/0xf8 [  102.068442]
> > can_rcv+0x3c/0xc0 [  102.071496]
> > __netif_receive_skb_one_core+0x50/0x78
> > [  102.076373]  __netif_receive_skb+0x14/0x60 [  102.080468]
> > netif_receive_skb+0x34/0xc0 [  102.084392]
> > can_rx_offload_napi_poll+0x60/0xd8
> > [  102.088921]  net_rx_action+0x114/0x378 [  102.092670]
> > efi_header_end+0x120/0x264 [  102.096506]  run_ksoftirqd+0x44/0x58
> > [  102.100081]  smpboot_thread_fn+0x1b4/0x270 [  102.104177]
> > kthread+0x138/0x158 [  102.107405]  ret_from_fork+0x10/0x18
> > [  102.110979] ---[ end trace 8de9661669c150a7 ]---
> >
> > 2. Patch introduces issue:
> > commit 286228d382ba6320f04fa2e7c6fc8d4d92e428f4
> > Author: Oleksij Rempel <o.rempel@pengutronix.de>
> > Date:   Wed Dec 18 09:39:02 2019 +0100
> >
> >     can: can_create_echo_skb(): fix echo skb generation: always use
> > skb_clone()
> >
> >     All user space generated SKBs are owned by a socket (unless injected into
> > the
> >     key via AF_PACKET). If a socket is closed, all associated skbs will be
> > cleaned
> >     up.
> >
> >     This leads to a problem when a CAN driver calls can_put_echo_skb() on a
> >     unshared SKB. If the socket is closed prior to the TX complete handler,
> >     can_get_echo_skb() and the subsequent delivering of the echo SKB to all
> >     registered callbacks, a SKB with a refcount of 0 is delivered.
> >
> >     To avoid the problem, in can_get_echo_skb() the original SKB is now
> > always
> >     cloned, regardless of shared SKB or not. If the process exists it can now
> >     safely discard its SKBs, without disturbing the delivery of the echo SKB.
> >
> >     The problem shows up in the j1939 stack, when it clones the incoming skb,
> > which
> >     detects the already 0 refcount.
> >
> >     We can easily reproduce this with following example:
> >
> >     testj1939 -B -r can0: &
> >     cansend can0 1823ff40#0123
> >
> >     WARNING: CPU: 0 PID: 293 at lib/refcount.c:25
> > refcount_warn_saturate+0x108/0x174
> >     refcount_t: addition on 0; use-after-free.
> >     Modules linked in: coda_vpu imx_vdoa videobuf2_vmalloc
> > dw_hdmi_ahb_audio vcan
> >     CPU: 0 PID: 293 Comm: cansend Not tainted
> > 5.5.0-rc6-00376-g9e20dcb7040d #1
> >     Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> >     Backtrace:
> >     [<c010f570>] (dump_backtrace) from [<c010f90c>]
> > (show_stack+0x20/0x24)
> >     [<c010f8ec>] (show_stack) from [<c0c3e1a4>] (dump_stack+0x8c/0xa0)
> >     [<c0c3e118>] (dump_stack) from [<c0127fec>] (__warn+0xe0/0x108)
> >     [<c0127f0c>] (__warn) from [<c01283c8>]
> > (warn_slowpath_fmt+0xa8/0xcc)
> >     [<c0128324>] (warn_slowpath_fmt) from [<c0539c0c>]
> > (refcount_warn_saturate+0x108/0x174)
> >     [<c0539b04>] (refcount_warn_saturate) from [<c0ad2cac>]
> > (j1939_can_recv+0x20c/0x210)
> >     [<c0ad2aa0>] (j1939_can_recv) from [<c0ac9dc8>]
> > (can_rcv_filter+0xb4/0x268)
> >     [<c0ac9d14>] (can_rcv_filter) from [<c0aca2cc>] (can_receive+0xb0/0xe4)
> >     [<c0aca21c>] (can_receive) from [<c0aca348>] (can_rcv+0x48/0x98)
> >     [<c0aca300>] (can_rcv) from [<c09b1fdc>]
> > (__netif_receive_skb_one_core+0x64/0x88)
> >     [<c09b1f78>] (__netif_receive_skb_one_core) from [<c09b2070>]
> > (__netif_receive_skb+0x38/0x94)
> >     [<c09b2038>] (__netif_receive_skb) from [<c09b2130>]
> > (netif_receive_skb_internal+0x64/0xf8)
> >     [<c09b20cc>] (netif_receive_skb_internal) from [<c09b21f8>]
> > (netif_receive_skb+0x34/0x19c)
> >     [<c09b21c4>] (netif_receive_skb) from [<c0791278>]
> > (can_rx_offload_napi_poll+0x58/0xb4)
