Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D39D79DAE
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2019 03:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbfG3BAM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 Jul 2019 21:00:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39808 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfG3BAM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Jul 2019 21:00:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id v85so43357770lfa.6
        for <linux-can@vger.kernel.org>; Mon, 29 Jul 2019 18:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=capp-tech-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zm2iKYo/Ze3n66d6mw4LHgj37I8WoI9Y5O6i5dN+ceE=;
        b=HZxjnNKiH/tnCQsI5BfBzm3j6KQw4zr5ErreNFUutMQ1woigdSDCaALsC9tCCOLbM4
         cnolmy7Li5FCEvMSkzFvu32Vp9udauoUq9CmpvDUXBTvk62qNlmtP4fipevJeVNOxbFO
         JGBkP0Zg6wKK621RJFOstNG+FIEC1YzooKaldU1PCdht8PHRA+tpvhJh8SSsViXmBUCl
         dGcPGwY59t5W3iuWsXRE+/kAOms//hIA+4WgLgflkn2rLVugmPKRKO7euJWO2cRmMBJI
         PednaP1tF+6oH5SvDY/UdE/D63x4ZXpbaoId+fZbdXRzb9iO/uhuphk9fCjm6Lf+wyx8
         cnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zm2iKYo/Ze3n66d6mw4LHgj37I8WoI9Y5O6i5dN+ceE=;
        b=uboFhBZM+yzaITc2WWrKpIuafnaHETtI6wXHxmUSH/Kn6QlGnUWhIgWGR3JVkinxv9
         E2UlL70AxqA3gom6a+tM1rVdrJr7gC5IbIVfLz+eyAZNrpZcMDOe6BBSUASTjn1r4nud
         ACZUUmrOEwojiHLff6KhckkhsxgFbIvXTcKzAfc3wyKE3qz6THEQmBCdPcqLmmd97E35
         SBcdatMozZv2GxNlJZZ0dlHnmp9gnV/rGx96bkiuTCUydbxyflMFXTUI8qruF2hLfdeR
         Pkmc0oXR+KWRLWDYxGiCWTuc9g6Ip8LtRk64ZQkWAUG3kcruAu2umNdgOlPffbs1Ugv7
         qIRA==
X-Gm-Message-State: APjAAAUBmUFnMW6ervyum9j/Iq1Ve3NIzGVtmQZzd9Wwv2G7zxq2lz7v
        8mK3SKQGxTNUzvmN26vAOEy4x/caLgeg3CvbaT0hNw==
X-Google-Smtp-Source: APXvYqzY8AXWnUcvUooaAtojJuu/TkZwcXHYQ8Xq7o9HAeqDtsDi/e98x6Eg5xDfTiBNGq1LllbG0f5kRnZq0n/A5Pw=
X-Received: by 2002:a19:6e4d:: with SMTP id q13mr11834425lfk.6.1564448410092;
 Mon, 29 Jul 2019 18:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <CANRGksjUg8r5zwCpnat_UhX0EP3PDcyazApNSxqc6R_iu0Tqtg@mail.gmail.com>
 <d48e0b11-2fa7-eafe-6ec5-fe4a84e33c14@pengutronix.de> <CANRGksi1Wk2qoeSGTG+q4KBjRDxa_qZQCxyamr5PXOeM62witA@mail.gmail.com>
 <5cf240d7-f9bc-1cff-5ce0-bd3f5f437d9c@pengutronix.de> <CANRGkshiaL9QXMt8s15FydRdL9uF-zBqKw07fVn6JvJaob0umw@mail.gmail.com>
 <f6c215d0-59c1-dcc2-7605-70198ef3f9ad@pengutronix.de>
In-Reply-To: <f6c215d0-59c1-dcc2-7605-70198ef3f9ad@pengutronix.de>
From:   Tom Prohaszka <tprohaszka@capp-tech.com>
Date:   Mon, 29 Jul 2019 20:59:59 -0400
Message-ID: <CANRGksgZE7tSwAyuhWo9_c7LwXO3hrvhqZwfUyyH0c5xYS_WpA@mail.gmail.com>
Subject: Re: Microchip mcp25xxfd can controller driver- BUG: using
 __this_cpu_add() in preemptible
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@martin.sperl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

You ROCK!  Thank you for finding the issue!

On Mon, Jul 29, 2019 at 4:27 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 7/28/19 9:37 PM, Tom Prohaszka wrote:
> > Hey Marc,
> > I added the options below, but it doesn't look like the stack is dumping.
>
> Thanks, that's indeed a proper stack dump, which is a different name for
> backtrace.
>
> > check_preemption_disabled: 143 callbacks suppressed
> > BUG: using __this_cpu_add() in preemptible [00000000] code: irq/194-mcp25xx/805
> > caller is __this_cpu_preempt_check+0x1c/0x20
> > CPU: 0 PID: 805 Comm: irq/194-mcp25xx Tainted: G           O
> > 4.9.65-dey+gf832589 #44
> > Hardware name: Freescale i.MX6 UltraLite (Device Tree)
> > [<80111790>] (unwind_backtrace) from [<8010d6cc>] (show_stack+0x20/0x24)
> > [<8010d6cc>] (show_stack) from [<804c1c94>] (dump_stack+0xa0/0xcc)
> > [<804c1c94>] (dump_stack) from [<804e1ad8>]
> > (check_preemption_disabled+0x130/0x134)
> > [<804e1ad8>] (check_preemption_disabled) from [<804e1b1c>]
> > (__this_cpu_preempt_check+0x1c/0x20)
> > [<804e1b1c>] (__this_cpu_preempt_check) from [<80804284>]
> > (__netif_receive_skb_core+0x118/0xa60)
> > [<80804284>] (__netif_receive_skb_core) from [<80806ffc>]
> > (__netif_receive_skb+0x38/0x94)
> > [<80806ffc>] (__netif_receive_skb) from [<808070e8>]
> > (netif_receive_skb_internal+0x90/0x21c)
> > [<808070e8>] (netif_receive_skb_internal) from [<808072e4>]
> > (netif_receive_skb+0x70/0x1f4)
> > [<808072e4>] (netif_receive_skb) from [<8065006c>]
> > (mcp25xxfd_can_int+0x8f8/0x9cc)
> > [<8065006c>] (mcp25xxfd_can_int) from [<8019d2e4>] (irq_thread_fn+0x2c/0x64)
> > [<8019d2e4>] (irq_thread_fn) from [<8019d644>] (irq_thread+0x180/0x24c)
> > [<8019d644>] (irq_thread) from [<801529f4>] (kthread+0x11c/0x134)
> > [<801529f4>] (kthread) from [<80108650>] (ret_from_fork+0x14/0x24)
>
> We see that netif_receive_skb() is called from the mcp's interrupt
> handler (mcp25xxfd_can_int), which is not allowed.
>
> I've pushed a fix to mcp25xxfd branch on linux-can-next. Please use that
> patch stack, it's the newest.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=mcp25xxfd
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
