Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0EEFF8142
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2019 21:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKKUbQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Nov 2019 15:31:16 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:35698 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKUbP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Nov 2019 15:31:15 -0500
Received: by mail-pf1-f170.google.com with SMTP id d13so11509553pfq.2
        for <linux-can@vger.kernel.org>; Mon, 11 Nov 2019 12:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPbOUE6DESjgslcPjKkWBYjpdgsdsnwY7cn8aQskpKM=;
        b=VquwIIMNEyjrklLDWlqxOKVamAoXDRPyOEuX5tESYOVX4uiyKND1ty3ws6xUQbGGZv
         KPdcRBGCg6OyAI5LnkwE8JrQOy1D+PVdA565DY7IFKOiOPPvDhVweRw5Y+W8PhME4oGc
         xipZFV44lQgz0nWoGnsQyTpD2VcTeh6vvBRSyFgbJ4BBIjFTCWqvd4f1jor9EttUqIx+
         EZRnFuYkrsspdgBQlQFJJXkBe2moj+P3FBu/zi8SfhDQSdWOjLjYnPdeBQfxhByLJtAa
         5kqzwSaOi/Qcp9qGkO2+/O7aq6haPdbTlOen1Ic0JLqzylvAnqRc//UEedsLOEF3WKQj
         mIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPbOUE6DESjgslcPjKkWBYjpdgsdsnwY7cn8aQskpKM=;
        b=sb2ZK510dE7t5fHrULcEqFk9uC9eMaWhBLo9IHIZVzqdJ5XNXBSKqCu4Ifhdu1v23s
         ckZZQf399mkaufydOO9Gs29j7cUZyzdMMz0+NU/V6T2uxr/BM7o/+Wio4SXt89EmIO91
         99bJXjkc+5/JxmR/z2olsTghTrJrGsWXU4VQdmacZomrR84ogpdmJxxWi0DQLjkGU48X
         mP72ZchDOwUH+zhiAuMDy1nLEZ4SQFeNZT3IFwcEnaIvaGBhX4eaaKhhqU06iuFTGeTW
         b1ZOjKdaeJnNbldtO0cuUn69zr5ZlborHBT58d2c0FYAE3Vtz0MKgAZz9kXJrTqNFypN
         DbXg==
X-Gm-Message-State: APjAAAWo+p21Cvh3L+lyHzJhSyO8ObHFCg3iC2JK5zZM05nScsos22rh
        tSWFbY+1Ep1or/jWHmad43FlpXUCoDM5ud+EE0UYbLlx
X-Google-Smtp-Source: APXvYqyET29nQH6hS4+vRO5lR+9d7v5Q6l/xGRB1WG76tb+h8cSiJWkH6TUuQGJS+bifEu0Dp4GId7xTJXrrz9/tBiY=
X-Received: by 2002:a63:1624:: with SMTP id w36mr28726711pgl.404.1573504274500;
 Mon, 11 Nov 2019 12:31:14 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4M_AVk=2cZJ4LQ8QdnNa=6se4bCLkBPLFY5qR=ECpaq7ZKg@mail.gmail.com>
 <9d854335-366a-0b7f-1985-5e1d3245d33a@pengutronix.de> <20191111200045.GB7051@x1>
In-Reply-To: <20191111200045.GB7051@x1>
From:   Drew Fustini <pdp7pdp7@gmail.com>
Date:   Mon, 11 Nov 2019 12:31:03 -0800
Message-ID: <CAEf4M_D1ZDmBFjO+VLYxLgOvzb_gpqad8443_OOw7CoEwqJ1Eg@mail.gmail.com>
Subject: Re: mcp251x: read oscillator frequency?
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Nov 11, 2019 at 12:00 PM Drew Fustini <drew@pdp7.com> wrote:
>
> On Mon, Nov 11, 2019 at 11:28:14AM +0100, Marc Kleine-Budde wrote:
> > I successfully got a mcp25625 (which is basically a mcp2515 with
> > internal phy) running on a rapsi using the frequency printed on the
> > oscillator in the DT-overlay.
>
> I came across this patch by Andy on the linux-can archives:
>
> [PATCH v2] can: mcp251x: Get rid of legacy platform data
> https://www.spinics.net/lists/linux-can/msg02407.html
>
> The description:
> Instead of using legacy platform data, switch to use device properties.
> For clock frequency we are using well established clock-frequency property.
>
> I reads the clock-frequency property from device tree:
>
>         freq = clk_get_rate(clk);
> -       if (freq == 0 && pdata)
> -               freq = pdata->oscillator_frequency;
> +       if (freq == 0)
> +               device_property_read_u32(&spi->dev, "clock-frequency", &freq);
>
>
> I feel like this is currently missing from mcp251x.c.  I don't see how it is
> reading the clock frequency from Device Tree as I don't see any code in the
> current mcp251x.c to read device tree properties.
>
> I would appreciate any insights to improve my understanding.

Also, I meant to ask as to why the clock for MCP2515 Oscillator comes
from the spi device:
clk = devm_clk_get(&spi->dev, NULL);

line 1034 from:
https://elixir.bootlin.com/linux/latest/source/drivers/net/can/spi/mcp251x.c#L1034

It seem like there should be separate clocks for the SPI frequency and
the MCP2515 oscillator frequency.

Am I missing something?

Thanks,
Drew
