Return-Path: <linux-can+bounces-6533-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHesGIbjimmjOgAAu9opvQ
	(envelope-from <linux-can+bounces-6533-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 08:51:34 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDC51180CC
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 08:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CE6C3016ED0
	for <lists+linux-can@lfdr.de>; Tue, 10 Feb 2026 07:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28C62C21C4;
	Tue, 10 Feb 2026 07:50:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74669306B37
	for <linux-can@vger.kernel.org>; Tue, 10 Feb 2026 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770709848; cv=none; b=bvFUlQWT3vOXO7cdd9FnCOF6ZDjIGgpTr174YivODzW3+jA4F5p+7Yl81avhk0IGXsU3cu7jGkFZlnfMg4wFIcGWfWygig4veUbFN5H60tsPpVqS7HcAFsD6oEz6Xd26z8V4Xg0q2AXJpKKmLaRyFySHUOa0DmQ1YYbvpg8q5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770709848; c=relaxed/simple;
	bh=ZBrn2V6Ps9nAXfcemoiQWj+7Cl/HyRPhAU9WPaB6Fxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EITcDs2uXwWzTc300u6iAhO5+RpknX7nWmvPijvD+N0T9wgqEk+gX/n4KwWmvNsPDm6xx/fvx6smjlP+05/fD7L5VMdqsLWV4TIbbGR48ojEHMe7cuYSG+sdGYzosHE6wBza+WPUAuAZ4GWIwYVt7pAYQF0L6syzwrpd8HglD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56739adfa1aso466509e0c.0
        for <linux-can@vger.kernel.org>; Mon, 09 Feb 2026 23:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770709846; x=1771314646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za+ffUzQm9VRZ3fSQVHtfuOR3ywRY/ywHi+DZoQjMUc=;
        b=C2cCesSHlf3vgKuSFwmfWt93JOI649/O/8s9kDwlNjnnNH5Rtrg+d0hC3qJ+fDuG0w
         QOB98L8tXwXAC+FYPpFPDLr9Ki/C3JpGUQs4UT21EBapWFvm+T/K9wG9G4c2KcMXenKp
         J1h5YFTNb+sQ4y2G7pHLI2pMjSnovC8QvzhmbayY+2bbMmpfIJvxFxJluKlEAgk5hyG2
         7YyjvKveNQRttf1oKjH9i26qaq2zxm3xb6iTTE9nTFSTh3UdRGuuxat7fcApKHHkI+o9
         rPDCxufLAUmIojRXq9fwitiL3BUmLguBwQ/KXe42ijV02caRFM3vd8JO4AiLjPhi2Om2
         5ZzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/7d1ruXQ093uP9rA6tCzX4oO1ExXuuH8WV/t0jBAmD3QDSElAKEyszjujIoSxR+R42KKGIf7RKYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1D8T3r7KFanbyklESYRRzxx6y7qvMjTufaRuBRly8OYkYxnqW
	0y9i0mfEc9quw8GFU1TBwfYMItGnQauBw7a3ik39S2whb3Gg7tVz8fSvYFcNm1a7
X-Gm-Gg: AZuq6aLAmEKs48NYT6K4YXVa2FEMWwqh10GLNcl8v8wEi9s1VKV6fGoqMGWNl5gTTiW
	9MLyD2j4skEo+RmKGe/9ZzStGLZ3Fsls1Cd2NDTXyGLULvBSwAirlMYGoOqyth2fsJa1kUwZH8D
	zhEvaR8wcvuHFC8rkMtvwcgFiKiSMQ317EmsUXvACDEyCIzzvZhEYrkYSo0drLe3rII+e6E3ilM
	wiWmE787N61JQ+V/u3QG1yTXMF9qAHtCt0lPMakey4RiaAqMal0BJmTHUnQFcsO/XEZXVS5xlEW
	ByrXPlbw+dgNhCLQmymVuUHJEWvrQQZ9ADgn8zWlQjCX3E08Bw0LUtI1Mxkj3sujPrJw6b1FhgP
	vt6uVFztRqAwKuD8sv7MI6+kfnySy5FdFPl4CgqFh3rX/Tikjtawa+vsyMKhJ0OKIH0o4+hJ0kM
	vsj7sX3XuN84p6yEVJtgQZKdVj9qcoTlEPYmmfKTuNbIMiJwPxCxiTfkYdQAQrDF0y
X-Received: by 2002:a05:6102:32c5:b0:5f1:7aad:7c04 with SMTP id ada2fe7eead31-5fc48eba45dmr331868137.41.1770709846285;
        Mon, 09 Feb 2026 23:50:46 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5fae8e5079esm4147128137.7.2026.02.09.23.50.45
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 23:50:45 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56739adfa1aso466487e0c.0
        for <linux-can@vger.kernel.org>; Mon, 09 Feb 2026 23:50:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsgR9f0T4yOo7OMwhuW7YqxFGFVzHpRNq7kwcyyhcXjBDI5ljaI5LLUrA++QGx30Xt6D7PZjJNc84=@vger.kernel.org
X-Received: by 2002:a05:6122:920:b0:55b:305b:4e31 with SMTP id
 71dfb90a1353d-5673dad68b3mr278879e0c.17.1770709845104; Mon, 09 Feb 2026
 23:50:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com> <bc5fbfc5-6f71-eeed-ad90-0c1b835e65ea@axentia.se>
 <fcef2798-1645-41fb-952e-daf3657bc231@solid-run.com> <704210e0-2e53-09f6-9f8c-3ae0c4b8e0da@axentia.se>
 <9d7bda92-e520-466a-a0be-d01686af1d56@solid-run.com> <f4d8547d-3de3-0de5-da61-3de57d9af895@axentia.se>
In-Reply-To: <f4d8547d-3de3-0de5-da61-3de57d9af895@axentia.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Feb 2026 08:50:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUEZZ+p+yaQDWhVCRNEQUygR2j=HpCp5LuzFU3E=qVNXg@mail.gmail.com>
X-Gm-Features: AZwV_QjWs_kGwWtLP-4KOwLJynmxdzZD9XMo5f_JCKEF6YiXm5BZAUIGiU8_kRM
Message-ID: <CAMuHMdUEZZ+p+yaQDWhVCRNEQUygR2j=HpCp5LuzFU3E=qVNXg@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] mux: add help text for MULTIPLEXER config option
To: Peter Rosin <peda@axentia.se>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[solid-run.com,pengutronix.de,kernel.org,linaro.org,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,vger.kernel.org,lists.infradead.org];
	DMARC_NA(0.00)[linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6533-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-m68k.org:email,axentia.se:email]
