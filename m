Return-Path: <linux-can+bounces-1164-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B03194A702
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 13:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3725428142E
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 11:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4592D1E486A;
	Wed,  7 Aug 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RtnxBuOw"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C931DF68A
	for <linux-can@vger.kernel.org>; Wed,  7 Aug 2024 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723030419; cv=none; b=m9iltdjRbLAofjgxn3eLHUy53abjA4HKCXJkmdX6W09fQYOMxcUohc9mBYYh3hi7EwLv+0hxjdGsF8YNYX2V5hprzreH3t1BIOeEj5MrAIxzzUy1B6zM4qfWexi9rBms14R1mxxi6Np/rerp0vOEIKz+2kSaD0HFCdT/10iVoiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723030419; c=relaxed/simple;
	bh=6pVRo0NUIjztrkGDxcisHgjwv+iwRhqOaOeG8t2h/1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9Z2qXaZUEtq/p70IoxZvwEb56iy17k2TaBuLcehiaCco/MIs1Vs4ULvIkX02uhW3OJLwWXQ4mi0ueVCZ0LigWbQNA0CUJlosPQV1kd0If11L6XBCifVyMSPXSbJ9styKx1xzXfDnoYCZ9ON3zlHYzcVT9s+CmMoreV9y5MhFQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RtnxBuOw; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-81fd1e1d38bso82297039f.1
        for <linux-can@vger.kernel.org>; Wed, 07 Aug 2024 04:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723030415; x=1723635215; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TO3M4/b2w+N5GFX+bWSuliwBhXhBbHQ7fK/88QYJzvU=;
        b=RtnxBuOwKSQ8QJa+7RwRm8/mRI/irYbrAoi3Xed4p+bOXPKDiwFcyFh0st8cedG7UM
         XiZpbyIdUNMSkG7QpMOY+Nb3XrKnz/ZeNljA2iUMdLUriofX/kuFXfkWTZcbhXQFyObR
         ijVKov8BVYY9sWX9sWOUxXdy0GDk90xgugkGF3tjIB9qTA1uYVq3D/y87O+Bpd93qQeL
         LuRd1B19CJuyScU1J7GHejQ02hqEg8oQ6MwG+INlTn4Z6tBONqSlB2zJ+Uz3xuxQoJns
         fj5ymwfhdmgZcMYCN5n6JRCmHMc8vq2Nql9qB0zncymqLmp6wAnnxCr0fiGFCFYvdw7r
         kWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723030415; x=1723635215;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TO3M4/b2w+N5GFX+bWSuliwBhXhBbHQ7fK/88QYJzvU=;
        b=nOXR/kb5LFwGimgkr8baSVbr1ug7JzwyAo0VN2tuXXUnIr6RJmQHYR76GSSUIrdChD
         EGIZi0Gpp3RdfFbPTUxZwio0eke2Ss5Y/43BBNzsE1scWHqZwqHeLBk8DwdFa4bjykh4
         PSG12gaKlEjoOAvOQRPDtS8yTikYFTdeLPjmaGP8OFf8tVXEUMqXmOlDFw30XbLi4/UJ
         TnA1jNfiznYdNMezWYJslThR/icT5lwSNc3ilUs3Wh3N2tfNr6cdaF9GZj7i1ZUCAMte
         Ai2x6rhZfkOFx9vks7pEJPCgtqZaZpwmmECjv9IihEp5GJytukVIsYbak5RtCcOm+Zr/
         g0dA==
X-Forwarded-Encrypted: i=1; AJvYcCUsy5ocrSQPANRQmp5XJdeyYFuPlSKXTK/nOBVUkCN5wAGMW72GHkM5B5mCbDi4nocqf9M7bpICBroVLxLRGtwS+/EHG8E+KIg2
X-Gm-Message-State: AOJu0YxBQjoJEb4BM6nKIs81G3MBZaF18r0I650Irb9b4YydcdIbmdPB
	Iiogel7CKLjgJyvZh+SJNdB2ScEP4cSGX+2tOpGD2Z1UImAj09kbcIoWHyJxMcM=
X-Google-Smtp-Source: AGHT+IHGPYq6U63wYkXW5Ao1UYJo9K2LfIkWxE28uBk35YalI9BIp4WaXcnBvcyG5BZbzaCfz3g7fQ==
X-Received: by 2002:a05:6602:641f:b0:7f7:e273:a97d with SMTP id ca18e2360f4ac-81fd437a1d5mr2224546739f.9.1723030414710;
        Wed, 07 Aug 2024 04:33:34 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d69878b1sm2690261173.2.2024.08.07.04.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:33:34 -0700 (PDT)
Date: Wed, 7 Aug 2024 13:33:30 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Linux regression tracking <regressions@leemhuis.info>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S.Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, 
	Judith Mendez <jm@ti.com>, Tony Lindgren <tony@atomide.com>, 
	Simon Horman <horms@kernel.org>, linux@ew.tq-group.com
Subject: Re: [PATCH v2 0/7] can: m_can: Fix polling and other issues
Message-ID: <a3inpbruecwescx4imfzy4s5oaqywvzblhk75chkyyrhujflxr@vdbbf6jtxwso>
References: <20240805183047.305630-1-msp@baylibre.com>
 <ab4b649b32ca9a1287e5d1dc3629557975b7152f.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab4b649b32ca9a1287e5d1dc3629557975b7152f.camel@ew.tq-group.com>

On Wed, Aug 07, 2024 at 10:10:56AM GMT, Matthias Schiffer wrote:
> On Mon, 2024-08-05 at 20:30 +0200, Markus Schneider-Pargmann wrote:
> > Hi everyone,
> > 
> > these are a number of fixes for m_can that fix polling mode and some
> > other issues that I saw while working on the code.
> > 
> > Any testing and review is appreciated.
> 
> Hi Markus,
> 
> thanks for the series. I gave it a quick spin on the interrupt-less AM62x CAN, and found that it
> fixes the deadlock I reported and makes CAN usable again.
> 
> For the whole series:
> 
> Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> 

Great, thanks for testing!

> 
> 
> 
> > 
> > Base
> > ----
> > v6.11-rc1
> > 
> > Changes in v2
> > -------------
> >  - Fixed one multiline comment
> >  - Rebased to v6.11-rc1
> > 
> > Previous versions
> > -----------------
> >  v1: https://lore.kernel.org/lkml/20240726195944.2414812-1-msp@baylibre.com/
> > 
> > Best,
> > Markus
> > 
> > Markus Schneider-Pargmann (7):
> >   can: m_can: Reset coalescing during suspend/resume
> >   can: m_can: Remove coalesing disable in isr during suspend
> >   can: m_can: Remove m_can_rx_peripheral indirection
> >   can: m_can: Do not cancel timer from within timer
> >   can: m_can: disable_all_interrupts, not clear active_interrupts
> >   can: m_can: Reset cached active_interrupts on start
> >   can: m_can: Limit coalescing to peripheral instances
> > 
> >  drivers/net/can/m_can/m_can.c | 111 ++++++++++++++++++++--------------
> >  1 file changed, 66 insertions(+), 45 deletions(-)
> > 
> 
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> https://www.tq-group.com/

