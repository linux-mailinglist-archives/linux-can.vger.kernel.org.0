Return-Path: <linux-can+bounces-4244-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167C2B2655A
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 14:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F78D628872
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 12:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DDD2FD7CE;
	Thu, 14 Aug 2025 12:28:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7241F8BD6;
	Thu, 14 Aug 2025 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174529; cv=none; b=kpPjnK1PjlvfC65DVqvP6xw/5IhgnroNiIjVYFkvtXzI0TMcBR9/JI6ywf04SlTMTINCtb3QdW3z3K5AXW7mBxaTSabO5fEHVvSJarsFHAs4evLVB8Xy6u7NEMO0vUR27L/pg/mumRquFR1r5RYJOU27iO61Db8cnc10F1F0xSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174529; c=relaxed/simple;
	bh=QBOu//1MZrp/YChDDR6cXNrrWM9pk5OdZDjgVPQ5HfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCUOPbasO9s9n0ZNuBjUxA4AXm05dt1tEYzUv1Fcsx23CXSJmNOBAQAuwRd/aikZ0Gbe/rcV+nPTrGl6uX1kJnlyhy6sSC9QqJmyk5KNfBT3U8ShLwUJ0pUsJ7ejZG3mNLshYRPhTeK+Xx6IR5PceJ3fKzDWlIYNTTprzTbzBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-89019119eeeso517160241.3;
        Thu, 14 Aug 2025 05:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755174526; x=1755779326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vqN8ziP+CaJ6pZc8kPYTQ5seD3d677fvNr2+1W2ZV4=;
        b=IFBj6iLrCAL3hp2G8r9W4t/SjNPxDRRM1A9Tu8oEKAwloDDLug2Wf61mAF3PxW+b//
         nbdFOAEZdBEJAXMXRJ6lwSo20CimZpY68ECR7jQohO+AkZxcF4k3mQkcnf3pDJCoZhff
         5UrxEWsdkgqV62Cw+qCD5tk8huFhGYTQpDyAz7lQI6lzkgUaIqkNfCoYC3kRrIjqvJ+x
         ieEk8+Ks7rTfUYFUpylw5rNALCDt7+y5bA6rj4Rqf5DfVPw5sJ1h/Jy/fgZVJ6hJJr8j
         BXGqJhDZIfT8VKuriA3ONLtufz007VcAqPU2pSJPLRAlW2/biKszq40Jy1PEj0C/q+Mt
         oETg==
X-Forwarded-Encrypted: i=1; AJvYcCUnw6/AyrWVDDZJ7AeUHIOmQOgY7qs3ba05cCyrD5vcHEC9T5H5BiffgvyNbFD3VKYJK4OmE+AO2cs=@vger.kernel.org, AJvYcCVon4mmHBrjxu7TyNS/GHwXWnKBKTXUolsUJvE5Pdo1sNpAeJUsDbYLYaiG6ZIv0g5UM60Ot+i+NJtygprnZ7o98io=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNvWOoWIBI7Y+hFqE4suwnSmjXitYbYBeokEBF/L1Hx21a5gVP
	yp+p9LKijGLg0pFQEcntO10SREXv7bdW+qqT2iPLMixwOmzL9KzFSGTlgeNHpJ89
X-Gm-Gg: ASbGncuv6sTNC9MWrxcG1QxOoT13ceyxIIO82iAQ05y2LlJwD5HcGaTOoiPojjaK6/g
	dgbFWiZ0aqZ4vbT04rBQiOu3WUdJYFgOlbrSs5pal9wAxKwNDvfLu9w0lx9XcKWLVrlteFnYAQc
	E5p44ptRMte0oHsHC8jSaPNuV5Nzxfe5M1XjIEqR2fUgvVudERHbo3y3AVN6ODOIsGJ+AZpyao6
	A+fjpZNs/bDRY/zmt2Sj4nXPpwGooLN1dc8EhjCGDGxFH3DjTTa1TCUOKwppjVoZ4m2DnuY0IcW
	nki0hxbeRQ28bvlQMmB6mTCMYCHCRVZn8IQsxu0RCnpPBfdHWiA8i4qoz46y7QC7z91k8ZZhqAv
	E78NV0LgnMfZ6Rc1b95a8O28n7cDNjuhzUZiQw6kfzhoYO4Nj7KXaLz+a45cN
X-Google-Smtp-Source: AGHT+IE2es+p19C59jHjIOLMUKkrltymQlEVEI4Yn3fBEyp039WN8CrIh3n1BGyPQQZvgFAWGZ209A==
X-Received: by 2002:a67:e01c:0:10b0:4e5:ac0f:582c with SMTP id ada2fe7eead31-50fe9f7a54dmr752090137.13.1755174526314;
        Thu, 14 Aug 2025 05:28:46 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88e028f6355sm3293078241.12.2025.08.14.05.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 05:28:46 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-890190bee8bso485649241.2;
        Thu, 14 Aug 2025 05:28:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyHz7qLiuijl6k5z69i3qPRPo8WIcxB/Q60gddX8RHSCM0KTRxlcb+433ZKVTdu48jKFHd2BuyBIN/NHF5zXkaOFQ=@vger.kernel.org, AJvYcCWEY/IWkSkLRipBJX9T7D9/aLuFrPJU6pr074f6jVro4bYDfWeVvI/f0v9pPRWzNjjvyRgDFjMgL04=@vger.kernel.org
X-Received: by 2002:a05:6102:2c83:b0:4fa:85f:31c0 with SMTP id
 ada2fe7eead31-50fea3b35e6mr1130342137.19.1755174525882; Thu, 14 Aug 2025
 05:28:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <699b2f7fcb60b31b6f976a37f08ce99c5ffccb31.1755165227.git.geert+renesas@glider.be>
 <20250814-gray-yak-of-happiness-829267-mkl@pengutronix.de>
In-Reply-To: <20250814-gray-yak-of-happiness-829267-mkl@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Aug 2025 14:28:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUXBTpPpS6S6=u3N75Ut+NqBJ2Xu1chnYgjK7XBZ5tXYQ@mail.gmail.com>
X-Gm-Features: Ac12FXwQM796sP80JzLSgKJNMbaVWtSL4dvHeai6KLb764qilCw9cJb1OyfedB8
Message-ID: <CAMuHMdUXBTpPpS6S6=u3N75Ut+NqBJ2Xu1chnYgjK7XBZ5tXYQ@mail.gmail.com>
Subject: Re: [PATCH] can: rcar_can: Fix s2ram with PSCI
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Thu, 14 Aug 2025 at 14:08, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 14.08.2025 13:26:37, Geert Uytterhoeven wrote:
> > On R-Car Gen3 using PSCI, s2ram powers down the SoC.  After resume, the
> > CAN interface no longer works, until it is brought down and up again.
> >
> > Fix this by calling rcar_can_start() from the PM resume callback, to
> > fully initialize the controller instead of just restarting it.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Can you add a fixes tag?

Well, the issue is more like an integration/platform issue: before the
advent of PSCI system suspend powering down the SoC, s2ram worked fine.

One might consider the (rudimentary) addition of support for R-Car
Gen3 to the driver as the first "broken" commit:
Fixes: e481ab23c57b37c9 ("can: rcar_can: Add r8a7795 support")
But at that time, Linux didn't even support wake-up from PSCI system
suspend on R-Car Gen3 systems...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

