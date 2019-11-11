Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6E7F7BBD
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2019 19:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfKKSjU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Nov 2019 13:39:20 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:32791 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbfKKSjS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Nov 2019 13:39:18 -0500
Received: by mail-pf1-f175.google.com with SMTP id c184so11279093pfb.0
        for <linux-can@vger.kernel.org>; Mon, 11 Nov 2019 10:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=J4Fz+tCKUo6xxbRKwiT5IX8z0XOfgn8hgMyRPrOqGkI=;
        b=Tcb3fhdzzAYFrJ8JDJYPgmStqKCxWF++LTs5h8kjQEhZEplJ+m8gcrQs0vlaa56XDy
         YIlOdYw5WOwoUOD5KHCeLInE8PvAYs5cVq4QjdPmvTe4F/TzkwKnn+FESeWtwBwmEE7v
         slsC6M3C6NV9+6p0+ZFBy+UojzM0OgMO60QEijucchqFTHOQw2bPMT79ZKEWy3ioRURd
         6Scep0j63qVyBCFrFk9+5HHcJZiaGBOeomUhyWWpCODA8PXGlPVFjk0L6W4jjOCalnAi
         FJEigeUUzsh20YpslF0m1GJQIiDca2HMp8UzHYktqha1ZhjCwn0jsChFa1qVIrxSfhZ4
         wyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=J4Fz+tCKUo6xxbRKwiT5IX8z0XOfgn8hgMyRPrOqGkI=;
        b=QNLao++1HwNA0KlJIkR7Nx6YsOtPnGNSCaHLbriGn/fRPjHjHw3jG8GehBm9GXOLvb
         4isyAibquf9uKkQB5YIzDprilI+wt4963tM+WJ8joj10NDeO1h0YUaUmf7N4vZoiui8K
         8WJeKQwvjL1bxf+9FoeiXMfC9Iccv/QsvA1W/QBFi9GkJ/gewSPl40PxmCOr2471mLcg
         QXlybGTI/WyVGLeyXkvb5uoTHyR8JG2QjwGPMuFHi6RQ/6j0SXusLw8T6dmknQN8GAEU
         st0mjeGhF+Yj71OYcHvv0EHhlLssrPgW5aP5Rtgq9IZAkytIOYbYrgnVzZsgQ6b8/HY5
         25+g==
X-Gm-Message-State: APjAAAWn5eMHABQeRa42hvP28rhrgmI9xWeGeMD5zI/3im5AIrSubhMV
        8NzpXmcUxGBWNBpKAdn6rQQ=
X-Google-Smtp-Source: APXvYqziYU6gDvpHcsS66xVtsBgzDsUiPRoNKjc/c7R5zeC0fUvbZfahDEFiXhFrTQVPS/GsgnPadQ==
X-Received: by 2002:a63:3e07:: with SMTP id l7mr14036775pga.171.1573497555811;
        Mon, 11 Nov 2019 10:39:15 -0800 (PST)
Received: from x1 ([65.153.21.102])
        by smtp.gmail.com with ESMTPSA id q12sm4362944pgl.23.2019.11.11.10.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 10:39:14 -0800 (PST)
Date:   Mon, 11 Nov 2019 10:39:12 -0800
From:   Drew Fustini <drew@pdp7.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Drew Fustini <pdp7pdp7@gmail.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: mcp251x: read oscillator frequency?
Message-ID: <20191111183912.GA7051@x1>
References: <CAEf4M_AVk=2cZJ4LQ8QdnNa=6se4bCLkBPLFY5qR=ECpaq7ZKg@mail.gmail.com>
 <9d854335-366a-0b7f-1985-5e1d3245d33a@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d854335-366a-0b7f-1985-5e1d3245d33a@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Nov 11, 2019 at 11:28:14AM +0100, Marc Kleine-Budde wrote:
> On 11/11/19 12:09 AM, Drew Fustini wrote:
> > Hello, I'm looking at mcp251x driver and it does not seem to read the
> > device tree property 
> > mcp251x,oscillator-frequency.  
> > 
> > I have a problem where I have MCP2515 with a 16MHz oscillator.  However,
> > it is getting configured with a 8MHz clock despite
> > having mcp251x,oscillator-frequency defined as 16MHz:
> > https://github.com/pdp7/bb.org-overlays/blob/patch-1/src/arm/PB-MCP2515-SPI1.dts
> 
> I assume you get the 8MHz clock rate from the "ip" output, right?
> 

I added printk to output the value of:
freq = clk_get_rate(clk);

which is from line 1041:
https://elixir.bootlin.com/linux/latest/source/drivers/net/can/spi/mcp251x.c#L1041

which shows:
mcp251x_can_probe: clk_get_rate(clk)=8000000

I'm confused where that value is coming from.  The line that divedes freq / 2 comes later.

> Like here? (example output from a different CAN controller)
> 
> It's due to this line in the code:
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/net/can/spi/mcp251x.c#L1065
> 
> where only the half of the external osc frequency is stored. That value
> is displayed in the user space by the "ip" command.

Here is the output which shows 8MHz when freq is hardcoded to 16MHz instead of the 8MHz that clk_get_rate(clk) returns: 

# ip -details -statistics link show can2
6: can2: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
    link/can  promiscuity 0 
    can state ERROR-ACTIVE restart-ms 0 
	  bitrate 33057 sample-point 0.818 
	  tq 2750 prop-seg 4 phase-seg1 4 phase-seg2 2 sjw 1
	  mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
	  clock 8000000
	  re-started bus-errors arbit-lost error-warn error-pass bus-off
	  0          0          0          0          0          0         numtxqueues 1 gso_max_size 65536 gso_max_segs 65535 
    RX: bytes  packets  errors  dropped overrun mcast   
    4          1        0       0       0       0       
    TX: bytes  packets  errors  dropped carrier collsns 
    0          0        0       0       0       0       

debian@beaglebone:~$ dmesg |grep -i mcp
[   27.295958] mcp251x_can_probe: enter
[   27.363720] mcp251x_can_probe: clk_get_rate(clk)=8000000
[   27.363731] mcp251x_can_probe: OVERRIDE freq=clk_get_rate(clk)=16000000
[   28.144501] mcp251x spi1.1 can2: MCP2515 successfully initialized.
[  579.547200] mcp251x spi1.1 can2: bitrate error 0.1%

Here is the diff where I hardcode 16MHz:
https://gist.github.com/pdp7/8e1765110178f4f65b04d19ac7cb1c4d#gistcomment-3079280

> > I would appreciate any advice on whether a patch for mcp251x.c to
> > read mcp251x,oscillator-frequency would be a good way to solve this issue.
> 
> Looking at the datasheet[1] of the mcp2515 page 40, equation 5-2, I
> think this is correct. As the timequanta is calculated by:
> 
>     Tq = (2 * Brp) / fosc
> 
> On other words:
> 
>     Tq = Brp / (fosc / 2)
> 
> We have no means of expressing the additional "/2" during the bit timing
> calculation, but to store the fosc/2 as the "effective" oscillator
> frequency.
> 
> I successfully got a mcp25625 (which is basically a mcp2515 with
> internal phy) running on a rapsi using the frequency printed on the
> oscillator in the DT-overlay.

Thanks for the explanation.  I'm still trying to figure out why clk_get_rate(clk) is returning 8MHz when I have 16MHz in the device tree.

Would you be able to the DT overlay you are using?

Maybe I am not using the correct properties to define the clock?

This is the DT Overlay:
https://gist.github.com/pdp7/56174646bb9d075b041f24de2bb01973


Thank you,
Drew
