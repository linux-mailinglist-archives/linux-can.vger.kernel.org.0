Return-Path: <linux-can+bounces-4703-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06052B579F5
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 14:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56AE2188AA2E
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 12:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4BC26E6FE;
	Mon, 15 Sep 2025 12:08:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260B3009E9
	for <linux-can@vger.kernel.org>; Mon, 15 Sep 2025 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938080; cv=none; b=DIDdEOIebg+YXFmDZVyvg7YXQbqywzlBLs1VDrumxYH9MGZxtkQvjbzPF6NwcBK3i2aQHYZU7XgQf/DHzkba2zI7B359WuuY0DAyfsS80nNOxcddyXK5HojQ3gB/tlnzIrXNf7jDGgLWYnT4DNySyOQ0DODJSezNlJr+NqeLsco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938080; c=relaxed/simple;
	bh=w1EtHwW9I0RFjXogMFDEDAFVqUSNz6KiSixf/4aXXzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFXfnnDWxjmprb7USvb+IuKaLKcuJhfoUwjvOfGec+z2P9R45itRJDWYAN9QT0+nWR4UJSX9u4qTmtB8Zju0HJy5N3qsIfUtFpc9nDZUe6Z8DU6F0dRhspmEUqp6YarlYnk28XNHtpoS/xmlc90wKTiBo5oV3jimypsrvBPb1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-54a2beaa29fso575296e0c.2
        for <linux-can@vger.kernel.org>; Mon, 15 Sep 2025 05:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757938077; x=1758542877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBfi4uhS2B+Eniv5scVBhoF8y69qK9fhF+0G1ZdygDE=;
        b=KhYfLsuGNM86JKpXLl5nrpP2kHTo9xffZgqE1p448U6ndeRX/IPs8EZPZRJb1GUvRj
         a6o4Y9MvB6FIjQXqnWoX/4DWK7+33B9K1qvemdHNDuop9vGL3k8VH0qsXEZNRq2PpuX5
         Ded1EY+Eei4e9RulxNr56vdBBHml7krbi+crkVsI0mIRGFaYiei72v68DAPTDZlQfjfl
         1ILviadwTtrknnIx9rEg9/m3F/y6VaBkursHSLdKR/1OkmK2IVBv4qD3pPeqvfYyeU0b
         eR2OPtQGanKCF3sg5Pb/Jtvk6zGLSU/yggNXyNYNTuL/HbZVM1NsqMh//PNMLk3ifrvk
         eJYg==
X-Forwarded-Encrypted: i=1; AJvYcCWO0UW98asMzcP5NOOGqlX9RhjA3krfk99+mHS1HzIpXXQ0xyh5vXZRbvRrA+Jkr8Uk9gpyZVLdE88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtbwRilPPx/tAvalvmUU02OSgw4X57rUIK0gAxKtq0vVjLpWr2
	FgOYikw6BjhfZDGdWsT2ocKdE+XPvryKDysAxMBJH3C2/jYkZlo48Fbjyu5UcMIx
X-Gm-Gg: ASbGnctY3rIZDhcaIKs3rg9kSYfFzW83Cycn53+LMnpJNfpdq37h8h/TZsrQYK+Mxia
	Lsz3UOsVrVVrohVx2ofrsX2IQ8gi9DSgDX9gnpMOeu+abWlI9YqYBvqqVZjsOOC9MMocV0nGGna
	ROrn0hV6kee+6BakhVsXmBGMLcCblsUZY/BIns44XELFpZPE/xbR8fmskfMezmVxvla/3fp80vV
	SQR3GffNjg1xenmYsx12AhQJx3sbsNwPFeuhWLWXZXYo8k4gw5hjZnjgHHAiBmJYstBwbZwU/XZ
	3tP772OvhaJpKQv8FhvgpDwgeQ/sbHORB3kcLeL5lAbbCrSWW1oWrmUxn0JHSH/E4k5A2ohc/3/
	5jBxKWJiomyVfaHPw2ZkjX88cSpv3sQL9/PzIAILeUlH7zQqEZg4QlIGdYSYn
