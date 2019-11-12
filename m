Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE946F9B68
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2019 22:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKLVBo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Nov 2019 16:01:44 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44135 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLVBo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Nov 2019 16:01:44 -0500
Received: by mail-lf1-f67.google.com with SMTP id z188so6826460lfa.11
        for <linux-can@vger.kernel.org>; Tue, 12 Nov 2019 13:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVS8SFCndtPaeZjb+yTYpB1XHJL0/rt7uYkupsQA/sw=;
        b=uYqi0eSFZ5x+mNyn3dzRUnSp33STZ77g/q1GddjdZgfzn9iOsLz0/CX/ZkPEZvEYKW
         rgKNX6MUJ9PbYk9vt1DRR68iZyI69m4Wx5wzMmRPL5UXiazuRatrR3RgZ2RpxFXZPrXs
         w2nyMTYoQm6XxeVvRPif0uaU7t+B+AKMSmgYJZ2LU5Bcg70sEXph3oumVB60Xb3+ytKC
         +BA49/QJYOMbXb36FtNafWiqEtk6SK2V9Vt3tEaBKTmgY6btxfFOgyiezKzx5KVNbyl4
         tlrK14etkg4wZW8eaYL7yhGpneZnX3YzSFl0jaXjuQWwHaneveURtJi0SPyAp2FbBO/v
         ydvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVS8SFCndtPaeZjb+yTYpB1XHJL0/rt7uYkupsQA/sw=;
        b=SYvnLVWv1JUbJZ9BS1azgPAeQtPsQjRgUJrVjNOfmNFQdZR+MU5To4bpjILI46X159
         gTVtDwMemWojrOrrlViRdbj3LABhwerON8TOthN89cpWJHkBfDzU0hDPg1WKsC8zP7JR
         VZvXpFGggK3eWM32yu1T3axX+8RohfDvipQYKwVXynzRgcZQEH3dLns3yWkuSktXAdaq
         X19ne7z19rzcODX2sQBBz3r1PahSLMP53EBpJDppB+neV6t/jWaCzsLKUYuYxen5AhgG
         4k3KGVTmSzUZ5fzecXA3/ksFOWe/qVPj/QiG4MtQ2eusVjC4xi9Y6CiJYDhwygRsLUKm
         NPDQ==
X-Gm-Message-State: APjAAAUEcsrAs5I68Ut3kOpQTxLRK/S0x9pgcfcUzTjkvrKxIMzWZ26o
        /CN/QV48BvkxcfY6cPYSA6LhWguTMIx9nO/Inlo=
X-Google-Smtp-Source: APXvYqy4zMlyktY2V3dcRfEK/K7C486mC1WDMTtQ7et7Tiw7bD3uvXAcLXT2nGHcSmzI3ekM0NyQzcSj3GEpL0YIZJM=
X-Received: by 2002:ac2:522e:: with SMTP id i14mr44733lfl.9.1573592501745;
 Tue, 12 Nov 2019 13:01:41 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4M_AVk=2cZJ4LQ8QdnNa=6se4bCLkBPLFY5qR=ECpaq7ZKg@mail.gmail.com>
 <9d854335-366a-0b7f-1985-5e1d3245d33a@pengutronix.de> <20191111183912.GA7051@x1>
 <e61a86f9-c201-458c-2522-a8044e93bc08@pengutronix.de> <20191112064624.GA13873@x1>
 <8557f946-bb99-5ff8-5651-91757dc958ba@pengutronix.de>
In-Reply-To: <8557f946-bb99-5ff8-5651-91757dc958ba@pengutronix.de>
From:   Drew Fustini <pdp7pdp7@gmail.com>
Date:   Tue, 12 Nov 2019 13:01:29 -0800
Message-ID: <CAEf4M_CbSPS-HrOi_LcFm_SW50o6wH0pu17iKBQCA4dV9oDp-g@mail.gmail.com>
Subject: Re: mcp251x: read oscillator frequency?
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Nov 12, 2019 at 12:44 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Several of these properties are not handled by the mainline driver
> (mcp251x,irq-gpios, mcp251x,stay-awake, mcp251x,oscillator-frequency,
> mcp251x,enable-clkout). This doesn't have any effect, it just bloats the
> DT by some bytes.
>
> Which kernel are you using?

I'm using 4.14 kernel on the PocketBeagle:
https://github.com/beagleboard/linux/blob/4.14/drivers/net/can/spi/mcp251x.c

I see now that those properties are not in the bindings:
https://elixir.bootlin.com/linux/v5.4-rc7/source/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt

I based the overlay I was using one a MCP2515 overlay for SPI0 on
BeagleBone Black:
https://github.com/battlesnake/beaglebone-spi0-mcp2515/blob/master/MCP2515.dts

I'm not sure where those extra "mcp251x," properties come from since
the driver does not appear to use them at all.

I did see the Andy posted this in October:

[PATCH v2] can: mcp251x: Get rid of legacy platform data
https://www.spinics.net/lists/linux-can/msg02407.html

The description:
Instead of using legacy platform data, switch to use device properties.
For clock frequency we are using well established clock-frequency property.

Do you know if that is going upstream?

Thanks,
Drew
