Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDB074B8C
	for <lists+linux-can@lfdr.de>; Thu, 25 Jul 2019 12:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfGYK10 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Jul 2019 06:27:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35636 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbfGYK1Z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Jul 2019 06:27:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so47547082ljh.2
        for <linux-can@vger.kernel.org>; Thu, 25 Jul 2019 03:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=capp-tech-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFNtrdsE6wikmtyhjQ1bg7FsBjKiXenqyYi9rNT5Dig=;
        b=ulyyAUQc2lGpzi5L6CrxcSTS7+CCJ+uRDEO18zuDLAj2RcO0ga9vICNGq7iq36QbC7
         THjpNqXgYXSusE6qCXjm69dtIF4rGgDTirVmyn43p7thbAo5iP1K3K0OgyrZ7Pi9c+Md
         wcG0zINMOyCkh5gqQXFoSWZhPZD5dEBBPv6B2bBBKzII0hg1I+ymKRaRg9UrIlr3p3vA
         nUQSMAa8mkS4fIlnwkpnLw//MSmEU1al9YUPfursQdh3a3VjmE0BzNdzZLZBHsgpSzc6
         udii+W2iqQiSql+nzp2mKT14Z1NzbcLDYJbXJdx8dPDNt4QtTXn6x6NWbJPEtpRtIQON
         V6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFNtrdsE6wikmtyhjQ1bg7FsBjKiXenqyYi9rNT5Dig=;
        b=AKW7CI1z/UeinQk2Sf8eulAGA9zU+Xb50Sl5JUlUXXgfRtLKF+44gUj9FFVO2yVOOa
         C01b61BmIp8184FgxTtqqfYbKJlRj3NKdAcbTojqN36jfKuvoq3CKBECId4pD5sRmSGC
         2pDZHruxxbB0NzD0IoWYQ22rl+MpRVs6BrK9p96uFHbpUaN1e97u9ZXYrr5z4Bj2Gewb
         MpYghwwPNVYEuRMOMQeypSrwzYZRSxhlDtzdpjlbqFkxsvqLnbx6NLHm5o0qWVbGik38
         klTfnwenShTUbEQnRo+yJgaLg1/i7SpDV0Fo3R/gdi07N+mE6MHW4AB/uXfmGaiOKVH+
         C7Lg==
X-Gm-Message-State: APjAAAVseqGGbX963BIz8/x938dp8o7K54TMErTbLU3RhUh/FhWswWAw
        ElwfJ3/hX0rO8E/8nlN6uYFM8TtidC5N6gbn6BYmUA==
X-Google-Smtp-Source: APXvYqytBjenJcK2ueHIwRJVFSps2NxpHBpND5+c891lEfoxp2g16NEtowHrWEepNY3MDrIrhCTsCbJp8UQ2O7FvBCo=
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr46979370ljj.156.1564050441927;
 Thu, 25 Jul 2019 03:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <CANRGksjUg8r5zwCpnat_UhX0EP3PDcyazApNSxqc6R_iu0Tqtg@mail.gmail.com>
 <d48e0b11-2fa7-eafe-6ec5-fe4a84e33c14@pengutronix.de>
In-Reply-To: <d48e0b11-2fa7-eafe-6ec5-fe4a84e33c14@pengutronix.de>
From:   Tom Prohaszka <tprohaszka@capp-tech.com>
Date:   Thu, 25 Jul 2019 06:27:09 -0400
Message-ID: <CANRGksi1Wk2qoeSGTG+q4KBjRDxa_qZQCxyamr5PXOeM62witA@mail.gmail.com>
Subject: Re: Microchip mcp25xxfd can controller driver- BUG: using
 __this_cpu_add() in preemptible
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@martin.sperl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Here is the backtrace:

 can1  456   [8]  0F 00 00 00 00 00 00 00
  can1  354   [8]  0F 00 00 00 00 00 00 00
  can1  331   [8]  0F 00 00 00 00 00 00 00
  can1  234   [8]  01 00 00 00 00 00 00 00
  can1  044   [8]  00 00 00 00 00 00 07 00
  can1  354   [8]^C  can1  456   [8]  0F 00 00 00 00 00 00 00
