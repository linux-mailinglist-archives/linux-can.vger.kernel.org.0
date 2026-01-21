Return-Path: <linux-can+bounces-6247-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMFjHn6zcGndZAAAu9opvQ
	(envelope-from <linux-can+bounces-6247-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 12:07:42 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3F855B7B
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 12:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9468C628F6F
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F442328B6E;
	Wed, 21 Jan 2026 11:00:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72415352C40
	for <linux-can@vger.kernel.org>; Wed, 21 Jan 2026 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993211; cv=none; b=F3eqF5e7cUmeiE6/eWceApwFPA1ZYZNLGWknR4t4lUf9zfTS+OFc/JKgsKwgN0s216ipr7qg93xoQW49+sGBkPK5o+j8p8qRSXFfGXXprbwHF6vaaH0W8mmlobXHAid1dCRCWwwSrmjj05aiDhFo2csPtVd3U+eKsa1abmBKCFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993211; c=relaxed/simple;
	bh=cysOwS5g5dZRSxtVrJ3zv/VB5w+D2iLkyCuaPMhXFP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HsMVybZeIEKzy7ahBV8s4wyoXHVDAwphLO5vkzKp+fcYyvaP3VFvTBvM6SbxHp5bLuwV6N5jQjawmMa3Lk/0m+zLmQ/sH9ywGISvBuQS/L1qb5ttNoO5HmOVhSGtqUPTxrjS/6cGo7jHO7H9T3AH84/W7LuaxBNLAcX+LQyvUaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5ed065f1007so3676866137.1
        for <linux-can@vger.kernel.org>; Wed, 21 Jan 2026 03:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768993205; x=1769598005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSYJm8i9wWqRvGvRTZz6VIsl7/oMewZT8tw/+hAgWzw=;
        b=fXCu51UbxQOcDm+6bQ1B3wROawOL02h6zbC6ovl/xsmvJJDPOT3rFO5WPCpjj4dYwt
         9k4VrlBpW7T4tGDXRRW49MGxUYm/vR1jfMHYp8/fHjsT6RbodTn96fFdq9nB4TISCFUZ
         j2+CZgVzcYu+V1SqQbfDk0b+9vLSTjcdpV6QXjCH0+6z2bEheYyacZeJgrP7GCfFgp8X
         YaQCsk/qTlvx0+HT7urSsaOzTVGNyXDIlfr4glVMvTZTjL+VsY84+MlxVQfd4mtXyAbG
         hZ/vv19eUi9tQQbA3PxQXi4IBzk0xYnqHKld38y0qce/T9lD74kDpG2H8xkGhI6/0WW0
         ULXA==
X-Forwarded-Encrypted: i=1; AJvYcCU4ydhT4Zy9A0516H3XSQbEdsZid0JDHIveP9qvSiobA/DgKYi14+Ki93xOpP1qW2DrP8cidsT2eW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTlcJps+VF3v35YP/zL2zEYIqqHhBXW5dnSkVWBc8MMvrp9NVF
	mPJs5hh5XoL31LRLKW01bt9ATSpbr9Ufi2Y9OYwavNYO/dfFF5mBDvyfK89VcU4R
X-Gm-Gg: AZuq6aIdEDSAD+2rRsja2/1G3vho9Akc3tveUW2d8KE5fIri51NPQS6IJWZWYLfOlaP
	g6uls3cNyHynvtEaIpYDCZRPyKljB6K45tHEwEyS3KaCFB+Yi4kLViwq9NkF9aGx2Q+1Ydg3Jt9
	jPX/Kd6R2BDTqJJBuh5Js0XVRH3AxypQn9P9tKdpFA/xC9DBsbK+6jzTHUF1LcWKGAf+SeYKZvE
	ZbWTloh6br+ZipdGw1AQGR0RsK01GJL/9WNwIUBVyxwfoWhL6cvh9KWdfl1Gh2xmjkSHwLWr1sc
	ZaH3qKOn26/OgwpTKzdFqzd+hbwplDkxfdKU0m09HPPvln5b4JWlPm+2ebMs95CEl03TduMqJaM
	mwVFmmwJRxfTNw+9GvJ9OzI/FfirB2kl2tBmKf6fgI6GD0MC/ddmUO3mrn2wMLtOG3lU+ym1F7X
	N45xNIgACA1jJw+B815G3ZW3hkIw0y/DYN1ZYq6ozjHE3NW5a7
X-Received: by 2002:a05:6102:3708:b0:5d7:dea0:d6c4 with SMTP id ada2fe7eead31-5f1a6f9e8d8mr6128345137.7.1768993204963;
        Wed, 21 Jan 2026 03:00:04 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-947d0437783sm4826861241.9.2026.01.21.03.00.04
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 03:00:04 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-93f5729f159so3953969241.0
        for <linux-can@vger.kernel.org>; Wed, 21 Jan 2026 03:00:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXY/tesroL8Bigu8OOJ08yuYxYHHkUl8ANyasaBddIyYp2pjksnXt76TQXaW60UmicpOBIX3Z5ZSX4=@vger.kernel.org
X-Received: by 2002:a05:6102:2ad6:b0:5ef:248b:d533 with SMTP id
 ada2fe7eead31-5f1a716fcbcmr6150752137.31.1768993204250; Wed, 21 Jan 2026
 03:00:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com> <20260121-rz-sdio-mux-v6-3-38aa39527928@solid-run.com>
In-Reply-To: <20260121-rz-sdio-mux-v6-3-38aa39527928@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Jan 2026 11:59:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX_rKgfusHP5qVny8OZufU6VAiA6sqg1LP3T2jikSz7yQ@mail.gmail.com>
X-Gm-Features: AZwV_QifTISU05sQ0lYySqx5XyPjAzUqa1H8fmOUOfLhWhGN7rzCzfM2UGq26-s
Message-ID: <CAMuHMdX_rKgfusHP5qVny8OZufU6VAiA6sqg1LP3T2jikSz7yQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] mux: add help text for MULTIPLEXER config option
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
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6247-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,solid-run.com:email]
X-Rspamd-Queue-Id: 1F3F855B7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Josua,

On Wed, 21 Jan 2026 at 11:02, Josua Mayer <josua@solid-run.com> wrote:
> Add help text for CONFIG_MULTIPLEXER to allow enabling this option
> through the kernel configuration without explicit "select" driver
> dependencies.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Thanks for your patch!

> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -5,6 +5,14 @@
>
>  config MULTIPLEXER
>         tristate
> +       help
> +         Generic Multiplexer Support.
> +
> +         This framework is designed to abstract multiplexer handling for
> +         devices via various GPIO-, MMIO/Regmap or specific multiplexer
> +         controller chips.
> +
> +         If unsure, say no.
>
>  menu "Multiplexer drivers"
>         depends on MULTIPLEXER
>

Unfortunately it doesn't work like that. As the tristate has no prompt
specified, the user will never be asked about this.
You should use something like below:

--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -4,10 +4,8 @@
 #

 config MULTIPLEXER
-       tristate
+       tristate "Generic Multiplexer Support" if COMPILE_TEST
        help
-         Generic Multiplexer Support.
-
          This framework is designed to abstract multiplexer handling for
          devices via various GPIO-, MMIO/Regmap or specific multiplexer
          controller chips.

Sorry for not noticing before.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

