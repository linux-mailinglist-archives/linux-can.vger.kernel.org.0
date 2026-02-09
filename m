Return-Path: <linux-can+bounces-6515-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L80AE60iWlLBAUAu9opvQ
	(envelope-from <linux-can+bounces-6515-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 11:17:50 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 894EB10E103
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 11:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B112B300A625
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 10:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6646B2DC782;
	Mon,  9 Feb 2026 10:17:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290D91D9663
	for <linux-can@vger.kernel.org>; Mon,  9 Feb 2026 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632264; cv=none; b=pD+meyqVmFuZPTAj7JYztqy7yyU+6mvInl52CS49iY6V3TL5SdUOXVS9HZHxBchm70V1rTw9LbBAuWXUril7Q7e44rr65lrK5Hwt20UP7+JKdaoOsG4azRJ0Lp66jkWp4YFGGcc1kDWQUtVxyfeUnn1w8bIp9FkeI/JdnVI+XJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632264; c=relaxed/simple;
	bh=J73vKAZhiN3K6G/5fpGigw+8duj0Td3xLp2ybYYDes8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbbIcEFF//p8zSeixnG11pWCOtz3eYRgBmdL5jI7kt4hkjhof2f/He74RjTYUTh2pxTc2+VeGt7SMTMAMheIrtTnngWahBPbyHtCr9f5ZrHwHiQQf527DiWS7bXsc50hdlSbrSyfjK6A+VapzTvft9UqaUqCGw9ymMqgNHprKKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5eeaae0289bso2630321137.2
        for <linux-can@vger.kernel.org>; Mon, 09 Feb 2026 02:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770632263; x=1771237063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55b+49cOY521wvVXvsz0WcOQjNDu8cxcjrZIHfMxzy4=;
        b=ihXzGX4TVGBfcjn3hV0Ohx6hXlslwNrpZUP6QMsDzoI5wGOlWwLmdToTQAggIzvqYo
         b1299fn5XukS49laXL81xITM5MxbizCoMxtpiwBf9uhfsxlo/7ol7rGGKKpG0sZxZ0hd
         bhuEyWtMM/eL8IMRyjuCZ5JTBl6cK+sLTrCfOFr38932/9d3gaWGXQPGkHzBnu9BSWcU
         WFctvyhQq9XDxb4RXET7pxnDsXFAwKfgDm756M5C4wqKaZAlxLIuiBRjuBkRM8cNWyjj
         KcX1rrohOP6WvCh0g2nrKtCRVGLrZmOWwIHZfDiPCcH1YawqBmSasxYGsinq9Pu94ENH
         lfJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbulQzMeuhUBsOpYjoQQ/arkzAjL4OXRQwAg5JZJpoPPNDJ4fmIN8WeKEGvRzBa2ygQdH0kieb4q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxwgaYWVaC8a9IwatgLyhUuvqzy2a275uZkNG/35UODuEWfw/
	aHhL7eSM+0bcYffKT2xtb0vJ+ndDqww8dfCMiKbeY1CkbV1mxK+LPclDUAOvWFpt
X-Gm-Gg: AZuq6aK35gkc1twWmnb0vx2m0bo3e85dDb75wSOvLrnqXzJjeP5/YzBixwcRIxzjrby
	GWwB9/tJWFqCs9/f8zCl+E5PfAO/KPaoMGLavQEmlQjpapurjl0+2ymg/xr4HWUj8tS5AG6Cdcv
	aBi3rYnO/Btq7g5KT2odUXDI2NExwyxX9BUokBX+xVihXGVSn27W3KvzmGFzyij8Nk2deZ0m1Fk
	JQCFmXFpga0gOUsYOd3PV5q0HPZ8Kb1kxAa9I1x9B2BU8/NHJFlK8F4bmzaY78ybxzFRtt+to8C
	AhEC/OHn3sW7Ioyqiu7s7FFKdTWqG70mHdc7Io3ig23396djRSvGxXg72F6R4xHm3qPn7l9VDSY
	f27zkS6Eb0/3y/fwQXZcVVmJP06TsYPlBO/W/lx1gZfWB9KS1Ut7Lkxze8zcYpP03bgwn0n1NK4
	RawjowBCcpdrpUsJ2a85/Sx3m7aV3wrwx4QJ4FEmNnZ/xpBfRXls/o
X-Received: by 2002:a05:6102:2913:b0:5f5:33c9:c9b7 with SMTP id ada2fe7eead31-5fae8c90986mr3162689137.41.1770632262947;
        Mon, 09 Feb 2026 02:17:42 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5fae8e5079esm3236762137.7.2026.02.09.02.17.38
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 02:17:40 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-566360cab02so3108509e0c.2
        for <linux-can@vger.kernel.org>; Mon, 09 Feb 2026 02:17:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLRvCYIrtWMak9OVTqqouZT+eMODY1G8YMhrgT1IEJOE4ucsk10hKNYUBTYtN9XRBY7n1scIgdU4U=@vger.kernel.org
X-Received: by 2002:a05:6122:3c54:b0:566:3d03:8e1d with SMTP id
 71dfb90a1353d-56705febb0fmr2935090e0c.17.1770632257982; Mon, 09 Feb 2026
 02:17:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-3-024ea405863e@solid-run.com> <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
 <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com> <39f3891c-c05a-4e10-9ad4-ab3cbc6fa70e@solid-run.com>
In-Reply-To: <39f3891c-c05a-4e10-9ad4-ab3cbc6fa70e@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Feb 2026 11:17:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVbi=2puhk84k+FCDXqkQ9jFsy0rsseQiFCF8i=KsR1OQ@mail.gmail.com>
X-Gm-Features: AZwV_QizeLChl5bqEs0QtuubG3nlVKZbEpUJtWLc1m5RmCDOEU_VrUSeQPEZi-k
Message-ID: <CAMuHMdVbi=2puhk84k+FCDXqkQ9jFsy0rsseQiFCF8i=KsR1OQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] mux: add help text for MULTIPLEXER config option
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
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
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	DMARC_NA(0.00)[linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6515-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.905];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solid-run.com:email]
X-Rspamd-Queue-Id: 894EB10E103
X-Rspamd-Action: no action