X-Rspamd-Queue-Id: AEDC51180CC
X-Rspamd-Action: no action

Hi Peter,

On Mon, 9 Feb 2026 at 14:09, Peter Rosin <peda@axentia.se> wrote:
> 2026-02-09 at 13:07, Josua Mayer wrote:
> > On 09/02/2026 13:43, Peter Rosin wrote:
> >> 2026-02-09 at 12:31, Josua Mayer wrote:
> >>> On 09/02/2026 13:10, Peter Rosin wrote:
> >>>> 2026-02-08 at 16:38, Josua Mayer wrote:
> >>>>> Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling this
> >>>>> option thorugh the kernel configuration without explicit "select" driver
> >>>>> dependencies.
> >>>>>
> >>>>> Select it by default when COMPILE_TEST is set for better coverage.
> >>>>>
> >>>>> Signed-off-by: Josua Mayer <josua@solid-run.com>
> >>>>> ---
> >>>>>    drivers/mux/Kconfig | 9 ++++++++-
> >>>>>    1 file changed, 8 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> >>>>> index c68132e38138..4f7c6bb86fc6 100644
> >>>>> --- a/drivers/mux/Kconfig
> >>>>> +++ b/drivers/mux/Kconfig
> >>>>> @@ -4,7 +4,14 @@
> >>>>>    #
> >>>>>
> >>>>>    config MULTIPLEXER
> >>>>> - tristate
> >>>>> + tristate "Generic Multiplexer Support"
> >>>>> + default m if COMPILE_TEST
> >>>>> + help
> >>>>> +   This framework is designed to abstract multiplexer handling for
> >>>>> +   devices via various GPIO-, MMIO/Regmap or specific multiplexer
> >>>>> +   controller chips.
> >>>>> +
> >>>>> +   If unsure, say no.
> >>>>>
> >>>>>    menu "Multiplexer drivers"
> >>>>>           depends on MULTIPLEXER
> >>>>>
> >>>> I'm not comfortable with making MULTIPLEXER a visible symbol. It is meant to
> >>>> be selected when needed (and there are a dozen or so instances). The kbuild
> >>>> docs has this on the subject:
> >>>>
> >>>>    "In general use select only for non-visible symbols (no prompts
> >>>>     anywhere) and for symbols with no dependencies."
> >>> The patch description didn't make the decision logic clear,
> >>> and I plan to submit a standalone patch for this after v7.0-rc1.
> >>>
> >>> Basically existing drivers using mux core used "select" to enable it,
> >>> even though the core can function standalone with device-tree.
> >>>
> >>> Some of these users (phy-can-transceiver) function perfectly
> >>> perfectly fine without mux, and use it as an optional feature.
> >>>
> >>> Likely drivers only used "select" to avoid writing helper functions,
> >>> prompt, kconfig description and stubs - which this patch-set added.
> >>>
> >>> So I will argue that some existing users relying on "select" was wrong,
> >>> and that the mux framework is generally useful on its own.
> >> When I wrote the mux sub-system it was very much intentional and by
> >> design that drivers needing a mux should select MULTIPLEXER, and that
> >> MULTIPLEXER should not be a visible symbol.
> > Need is a strong word here, and doesn't address the optional case.
>
> "Need" was the correct verb up until you needed the subsystem to be
> optional. If you need the mux subsystem to be optional, you need to
> do it in a way that does not introduce headaches.

In the other thread, Josua pointed out that there are already several
drivers that cannot be enabled if MULTIPLEXER is not selected by
something else:

drivers/mux/Kconfig:

    menu "Multiplexer drivers"
            depends on MULTIPLEXER

    config MUX_ADG792A
            tristate "Analog Devices ADG792A/ADG792G Multiplexers"
            depends on I2C

    config MUX_ADGS1408
            tristate "Analog Devices ADGS1408/ADGS1409 Multiplexers"
            depends on SPI

    config MUX_GPIO
            tristate "GPIO-controlled Multiplexer"
            depends on GPIOLIB || COMPILE_TEST

    config MUX_MMIO
            tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
            depends on OF

While MUX_MMIO is selected by some/all(?) symbols that need it,
the other three are not.  Are these three really dependent on another
symbol selecting MULTIPLEXER?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

