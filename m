Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18B0AFAD97
	for <lists+linux-can@lfdr.de>; Wed, 13 Nov 2019 10:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfKMJun convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 13 Nov 2019 04:50:43 -0500
Received: from p3plsmtp21-02-2.prod.phx3.secureserver.net ([68.178.252.48]:39305
        "EHLO p3plwbeout21-02.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfKMJun (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 13 Nov 2019 04:50:43 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2019 04:50:43 EST
Received: from mta2.hi.local ([80.90.192.26])
        by :WBEOUT: with ESMTP
        id UpAqiCo1mZbZUUpArilpr0; Wed, 13 Nov 2019 02:42:54 -0700
X-SID:  UpAqiCo1mZbZU
Received: from mail-vs1-f46.google.com ([209.85.217.46])
        by mta2.hi.local with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <mark@battlesnake.co.uk>)
        id 1iUpAq-0006lD-6g
        for linux-can@vger.kernel.org; Wed, 13 Nov 2019 09:42:52 +0000
Received: by mail-vs1-f46.google.com with SMTP id m6so899185vsn.13
        for <linux-can@vger.kernel.org>; Wed, 13 Nov 2019 01:42:52 -0800 (PST)
X-Gm-Message-State: APjAAAU3pwIvDiFIAFv7NbucpgjCnYdW7rWc4W8kWWJ4VPV5xExXZgIH
        wBep+dXJN2+XUhSr297r4OBtOlJUwfULceICNOw=
X-Google-Smtp-Source: APXvYqwWEXE+bF3+XqJWDwCjgw/M2F6sGq8oqRbSVK1hsHFGSgxkMGlzEI8Zz4mCuwQqa9MpOQyuULyZ3r7JY68bTEA=
X-Received: by 2002:a67:e410:: with SMTP id d16mr1162762vsf.209.1573638171001;
 Wed, 13 Nov 2019 01:42:51 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4M_AVk=2cZJ4LQ8QdnNa=6se4bCLkBPLFY5qR=ECpaq7ZKg@mail.gmail.com>
 <9d854335-366a-0b7f-1985-5e1d3245d33a@pengutronix.de> <20191111183912.GA7051@x1>
 <e61a86f9-c201-458c-2522-a8044e93bc08@pengutronix.de> <20191112064624.GA13873@x1>
 <8557f946-bb99-5ff8-5651-91757dc958ba@pengutronix.de> <CAEf4M_CbSPS-HrOi_LcFm_SW50o6wH0pu17iKBQCA4dV9oDp-g@mail.gmail.com>
 <CAEf4M_B-ChHseDWkRLJKxF-sCrNXe8gCoGO32kZnkQfYXGMByA@mail.gmail.com> <20191113091923.GA32742@smile.fi.intel.com>
In-Reply-To: <20191113091923.GA32742@smile.fi.intel.com>
From:   Mark Kuckian Cowan <mark@battlesnake.co.uk>
Date:   Wed, 13 Nov 2019 11:42:39 +0200
X-Gmail-Original-Message-ID: <CAJQL7_o+it9HhKAOfcraD5Jk_+OdMq-rS0JhV_=cUXvm1-LdBg@mail.gmail.com>
Message-ID: <CAJQL7_o+it9HhKAOfcraD5Jk_+OdMq-rS0JhV_=cUXvm1-LdBg@mail.gmail.com>
Subject: Re: mcp251x: read oscillator frequency?
To:     "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
Cc:     Drew Fustini <pdp7pdp7@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-SA-Score: 0.0
X-Heart-Authenticated: mark@battlesnake.co.uk
X-Originating-IP: 209.85.217.46
X-CMAE-Envelope: MS4wfJO5aQHaZkF0NgeVFzrU98Q3O9UbLz38gXksTFoIgmztxwHdwXYKx7SK74LUhic9bip2rYX6XbwqVvO4QoOb8eVv5YsicTMh2AwProl2xV+sUQ4BHUAr
 DlDnD+DV+3wqcqyofmepH8n4I5U7V0e01NxJ4V37X1Xk5rAmpcUMUamht5L5SZLQo/CdhcM53dvsvw==
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The out-of-tree DTS in question was developed quickly and lazily for
getting CAN working on a prototype, where the MCU's built-in CAN had
not been routed correctly (so I added an MCP251x via SPI for testing).
It was a one-off fix for a problem that no longer exists, for hardware
which no longer exists.  Probably not the best approach to fix the
problem either.

I shared the DTS to help others at the time who might be using the
same part with similar kernel versions (~4.9?) and out-of-tree mcp2515
driver.
There is an driver available in-tree, with documentation of DTS
properties at linux://Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt

I don't care about that out-of-tree MCP2515 DTS any more, the kernel
developers certainly shouldn't care about it, and neither should
anyone else.

-- Mark Kuckian Cowan

On Wed, 13 Nov 2019 at 11:19, andriy.shevchenko@intel.com
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Nov 12, 2019 at 01:15:26PM -0800, Drew Fustini wrote:
> > On Tue, Nov 12, 2019 at 1:01 PM Drew Fustini <pdp7pdp7@gmail.com> wrote:
> > > I based the overlay I was using one a MCP2515 overlay for SPI0 on
> > > BeagleBone Black:
> > > https://github.com/battlesnake/beaglebone-spi0-mcp2515/blob/master/MCP2515.dts
> > >
> > > I'm not sure where those extra "mcp251x," properties come from since
> > > the driver does not appear to use them at all.
> >
> > I searched for "mcp251x,oscillator-frequency" on google and found this
> > old patch by Alessandro Zummo <a.zummo@towertech.it>:
> > https://github.com/beagleboard/meta-beagleboard/blob/master/common-bsp/recipes-kernel/linux/linux-mainline-3.8/net/0006-mcp251x-add-device-tree-support.patch
> >
> > It does read some of those properties:
> > + of_property_read_u32(np, "mcp251x,oscillator-frequency", &tmp);
> > + pd->stay_awake = of_property_read_bool(np, "mcp251x,stay-awake");
> > + pd->enable_clkout = of_property_read_bool(np, "mcp251x,enable-clkout");
>
> > Maybe there are people using this out of tree patch still and
> > therefore including those properties like Mark K Cowan did in:
> > https://github.com/beagleboard/bb.org-overlays/blob/master/src/arm/MCP2515-SPI0.dts
>
> First of all, there are rules (which are getting stricter all the time) about
> property names and use in DT. Second, no one cares about out-of-tree
> customizations. In kernel we consider no regression made if we introduce
> properties that are not compatible with no-one-knows DTSes (it didn't work
> with older kernel, it continue not working with new — status quo).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
