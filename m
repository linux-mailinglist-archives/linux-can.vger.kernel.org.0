Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B508627D0AC
	for <lists+linux-can@lfdr.de>; Tue, 29 Sep 2020 16:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgI2OLW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 29 Sep 2020 10:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2OLW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Sep 2020 10:11:22 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1798C061755
        for <linux-can@vger.kernel.org>; Tue, 29 Sep 2020 07:11:21 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id s88so5012712ilb.6
        for <linux-can@vger.kernel.org>; Tue, 29 Sep 2020 07:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=F1vGToOKT+EjET93uEuVFZ5+v0JwNF+5f291n8d0Uqw=;
        b=TOTo/B2eqQvCeKN63FNyi+/aiJ5177fuNYqoi9JZafxxeOyZZX8lqJXQKcW30HVW83
         p95kx79WwjFIf//MWA/nsJZe5wA77QM3LOJe7SzXgAhGzjJuyKIbafOO9RQAtFtqWj+5
         e/962s/+zMjFbbtf11FvgUnP+LpQWSOXi5mxSc+iBMZPDGUOZli52/CDp0o8TJJ+OnAq
         QZRSXreuE4MH1Q2NXtcBaGdJzN+aqJ62lt6o0jPscMcKeFnyZ4aMgFFZMidaqeYUdDyX
         TtOyE5Ttcq49ikywtm2nIvjYaB+cv6vuo0LSvVKoK9Uy77dW2pyj5BqK4W2oVSHvVnqh
         Regw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=F1vGToOKT+EjET93uEuVFZ5+v0JwNF+5f291n8d0Uqw=;
        b=eqgDxgFYB25nZ1BQfR/SJUY23lunKgzOnQP6eX5czCYKTC43B6Shm3s69LpX14oiKf
         cXLuVxDs0m2ctqGmt0J39gUjbquTAS9b+Lk9xuGRFOEuAhixg4NjkuZRUeEHAUZzchEu
         VfFmzyAR4RueQGoBlFt2XLtNKFuWD2OniK7F9ZJjQ775AWDi3yU4EoDxwVocr1Qmrn0M
         3GhpZTyadNKieYSJCm+S20oVndT4D0SMgx2DNsumMudVjlvu430sYm8R/S6t9ZJzZLby
         05BloLiGz0OrP5ATHtuKQprVwyrT6mpRm3T42/043A6L5J/fxfJdLMFKpIO5SwCwnusM
         RQ3w==
X-Gm-Message-State: AOAM531tqKpfegCq2X47wDQdTgsAaTNIZ+Zs+ReqODH2InwDA6jKtZ4m
        wl7y83OIG/SmY9QOFUZoyMOyeYmzUpYgI11Z5A==
X-Google-Smtp-Source: ABdhPJxb4boJVIG4TxyFbampVaP9qBazsnlSz8DssMzzJrY2VkSMGo2GG0cuXki+Rh+/7TBthkPYqEiFYv3WNINUfDU=
X-Received: by 2002:a92:d905:: with SMTP id s5mr3341425iln.224.1601388681196;
 Tue, 29 Sep 2020 07:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAO8h3eGqrxFMKrsrjECeog6cheLrRpn_y6Ty9BMUv_ncU1c67g@mail.gmail.com>
 <20200923190551.GA14591@x1.vandijck-laurijssen.be>
In-Reply-To: <20200923190551.GA14591@x1.vandijck-laurijssen.be>
From:   =?UTF-8?Q?Matthias_Wei=C3=9Fer?= <m.weisser.m@gmail.com>
Date:   Tue, 29 Sep 2020 16:11:08 +0200
Message-ID: <CAO8h3eEXG0WiJbmiswXd6uWbR4AE-tzL772mNLvUhbqgK7+jRQ@mail.gmail.com>
Subject: Re: mcp25xxfd driver testing
To:     =?UTF-8?Q?Matthias_Wei=C3=9Fer?= <m.weisser.m@gmail.com>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Kurt

Am Mi., 23. Sept. 2020 um 21:06 Uhr schrieb Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be>:
> > Also receiving of any CAN frame doesn't work
> > # candump any,0:0,#FFFFFFFF
> > [  259.937612] spi_master spi1: I/O Error in DMA RX
> > [  259.943743] mcp25xxfd spi1.0: SPI transfer failed: -110
> > [  259.949644] spi_master spi1: failed to transfer one message from queue
> > [  259.956566] mcp25xxfd spi1.0 can0: IRQ handler
> > mcp25xxfd_handle_rxif() returned -110.
> > [  259.964547] mcp25xxfd spi1.0 can0: IRQ handler returned -110
> > (intf=0x3f1a0002).
>
> There is something bizarre with the DMA implementation of imx.
> The variscite device-tree's come with dma disabled in their SPI nodes,
> using
>
>         &ecspi1 {
>                 status = "okay";
>                 /delete-property/ dmas;
>                 /delete-property/ dma-names;
>         };
>
> Since I was struggling to consume 1Mbit, I tried to enable DMA again,
> and ran into the same SPI tranfer failed. Disabling DMA fixes this.

After adopting my DT I am now able to successfully receive CAN frames
now. Load testing needs to be done....

I also tried with different SDMA firmware versions but that didn't
change anything.

> > Trying to send a CAN-FD frame with baud rate switch fails
> > # cansend can0 123##142
> > [  190.921477] mcp25xxfd spi1.0 can0: bus-off

This still leads to an immediate bus off. I think I have to get the
scope out to check the reason here.


Thanks,

Matthias
