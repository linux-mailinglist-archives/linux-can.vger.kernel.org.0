Return-Path: <linux-can+bounces-6143-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEE7D1E9AF
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 13:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3E98305A03B
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD671399037;
	Wed, 14 Jan 2026 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Z+N4yast"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB804397AC6
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391404; cv=none; b=SdmteupcyB5uIHlpwMBQ7OAmjtrj9xTvpSBtXJdn8wOvq1UxI/GFawfzaf6phun2u64EsPdxF78DuG0uF4aPZCVQzkdt1lUbjxAAekENcv46ekyFvU0rQxqfGQVI7s3cGCKlSIjj6MTKNANJJmjR+r++MvgsM+Id/2/OfTv6yuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391404; c=relaxed/simple;
	bh=5G3bZDFv1qBG7SvPosgBK8cERnxjv6HIzxzWgJHcMAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XseXt+8KEh3zEh6B4FplEq7o6eaYEee9abp7HvBJvj/bsjBIN7XBu+Q7BAy/96q2KY1kf3OlWFrAjnXXoyFTKxpX4NcmiK/LQDdfDeBp2IBZsYWqixBRZcRT5SC5yAffDnw6nVeDBQw44Maw3AHdUQM0OFMeNH4IT9ZQUTzJwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Z+N4yast; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=gNMi
	hpzhf2NxKZIcbZg7O2NEUbdwfbHtTszJtzgTj5I=; b=Z+N4yastOsG1hmW6/MpE
	qJn3S1j5gjDiWLbMXPIr5OKNab4rVxTQ1ISuU/PcwKJNFCP4kxxx0cMd9ocJEYwl
	rBtM208IDnsTl8YCpApJaEv88+NT0Em1NPc6Tbvj3/9uHqA8vQBIxg0QH3KVhUAz
	SwzHYADFiSMrJvV/ycsNqExqc0zRxVlOU39NKRHInFy+QXnjDjIz30avvFuZ8F5g
	Gri7hALcq59mlzxXhbANhpN56BlQ/DVpj6Snpm6iAjr2YruLmkQC+vnuhFN6BWmF
	JGzVQI/FhDVQVlpXXlNU8Dcyl5bl8RnycG1yAVJyIZ51ICoNtHhpMUKvwBQ20Fi/
	7Q==
Received: (qmail 2113255 invoked from network); 14 Jan 2026 12:49:58 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Jan 2026 12:49:58 +0100
X-UD-Smtp-Session: l3s3148p1@tokXtVdIoNkujnsM
Date: Wed, 14 Jan 2026 12:49:57 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Vignesh R <vigneshr@ti.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 7/7] mmc: host: renesas_sdhi_core: support selecting
 an optional mux
Message-ID: <aWeC5brP_KdrCmHz@ninjato>
References: <20251229-rz-sdio-mux-v4-0-a023e55758fe@solid-run.com>
 <20251229-rz-sdio-mux-v4-7-a023e55758fe@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229-rz-sdio-mux-v4-7-a023e55758fe@solid-run.com>

Hi Josua,

thanks for your work and kudos for striving for a generic solution. It
seems worthwhile to me to add the helpers. I have questions, though:

> +	priv->mux_state = devm_mux_state_get_optional_selected(&pdev->dev, NULL);

The minor nit (which may be bike-shedding): Maybe the function name
could be '*_select' instead of '*_selected'. To make more explicit that
this function is actively changing the selection and not passively
retrieving the current state?

The bigger thing is that with devm_* I had the expectation that
deselection is also handled automatically...

> +edselmux:
> +	if (priv->mux_state)
> +		mux_state_deselect(priv->mux_state);

... so I was a bit surprised to see this manual cleanup. Has it been
discussed if that deselection can also be in the helpers?

Happy hacking,

   Wolfram


