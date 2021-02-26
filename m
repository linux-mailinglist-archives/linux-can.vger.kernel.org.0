Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A8532636F
	for <lists+linux-can@lfdr.de>; Fri, 26 Feb 2021 14:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBZNhr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Feb 2021 08:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhBZNhp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Feb 2021 08:37:45 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C313C061574
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 05:37:05 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b18so2127071wrn.6
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 05:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UDVQ/kAq9g/xrNZgAl52BzOUhtxxFpWG9F40U1g8z0Q=;
        b=dra4UqH8PHX6c3jnduAGeRepHQqHuXJf+kFY22pJ+RTSOMIE0zQIFUz8KkwrMSM3jP
         IiupI30nRnnw45KSpPD49huGCItBJffYZ6mOaWoOIWvrtJXCjzqaKYT/0OhR2GrN7Cyv
         I7dCYTyS+LbmCxQ4Op7Z8GLOC3HCibKYC2ruYWzb8QgraZx3rfwtuap5ab8ngPieJPiP
         jrSwAXB687RGSP08bzXz689svq97iXYg8DQt5xmX0TAFNjGfiF/oAlvlOq5vMFh82K0H
         diT2k6YqMJQk+3zzSFkMrEzoIqesl1GUu77wOgzmLs35f3aDpXn2ECDtAQaJSveUnEcE
         OLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UDVQ/kAq9g/xrNZgAl52BzOUhtxxFpWG9F40U1g8z0Q=;
        b=poq0dMKoo/L8oBHGO9Sj7clu64lIwJa6EftodoLh8CxiSWaSjrgXzYKyCUtam8z0EC
         wZaecLePSHkbLjrSqVo7gAzBGGC9qkYohElbTGkN4sn0jqY452PvCmw2CqfWrf63lQr6
         zNtSQo1llwFmf8hsS/BuwZqYbYEsl/GulJ75S3DatnKEkTrPXLhsPrjiLapzrAHqD6Eh
         fEmzyO9RpXc73IgzneWhtTVWqt92etgh/iSf39ibCQcq3fF7OIuQ5lpP0B0q93ZXUXZS
         UcckGre9alP+SrdNGEN+IA0qk2WmlNnVPWvDWReVkOXkCgwQuxo5aXbBWXSy5wgPqF66
         GE4A==
X-Gm-Message-State: AOAM5311rON8ilNbvkDsbb1T9MENpowO6XFWv6fc9qHu4nUBttZvVhNK
        YICL4w2i+25TtRkuuTsX1uOsQQ==
X-Google-Smtp-Source: ABdhPJx7BgInSSi8rzl0c/JYR2f+Tw1Db3LCOWuJGcQCziw4VAKfSt+H6rs9+vC1xx9JXGS+RfCTYw==
X-Received: by 2002:a5d:6b85:: with SMTP id n5mr3345293wrx.16.1614346624196;
        Fri, 26 Feb 2021 05:37:04 -0800 (PST)
Received: from bigthink (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id t23sm12493767wmn.13.2021.02.26.05.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 05:37:03 -0800 (PST)
Date:   Fri, 26 Feb 2021 13:37:02 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Mariusz Madej <Mariusz.Madej@xtrack.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>
Subject: Re: m_can: a lot of 'Rx FIFO 0 Message Lost' in dmesg
Message-ID: <20210226133702.echxlob5z4pj5ptc@bigthink>
References: <PR3PR05MB7212376CDA795770B7E625E6809F9@PR3PR05MB7212.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR3PR05MB7212376CDA795770B7E625E6809F9@PR3PR05MB7212.eurprd05.prod.outlook.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Feb 24, 2021 at 02:27:28PM +0000, Mariusz Madej wrote:
> 
> Hi,
> 
> I have a problem with m_can controller in my sama5d2 processor.
> Under heavy can traffic it happens that my device starts to report (dmesg):
> 
> [   77.610000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
> [   77.620000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
> [   77.630000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
> [   77.630000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
> [   77.640000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
> [   77.640000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
> [   77.650000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
> [   77.660000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
> [   77.660000] m_can_platform f8054000.can can0: Rx FIFO 0 Message Lost
> 
> what causes large load problem in my system.

How heavy is this traffic? Is the bus operating at a very high bitrate?
Are there any other useful lines in dmesg?

> The only place in m_can.c file, where interrupt register is cleared is function
> called when interrupt arrives
> 
> static irqreturn_t m_can_isr(int irq, void *dev_id)
> {
> .
> .
>         /* ACK all irqs */
>         if (ir & IR_ALL_INT)
>                 m_can_write(cdev, M_CAN_IR, ir);
> .
> .
> }
> 
> But when we enter 'NAPI mode' in heavy load we are never get to this function
> until load gets lower and interrupts are enabled again. In this situation,
> this code:

The m_can driver handles the IRQ by offloading the RX to a NAPI queue,
so the RX procedure is deferred, and is scheduled to happen at a
(slightly) later time. As far as I understand it, interrupts are not
disabled at any point.

> That is why we got so many messages in a row for so long time. So clearing
> RXFS_RFL bit after warning is issued could be a solution.

RXFS_RFL is a flag in a status register, not an interrupt flag. There is
a corresponding interrupt flag, but that is cleared along with the rest,
at the top of m_can_isr.

I think you are losing messages because the traffic is too heavy for
your system to read out the messages fast enough. That is the usual
reason for seeing "Rx FIFO 0 Message Lost".

--
Regards,

Torin Cooper-Bennun
Software Engineer  | maxiluxsystems.com

