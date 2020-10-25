Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BE3298005
	for <lists+linux-can@lfdr.de>; Sun, 25 Oct 2020 05:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767018AbgJYEai (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Oct 2020 00:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1767017AbgJYEai (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Oct 2020 00:30:38 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3937C0613CE
        for <linux-can@vger.kernel.org>; Sat, 24 Oct 2020 21:30:37 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id f97so5183496otb.7
        for <linux-can@vger.kernel.org>; Sat, 24 Oct 2020 21:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8PtiSpe61v2HgS01pnZBZkuPnqmJ7mU4ABGlOMyMBQ=;
        b=NADm2j8n2UBmAOqd30yYQlxF5ekbVASI7R8b4bAYc8xY+X2a7uM/JLEQxtKThq02gq
         eY9fOenxnnt4DN88JfXf/Qm4JYvMoxebvlpSOTeBkSdOsP2Xv9bj0bczfdNjgw/nGH9j
         cVA11JqVHnydZy6i2Gst71uAYUItSsediqaYEey1DyQgJSm8BrwpTybAq2EKS0+foRmY
         DIEJ9+1DLeyWQgGFCPym8k7ywFk9tSKP1MtZx/LMfZ2VrV7k9/dU5mgT9/tVUkmnzngC
         16B4Q9arSPeGAByPbO0vwGJve/L0LJ47KjxQUYEAsCpP/XnRc6An63kOibajoH47hf2b
         tb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8PtiSpe61v2HgS01pnZBZkuPnqmJ7mU4ABGlOMyMBQ=;
        b=A9N5abzxoqtwj+LHrVbm69bKSIcNTl+PsUhiHz4s0BZfuvROcZVr00hCy+xUDN8iwl
         u8AXKd1u9bxtuSqt950IyFzzRQPhf0noo+LETvonunGbiXodvylMRfwvPYpGOOBYBYr+
         nqm3XIizKscjNSQR/b9I+OIKoGV6uY6EwyoFmpgeA7sajUz3O+4juconox4CvtI4UziS
         HSlywYzCViBEc8HYCMb/LgesPPRqQio9QAhO8WxgqlvvJmkcq4kkyMv5D2cIZOAyrqqT
         DB3nxta93ho9I/eq7CYyv/6oMCWJFK5THaL65GYyD1UKfTS1YvdhZQ738Z7prX7eNoDn
         LEUQ==
X-Gm-Message-State: AOAM533TmHUPE45da1XUSk5vf/HeBc5QIs+z3p8DEttlAsCKxWsHk847
        w9qEAwb3xv5HOlYEV78Dg4s9hXruXZlbUsFMXWXxXv3TSXuxhQ==
X-Google-Smtp-Source: ABdhPJxkN+WetwxUeOJZf8ghygAurtejpKw/gjMc0z2kCPbsezeSZX7IAnZwmSLwd+cf2E7J2XsD9Mm6v4H4QuNJBks=
X-Received: by 2002:a05:6830:12d9:: with SMTP id a25mr1836177otq.168.1603600236434;
 Sat, 24 Oct 2020 21:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
 <CAPgEAj5HwFUTqhbgZ2Y5Db-_PPHNN7Rc8dnp1s+TBBALf5EwSw@mail.gmail.com>
 <3ede1c31-9436-a8ec-b7cd-65cee5fa23fc@pengutronix.de> <CAPgEAj7JLUjWiN8LdGV9OfQScsUkPVcs9bSE+w_9G0c9BNd-sg@mail.gmail.com>
In-Reply-To: <CAPgEAj7JLUjWiN8LdGV9OfQScsUkPVcs9bSE+w_9G0c9BNd-sg@mail.gmail.com>
From:   Drew Fustini <drew@beagleboard.org>
Date:   Sat, 24 Oct 2020 23:30:41 -0500
Message-ID: <CAPgEAj6nQOAQ9NNB2QBbARuqWm5K62QW+NsqPROzcQOZqe-F+g@mail.gmail.com>
Subject: Re: mcp251xfd on RPi 5.4 downstream
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Josh S <josh@macchina.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Oct 22, 2020 at 1:42 PM Drew Fustini <drew@beagleboard.org> wrote:
>
> On Thu, Oct 22, 2020 at 1:33 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> >
> > On 10/22/20 8:00 AM, Drew Fustini wrote:
> > > It appears it was simpler to get it to compile than I expected.
> >
> > \o/
> >
> > > cs_change_delay.unit becomes cs_change_delay_unit,  and
> > > cs_change_delay.value becomes cs_change_delay.
> > >
> > > The other issue was 728fc9ff73d3 ("can: rx-offload:
> > > can_rx_offload_add_manual(): add new initialization function") which
> > > was simply solved by adding can_rx_offload_add_manual() to:
> > > include/linux/can/rx-offload.h
> > > drivers/net/can/rx-offload.c
> > >
> > > The driver builds ok:
> >
> > With your help :) I backported current linus/master to the rpi-5.4:
> >
> > https://github.com/marckleinebudde/linux/tree/v5.4-rpi/mcp251xfd-20201022-54
> >
> > Can you test that?
>
> Thanks, will do.   I am currently trying to finish up my ELC-E talk
> prep :) but will get back to you with the results of testing later.

I noticed up doing a modprobe that there are several Unknown symbol errors.

Any ideas?

[  358.686691] mcp251xfd: Unknown symbol can_rx_offload_del (err -2)
[  358.686744] mcp251xfd: Unknown symbol can_put_echo_skb (err -2)
[  358.686796] mcp251xfd: Unknown symbol can_len2dlc (err -2)
[  358.686844] mcp251xfd: Unknown symbol alloc_canfd_skb (err -2)
[  358.686942] mcp251xfd: Unknown symbol open_candev (err -2)
[  358.687042] mcp251xfd: Unknown symbol alloc_can_skb (err -2)
[  358.687093] mcp251xfd: Unknown symbol unregister_candev (err -2)
[  358.687139] mcp251xfd: Unknown symbol can_change_state (err -2)
[  358.687183] mcp251xfd: Unknown symbol can_change_mtu (err -2)
[  358.687227] mcp251xfd: Unknown symbol can_rx_offload_add_manual (err -2)
[  358.687294] mcp251xfd: Unknown symbol free_candev (err -2)
[  358.687345] mcp251xfd: Unknown symbol alloc_candev_mqs (err -2)
[  358.687416] mcp251xfd: Unknown symbol close_candev (err -2)
[  358.687475] mcp251xfd: Unknown symbol can_bus_off (err -2)
[  358.687519] mcp251xfd: Unknown symbol can_rx_offload_enable (err -2)
[  358.687569] mcp251xfd: Unknown symbol can_rx_offload_get_echo_skb (err -2)
[  358.687656] mcp251xfd: Unknown symbol can_dlc2len (err -2)
[  358.687710] mcp251xfd: Unknown symbol alloc_can_err_skb (err -2)
[  358.687773] mcp251xfd: Unknown symbol can_rx_offload_queue_sorted (err -2)
[  358.687819] mcp251xfd: Unknown symbol register_candev (err -2)
[  369.092608] CAN device driver interface

root@raspberrypi:~# modinfo mcp251xfd
filename:
/lib/modules/5.4.72-v7l+/kernel/drivers/net/can/spi/mcp251xfd/mcp251xfd.ko
license:        GPL v2
description:    Microchip MCP251xFD Family CAN controller driver
author:         Marc Kleine-Budde <mkl@pengutronix.de>
srcversion:     1E05EEB5939E9AB22BA2E1B
alias:          spi:mcp251xfd
alias:          spi:mcp2518fd
alias:          spi:mcp2517fd
alias:          of:N*T*Cmicrochip,mcp251xfdC*
alias:          of:N*T*Cmicrochip,mcp251xfd
alias:          of:N*T*Cmicrochip,mcp2518fdC*
alias:          of:N*T*Cmicrochip,mcp2518fd
alias:          of:N*T*Cmicrochip,mcp2517fdC*
alias:          of:N*T*Cmicrochip,mcp2517fd
depends:        can-dev
intree:         Y
name:           mcp251xfd
vermagic:       5.4.72-v7l+ SMP mod_unload modversions ARMv7 p2v8

root@raspberrypi:~# lsmod |grep mcp
mcp251xfd              36864  0
can_dev                28672  1 mcp251xfd


Thanks,
Drew
