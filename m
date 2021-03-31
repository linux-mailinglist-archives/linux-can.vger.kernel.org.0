Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B60D3502D0
	for <lists+linux-can@lfdr.de>; Wed, 31 Mar 2021 16:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbhCaOyh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 31 Mar 2021 10:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbhCaOye (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 31 Mar 2021 10:54:34 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251DDC061574
        for <linux-can@vger.kernel.org>; Wed, 31 Mar 2021 07:54:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e7so22632972edu.10
        for <linux-can@vger.kernel.org>; Wed, 31 Mar 2021 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMU6/LnEcj+bd+gJDWHuE7jKvgGDD3VtI1BTIQgBO2U=;
        b=TvhuHFvDJvQfER8YS/M1YDS5XEu+7XcF5ePVX062DNXtkL6C+yKo00i+S9R/kBIgS7
         4WjE/2HiUW/M7Sz1xpuv53lRbqPDMkq4VvsNsyQ+koe4eiyrP1Lg7pW9sZKcmEKiU9XE
         LVrSLp5q5rusr2yNDrxT5APsYYIwXgGinJlLHIta8DK7iQHc8dv6QS8v5e73j+btLCFB
         D5w7vqHexT3e/yrQaTNniAzBv4j826EquFBcS9AcIuhSp4W2IlWvo/myazG7mAcBdaLv
         HJAk6hE7v/07GEujSbWEJmGNDiD7sU68tRXIJdApQ8HPmD+1dxDwNQHIPcvMPJBcvFDq
         vQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMU6/LnEcj+bd+gJDWHuE7jKvgGDD3VtI1BTIQgBO2U=;
        b=a3ftlEtRGgSs3MeuaUQx64MpKAwQ+iHdbkRFeNps0p+OiXtNfE1rt71jSRIx3J0UOL
         uD7U/AsLMmsbEUTvwBuQa5v170/0vRe+2iOcu0abKIBYdIp4II73B47SQw+wL9qCjQX/
         esLIsDZBJAux22IOw4BEXgM+6m9YEB7dBGr+LCxpxPDa9EOcYEl73OcSUXx70uvXBEbF
         xOxJW53sTIijkA0UVkwgG8G/m62y3o+YTmA4odosy3OJIieqHscqO7RngQWpgupxH/5f
         yk6Xt/tXnyxGnetvZjLShPu+MdvNQYnzEObolrw9zGKGSIhK/I2INtbpHleCHdv4oSf2
         5TzA==
X-Gm-Message-State: AOAM531xoMITEeETlia+WtoeEzaLU6I4DHGEs9mmFsNQn00ALG2QN+Kc
        vpefCigfNIlgUWkQ+MovSCqT7vKDHwMCa4eDgW8ognTHq1F1uTbd/fc=
X-Google-Smtp-Source: ABdhPJx3h3IpBS4vM4iEN1J1l8UtchKO4JPprClCQPp0DQaVNY5dBH0zuyTd8AtiavHIBHobNSlFoX8Ag2NNHBQ5KsE=
X-Received: by 2002:a05:6402:3486:: with SMTP id v6mr4103004edc.109.1617202472852;
 Wed, 31 Mar 2021 07:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210330100246.1074375-1-mkl@pengutronix.de> <CAJ+vNU0w2faqmW0MOA9FQD8=vxpJH1Lc8c0BMcAVKGNq1vNjjg@mail.gmail.com>
 <20210331071427.w4bplxt2hoiduho2@pengutronix.de>
In-Reply-To: <20210331071427.w4bplxt2hoiduho2@pengutronix.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 31 Mar 2021 07:54:19 -0700
Message-ID: <CAJ+vNU10c5NtLaG64VhcYO8E9sA3di6v5_MnNHVTaFrfkrpxyQ@mail.gmail.com>
Subject: Re: [PATCH] can: mcp251x: fix support for half duplex SPI host controllers
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Mar 31, 2021 at 12:14 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 30.03.2021 14:06:03, Tim Harvey wrote:
> > On Tue, Mar 30, 2021 at 3:02 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > >
> > > Some SPI host controllers do not support full-duplex SPI transfers.
> > >
> > > The function mcp251x_spi_trans() does a full duplex transfer. It is
> > > used in several places in the driver, where a TX half duplex transfer
> > > is sufficient.
> > >
> > > To fix support for half duplex SPI host controllers, this patch
> > > introduces a new function mcp251x_spi_write() and changes all callers
> > > that do a TX half duplex transfer to use mcp251x_spi_write().
>
> > So was the issue being resolved here that there was another SPI host
> > controller that wasn't advertising that it was half duplex only
>
> I don't know which SPI host controller Gerhard uses, but I assume it has
> half duplex set, as the driver probe fails with:
>
> | [  112.226164] mcp251x spi0.1: spi transfer failed: ret = -22
>
> The -22 is returned by the SPI framework if you have a half duplex
> controller and a transfer with both TX and RX buffer set. This is the
> case in the mcp251x_spi_trans() function.
>
> > or was something else wrong with e0e25001d088 ("can: mcp251x: add
> > support for half duplex controllers")?
>
> Your patch only converted the SPI read path to use half duplex
> transfers. My patch also converts the SPI write path.
>
> If your half duplex controller works without that patch, the controller
> driver doesn't advertise correctly that it is half duplex only. If the
> hardware is indeed half duplex only, better send a patch that sets the
> half duplex flag. If the hardware support full duplex, but the driver
> somehow doesn't implement it correctly, so that it implements half
> duplex only you should at least drop a note on the SPI mailing list.

Marc,

Thanks for the explanation!

I was surprised as the 5.4 kernel I use with the CN803x OcteonTX using
drivers/spi/spi-cavium-thunderx.c works fine but as you say it is
because the host controller does not advertise half duplex only in
that kernel. I did mainlin in e8510d43f219 ("spi: spi-cavium-thunderx:
flag controller as half duplex") which appears in 5.9.

>
> Can you test this patch and give me a Tested-by?
>

I did verify that with this patch 5.12-rc5 initializes the mcp251x on
the CN803x OcteonTx and without it we fail.

Tested on a GW6404 board with an OcteonTX SoC and MCP25625

Tested-By: Tim Harvey <tharvey@gateworks.com>

By the way, I believe you were discussing at one point the possibility
of adding something in the spi core that would be able to implement
half duplex transactions for drivers written for full duplex
communication. Is that something on your list or even possible?

regards,

Tim
