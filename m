Return-Path: <linux-can+bounces-6511-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE4/BTKXiWlj/AQAu9opvQ
	(envelope-from <linux-can+bounces-6511-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 09:13:38 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 300D310CCE6
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 09:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A70B301B72C
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2065433B6DD;
	Mon,  9 Feb 2026 08:11:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AA981732
	for <linux-can@vger.kernel.org>; Mon,  9 Feb 2026 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624693; cv=none; b=j/TX8BB4LN0lHYW1bf+TAOEFXV+7l6pCMyZELF1zKRYpBHYCt15ToWpYYgBsdXiFbCrAKR7gi7pRLJmTLNRjhJNXKBZyfSdogb5BfMdSkD/f9dUNBtw7cQwLkiWqXGrNmCNcYzYfmR9r61e3vPnpLtJqckNrHY+GIkT2UrUbcDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624693; c=relaxed/simple;
	bh=jGnKFIqAqLu+rNpANBkHFw8kJ3LdtX3G4oazBBlCuPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEK/0Qgbu7PHMoQ10QYD1Io0cCaLsdWO6f5dNGMKmDqjfocquG44xzUuMZKXeS998P+dcb/Ca/2oclmT0xDl/efUBDD9CAS1mMMaXzVdQwY53Qv9dK/1LugaKy6WXm/74FPgxj6PoT0RMQzErqfcULnVuXHbZyl6TT/KDOWU49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8946e0884afso55187526d6.1
        for <linux-can@vger.kernel.org>; Mon, 09 Feb 2026 00:11:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770624692; x=1771229492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l9pK4QYIZutXAE3AMWeCiy3lF4Ku+2UbgC78kdie5tY=;
        b=aVfGeHeyMiCrRiW4X3xJbS2FY8XepG2ves+8Og6Duk2eFimW/Vycfky3rZXAxSZfNv
         JBM9HGB4koFyYzyV06WucfVYBmBGAnE3Vq9LK3Dv4Zg5NmzLTP3KWvAO8qEFPdU+EIM1
         efP8BvlBh3eEgBAZ14KIVrEMuq7paIvGpvqUePLBCzWB2JI3P3XMDkRW0VSVsqyL4EsK
         Ynrq1OiBct8delrQrqd06MLmEEbUghhbWbbv/5iK6ATnWvWTrKWKMxQjM5HeZ6nHuzwi
         nkXKcOx9FajYbF4HM1DBMMAyc/El7jWxh+6sAH62RJ/qbcbGCKXhptWdj/qDf3hSH6z8
         pxUg==
X-Forwarded-Encrypted: i=1; AJvYcCWBYwJT9+y9Ux+7GS+1EfL6ob9lXfh3b0Jitm3bJWd2VFShsiAUn07QpMaq1ccTYAkbCtli3zS/O24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtqh188XK37CqT0fqer9U46KAAXIAv/txabZyr5vpU77PlCz/u
	AvPNy85H4PFaRaEu0tuqU6S02D708UU8cuYr4ek5gvab9zBS/J3jPN65VDLvMql+
X-Gm-Gg: AZuq6aJ3Ulh/Si5GAE0ZgslSJPZg7RxJjJNKyvrUafNGyXKJZ7imUyi4vIgxnHohyzC
	qpQcXLugVntO3R/WiQhlNtHzssGsgIvJrg1O34CSfU+kCbJ/26tKOcUe8uKWRnqYtS+2jAJZqYo
	v4JPRcNw6GD6LOOM2mP6BFtGObgKRG1wTPVoxmY5XH8J/9TM5MnHtqE/8S/kk6UkRhdUMJMtTqq
	jUgIdcNrFFsub0LQpedKhi0/NIgMAWBfoA7lS4VmZ/8NapsNNwtd0gFPGiIdXuSE+l+Yy6Ek7cz
	NYKJav18ukcDyv7ZqrjupbsyC5aAKUzCkaNWgWl1KY7yQaRnYFZolS205WX/FfBgkqovcaV/Hpf
	0NG+5wdepMRKQh5p3CBJM4zQIrg67Rs/MQm5PF/3P+eg9awuDmIlRtvcYxNp+LePjk696a/Jx1F
	h9g6Z3oBsrcUj4yX476jxorcx9i5aAQhdac/27C1EgG/jttaWo
X-Received: by 2002:ad4:5fcc:0:b0:892:670e:e60c with SMTP id 6a1803df08f44-8953cfa189cmr145362886d6.68.1770624691796;
        Mon, 09 Feb 2026 00:11:31 -0800 (PST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com. [209.85.219.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf38514sm72993566d6.7.2026.02.09.00.11.31
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 00:11:31 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89473dca8aaso39120716d6.0
        for <linux-can@vger.kernel.org>; Mon, 09 Feb 2026 00:11:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/5ItUNj+XMqQlJUqcgtWtIP0HXUztuf5tNH68qvIp5lbeHAdc9zt/DYRwNOPTiM84/+wRyUSDdrg=@vger.kernel.org
X-Received: by 2002:a05:6102:3747:b0:5f8:e2d3:c463 with SMTP id
 ada2fe7eead31-5fae8a3b31bmr2934943137.3.1770624379360; Mon, 09 Feb 2026
 00:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-3-024ea405863e@solid-run.com> <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
In-Reply-To: <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Feb 2026 09:06:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com>
X-Gm-Features: AZwV_QiiqRuDaFts73-z5beOOIXm-WRqeTDAQV4zcAAegTI5YGKcuRUZfqXMUrE
Message-ID: <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-6511-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.916];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,solid-run.com:email]
X-Rspamd-Queue-Id: 300D310CCE6
X-Rspamd-Action: no action

Hi Josua,

On Sun, 8 Feb 2026 at 16:16, Josua Mayer <josua@solid-run.com> wrote:
> On 03/02/2026 15:01, Josua Mayer wrote:
> > Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling this
> > option thorugh the kernel configuration without explicit "select" drive=
r
> > dependencies.
> >
> > Select it by default when COMPILE_TEST is set for better coverage.
> >
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > ---
> >   drivers/mux/Kconfig | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> > index c68132e38138..e31c46820bdf 100644
> > --- a/drivers/mux/Kconfig
> > +++ b/drivers/mux/Kconfig
> > @@ -4,7 +4,13 @@
> >   #
> >
> >   config MULTIPLEXER
> > -     tristate
> > +     tristate "Generic Multiplexer Support" if COMPILE_TEST
>
> This didn't do what I thought it would.
> It was my intention to allow enabling this through menuconfig / .config.
>
> With the syntax above menuconfig shows:
>
> =E2=94=82 Symbol: MULTIPLEXER [=3Dn]
> =E2=94=82 Type  : tristate
> =E2=94=82 Defined at drivers/mux/Kconfig:6
> =E2=94=82   Prompt: Generic Multiplexer Support
> =E2=94=82   Visible if: COMPILE_TEST [=3Dn]
>
> This means it cannot be selected.

Looks like you haven't enabled COMPILE_TEST first?

> Instead I (think I) should use
> default m if COMPILE_TEST

No, merely enabling COMPILE_TEST must not enable additional
functionality.

> Since my patch-set broke x86_64 allmodconfig and failed merge into
> linux-next,
> this presents an opportunity to change the above as well with v9.

Ulf has already applied this series to mmc/next.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

