Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C22FD21E
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2019 02:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKOA7z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Nov 2019 19:59:55 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:46225 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKOA7z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Nov 2019 19:59:55 -0500
Received: by mail-pl1-f170.google.com with SMTP id l4so3472726plt.13
        for <linux-can@vger.kernel.org>; Thu, 14 Nov 2019 16:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fRbN5JCm5bE0QcTI7Tzwl8jRQG49Z2jUjWQ1xbN2uQY=;
        b=WQYgd2Jsi5SeeSKl3l0wKia1oSx1RjYvJPcMfX06zPLIK1WW5v9LtUXdZXpQrvF8GG
         4jB0vf7yZMHHCbQw+BP5xiiyWDQUb8qfBcE1NBss4BHsD/7Xw1HMHSAsWHbVCj8O5qgz
         AFfQXLRDd7TtAOKRjUwGebavBBrFYZPyjvLNyeBvpW31xAlL609bZIfgNotvqO1T3iQj
         QAj5MlPZ+1XXw1Y15xlheMqPqsjVuwSTeYR9hrT/tLTQv0J0VldUg0G7DEcTMNSnY12e
         AAHvjmYjuQCXY25rwqkqq7x5Z2RbvuaRHsb7Mfnm0RE8FXtWTNa0+cKzgZ21sxBUw5in
         jvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fRbN5JCm5bE0QcTI7Tzwl8jRQG49Z2jUjWQ1xbN2uQY=;
        b=Jna0otPKM3Z7kCuxubUHPPT3eWEqwrN+MtYPC8t9jCwEFOMTNkSnfDbRMcUWiYAc1l
         Nr6z5z44LgUXTITxMqy6bDw9VrzVoyr6nKVE9psQaCD2wRzE7ArWVcXNfzHJAGbqwo9P
         9gRWndfG2Z59L005y5XRClT1FZRmMflFBm/5f8WUkwsROdhvO+PZdjsUIFi1e+Fl6fR9
         Q7DXDhKpWFjgqf9lici5gDmfs6yvb13b+LDUgC2Ry4Ey8btRw/vaENFWSEqNn4sqXK/8
         u44ZlTgzJiAHpHN46dP7LhtQwKlVRgnwMuHBP35D0mw1McWIxD1YCR+KefJwV0m3i9Us
         QKtw==
X-Gm-Message-State: APjAAAU70LHNfEurKlphiMmifaikEa/hzSbEChbWfhC0EYA6y4Ch4QYy
        SO3TJIagbY133D7LN6bsgBM=
X-Google-Smtp-Source: APXvYqwWBh7mtWYHkGG4Xa6qm0ECKbB6RCUbTI7LjSxtWCllmSOhTBkqq1qIv0gAoIyNvg9De57ofg==
X-Received: by 2002:a17:902:9305:: with SMTP id bc5mr12658264plb.238.1573779594376;
        Thu, 14 Nov 2019 16:59:54 -0800 (PST)
Received: from x1 ([2602:41:6630:600:126:f04:dc48:e148])
        by smtp.gmail.com with ESMTPSA id k2sm6653366pjl.5.2019.11.14.16.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 16:59:52 -0800 (PST)
Date:   Thu, 14 Nov 2019 16:59:53 -0800
From:   Drew Fustini <drew@pdp7.com>
To:     Mark Kuckian Cowan <mark@battlesnake.co.uk>
Cc:     "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        Drew Fustini <pdp7pdp7@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: mcp251x: read oscillator frequency?
Message-ID: <20191115005953.GA9973@x1>
References: <CAEf4M_AVk=2cZJ4LQ8QdnNa=6se4bCLkBPLFY5qR=ECpaq7ZKg@mail.gmail.com>
 <9d854335-366a-0b7f-1985-5e1d3245d33a@pengutronix.de>
 <20191111183912.GA7051@x1>
 <e61a86f9-c201-458c-2522-a8044e93bc08@pengutronix.de>
 <20191112064624.GA13873@x1>
 <8557f946-bb99-5ff8-5651-91757dc958ba@pengutronix.de>
 <CAEf4M_CbSPS-HrOi_LcFm_SW50o6wH0pu17iKBQCA4dV9oDp-g@mail.gmail.com>
 <CAEf4M_B-ChHseDWkRLJKxF-sCrNXe8gCoGO32kZnkQfYXGMByA@mail.gmail.com>
 <20191113091923.GA32742@smile.fi.intel.com>
 <CAJQL7_o+it9HhKAOfcraD5Jk_+OdMq-rS0JhV_=cUXvm1-LdBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJQL7_o+it9HhKAOfcraD5Jk_+OdMq-rS0JhV_=cUXvm1-LdBg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Nov 13, 2019 at 11:42:39AM +0200, Mark Kuckian Cowan wrote:
> The out-of-tree DTS in question was developed quickly and lazily for
> getting CAN working on a prototype, where the MCU's built-in CAN had
> not been routed correctly (so I added an MCP251x via SPI for testing).
> It was a one-off fix for a problem that no longer exists, for hardware
> which no longer exists.  Probably not the best approach to fix the
> problem either.
> 
> I shared the DTS to help others at the time who might be using the
> same part with similar kernel versions (~4.9?) and out-of-tree mcp2515
> driver.
> There is an driver available in-tree, with documentation of DTS
> properties at linux://Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
> 
> I don't care about that out-of-tree MCP2515 DTS any more, the kernel
> developers certainly shouldn't care about it, and neither should
> anyone else.
> 
> -- Mark Kuckian Cowan
> 
> On Wed, 13 Nov 2019 at 11:19, andriy.shevchenko@intel.com
> <andriy.shevchenko@intel.com> wrote:
> > First of all, there are rules (which are getting stricter all the time) about
> > property names and use in DT. Second, no one cares about out-of-tree
> > customizations. In kernel we consider no regression made if we introduce
> > properties that are not compatible with no-one-knows DTSes (it didn't work
> > with older kernel, it continue not working with new — status quo).
> >
> > --
> > With Best Regards,
> > Andy Shevchenko

Thanks for your insights, Andy and Mark.

Mark - sorry to drag you into this.  Thank you for sharing that DTS as it helped
me out a lot in figuring out what I needed to get it working on the PocketBeagle.
I should have looked the official mcp251x bindings before I assumed those "mcp251x," 
properties were being used by the driver.

thanks,
drew
