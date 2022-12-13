Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB5664BAE1
	for <lists+linux-can@lfdr.de>; Tue, 13 Dec 2022 18:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiLMRTz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Dec 2022 12:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbiLMRTv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Dec 2022 12:19:51 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F9E22BF2
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2022 09:19:48 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so8438976wmb.2
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2022 09:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3EhMA6MMSu4b3D077MyxeOEBc3NixPe7QR4AlMv00C8=;
        b=6zr23JVIZwJKfOEfOAIHU80gTz21PGMoILrZJWuBVj2+3ReU+NUtdHX4lYRSlw1iwW
         nNXXjro6uxrP9zFiG//8W0znYdENXyWwpxDu6IhYzrvXx1vzyrcdPd8d6+PmR7DaypUJ
         YYGL287lOUoAR3Haq+2KREXNxFA/d1WQrc02txsK6LSDdFfXnQryWp9jeIW9vb+dBrCi
         LmfVJ7X5LuUmebgKkeT/2xIurygLi1VDF1c99nt7pRzyIVgUmEYweV96Nl+5froTqzPV
         sk5YEA3/M6KnNOWm8AhyadA3avXxB5P/BdzPILHThKNztUtZBW5ovpOc6kPKI9q6Guqi
         rKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EhMA6MMSu4b3D077MyxeOEBc3NixPe7QR4AlMv00C8=;
        b=GTdCk10lh2lsWiFxjmwS0J2bq1sO076Kp1iBC6jUzqhouOIWPlq75hs8wGgb72khes
         8W9XRocCb82wYZMEsfBwn2WGn0R+m57aSHWfhc/M75MEn40CjuM8DTimjdLJ8VmKqL3r
         vtXE4UHzFtqseiS7gQ4cUOk6uXpxyV9IU7zfAT464PF9cL7BMJTMrR60wpOmi5ZtlWoG
         rj80Vn4JCsqihrgb/jqWtZHFeqX87oPU7mfYOqtVeSOmsAXGH1FvxSx9JMhCh8Y8Op7F
         t6Uh8P9fOrQqgtybYIiURtFxT2x2o2kphNwh6BHy42thZZK5e+wPcoeMoh9CVYlQ8PR/
         D4LA==
X-Gm-Message-State: ANoB5pmbNuB7I0a3D6cOoKzk387iSKKdiypMqIOAj0Pa10UvY8+H8BZH
        3aX/xq7X/2OM/46drdgbHGeQgw==
X-Google-Smtp-Source: AA0mqf6HuubEdSO6ViNbsmRGhbOFKBkYZ1FySXG5n3yoR1Uww9vgN0+1tuohDwdiPwnjF6shxTfySA==
X-Received: by 2002:a05:600c:3acc:b0:3cf:9ac8:c537 with SMTP id d12-20020a05600c3acc00b003cf9ac8c537mr16411148wms.14.1670951987318;
        Tue, 13 Dec 2022 09:19:47 -0800 (PST)
Received: from blmsp ([2001:4091:a245:805c:8713:84e4:2a9e:cbe8])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c22d200b003c6bd12ac27sm13255188wmg.37.2022.12.13.09.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:19:46 -0800 (PST)
Date:   Tue, 13 Dec 2022 18:19:46 +0100
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] can: m_can: Use transmit event FIFO watermark
 level interrupt
Message-ID: <20221213171946.ejrb2glgo77jueff@blmsp>
References: <20221116205308.2996556-1-msp@baylibre.com>
 <20221116205308.2996556-5-msp@baylibre.com>
 <20221130171715.nujptzwnut7silbm@pengutronix.de>
 <20221201082521.3tqevaygz4nhw52u@blmsp>
 <20221201090508.jh5iymwmhs3orb2v@pengutronix.de>
 <20221201101220.r63fvussavailwh5@blmsp>
 <20221201110033.r7hnvpw6fp2fquni@pengutronix.de>
 <20221201165951.5a4srb7zjrsdr3vd@blmsp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221201165951.5a4srb7zjrsdr3vd@blmsp>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Thu, Dec 01, 2022 at 05:59:53PM +0100, Markus Schneider-Pargmann wrote:
> On Thu, Dec 01, 2022 at 12:00:33PM +0100, Marc Kleine-Budde wrote:
> > On 01.12.2022 11:12:20, Markus Schneider-Pargmann wrote:
> > > > > For the upcoming receive side patch I already added a hrtimer. I may try
> > > > > to use the same timer for both directions as it is going to do the exact
> > > > > same thing in both cases (call the interrupt routine). Of course that
> > > > > depends on the details of the coalescing support. Any objections on
> > > > > that?
> > > > 
> > > > For the mcp251xfd I implemented the RX and TX coalescing independent of
> > > > each other and made it configurable via ethtool's IRQ coalescing
> > > > options.
> > > > 
> > > > The hardware doesn't support any timeouts and only FIFO not empty, FIFO
> > > > half full and FIFO full IRQs and the on chip RAM for mailboxes is rather
> > > > limited. I think the mcan core has the same limitations.
> > > 
> > > Yes and no, the mcan core provides watermark levels so it has more
> > > options, but there is no hardware timer as well (at least I didn't see
> > > anything usable).
> > 
> > Are there any limitations to the water mark level?
> 
> Anything specific? I can't really see any limitation. You can set the
> watermark between 1 and 32. I guess we could also always use it instead
> of the new-element interrupt, but I haven't tried that yet. That may
> simplify the code.

Just a quick comment here after trying this, I decided against it.
- I can't modify the watermark levels once the chip is active.
- Using interrupt (un)masking I can change the behavior for tx and rx
  with a single register write instead of two to the two fifo
  configuration registers.

You will see this in the second part of the series then.

Best,
Markus
