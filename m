Return-Path: <linux-can+bounces-6408-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAucHrCje2kVHgIAu9opvQ
	(envelope-from <linux-can+bounces-6408-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 19:15:12 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E774AB372B
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 19:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 850B4301981E
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 18:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215522F28EB;
	Thu, 29 Jan 2026 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mZrJQ+RD"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBDB2EC559
	for <linux-can@vger.kernel.org>; Thu, 29 Jan 2026 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710510; cv=none; b=ssUk4Nognt4VJ78ElTcwiFcPjoLGjGpqAmbyZd3viRn4geq/FOhycciYkr986dHPIjTckpfs9CG1KfC43kMzsWDEWhUkfBX5A2L2x6qbi4SSQsffYUkr2guFfxHR9M8M49A45J/J9Tjw/M2fGS7wOxptD6+P/iuBV7U0Dc5tcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710510; c=relaxed/simple;
	bh=4MJvj2+fHYfSWTC96lU3fBxhfU5kqQ0zRTEQY/NwItc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fT+mFDgk+ddvPRiaVliCWHU352yDi8P777XhVRn9/rpi/OS3e+8VpsuYmFpeNk9CHzZ5psstznHaywwQOKyDdS5T4ADCKQIFXUkePfW7V1lnQJZ2NocsgyI5DOiJQvXP7wFdKgARfUQX+jzL84Zf/AHUJ1TChohI75XnlCeGouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mZrJQ+RD; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=kMwJ
	sRUTY1+8DlXqwrzudKGi67r8tcF8NN0fyMeA4OI=; b=mZrJQ+RDSMYjGwdVp2wP
	GzAkcvLuH78nOpPUuIN36eh/2nTSF5H9WVKg1Gmg98Jwk3KE3AUZoOaY9JBtHaGd
	Frd6gTcLDqOz5v1S0wcpf/bx9u4Xm+FZlru7a6OhVRjpeHbtFEry2iHyQJXKqXY2
	/B3zB2GINvd41izUXf2jojEJp70bEoY5c5ypI/7SNyTIfZTavHXwVYRki6HuVT7F
	aUZPwL1Kits1/RJUOAAJQGhN+NZ5MOjw+t/8xMuEaODY+opLGlWzIdKv2HTd98Tq
	3Gkv3tFwhSZKxdKWUNedaH5aHSJow2GI0M5IvYzVsb6SZgB2pxySgwEnEWqefkVf
	/A==
Received: (qmail 4159334 invoked from network); 29 Jan 2026 19:14:56 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jan 2026 19:14:56 +0100
X-UD-Smtp-Session: l3s3148p1@5gh11YpJZEVtKXEx
Date: Thu, 29 Jan 2026 19:14:55 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Josua Mayer <josua@solid-run.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Vignesh R <vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
Message-ID: <aXujn-jpKLcBeFPE@shikoro>
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
 <CAPDyKFp9StNf1eLaSETxC72=7sXYBmGFmHnv0CXysUGcYma5VA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFp9StNf1eLaSETxC72=7sXYBmGFmHnv0CXysUGcYma5VA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sang-engineering.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6408-lists,linux-can=lfdr.de,renesas];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[solid-run.com,pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,solid-run.com:email,sang-engineering.com:dkim]
X-Rspamd-Queue-Id: E774AB372B
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 05:15:06PM +0100, Ulf Hansson wrote:
> On Wed, 28 Jan 2026 at 15:46, Josua Mayer <josua@solid-run.com> wrote:
> >
> > Some Renesas SoC based boards mux SD and eMMC on a single sdio
> > controller, exposing user control by dip switch and software control by
> > gpio.
> >
> > Purpose is to simplify development and provisioning by selecting boot
> > media at power-on, and again before starting linux.
> >
> > Add binding and driver support for linking a (gpio) mux to renesas sdio
> > controller.
> >
> > Introduce generic helper functions for getting managed and selected
> > mux-state objects, and switch i2c-omap and phy-can-transceiver drivers.
> >
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> 
> This series needs to go together in some way. If you like, I can
> funnel it via my mmc tree, unless someone (Wolfram for the i2c part?)
> has objections to this of course.

No objections, I even acked the I2C patch in a previous series. Since
the series changed because of some of my suggestions, I want to have
another look at it. But yes, your tree sounds very reasonable.


