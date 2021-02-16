Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33BE31C7D2
	for <lists+linux-can@lfdr.de>; Tue, 16 Feb 2021 10:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhBPJHw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Feb 2021 04:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhBPJHp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Feb 2021 04:07:45 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24C5C061574
        for <linux-can@vger.kernel.org>; Tue, 16 Feb 2021 01:07:04 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l17so8494518wmq.2
        for <linux-can@vger.kernel.org>; Tue, 16 Feb 2021 01:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDO0uIu528pP5Zy3jOM8I28qRDdl1AyK9jViOMY4L44=;
        b=cyhnYDxk0OZIP46IvHSMpE5hFufiX9qUbvA5JdQDgMzOz/q0e3k1MSpxZQTwCyO8Tp
         M+sVyuRV9DXkdmZIxBHnw726yTKb4F4XjUuK1B4UF1B5/j4nCP2jo13uLtHxw+c+n9jR
         u1lwkmGEXFXGm4HhjBT4yhITi9ICZi32N6RDAxCZGllMVuabLJenNkKP/84XhDgZBGE7
         ZsI1UUSE3TYcUGBywYTNfuIqjYEnKYw/XiY/+Su4PFmyY0+JTSCE6QU2gDRUt7NZhTR/
         pV9rLGWtxOSimF4EYn6YMAAOa/bcMA/KHNcIApcQvB8S0X9CRAaoBomPllC03W32R+2S
         nkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDO0uIu528pP5Zy3jOM8I28qRDdl1AyK9jViOMY4L44=;
        b=CCkfwiDdn4wEBNURKX1LemvsrVPuiiXOiAsSHG9aDbnv8CPm2JvDYFCeFEIciF9cc8
         1xxyZmckvY21u/VbgGdmNEBkc6aIzMCNbkdXvaOd4lJgVcg0F8iytaysVG91MPyNDd9y
         h4NBoC02lqbipc0Isrvds5BPSQbNSJp3LIZnOXVoL64EYsuQDTU8ZTDA2jujGhkY8MXM
         pv8FCTIJ+hWpxDXEkE+UuvLHuhk3AGsTxgCdZDGy0BskLdI+YInpKDkr3h/lC8Dy5FDN
         a6IsDRVfXs/7MGV/9Jmx1aqiO/4xvcy0PkntNYoydAdDb09fbnOCmmTZQxsxnd6gGzN1
         WaqA==
X-Gm-Message-State: AOAM532AszTf/wCP6268EaFBB5xf3EHITLkbvZ4AsBzugHM2Ss4mA7ij
        hxORBdh/rGRMsOSJOnAE8MoAEjC6hmUwXA27CBJaFA==
X-Google-Smtp-Source: ABdhPJwLap6OPfI62awWO9IZRMwMrRHHvWeW4B2nG7TbVOQtgVVmMCV368qke0b8xyFZ1DcNmV4uEG6nblNxE4mWEt0=
X-Received: by 2002:a7b:c256:: with SMTP id b22mr2326640wmj.108.1613466423325;
 Tue, 16 Feb 2021 01:07:03 -0800 (PST)
MIME-Version: 1.0
References: <602651f9.1c69fb81.302a5.647d@mx.google.com> <20210215144509.rhds7oybzat6u27w@hardanger.blackshift.org>
 <CAALJrqgrmzGHZX+iiMYwMkVMpxtf_3fWYkVA-iMdPOxpGzrCRQ@mail.gmail.com> <20210215174408.eea3okssfzjsqrly@hardanger.blackshift.org>
In-Reply-To: <20210215174408.eea3okssfzjsqrly@hardanger.blackshift.org>
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
Date:   Tue, 16 Feb 2021 09:06:52 +0000
Message-ID: <CAALJrqj=QC1to9ja0CeL76JxVF1iwjsW7YJHs18VbXea=PvBGg@mail.gmail.com>
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, 15 Feb 2021 at 17:44, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Do you have the wake-gpio in your DT? This one works for me:

We actually don't break out WAKE on our board, and using this board
I've written a TCAN4550 driver for MCUs and haven't required device
wake-up via WAKE or other means.

My DT:

|            tcan4x5x: tcan4x5x@0 {
|                reg = <0>;
|                compatible = "ti,tcan4x5x";
|                pinctrl-names = "default";
|                pinctrl-0 = <&tcan4x5x_pins>;
|                spi-max-frequency = <4000000>;
|                bosch,mram-cfg = <0x0 0 0 10 0 0 0 10>;
|                interrupt-parent = <&gpio>;
|                interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
|                clock-names = "cclk";
|                clocks = <&clk_tcan4x5x_osc>;
|            };

> You mean something like these...
>
> | [  543.116807] WARNING: CPU: 0 PID: 11 at lib/refcount.c:25 refcount_warn_saturate+0x108/0x174
> | [  543.116820] refcount_t: addition on 0; use-after-free.
>
> with can_put_echo_skb() in the call stack?
>
> | [  543.117745] [<bf186edc>] (can_put_echo_skb [can_dev]) from [<bf1d67ec>] (mcp251xfd_start_xmit+0x2b0/0x3bc [mcp251xfd])

Yes, exactly. I have also seen, when putting the interface down...

[   69.378407] WARNING: CPU: 3 PID: 740 at lib/refcount.c:28
refcount_warn_saturate+0x13c/0x174
[   69.378413] refcount_t: underflow; use-after-free.

...with can_flush_echo_skb() in the stack this time:

[   69.378857] [<7f1de528>] (can_flush_echo_skb [can_dev]) from
[<7f1de5c8>] (close_candev+0x2c/0x30 [can_dev])

> > This is a Raspberry Pi 3 Model B v1.2, hosting a TCAN4550 on spi0. The
> > external oscillator for the TCAN4550 is 20 MHz.
>
> Is that a custom tcan pi hat, or is it officially sold somewhere?

It's a custom board, jerry-rigged to a Pi.

> First thing I'd do is to rewrite the RX function and IRQ handler for the
> "peripheral", that's the code path used for the SPI attached m-can
> core. TX doesn't look efficient, but it should work at least.

Thanks, I'll take a look. I am concerned about this weird behaviour
when trying to TX, though. I'll walk through the chip config and
compare with my known working process.

-- 
Regards,

Torin Cooper-Bennun
www.maxiluxsystems.com | Software Engineer