X-Google-Smtp-Source: AGHT+IFFnSsG6UQvaM1Ucw9SuBEAjVi8XZci9eGw8VCWzmI5myMe2womF8rxf216CaHoHTAtH5qWoA==
X-Received: by 2002:a05:6122:a16:b0:544:8e42:aac with SMTP id 71dfb90a1353d-54a16bc9dddmr4665071e0c.4.1757938076887;
        Mon, 15 Sep 2025 05:07:56 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a0d1bd094sm2150955e0c.1.2025.09.15.05.07.56
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 05:07:56 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-556f7e21432so2217352137.2
        for <linux-can@vger.kernel.org>; Mon, 15 Sep 2025 05:07:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXooKNft8MuIIFwnYSLx3Uxq/PeK3xt62PKYeNCzmCQzULc+424uQf/kAz1mJtC15LFg1ThnpDFNVE=@vger.kernel.org
X-Received: by 2002:a05:6102:3589:b0:533:44d4:d624 with SMTP id
 ada2fe7eead31-55609c313b4mr5030595137.8.1757938076242; Mon, 15 Sep 2025
 05:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Sep 2025 14:07:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXx88-3j6Gu_ZK6tRV=RWu+T_yETaNEMw=rviRsNM7u6g@mail.gmail.com>
X-Gm-Features: AS18NWCFmQom8EOHzoQl-rBXwlbJequ1oD-bXcXBziRkWkdhHqMf1HNZ0ce-n8w
Message-ID: <CAMuHMdXx88-3j6Gu_ZK6tRV=RWu+T_yETaNEMw=rviRsNM7u6g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Add suspend/resume support
To: Biju <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Fri, 12 Sept 2025 at 12:47, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> This patch series adds proper suspend/resume support to the Renesas
> R-Car CAN-FD controller driver, after the customary cleanuops and fixes.
> It aims to fix CAN-FD operation after resume from s2ram on systems where
> PSCI powers down the SoC.
>
> This patch series has been tested on RZ/G3E SMARC EVK, Ebisu-4D (R-Car E3)
> and White Hawk (R-Car V4H).
>
> v1->v2:
>  * Added logs from RZ/G3E
>  * Collected tags.
>  * Moved enabling of RAM clk from probe().
>  * Added RAM clk handling in rcar_canfd_global_{,de}init().
>  * Fixed the typo in error path of rcar_canfd_resume().

Thanks for updating!

This series behaves the same as v1 on Ebisu-4D (R-Car E3) and White
Hawk (R-Car V4H).  However, that means the small regression I mentioned
before [1] is still present:

   "While this fixes CAN-FD after resume from s2ram on R-Car E3 (Ebisu-4D),
    it does introduce a regression on R-Car V4H (White Hawk): after resume
    from s2idle (White Hawk does not support s2ram), CAN frames sent by
    other devices are no longer received, and the other side sometimes
    reports a "bus-off"."

Note that I did my testing between CAN-FD channel 0 on Ebisu, and
CAN-FD channel 3 on White-Hawk.

I retried with wiring between CAN-FD channel 0 and 1 on White-Hawk,
and with that configuration, CAN-FD still works after s2idle.

   "However, the underlying issue is pre-existing, and can be reproduced
    without this patch: the CAN-FD controller fails in the same way after
    driver unbind/rebind.  So something must be missing in the
    (de)initialization sequence for the R-Car Gen4 CAN-FD register layout.
    Note that it keeps on working after ifdown/ifup, which does not
    reinitialize the full controller."

Same here: CAN-FD channel 0 and 1 on White-Hawk keep on working after
unbind/rebind, unlike channel 3.  So it looks like we have an issue
again with handling channels 2 and higher...

[1] https://lore.kernel.org/all/f9198ea3be46f1eb2e27d046e51293df7fb67f46.1755855779.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

