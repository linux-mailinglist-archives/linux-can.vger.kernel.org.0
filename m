Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B9C3AE905
	for <lists+linux-can@lfdr.de>; Mon, 21 Jun 2021 14:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFUM07 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Jun 2021 08:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhFUM07 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Jun 2021 08:26:59 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFFAC061574
        for <linux-can@vger.kernel.org>; Mon, 21 Jun 2021 05:24:43 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id g13so14569658ljj.10
        for <linux-can@vger.kernel.org>; Mon, 21 Jun 2021 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBy5o0J6yrzKfdeVLta0c5P3i2lt/IQ+Fcm8ax5Ywk4=;
        b=qVenZPl6N9HCUspqRj4pfQ7BLY7L/Vz/BKxVdAqzZHWJPWbV4LqhSrZdDq0RBTGICj
         z9Wx8SZ73gWsMaf8mD7tTlnRqKPO5CTT1737h2S0Vq4CVeVeO2pW+W5LT/q/csqdcAd9
         5q7Q99IKXPetC5hjJfleFw2njZR64ifu3NWPqk64M/sDhqBtZL4GgGyucE2pfEZTk/MZ
         GxRitfZ5aMsXC+l64CipT/ZBhkj1qVIks2r4L3/tuo4ADL20Yu639IPIBEj8w0yIcF6l
         qIiWvEE4QSBRJhIKbgYt4Un08btlH48tGrejHwmu6ho6j1zfYZBAHXVUiE+3LOsJaYHz
         eQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBy5o0J6yrzKfdeVLta0c5P3i2lt/IQ+Fcm8ax5Ywk4=;
        b=oBZrWem+xGXiBjsQeixG1eTjjN+2/hXV3naQEcMobbS+LXw56l2qat93cnBOJg0FKd
         StgztqKXH5eSfayBrQz0PzNKXqwifqmGLGGK+8nwohEMycoQy6yKWycsvPrE3slxI2su
         xgoyAbm7Dclyob0GHPhgdHGIdgvc8VgK7BuajeKhw8fwzf/ljbCzqYDClvzyDhqZBH8B
         ZufEecwEwp5rWTsjs5Vp48Sd00yIWobJyAlBk5tuokExAk1cTR37wFnaw1KdZgKCub0v
         BkN1zD3x4p0DYxWTnwRdd2zGn1b+0/yDiHnE10e/2rY72Upv9F4OO4qb83KM8lki0pqZ
         7+XA==
X-Gm-Message-State: AOAM533Zx7sBgiY6gtISZMxJfSmMoC/RArdVUHgN1oqAzOTYXrm13vLb
        QItG08OZSfZlSlL/J6QXURJsJRd/85izPmayNP35YlYg+Oo=
X-Google-Smtp-Source: ABdhPJxF6uop89e7DSVFtGhot3DdrU7gT2UmDsSH6DweaUex3EN+ZMY5HcN76WY5F8/mEZn0cDZPfnunP7i0QDn8AMs=
X-Received: by 2002:a05:651c:54f:: with SMTP id q15mr15623689ljp.347.1624278282133;
 Mon, 21 Jun 2021 05:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5CwS-cO3W148YHVYFwcL3QC8oFJfeQBb+WN=QgEPU7AsQ@mail.gmail.com>
 <CAOMZO5D3suvPzaMq3Fx9LKDC9mzb-0w6i3EbQum-ozczdY-EPQ@mail.gmail.com> <20210615071557.o7fjkleuk777otvm@pengutronix.de>
In-Reply-To: <20210615071557.o7fjkleuk777otvm@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 21 Jun 2021 09:24:31 -0300
Message-ID: <CAOMZO5AMP537Qz1MAb-D_27C=WH-5Cf602hichxty95A6db9-A@mail.gmail.com>
Subject: Re: Testing two MCP2518FD's on i.MX8MM
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Tue, Jun 15, 2021 at 4:15 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> The imx SPI driver has quite some overhead, when it comes to small SPI
> transfers. The mcp251fd driver performs much better with the SPI IP
> cores on the raspi, which have quite good optimized drivers.
>
> Hook up a scope to the SPI's clock and chip select lines of the imx,
> you'll see the time between end of transfer until the chip select is
> inactive is longer than the SPI transfer itself.
>
> I expect most bang for the buck can be archived by adding an IRQ less
> busy polling transfer mode, which kicks in below a certain SPI transfer
> length.
>
> On the mcp251xfd driver side, there is some room for optimization. The
> basic idea is to reduce the number of SPI transfers by combining several
> reads into one transfer. This can be done in some places.
>
> For peak loads in CAN-2.0 mode it would be interesting to make use of
> the remaining RAM for a 2nd FIFO.

