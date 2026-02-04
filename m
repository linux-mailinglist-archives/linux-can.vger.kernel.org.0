Return-Path: <linux-can+bounces-6492-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOMtHw5ng2ntmQMAu9opvQ
	(envelope-from <linux-can+bounces-6492-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 04 Feb 2026 16:34:38 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5CDE8E55
	for <lists+linux-can@lfdr.de>; Wed, 04 Feb 2026 16:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0830E309F83A
	for <lists+linux-can@lfdr.de>; Wed,  4 Feb 2026 15:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC1C423154;
	Wed,  4 Feb 2026 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="TITSY7QD"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED20421EE6
	for <linux-can@vger.kernel.org>; Wed,  4 Feb 2026 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218408; cv=none; b=Lj/ktfjK94f1nlejfoaDC4vSffA0JLZL9oRER0A+3bkcZ5AHNNbmLECaKUM7/OVUBdFccezg3hE68TD49ujwofCvAJFKG287cE79zhVJh9VIh/BWQEAtYSqckP/xzeFIQU+tJiPd7ud09AGJaf6rgIC4pakeVIbHY69Xd8V88io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218408; c=relaxed/simple;
	bh=zm0/NWf7aOzjoC3desMvfaYsOJUqbgd1rXKOILzE9Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zn+kzqMrxahtsa4qWgMgvoOr6hvGcq2+c0SSnIx0kLucACkBY0RO3ZoWfA5GAvhLqhI7aJuW2JsyrRuK9SAeVHkCa6K417spvax2YJCWR/yY9M6ks1SbA6DBDCxuzHlqwJgA5LMWaZbfnA0NanJ6fcbOh+yoJSGgYjeIYbVg32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=TITSY7QD; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=WcYB
	VxLBzN05bdXXm58VZxYg22L2CN5+zoOZnZfZw14=; b=TITSY7QDqs41Sop+siRd
	1tho1l/9ahyccHqLCXwIZHSw2EG+FWoC3cF17Xrh6/1JwiADM5p62YTCUvLHvvmz
	Uv4tut+UaxTcxX1oYGZJmrOZuZMP41+OMfPOdATpFJDy/QFOyQxbLQPdDoUE2O+z
	sSYsXVQ3qjIywdhSs/hZGp3DnDYmTCx3/QRnpcSaI48107S4vlW+Bj6ko0g+iGQI
	z0tTofr3YylcIRA6RWZfyNxRtgKP1GZgSJaOKa9ZCT6fTLeR+FuX5inFdeY/KvsW
	5ya/d+f9BpkFJYy11kEkq0QZqhlOlK4O2r7F+dl3syMxTMWwP0DBm9lvmuL9VRsZ
	cQ==
Received: (qmail 2408822 invoked from network); 4 Feb 2026 16:20:05 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Feb 2026 16:20:05 +0100
X-UD-Smtp-Session: l3s3148p1@/YExFwFKwpUqAAAQagvIAoH29ntsUY5F
Date: Wed, 4 Feb 2026 16:20:04 +0100
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
Subject: Re: [PATCH v8 5/7] i2c: omap: switch to new generic helper for
 getting selected mux-state
Message-ID: <aYNjpO3uJqO4N4r_@shikoro>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-5-024ea405863e@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-rz-sdio-mux-v8-5-024ea405863e@solid-run.com>
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
	TAGGED_FROM(0.00)[bounces-6492-lists,linux-can=lfdr.de,renesas];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,solid-run.com,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,solid-run.com:email,sang-engineering.com:email,sang-engineering.com:dkim]
X-Rspamd-Queue-Id: 1E5CDE8E55
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 03:01:38PM +0200, Josua Mayer wrote:
> Multiplexer subsystem has added generic helper functions for getting an
> already selected mux-state object.
> 
> Replace existing logic in probe with the equivalent helper function.
> 
> There is a functional difference in that the mux is now automatically
> deselected on release, replacing the explicit mux_state_deselect call.
> 
> This change is only compile-tested.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


