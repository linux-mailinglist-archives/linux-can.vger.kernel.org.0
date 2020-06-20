Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EF1201FDC
	for <lists+linux-can@lfdr.de>; Sat, 20 Jun 2020 04:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbgFTCoB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Jun 2020 22:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgFTCoB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Jun 2020 22:44:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E841BC06174E
        for <linux-can@vger.kernel.org>; Fri, 19 Jun 2020 19:44:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d8so4757347plo.12
        for <linux-can@vger.kernel.org>; Fri, 19 Jun 2020 19:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FLWT276u2aO9qAHRs8E3h1+NnyUeXGvQciwY1qNzilY=;
        b=St45XTuKxoL4qMh9JNrnVKhDLmDM/4iTL6bjKrYy6QLHEttboehyDjG/4XA+Gsf0G8
         /FxzQPFCADOTO4HhEohMQFuErk9XKheVZxB0wabwPgFl8XhHeVJmWC+O80H6XV+9I5y9
         fN11ubcOXio/kR1AC7BNPDb6DObr/oVvnTiiLcPTIAB7ixfyTnPaqAlZTu72XIBJEp+O
         LYwzPMmErpNCUiEcmHaLOCZReZEhoe7hfTcBOAAip/9v8I0NTKU2b76BUe8L88yaCoiN
         RYtUhjLps0ByxhH9miMu9OUZd+OgSyjvwtMNp1bikf8oYlYWQKFyZIKS1WiB7QB+k3sm
         n7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FLWT276u2aO9qAHRs8E3h1+NnyUeXGvQciwY1qNzilY=;
        b=K0qwH++Zzd+dyDV5P09Kn/I3wIEds2WOMIOkD7cVEuL4UJt1M4WS7G4kLSLzPLUyTI
         ScXrM0A/Xi4csqtC35y182Y6YNmGYrvXPE5pGodfXFMm/2TEjUANk5O02v6lERxiQ2NH
         GALbxQlTv2/SvRTGxcPvFgyDD27Stz1QoELwEBqGmP28HudsodIrCo5QEv+5d7gRG8Ja
         WdsUfLFUrb8A2mYdZSEKwr+l3MEKhqhR1fNamnojusOJm85bPefnXXSGLGNMHylvOJt0
         bL5P844wT5mNg5AYtZ9mNFro536dnN4N89troSNBxTRMiC3mLnzlBbsOS1hgpmUIp7+y
         woOw==
X-Gm-Message-State: AOAM533cBPay8zkI6NbOXXtsRjbd+Kw3scdd0ZPzOP/HsnppgV+q9Gg1
        G5sFAVrZNi1l/hLo0RednpPH
X-Google-Smtp-Source: ABdhPJz6e7aQ/jZVXcpBHCTWXtwI2uKAN2v8I1+qswnVkdxua9YKvO35sIeZLTi24n5yfLWTxU4m7g==
X-Received: by 2002:a17:902:7b90:: with SMTP id w16mr10287749pll.339.1592621040019;
        Fri, 19 Jun 2020 19:44:00 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:629d:f5bf:4d81:efb6:335e:3953])
        by smtp.gmail.com with ESMTPSA id w10sm6113168pgm.70.2020.06.19.19.43.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jun 2020 19:43:59 -0700 (PDT)
Date:   Sat, 20 Jun 2020 08:13:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     wg@grandegger.com, kernel@martin.sperl.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Message-ID: <20200620024351.GA18455@Mani-XPS-13-9360>
References: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
 <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
 <20200618085533.GA26093@mani>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618085533.GA26093@mani>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Jun 18, 2020 at 02:25:33PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> On 0611, Marc Kleine-Budde wrote:
> > On 6/10/20 9:44 AM, Manivannan Sadhasivam wrote:
> > > Hello,
> > > 
> > > This series adds CAN network driver support for Microchip MCP25XXFD CAN
> > > Controller with MCP2517FD as the target controller version. This series is
> > > mostly inspired (or taken) from the previous iterations posted by Martin Sperl.
> > > I've trimmed down the parts which are not necessary for the initial version
> > > to ease review. Still the series is relatively huge but I hope to get some
> > > reviews (post -rcX ofc!).
> > > 
> > > Link to the origial series posted by Martin:
> > > https://www.spinics.net/lists/devicetree/msg284462.html
> > > 
> > > I've not changed the functionality much but done some considerable amount of
> > > cleanups and also preserved the authorship of Martin for all the patches he has
> > > posted earlier. This series has been tested on 96Boards RB3 platform by myself
> > > and Martin has tested the previous version on Rpi3 with external MCP2517FD
> > > controller.
> > 
> > I initially started looking at Martin's driver and it was not using several
> > modern CAN driver infrastructures. I then posted some cleanup patches but Martin
> > was not working on the driver any more. Then I decided to rewrite the driver,
> > that is the one I'm hoping to mainline soon.
> > 
> 
> So how should we proceed from here? It is okay for me to work on adding some
> features and also fixing the issues you've reported so far. But I want to reach
> a consensus before moving forward.
> 
> If you think that it makes sense to go with your set of patches, then I need an
> estimate on when you'll post the first revision.
> 

Ping!

> > Can you give it a try?
> > 
> > https://github.com/marckleinebudde/linux/commits/v5.6-rpi/mcp25xxfd-20200607-41
> > 
> 
> Sure thing. Will do.
> 
> Thanks,
> Mani
> 
> > Marc
> > 
> > -- 
> > Pengutronix e.K.                 | Marc Kleine-Budde           |
> > Embedded Linux                   | https://www.pengutronix.de  |
> > Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> > Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
