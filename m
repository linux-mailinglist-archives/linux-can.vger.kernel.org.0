Return-Path: <linux-can+bounces-6958-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBhnEEitqWn+CAEAu9opvQ
	(envelope-from <linux-can+bounces-6958-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 17:20:24 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 82756215573
	for <lists+linux-can@lfdr.de>; Thu, 05 Mar 2026 17:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D8053003813
	for <lists+linux-can@lfdr.de>; Thu,  5 Mar 2026 16:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB4E3CF66B;
	Thu,  5 Mar 2026 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1rxxZ+R"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB543CE4A0
	for <linux-can@vger.kernel.org>; Thu,  5 Mar 2026 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727597; cv=pass; b=D7BY95uHOfOgWxJP60v+JjFDi7chXmeeCHBpT8MY4tIAZL/ZZaOUOWWr3hfhySnm8xggszcV5FaSmAYC1NWfflRdVdnG/KntZo43WxnkRqxRaGJS77Pwx52tnfbpZEFkPBnXtXppLmAfh6+3oHltjUHjhqBlK+EJIcrcJIgC9AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727597; c=relaxed/simple;
	bh=4+VpwCYiZ/k0oS5DZgX7u4wiQTYlbC6gsA/O1CRuO+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2PhU7s0CFVHx05H5AZDZAoESblYzvO3pxliS+zQ6VXvAYs6YdYXosAFGJQrrBWHegI50OxEXDyH/hPuRUsjRqp06Bgk3QdcvNTpxCgxm0+qXOABkG6mPFOlni9OtlUeZnufWLKQ4AV7VFbj2qBjqAnj19BD46Z3rYMEhdmT/so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1rxxZ+R; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a12cc20e71so935736e87.0
        for <linux-can@vger.kernel.org>; Thu, 05 Mar 2026 08:19:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772727592; cv=none;
        d=google.com; s=arc-20240605;
        b=D3pTGUXksvgSPel6gkNt6wWP+j7LKn9BT9tYLgSyOH8x2I0c3KNBVGU8xKSJ+CXkBy
         lpsGzVf7DSdHxTK73Xav57LOq3FJz5dGTeULiD/mZLaMssUYgGARHMUt0SqL0jPlg1Ai
         6PWJsA38YLDYnEcjMcSDBHulRBuERggFwztHk3/xaBF4pHbHTjpg+KnCI+fkJOZL5/WH
         IFGi3+zOYQa9KbYvb0SGd7YSdEPu1/2spAYP79el4uetLUxUUW5k26sGZGdlxOkNnw+p
         FQ5PahaE1Tg6XxmfJxBv9Hf6p7pKEEgxOIe5C4gsFN+vxxqAeDhaan1+74c9jVYhL9fq
         OKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ClrW0+oPx++TxWQN/hIjl8TEzU24ahyY2M6DFRgObAo=;
        fh=M3LtXUan0wMiIHzG8ZdXWDJbn8QcVlq2JHDalbMC6j8=;
        b=Di7gZgRX7HpFb2PsTDxyqANewGlLVlZlc664TXhzcw08veDc2E3oJtTwxMu2p1A586
         Hu/tKHmhbTPrAWOZtWDKvqs7PGBp+v3/s0br0YuC1J3efCpB4v7NXi1ieeCX2w2Ooo0r
         eJaw7ix7tH2x8DHPSVJWzsdeT5TnvzBzC0EV+mQ1P0vrc40CHs474eX2S5y2nKsHuLnA
         RoP37Pknzs3nS1NThyKWTfT0SgVKNJF/n6vu64EhmhdE+LGhVo+oFUJBqy7hw/H6v9Fu
         GBTcD7Tk9731iUyPv84yZye2doVWGgOfpmGnu6WCf7zp///VTcFnqhrsYeJALXri6cS6
         /7Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772727592; x=1773332392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ClrW0+oPx++TxWQN/hIjl8TEzU24ahyY2M6DFRgObAo=;
        b=q1rxxZ+R/c00OLVd9zKREVlXnhXnf6dPnJHoQd9Fv3gM1E3n78TlIvVbGLmf/H6rhN
         QCLaLoqK0Hzum5zfvQ5aGdm869aGH0kiv9vsCJjgeRf+kTE0OCbV/OR06HMNqe/lYz/h
         JI0iEmSqBYk18AeQlvwx5ODpYlKfMNze4jVK/TgBdwpIFFNlZ923Pf63pIjP3SaiwJBO
         h2oRjXurKMaxZIVyQvNcK046OMfRSabM9VrTrrulW9zYWTBJaDImY1lKqSjkBeGgfp6I
         IUegtysfkxBHDj6KnahmtbocAUBZocYgHQHNhJdde5aFLEtXsBmlxeOO9vRDWmULvEfA
         442w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772727592; x=1773332392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClrW0+oPx++TxWQN/hIjl8TEzU24ahyY2M6DFRgObAo=;
        b=NZA2GUgIlIxWPEjxJVssFcRIEbG4vLmIxsmnNjbYEUWtO8f1pjnjg0g4kTLcYuRFw9
         3y4ynTmrBfbtK82PU2LFj6qjRvHMOyt34C5bjm0DVJ5Wd62jhv/vHmU7Hw0r/zWH3Hcq
         456Ue/uaQKfpXCEUCL2H+TmrKvGYvrShh2vOPIy/SifoiZ+Z2Pl6CX0iTTqQIX18Cnn7
         An/0JF8oUckRVmdA0Y52IeyLvq3B0wzd3eckUjKEniCQZs0x3UgPdvbUzkpha7l8NVxA
         VCIrExBV+5a4eUN+3aHDE5NUxamv3u0l2Zi5c69VYHHQUSF8Ui0vYPsToqvwtyjShKtl
         QyUg==
X-Forwarded-Encrypted: i=1; AJvYcCVfpbSn2OdI9OZs+ILPZQ5pTEbfDhi61yKaXqPTzyPRLYllmG374iL2b82tagIgIIwiYmNulFeJYLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6agwX3Y2fXCCC+EwnSxrzQior49lJ7h6uTCFwWXxELOuuExga
	Lq7/HDetLt30tSPtYrC6TFIlrUO/RyR2ZyYE3PPxbOJjs1aqH+11Qpyrcdzl36IcE4KQB69c+Ei
	ixGEoAuXoQiG4Xmg+UCZa/Hmaz63QlPcC8W0CvM04Fw==
X-Gm-Gg: ATEYQzxy2D9MlCgC3o7AbUbxgED6gFjGhg6SuuEU9udb78cKjxHZDCnVGGFpdJEd0H2
	L/f1xdSC8zC54LPKZcQzVsFIPiKFDbePJmUpFzXGqQpljXLlNbRp+gH8vAL8pMoy+wNdy7SRdGJ
	JKyAgN5sm3MEbvCXxbdgKja2Ug+JqeSm5/KuHFciGX6E18PXZpNQJtWgxTn53nm0mCd4z54CMXC
	jobmvjl/19V09a/6vkT5unsgsk1pDdXzsr3dEqxoZzMQHMz2NGmbTYfCv6QBfzsFST8VC5rkZp8
	nQmqNC5t
X-Received: by 2002:a05:6512:1288:b0:5a0:fe69:af2c with SMTP id
 2adb3069b0e04-5a12c339474mr1173761e87.33.1772727592278; Thu, 05 Mar 2026
 08:19:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
In-Reply-To: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Mar 2026 17:19:16 +0100
X-Gm-Features: AaiRm52HLUuRfxFPVPVExv-76gWZPV1pu-J_tp-8KI24bnstuTqUB205NGBVxZk
Message-ID: <CAPDyKFr5NZKEKpV2+GXGnzH9pyyj_TLmMCc3rac8h248srX_dw@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Josua Mayer <josua@solid-run.com>, Peter Rosin <peda@axentia.se>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 82756215573
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6958-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,solid-run.com:email,linaro.org:dkim,linaro.org:email,linux-m68k.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 at 14:21, Josua Mayer <josua@solid-run.com> wrote:
>
> This series has evolved over time from adding generic mux support for
> renesas sdhi driver, to partial rewrite of the mux framework.
>
> Several drivers have started implementing driver-local managed and
> unmanaged helper functions for getting and selecting a mux-state object.
>
> mmc maintainers have requested that new code shall intreoduce and use
> generic helper functions that can be shared by all drivers, avoiding
> code duplication.
>
> This series is structured in 5 parts, each of which is self-sufficient
> depending only on the previous patches. This shall allow the first N
> patches to be applied even if the last ones need further discussion.
>
> 1. Rename driver-local helper functions to avoid name collision with
>    global version to be introduced later.
>
> 2. Implement generic device-managed helper functions in mux core.
>
> 3. Convert driver local code from similar patterns to use the newly
>    added global helpers.
>
> 4. Change mux-core Kconfig so that it can be enabled through menuconfig,
>    without an explicit "select" dependency from other drivers.
>
> 5. add dt bindings and driver support for mux in renesas sdhi driver.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v11:
> - changed approach to Kconfig making MULTIPLEXER a bool, and adding a
>   user-visible wrapper for menuconfig.
>   (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
> - dropped the "default m if COMPILE_TEST".
>   (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
> - improved kerneldoc line wrapping.
> - removed unnecessary changes to original devm_mux_control-get.
> - fix "reference preceded by free" in mux_state_get function
> - Link to v10: https://lore.kernel.org/r/20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com
>

[...]

To me, this looks ready for a new try. Unless I hear some objections,
I intend to apply this as material for v7.1 via my mmc tree on Monday.

The complete series will be available on an immutable branch, for
other subsystem maintainers to pull in if that turns out to be needed.
I let you know of more details on Monday.

Kind regards
Uffe

