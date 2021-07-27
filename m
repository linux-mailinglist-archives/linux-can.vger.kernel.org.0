Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22C53D71B6
	for <lists+linux-can@lfdr.de>; Tue, 27 Jul 2021 11:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbhG0JKI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Jul 2021 05:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbhG0JKI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Jul 2021 05:10:08 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73138C061757
        for <linux-can@vger.kernel.org>; Tue, 27 Jul 2021 02:10:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so3167831pja.5
        for <linux-can@vger.kernel.org>; Tue, 27 Jul 2021 02:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xi05432Q5BhtATujxnSmpf2TEH+sznzYo3YfD45A+VU=;
        b=VmLDfeg5UkUrnapp8wPeMVTYEE4sn5AZ5KJKRREkHewK+JhKVZzPhi5s6IIF1L2b2M
         D9KHOSSrN+CDBQ7D+N0suBqgL9Qinp2cpu5Wtj0ToeMKECuiUrCZDQOOLxE3QkLaAspW
         LXwW2TY5wfwJqnmsQiOG9MtPRznkJabIvqTAn9ZL3YdMy4Wg0aRoeRDSfqC6/SAdIepq
         /3AmbJy31lKJbcIdOnfebAvyoQQBFnJjNlmxv0HiHkx3h0mdGYDOz0agkJyUfcGqyf2N
         R+hpsVKuxHumNR2P1Hj3aqmGaMgLneEnvBKBPMiqmK6IpbpayjqpwB8xanloiOcVp4pG
         Eotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xi05432Q5BhtATujxnSmpf2TEH+sznzYo3YfD45A+VU=;
        b=fwcLPM3+ITuNRzh8zERtAWmCSwpFpw7qnua1v73SaqXu9Y73f6Odcz4Kf3Okv7NE2I
         ZRigAfPXMvUzaTCHz+fESwDxPUVlehYfUWxkOtg6dKWI/ITbXTGs7xfNfBzRcvNK7Kx7
         FNwgyTeJgxnmRrJI5qM/j2pfnuHp4RIls07YZZP9cHuYZ4TJM0rix/LptBstniPfAxTi
         FfW85qlwsPhiovYnBHWGdnoTq40XtsHDAGIXFry5Bo4I01PW4a8f7v3AFE/j+BZz5Uu0
         LDX5bcMawEcSiODT1SlxG3E0pKHrGuDz/rJFN+TYtif7BXkjviW/dumykg86k0d+0Oo0
         J/TQ==
X-Gm-Message-State: AOAM533H96woanVDNDcR2rzSyc/IzGTPi02YBEISs/KT45hbcm6THpEV
        HgfZtb1WlZdtdimhAhxVXosFmIVsWU5MmuY=
X-Google-Smtp-Source: ABdhPJwU5ki6JHIdMeRbqQ60ELhp5FQFW0w0FI3v+O9Sq6441oQwfdrpYG4PISH0lsE7BW4Be7545Q==
X-Received: by 2002:a17:90a:1302:: with SMTP id h2mr402130pja.15.1627377007755;
        Tue, 27 Jul 2021 02:10:07 -0700 (PDT)
Received: from thinkpad ([2409:4072:404:9e26:4427:70e5:216c:501f])
        by smtp.gmail.com with ESMTPSA id c136sm2770734pfc.53.2021.07.27.02.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:10:07 -0700 (PDT)
Date:   Tue, 27 Jul 2021 14:40:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>
Subject: Re: [PATCH] can: mcp251xfd: mcp251xfd_open(): request IRQ as shared
Message-ID: <20210727091003.GC33931@thinkpad>
References: <20210724205212.737328-1-mkl@pengutronix.de>
 <20210727071717.GA33931@thinkpad>
 <20210727074617.6tsjtlxmmvsmtfvc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727074617.6tsjtlxmmvsmtfvc@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, Jul 27, 2021 at 09:46:17AM +0200, Marc Kleine-Budde wrote:
> On 27.07.2021 12:47:17, Manivannan Sadhasivam wrote:
> > On Sat, Jul 24, 2021 at 10:52:13PM +0200, Marc Kleine-Budde wrote:
> > > The driver's IRQ handler supports shared IRQs, so request a shared IRQ
> > > handler.
> > 
> > I don't see any issue with the idea but I'd like to understand the
> > requirement for it.
> 
> Hardware designers might come up with strange ideas, so better be
> prepared for this. :)
> 
> But seriously, there's a group of people trying to bring the mcp251xfd
> driver to work on ACPI based systems. Having a shared mcp251xfd IRQ
> handler will (hopefully) help them during debugging.
> 

Oh, that's very interesting! ACPI on a ECU :)

> I've written the IRQ handler to properly only return IRQ_HANDLED if
> there really was an interrupt, this means it should be capable running
> as a shared IRQ handler. I've tested it and it works. So let the driver
> request a shared IRQ handler.
> 

I had one more look at it and looks fine to me. The driver authors tend to
return IRQ_HANDLED even during error cases (especially for devices sitting on
buses like i2c, spi) but I hate it. Why would anyone want to enable the
interrupt for the device if it can't be communicated in the ISR?

But you did return IRQ_NONE for error cases, so fine.

> > Usually the IRQ lines are shared when multiple devices use them
> > physically. For instance, a MFD device using a single GPIO for all of its
> > functions. But I don't see any sort of requirement like that here.
> 
> Indeed there is really no good reason to do so, but it works. For
> testing I've connected 2 mcp2518fd to the same IRQ line and the kernel
> runs both IRQ handlers an interrupt is triggered. If course this brings
> the overhead of an additional SPI transfer per IRQ, but it works.
> 
> > Making the IRQ lines shared will only induce latency IMO.
> 
> ACK - you will not get better performance compared to separate IRQ lines
> :) But if you don't use shared interrupts this change doesn't make the
> driver or system any slower or induce latency.
> 

Ack. Feel free to add,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


