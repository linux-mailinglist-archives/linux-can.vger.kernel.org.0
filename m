Return-Path: <linux-can+bounces-6974-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIy2Mej0qmkjZAEAu9opvQ
	(envelope-from <linux-can+bounces-6974-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 16:38:16 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD855223F5C
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 16:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9FF0303366C
	for <lists+linux-can@lfdr.de>; Fri,  6 Mar 2026 15:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C091C30E84F;
	Fri,  6 Mar 2026 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gXFLd6m4"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24714361DA5
	for <linux-can@vger.kernel.org>; Fri,  6 Mar 2026 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811196; cv=none; b=SnHfJjUU5WeW/dQjKGBThVGpV4kiqgFV1ohbohzpRr50f+OdWuk8s2NAuEQPaxcB9XvXRHWAfj7qXsnmTLqsUS2eJx7UM1H/gWn7tjTm6zqeHeLWe13mRYYT37baPMz5Cvli/TpxsCYj4UTkS7EKTeyP2Vzhtjs7wCQXoXbq8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811196; c=relaxed/simple;
	bh=bcSBsjGgici2Ik1sG34jJQmzUF8m5cQXx4XEbIzOjHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QecjKXXvkU0EKLdyo4wEA+JVkj8dtrZanIJ+Q8ywjQvLGEvOAf1qgZBX/lEuW1xBFgW74kyvdW2hL9wWbT8FXL4ltvp/2Jo8hKn4xpwgL2Oo+5M323Px8k6TJ5clQt/BKn/pQ9ZNk1YHrqBXmdzspt4hENn69oNLeGK26P5dje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gXFLd6m4; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=s1cu
	QDsG6Zp0lohUD8JZqduywcTu0nS0IvyfvMb/LrU=; b=gXFLd6m4lL00z1Xt4Zqf
	qJZEngkn4txbzsE9YboB6vNiiLHq9kK4Yy6DbDaVV7ej2b9clDQsNuaGoL+G4u+s
	tMuFLvCFIAswE4xSzAlhfZCsz94+szcxvXqlsBSuMLgZw3zmSvg5cIKGvJHMoPjf
	TiIdwj3SrpOY5Ep9KUFN+wnRqZyAlTCUHY/MBe2kBw8WUX5C3phbY0SbLWygO/Y+
	ihkeA/mhE1DjVSONYL9+tWnUI0BICh/0jfJPaYusZTIGdJPyx6YXZIbr4lKkXXCG
	FiLUo0Daj33caZU8BTifdOi+7jARPrtwbF4QWP0wfIieF67Utbenrk7UnrgDj/iG
	yQ==
Received: (qmail 1689643 invoked from network); 6 Mar 2026 16:33:12 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Mar 2026 16:33:12 +0100
X-UD-Smtp-Session: l3s3148p1@lHNXxVxMMN4gAwDPXzF+ANZpdrMKUeLI
Date: Fri, 6 Mar 2026 16:33:11 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Vignesh R <vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v11 5/9] phy: renesas: rcar-gen3-usb2: drop helper
 getting optional mux-state
Message-ID: <aarzt_BsQlwFI8Zb@shikoro>
References: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
 <20260226-rz-sdio-mux-v11-5-c2a350f9bbd3@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226-rz-sdio-mux-v11-5-c2a350f9bbd3@solid-run.com>
X-Rspamd-Queue-Id: DD855223F5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sang-engineering.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6974-lists,linux-can=lfdr.de,renesas];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	NEURAL_HAM(-0.00)[-0.984];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,renesas.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:email,sang-engineering.com:dkim,sang-engineering.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 03:21:13PM +0200, Josua Mayer wrote:
> Multiplexer subsystem has now added helpers for getting managed optional
> mux-state.
> 
> Switch to the new devm_mux_state_get_optional_selected helper.
> 
> This change is only compile-tested.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