Thanks for your reply.

I do see some RCU related errors every time the application is launched:

# ./cantest.sh start
root@verdin-imx8mm:~# interface = can1, family = 29, ty[   17.484220]
NOHZ tick-stop error: Non-RCU local softirq work is pending, handler
#08!!!
[   17.484240] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
pe = 3, proto = 1
interface = ca[   17.502870] NOHZ tick-stop error: Non-RCU local
softirq work is pending, handler #08!!!
n0, family = 29, type = 3, proto [   17.502912] NOHZ tick-stop error:
Non-RCU local softirq work is pending, handler #08!!!
= 1
interface = can1, family = 2[   17.524457] NOHZ tick-stop error:
Non-RCU local softirq work is pending, handler #08!!!
9, type = 3, proto = 1
interface[   17.524476] NOHZ tick-stop error: Non-RCU local softirq
work is pending, handler #08!!!
 = can0, family = 29, type = 3, p[   17.535223] NOHZ tick-stop error:
Non-RCU local softirq work is pending, handler #08!!!
roto = 1
[   17.557284] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[   17.557284] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[   17.574035] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[   17.574037] NOHZ tick-stop error: Non-RCU local softirq work is
pending, handler #08!!!
[   18.435652] sched: RT throttling activated

After some time:

[  292.197058] rcu: 0-....: (1 GPs behind)
idle=6db/1/0x4000000000000002 softirq=2974/2975 fqs=7882
[  292.206039] (t=21003 jiffies g=1249 q=1317)
[  292.210316] Task dump for CPU 0:
[  292.213549] task:cansequence     state:R  running task     stack:
 0 pid:  374 ppid:     1 flags:0x00000202
[  292.223485] Call trace:
[  292.225932]  dump_backtrace+0x0/0x1a8
[  292.229613]  show_stack+0x18/0x28
[  292.232936]  sched_show_task+0x150/0x170
[  292.236869]  dump_cpu_task+0x44/0x54
[  292.240453]  rcu_dump_cpu_stacks+0xf4/0x13c
[  292.244648]  rcu_sched_clock_irq+0x844/0xdc0
[  292.248929]  update_process_times+0x98/0xe8
[  292.253125]  tick_nohz_handler+0xac/0x110
[  292.257142]  arch_timer_handler_phys+0x34/0x48
[  292.261598]  handle_percpu_devid_irq+0x84/0x148
[  292.266138]  handle_domain_irq+0x60/0x90
[  292.270071]  gic_handle_irq+0x54/0x120
[  292.273833]  call_on_irq_stack+0x28/0x50
[  292.277767]  do_interrupt_handler+0x54/0x60
[  292.281964]  el1_interrupt+0x30/0x78
[  292.285550]  el1h_64_irq_handler+0x18/0x28
[  292.289653]  el1h_64_irq+0x78/0x7c
[  292.293061]  __audit_syscall_exit+0x8/0x238
[  292.297256]  el0_svc_common+0x60/0xd8
[  292.300927]  do_el0_svc+0x28/0x90
[  292.304249]  el0_svc+0x24/0x38
[  292.307312]  el0t_64_sync_handler+0xb0/0xb8
[  292.311502]  el0t_64_sync+0x198/0x19c
2020-02-12 19:28:40:388 sequence CNT: 1586297, RX:     93    expected:
121    missing:  228    skt overfl d:    0 a:    0    delta: 228
incident: 1    seq_wrap RX: 6196     sequ_wrap_expected: 6196
overall lost: 4294967268
2020-02-12 19:28:40:389 sequence CNT:     95, RX:    121    expected:
95    missing:   26    skt overfl d:    0 a:    0    delta:  26
incident: 2    seq_wrap RX: 6196     sequ_wrap_expected: 6196
overall lost: 4294967294
2020-02-12 19:28:40:389 sequence CNT:    125, RX:    127    expected:
125    missing:    2    skt overfl d:    0 a:    0    delta:   2
incident: 3    seq_wrap RX: 6196     sequ_wrap_expected: 6196
overall lost: 0

Any ideas how these RCU errors could be fixed?

Thanks,

Fabio Estevam
