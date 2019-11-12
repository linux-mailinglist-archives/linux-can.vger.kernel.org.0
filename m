Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8293F9BDD
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2019 22:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfKLVPk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Nov 2019 16:15:40 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37967 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLVPk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Nov 2019 16:15:40 -0500
Received: by mail-lf1-f66.google.com with SMTP id q28so45070lfa.5
        for <linux-can@vger.kernel.org>; Tue, 12 Nov 2019 13:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AI25XYb5CLulZslp8TlFwXdv33g2ilNodGr5KINBjFI=;
        b=Rp387g4TzdCJPy3Yr3Cw9Wj3i7eSz5yQcMzxc6nDxTdikJjnD9GHAWRAiB5K3qnujp
         blmcK8mDvUNLdTzVSIlO1kNM7kJqHcsLyxu35AaR7gB7JI6bayBUJLLR8EXTlf/8XaZQ
         IORyUWmi3CRA+6jpfR7VY9aq5ADHT0UV/aFP3UhOyYPnjLxVQZKtqrpYcHOAEGrGt0s6
         RmW6rsVL+UgjVUMEQnfk79xcRVVuj2SqQH3HVXjBe3Jr3Xl6sTOwBoAXmKHsQ2g0XSXR
         P/MxRtVxvQKCrdT6EExKAznXIGTWr2LHPTYqOHZ3JVj9wtSxxC7Dld7e32x47Neq/PGj
         DzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AI25XYb5CLulZslp8TlFwXdv33g2ilNodGr5KINBjFI=;
        b=BUl2ek58M0DKsIzOq4s11/86i5gGvtpZH5gOdhtQ5JchKRNv83vopivEKIuzqerG9F
         dzPgUE+Bcjq+ZTH7nSt5CW1eob5j6+J9zR5f3FZtx4NleF6ZAiDyGoVrwz89qgs3BoyQ
         /7bCpXwUYY9Hp+FuQ5ndnOoy0DWuEKBliWI9pIMPTWnSN5oR6r3xj0qlkkzx7JibwKrf
         zcC9rLoUfuKT7w9SJrvMfF4F+2rFraCBl1dFOrmiY5sbZXY76ZvIpEidjHBLAHTDvk9q
         Y6nPU7vRbCUN7a2kSv2vICa2Q7d62gsAUvAHwidD7b5eFpXeDPoyHQLDV/xPp4Ga4RrY
         d3jw==
X-Gm-Message-State: APjAAAXG31cWcqJmtTnQ/Wtfzw6son8gue/ooFEsvXwX6en04fq+ozFd
        dga5iz+oyaqPkWiqC+gJIG7tC06MJjbAZOOWFHBE4pyi
X-Google-Smtp-Source: APXvYqzSXA9i8euh10Yex7z7XTEWW4+/hShYgq/QUAcwQ37duXxQig4XqGz5k+HOS/AOxUDHAqd1C+oKWPJjK5kmn4o=
X-Received: by 2002:a19:c6d6:: with SMTP id w205mr19239799lff.17.1573593337898;
 Tue, 12 Nov 2019 13:15:37 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4M_AVk=2cZJ4LQ8QdnNa=6se4bCLkBPLFY5qR=ECpaq7ZKg@mail.gmail.com>
 <9d854335-366a-0b7f-1985-5e1d3245d33a@pengutronix.de> <20191111183912.GA7051@x1>
 <e61a86f9-c201-458c-2522-a8044e93bc08@pengutronix.de> <20191112064624.GA13873@x1>
 <8557f946-bb99-5ff8-5651-91757dc958ba@pengutronix.de> <CAEf4M_CbSPS-HrOi_LcFm_SW50o6wH0pu17iKBQCA4dV9oDp-g@mail.gmail.com>
In-Reply-To: <CAEf4M_CbSPS-HrOi_LcFm_SW50o6wH0pu17iKBQCA4dV9oDp-g@mail.gmail.com>
From:   Drew Fustini <pdp7pdp7@gmail.com>
Date:   Tue, 12 Nov 2019 13:15:26 -0800
Message-ID: <CAEf4M_B-ChHseDWkRLJKxF-sCrNXe8gCoGO32kZnkQfYXGMByA@mail.gmail.com>
Subject: Re: mcp251x: read oscillator frequency?
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>, mark@battlesnake.co.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Nov 12, 2019 at 1:01 PM Drew Fustini <pdp7pdp7@gmail.com> wrote:
> I based the overlay I was using one a MCP2515 overlay for SPI0 on
> BeagleBone Black:
> https://github.com/battlesnake/beaglebone-spi0-mcp2515/blob/master/MCP2515.dts
>
> I'm not sure where those extra "mcp251x," properties come from since
> the driver does not appear to use them at all.

I searched for "mcp251x,oscillator-frequency" on google and found this
old patch by Alessandro Zummo <a.zummo@towertech.it>:
https://github.com/beagleboard/meta-beagleboard/blob/master/common-bsp/recipes-kernel/linux/linux-mainline-3.8/net/0006-mcp251x-add-device-tree-support.patch

It does read some of those properties:
+ of_property_read_u32(np, "mcp251x,oscillator-frequency", &tmp);
+ pd->stay_awake = of_property_read_bool(np, "mcp251x,stay-awake");
+ pd->enable_clkout = of_property_read_bool(np, "mcp251x,enable-clkout");

Maybe there are people using this out of tree patch still and
therefore including those properties like Mark K Cowan did in:
https://github.com/beagleboard/bb.org-overlays/blob/master/src/arm/MCP2515-SPI0.dts

Thanks,
Drew