Hi Josua,

On Mon, 9 Feb 2026 at 11:12, Josua Mayer <josua@solid-run.com> wrote:
> On 09/02/2026 10:06, Geert Uytterhoeven wrote:
> > On Sun, 8 Feb 2026 at 16:16, Josua Mayer <josua@solid-run.com> wrote:
> >> On 03/02/2026 15:01, Josua Mayer wrote:
> >>> Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling thi=
s
> >>> option thorugh the kernel configuration without explicit "select" dri=
ver
> >>> dependencies.
> >>>
> >>> Select it by default when COMPILE_TEST is set for better coverage.
> >>>
> >>> Signed-off-by: Josua Mayer <josua@solid-run.com>
> >>> ---
> >>>    drivers/mux/Kconfig | 8 +++++++-
> >>>    1 file changed, 7 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> >>> index c68132e38138..e31c46820bdf 100644
> >>> --- a/drivers/mux/Kconfig
> >>> +++ b/drivers/mux/Kconfig
> >>> @@ -4,7 +4,13 @@
> >>>    #
> >>>
> >>>    config MULTIPLEXER
> >>> -     tristate
> >>> +     tristate "Generic Multiplexer Support" if COMPILE_TEST
> >> This didn't do what I thought it would.
> >> It was my intention to allow enabling this through menuconfig / .confi=
g.
> >>
> >> With the syntax above menuconfig shows:
> >>
> >> =E2=94=82 Symbol: MULTIPLEXER [=3Dn]
> >> =E2=94=82 Type  : tristate
> >> =E2=94=82 Defined at drivers/mux/Kconfig:6
> >> =E2=94=82   Prompt: Generic Multiplexer Support
> >> =E2=94=82   Visible if: COMPILE_TEST [=3Dn]
> >>
> >> This means it cannot be selected.
> > Looks like you haven't enabled COMPILE_TEST first?
> Correct.
> But CONFIG_MULTIPLEXER should be visible always,
> not just when COMPILE_TEST is set.

Why should it always be visible? All users select it?

> >> Instead I (think I) should use
> >> default m if COMPILE_TEST
> > No, merely enabling COMPILE_TEST must not enable additional
> > functionality.
> >
> >> Since my patch-set broke x86_64 allmodconfig and failed merge into
> >> linux-next,
> >> this presents an opportunity to change the above as well with v9.
> > Ulf has already applied this series to mmc/next.
> What would be the process to fix the build error for x86_64 allmodconfig
> now?

Incremental patches, cfr. Ulf's response to [PATCH v9 0/7].

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

