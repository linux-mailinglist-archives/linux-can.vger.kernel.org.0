Return-Path: <linux-can+bounces-6512-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGgSEXCYiWmk/QQAu9opvQ
	(envelope-from <linux-can+bounces-6512-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 09:18:56 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C19210CD9D
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 09:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A381A3008A63
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 08:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E54F2D0600;
	Mon,  9 Feb 2026 08:18:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0421917ED
	for <linux-can@vger.kernel.org>; Mon,  9 Feb 2026 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625091; cv=none; b=aFVC6sXmgii0F0BAAJpGf54Gby9eU+zvbQjkmb8Zsaf6l/FOxnf1C4UVysYHi9DSN+7OFEMQY+sIpsLrZvOXLyzybM7thkO+KJ9yTMz3cU2g1XHHwg59SS7v34MULnLA2H/4bG1xHbxv/C5kAGIv88RIAohvF7hbZYl3SYWvMX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625091; c=relaxed/simple;
	bh=/zYgLPOAHXK4/exWmt8hOWg3cIDWG24Bmk4iX8O5iZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAyTAOpDzCS60AF3z45IYJputKxnWwCuyYFv5K97FL7wk+HAR/7+rhSVOAc1pDGNZQLOIfTEwB5rtX0HAd6vTf28qUgGsumaKzu40ygtB05NSwxZTmGlWMmX3voHdLkoqkXMaZ30tHBhQT/LCPSQznOK/d787lYM2J4HtFGu8XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5fa26e497abso1849478137.3
        for <linux-can@vger.kernel.org>; Mon, 09 Feb 2026 00:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770625090; x=1771229890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bAsoauLtymOFaOmBSRU1sXzH6MyMCHQePcHPtAadtM=;
        b=M5/7NnjKRdZM+YVPJ431O9oc5dhdd9+PQa0o34n2j0pDGFQKvPgzcUqXxcQdDs5oT0
         0uZ5lwb+zS5r/tFNNU9ROIBv09irw0oH5eS7xDr+C/qMcuV3lXAwK+Gc+TrFxCYGGgzV
         pz2ZrNMa6VCkN0RDsxb0nT5Bj9uNUMzZ7vuJsOPmzbcT0EVpDe/MPJOGIiaYyd8LKs3m
         K0ZGaqQzOAeO1ezTmjmR0vzAAOC3OZ/97aJeG7YLNIC7oqd5okSYrlhsgOiloDb0X0ol
         xqTc03htugW58J1GOIw1+oQDLbX+tnKAo5GrOwFA7h8/vuM1sBS+Un45S7CA2jFt4/bO
         lGGA==
X-Forwarded-Encrypted: i=1; AJvYcCVoBIg85jdF/NAZ/dM8w5Cvh6LHiQMEa+WNhdVRofspZ4FpChnOuoXyuJeB7FRHA6o5iFzhY/N/Jx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvXEmA2bWIRdomSjfeEsBXBWShwUjK7mbS8PNENui8lXXjBSsO
	1KL1qyaGDNNVr/ImmDMRWDWme2c19eajA4XM3vMF4Gtc/pV4jKNH2cdZ1No2rEK/
X-Gm-Gg: AZuq6aJ5UnOl8QFZAaQsFC1BqDx5n/WlnzcXkNDqb+jJL8AiAxU6a2toIi/u6JaxoXj
	lbei1UHg5oQaxICIXjaEAZ4X7Has8zyC9BI7Z8wFrkksITYOHGmn8rwpjv05/VfHPw4cXlhRBKt
	29EzEoPpYt3Kfhel1YUhOlR6gbHbsRxNrhr72D3RXWlP4TV/iCoI/IPulwE3l82X7v71WYgKtdW
	c+HSRNFG+QfHqy6Fd5da4TbzUYZgva45wf74YAUZCYKxuIUgPBphrj+5AS8Lm13Bc30ahMIagOY
	IAhDS83DoMN+uC9T2hkALeeB31Aht9dJP1YsaES6qlR2v9vcn8jm2Q3PwzbauwceqbP6q2WXDkV
	uz1suSi/flvjImmGOPADJsnzc+fwmjEazZV6mP5viI0XyVGB+t9QPZVQzyTkyWyV+vOfw+hO99r
	ECEM6PcfLxKN2jDQ9wQtcl1QIszQsAn5aIYtB3GN/rsL4MPFjj
X-Received: by 2002:a05:6102:a54:b0:5db:f8aa:3a5f with SMTP id ada2fe7eead31-5fae8c69e21mr2987705137.38.1770625089842;
        Mon, 09 Feb 2026 00:18:09 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94adb4ea33bsm474355241.8.2026.02.09.00.18.09
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 00:18:09 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-94ac7d9d7ffso804056241.1
        for <linux-can@vger.kernel.org>; Mon, 09 Feb 2026 00:18:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMo0ZHEt+M2ORhMNuxX6bx3BwaCzJw/4Y4hN/f7N/dqGUeT1Sip3jOfa9HCeuB8hvz94deKKjayiM=@vger.kernel.org
X-Received: by 2002:a05:6102:5092:b0:5f5:3c96:983f with SMTP id
 ada2fe7eead31-5fae8a3ad9cmr3362584137.1.1770624619183; Mon, 09 Feb 2026
 00:10:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com> <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com>
In-Reply-To: <20260208-rz-sdio-mux-v9-3-9a3be13c1280@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Feb 2026 09:10:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV2a7uvtrJpSprU3YbgFSTmtKkMi+Z6j0m9-4vVXWK4=A@mail.gmail.com>
X-Gm-Features: AZwV_QhXlEX6D1abbrehjsrn3uf8WxyCcirF_ZvMoX3URB-GFlRdZjQEEn6kewA
Message-ID: <CAMuHMdV2a7uvtrJpSprU3YbgFSTmtKkMi+Z6j0m9-4vVXWK4=A@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] mux: add help text for MULTIPLEXER config option
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-6512-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.926];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,mail.gmail.com:mid,glider.be:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solid-run.com:email]
X-Rspamd-Queue-Id: 9C19210CD9D
X-Rspamd-Action: no action

Hi Josua,

On Sun, 8 Feb 2026 at 16:39, Josua Mayer <josua@solid-run.com> wrote:
> Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling this
> option thorugh the kernel configuration without explicit "select" driver
> dependencies.
>
> Select it by default when COMPILE_TEST is set for better coverage.

Merely enabling COMPILE_TEST must not enable additional functionality.

> Signed-off-by: Josua Mayer <josua@solid-run.com>

Nacked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