root@ccimx6ulcvdp:~/tmp# BUG: using __this_cpu_add() in preemptible
[00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805

root@ccimx6ulcvdp:~/tmp# ifconfiBUG: using __this_cpu_add() in
preemptible [00000000] code: irq/194-mcp25xx/805
gBUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
 BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
cBUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
anBUG: using __this_cpu_add() in preemptible [00000000] code:
irq/194-mcp25xx/805
1BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
 BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
doBUG: using __this_cpu_add() in preemptible [00000000] code:
irq/194-mcp25xx/805
BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
wn
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = 80004000
[00000000] *pgd=00000000
Internal error: Oops: 17 [#1] PREEMPT SMP ARM
Modules linked in: cryptodev(O) wlan(O)
CPU: 0 PID: 805 Comm: irq/194-mcp25xx Tainted: G           O
4.9.65-dey+gf832589 #41
Hardware name: Freescale i.MX6 UltraLite (Device Tree)
task: b9322840 task.stack: b9356000
PC is at _raw_spin_lock_irqsave+0x2c/0x6c
LR is at preempt_count_add+0x134/0x164
pc : [<8094d6c4>]    lr : [<801520d8>]    psr: 00010193
sp : b9357e68  ip : b9357e48  fp : b9357e7c
r10: ffff0ff3  r9 : 00000000  r8 : 00018834
r7 : b82f4c50  r6 : 00000000  r5 : 80010113  r4 : 00000000
r3 : b9322840  r2 : 00000001  r1 : ffffffff  r0 : 00000000
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c53c7d  Table: b892006a  DAC: 00000051
Process irq/194-mcp25xx (pid: 805, stack limit = 0xb9356210)
Stack: (0xb9357e68 to 0xb9358000)
7e60:                   b82f44c0 00000005 b9357e94 b9357e80 805c7968 8094d6a4
7e80: b82f44c0 00000005 b9357ef4 b9357e98 805c6a44 805c7954 8045a584 b92b8600
7ea0: 8017e780 00000001 00000000 80c26db0 80c26d80 80a51448 80f6c564 b82f46d4
7ec0: 8094db74 80152114 b9357ef4 b92b8600 b8224d00 00000000 00000001 b8224d00
7ee0: b92b8600 8017e780 b9357f14 b9357ef8 8017e7ac 805c6204 b9356000 b92b8624
7f00: 00000000 00000001 b9357f54 b9357f18 8017ead4 8017e78c 80faae92 ffffe000
7f20: 00000000 8017e8ac 00000000 00000000 b92b8680 b9356000 b92b8600 8017e98c
7f40: 00000000 00000000 b9357fac b9357f58 8014956c 8017e998 00000000 00000000
7f60: 00000000 b92b8600 00000000 00000000 b9357f70 b9357f70 00000000 00000000
7f80: b9357f80 b9357f80 b9357fac b92b8680 80149464 00000000 00000000 00000000
7fa0: 00000000 b9357fb0 801082d8 80149470 00000000 00000000 00000000 00000000
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[<8094d6c4>] (_raw_spin_lock_irqsave) from [<805c7968>]
(mcp25xxfd_can_tx_queue_restart+0x20/0x7c)
[<805c7968>] (mcp25xxfd_can_tx_queue_restart) from [<805c6a44>]
(mcp25xxfd_can_int+0x84c/0x974)
[<805c6a44>] (mcp25xxfd_can_int) from [<8017e7ac>] (irq_thread_fn+0x2c/0x64)
[<8017e7ac>] (irq_thread_fn) from [<8017ead4>] (irq_thread+0x148/0x200)
[<8017ead4>] (irq_thread) from [<8014956c>] (kthread+0x108/0x120)
[<8014956c>] (kthread) from [<801082d8>] (ret_from_fork+0x14/0x3c)
Code: f10c0080 e3a00001 ebe01238 f594f000 (e1943f9f)
---[ end trace 355ef7f6bf82f534 ]---
note: irq/194-mcp25xx[805] exited with preempt_count 1
Unable to handle kernel paging request at virtual address ffffffec
pgd = 80004000
[ffffffec] *pgd=bbfde861, *pte=00000000, *ppte=00000000
Internal error: Oops: 37 [#2] PREEMPT SMP ARM
Modules linked in: cryptodev(O) wlan(O)
CPU: 0 PID: 805 Comm: irq/194-mcp25xx Tainted: G      D    O
4.9.65-dey+gf832589 #41
Hardware name: Freescale i.MX6 UltraLite (Device Tree)
task: b9322840 task.stack: b9356000
PC is at kthread_data+0x18/0x20
LR is at irq_thread_dtor+0x38/0xe0
pc : [<8014a1bc>]    lr : [<8017e8e4>]    psr: 20010193
sp : b9357c40  ip : b9357c50  fp : b9357c4c
r10: 00000017  r9 : ffffe000  r8 : 00000000
r7 : b9322840  r6 : b9322c68  r5 : 80fb11f8  r4 : b9322840
r3 : 00000000  r2 : 0000b734  r1 : 0000b734  r0 : b9322840
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c53c7d  Table: b892006a  DAC: 00000051
Process irq/194-mcp25xx (pid: 805, stack limit = 0xb9356210)
Stack: (0xb9357c40 to 0xb9358000)
7c40: b9357c64 b9357c50 8017e8e4 8014a1b0 b9322c4c 80fb11f8 b9357c8c b9357c68
7c60: 8014784c 8017e8b8 b9322840 0000000b 00000000 b9357c98 b9356000 ffffe000
7c80: b9357cb4 b9357c90 8012d3fc 80147788 b9356000 00000000 b9357cb4 b9357ca8
7ca0: 80128030 7f000000 b9357cf4 b9357cb8 8010ce64 8012d0c8 b9356210 0000000b
7cc0: 80116a44 60010193 80bd675c 00000000 b9357e18 00000017 00000000 00000000
7ce0: b9356000 ffff0ff3 b9357d0c b9357cf8 8011b920 8010cc28 b9357e18 00000000
7d00: b9357d64 b9357d10 8094eeb0 8011b8b8 805c8c8c 805b71d8 b9357da8 b9357da8
7d20: b8563400 00000000 805b4524 00000000 00000003 00000003 00000000 80f08a34
7d40: 00000017 8094ea8c 00000000 b9357e18 b9356000 ffff0ff3 b9357e14 b9357d68
7d60: 8010125c 8094ea98 805c8d80 8094b324 b82f2144 b82f2144 00000000 00000003
7d80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
7da0: 00000802 00b71b00 b9357d18 b9357d18 00000000 0000067e 00000009 0000067c
7dc0: 00000001 00000000 b9357dfc b9357dd8 805c9044 805c8cc8 00000000 00000400
7de0: 00000000 bd200000 00000000 b82f44c0 b9357e3c 8094d6c4 00010193 ffffffff
7e00: b9357e4c 00018834 b9357e7c b9357e18 8094e178 8010121c 00000000 ffffffff
7e20: 00000001 b9322840 00000000 80010113 00000000 b82f4c50 00018834 00000000
7e40: ffff0ff3 b9357e7c b9357e48 b9357e68 801520d8 8094d6c4 00010193 ffffffff
7e60: 00000051 00000000 b82f44c0 00000005 b9357e94 b9357e80 805c7968 8094d6a4
7e80: b82f44c0 00000005 b9357ef4 b9357e98 805c6a44 805c7954 8045a584 b92b8600
7ea0: 8017e780 00000001 00000000 80c26db0 80c26d80 80a51448 80f6c564 b82f46d4
7ec0: 8094db74 80152114 b9357ef4 b92b8600 b8224d00 00000000 00000001 b8224d00
7ee0: b92b8600 8017e780 b9357f14 b9357ef8 8017e7ac 805c6204 b9356000 b92b8624
7f00: 00000000 00000001 b9357f54 b9357f18 8017ead4 8017e78c 80faae92 ffffe000
7f20: 00000000 8017e8ac 00000000 00000000 b92b8680 b9356000 b92b8600 8017e98c
7f40: 00000000 00000000 b9357fac b9357f58 8014956c 8017e998 00000000 00000000
7f60: 00000000 b92b8600 00000000 00000000 b9357f70 b9357f70 00000001 00010001
7f80: b9357f80 b9357f80 b9357fac b92b8680 80149464 00000000 00000000 00000000
7fa0: 00000000 b9357fb0 801082d8 80149470 00000000 00000000 00000000 00000000
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[<8014a1bc>] (kthread_data) from [<8017e8e4>] (irq_thread_dtor+0x38/0xe0)
[<8017e8e4>] (irq_thread_dtor) from [<8014784c>] (task_work_run+0xd0/0xf0)
[<8014784c>] (task_work_run) from [<8012d3fc>] (do_exit+0x340/0xa88)
[<8012d3fc>] (do_exit) from [<8010ce64>] (die+0x248/0x344)
[<8010ce64>] (die) from [<8011b920>] (__do_kernel_fault.part.0+0x74/0x1f4)
[<8011b920>] (__do_kernel_fault.part.0) from [<8094eeb0>]
(do_page_fault+0x424/0x438)
[<8094eeb0>] (do_page_fault) from [<8010125c>] (do_DataAbort+0x4c/0xc8)
[<8010125c>] (do_DataAbort) from [<8094e178>] (__dabt_svc+0x58/0x80)
Exception stack(0xb9357e18 to 0xb9357e60)
7e00:                                                       00000000 ffffffff
7e20: 00000001 b9322840 00000000 80010113 00000000 b82f4c50 00018834 00000000
7e40: ffff0ff3 b9357e7c b9357e48 b9357e68 801520d8 8094d6c4 00010193 ffffffff
[<8094e178>] (__dabt_svc) from [<8094d6c4>] (_raw_spin_lock_irqsave+0x2c/0x6c)
[<8094d6c4>] (_raw_spin_lock_irqsave) from [<805c7968>]
(mcp25xxfd_can_tx_queue_restart+0x20/0x7c)
[<805c7968>] (mcp25xxfd_can_tx_queue_restart) from [<805c6a44>]
(mcp25xxfd_can_int+0x84c/0x974)
[<805c6a44>] (mcp25xxfd_can_int) from [<8017e7ac>] (irq_thread_fn+0x2c/0x64)
[<8017e7ac>] (irq_thread_fn) from [<8017ead4>] (irq_thread+0x148/0x200)
[<8017ead4>] (irq_thread) from [<8014956c>] (kthread+0x108/0x120)
[<8014956c>] (kthread) from [<801082d8>] (ret_from_fork+0x14/0x3c)
Code: e24cb004 e52de004 e8bd4000 e5903320 (e5130014)
---[ end trace 355ef7f6bf82f535 ]---
Fixing recursive fault but reboot is needed!
sched: RT throttling activated
mca-cc6ul-rtc mca-cc6ul-rtc: Failed to set RTC time data: -110
reboot
^C^C




The system is going down for reboot NOW! (pts/0) (Sun Jul 21 21:40:36 2019):
INIT: Switching to runlevel: 6
INIT: Sending processes the TERM signal
Stopping syslogd/klogd: stopped syslogd (pid 601)
stopped klogd (pid 604)
done
Stopping Dropbear SSH server: stopped /usr/sbin/dropbear (pid 642)
dropbear.

On Wed, Jul 24, 2019 at 5:36 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 7/24/19 3:28 AM, Tom Prohaszka wrote:
> > We implemented the MCP25xxfd driver patch V7 and are experiencing an
> > issue when the CPU load for the mcp25xxfd driver is over 30%.  Using
> > CANDump or our custom application, we see:
> >
> > root@ccimx6ulcvdp:~/tmp# BUG: using __this_cpu_add() in preemptible
> > [00000000] code: irq/194-mcp25xx/805
>
> Do you have a full OOPS/backtrace for this?
>
> > When this occurs, the kernel eventually crashes.  Has this been seen
> > by anyone, or any suggestions on what could cause this?
> >
> > Our system is:
> > CAN 2.0 Std, 500Kbps, Tx/Rx enabled, but only Receiving CAN messages
> > Digi Imx6ul,
> > MCP2517 clk 40Mhz
> > SPI Clk 12 Mhz
> > Linux version 4.9.65-dey+gf832589 (gcc version 6.2.0 (GCC) ) #41 SMP
> > PREEMPT Sun Jul 7 21:39:25 EDT 2019
> >
> > On a secondary question, in the driver comments, it was mentioned that
> > transfer rate was >99% with no network statistics, but when network
> > statistics are used, the transfer rate drops 60%.
> > We don't care about network statistics, can you provide info on how
> > you turned this off?
>
> Adding Martin on Cc.
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
