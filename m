Return-Path: <linux-can+bounces-6496-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NorLhBrg2m3mgMAu9opvQ
	(envelope-from <linux-can+bounces-6496-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 04 Feb 2026 16:51:44 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B568E97F4
	for <lists+linux-can@lfdr.de>; Wed, 04 Feb 2026 16:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 311D9300337B
	for <lists+linux-can@lfdr.de>; Wed,  4 Feb 2026 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEC43D333A;
	Wed,  4 Feb 2026 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mVzufcXf"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6632D593E
	for <linux-can@vger.kernel.org>; Wed,  4 Feb 2026 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220025; cv=none; b=ceEVpTXqIlxKrrjejRz3PzR+n8xM9ltCKG1hoGyURkLhmteTngxlLUBQFp+ULh8soUQM47nG+eIE8fe/NWrYqAoWboCgV65vYnkUVD9tHCshQcgNdHYM0vspHJcuaOkfYLiDflOAjaSt2XJ10jFkGt10hbfhpGnDhB5dZhvgBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220025; c=relaxed/simple;
	bh=NhBMhptCDXkwpcXyoAjy4paUP5kVjoY/noDcDnftIxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILFUhN+pnImh+cqCWX0f+idxY8pkd+lmB3r62X5lEJHOg5d9tkY/6yugQ3+4tw9kNo4usHb3J+KpyCAbt6i6TmjqyWjIco+KcG/nzyEavcM5IdVD38m5s9eAvzMENTQm7rYpV0L55D4oDeMh39zv3YfpkgZhyLyBaBGYRakttsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mVzufcXf; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=9pjd
	1Z0abUIs/vb7jSYDYMKbNGzdvIiPE6k3qOxN4n0=; b=mVzufcXf2pCcfgow2H4I
	4WfypG+vvaw0CzCW++E6pTpghodG+FWoDs6BVs6KJ0S5ax+QoUq9WKejdXaFgdDC
	zLja6YCEkfnadgfeB1VGSe2SCvda7B7N7i2L8+ThOPWO9qFK20FjQCcWYDFmzdBC
	20U6oQTvaFskSjER5kpMuCM4lZEjNlShSfl00FqW0aiQcE2/I0pnskekj+3kXGSG
	4vayQRhLxRv0jJveM/536o64o1xRf/RQb4L8pfKRfs7W9BdcEh6qNzsELNadNr4O
	XcQcEjfYwfip0kGKCO/okuRxMzt2MGQVFxckDlBloIeyrt5bstYIvkkuhSTgNxB3
	cg==
Received: (qmail 2418933 invoked from network); 4 Feb 2026 16:47:02 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Feb 2026 16:47:02 +0100
X-UD-Smtp-Session: l3s3148p1@UtCVdwFKnOkqAAAQagvIAoH29ntsUY5F
Date: Wed, 4 Feb 2026 16:47:01 +0100
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
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v8 7/7] mmc: host: renesas_sdhi_core: support selecting
 an optional mux
Message-ID: <aYNp9Uqj-Sq67T7N@shikoro>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-7-024ea405863e@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-rz-sdio-mux-v8-7-024ea405863e@solid-run.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sang-engineering.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6496-lists,linux-can=lfdr.de,renesas];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,solid-run.com,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sang-engineering.com:email,sang-engineering.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,solid-run.com:email,glider.be:email]
X-Rspamd-Queue-Id: 5B568E97F4
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 03:01:40PM +0200, Josua Mayer wrote:
> Some hardware designs route data or control signals through a mux to
> support multiple devices on a single sdhi controller.
> 
> In particular SolidRun RZ/G2L/G2LC/V2L System on Module use a mux for
> switching between soldered eMMC and an optional microSD on a carrier
> board, e.g. for development or provisioning.
> 
> SD/SDIO/eMMC are not well suited for runtime switching between different
> cards, however boot-time selection is possible and useful - in
> particular considering dt overlays.
> 
> Add support for an optional SD/SDIO/eMMC mux defined in dt, and select
> it during probe.
> 
> Similar functionality already exists in other places, e.g. i2c-omap.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

And to confirm the obvious, no regression found on a Renesas SparrowHawk
(R-Car V4H) not using muxes:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


