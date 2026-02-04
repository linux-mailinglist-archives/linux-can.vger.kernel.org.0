Return-Path: <linux-can+bounces-6489-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sP/DDuhmg2ntmQMAu9opvQ
	(envelope-from <linux-can+bounces-6489-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 04 Feb 2026 16:34:00 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D63D0E8E18
	for <lists+linux-can@lfdr.de>; Wed, 04 Feb 2026 16:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0168630999A7
	for <lists+linux-can@lfdr.de>; Wed,  4 Feb 2026 15:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9B629AB1D;
	Wed,  4 Feb 2026 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="JcjpCjHg"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287C22332E
	for <linux-can@vger.kernel.org>; Wed,  4 Feb 2026 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218360; cv=none; b=R+E0TnQX+i9EU16LbEVNYpGMBeljV3qq/tLjMQ4mW1gGeSlqMxWtLGJkQjO/4vIq7xn4F6UEJoR9fES1xQnjqXbvgNyF942rr6sz83TA21bFbw6uNHt9ZPzTUhgPGtrB/opnXLKeA0AKPxn1oeDcdy+qeXiCtKqBdd9RSAoJ5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218360; c=relaxed/simple;
	bh=9jRUdh+pXDDfM+yVHrnf92zFnREdV5FD0ABAEsfxrzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3QS8iB6rdt534Tu8cyQGk2PHmiSgQjfRwXgP2D6CVXiXSS9bOrgZdvmnWxS3avisIJLVqD9099zSIo6EOg51NQdiIsJj6cTVTvcyW/VjBoB4clTaVqM0rEjDG3+IWXnMIjRMmtyBUiyVUGgDHhkIHu/nMREfsSyF+xUaim1nIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=JcjpCjHg; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=tfas
	ogbOh13N38230xubhMrZ3ndWq1FR/ZTYsvkPCVE=; b=JcjpCjHgvrmYVT5l70Bb
	sF50zCELOt4m5S7Zy6kG2fCS5q5BL83OWx4C4PkwYXmudyhWTE+pZvQ38x00TILA
	nPBRdeLEwQWqDcoLSB6JKH1OboZhMpQrC0MBtJ2WtHup5G2SArbgdyHQ3PfnDFxV
	QzNbIuxgnI0lzmDouvcLR950ZTtiIbp9PudSz43ZouKt4UGc8hXqxgfdSz5qgyUM
	66PjJrLBto3MbJh1umKbHgvc9OL50hJ4bU0H4VV14y1szYNAkK1JphscwzmlAZJr
	ePvocp2/GKkZY61J1C1OCL+D+InOKf9AOxTjxojgDT3/ONPLjfrUrVz75qO/xDnx
	1A==
Received: (qmail 2408096 invoked from network); 4 Feb 2026 16:19:16 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Feb 2026 16:19:16 +0100
X-UD-Smtp-Session: l3s3148p1@afZLFAFKApoqAAAQagvIAoH29ntsUY5F
Date: Wed, 4 Feb 2026 16:19:16 +0100
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
Subject: Re: [PATCH v8 2/7] mux: Add helper functions for getting optional
 and selected mux-state
Message-ID: <aYNjdKul53HalKdw@shikoro>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-2-024ea405863e@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-rz-sdio-mux-v8-2-024ea405863e@solid-run.com>
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
	TAGGED_FROM(0.00)[bounces-6489-lists,linux-can=lfdr.de,renesas];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:email,sang-engineering.com:email,sang-engineering.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D63D0E8E18
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 03:01:35PM +0200, Josua Mayer wrote:
> In-tree phy-can-transceiver driver has already implemented a local
> version of devm_mux_state_get_optional.
> 
> The omap-i2c driver gets and selects an optional mux in its probe
> function without using any helper.
> 
> Add new helper functions covering both aforementioned use-cases:
> 
> - mux_control_get_optional:
>   Get a mux-control if specified in dt, return NULL otherwise.
> - devm_mux_state_get_optional:
>   Get a mux-state if specified in dt, return NULL otherwise.
> - devm_mux_state_get_selected:
>   Get and select a mux-state specified in dt, return error otherwise.
> - devm_mux_state_get_optional_selected:
>   Get and select a mux-state if specified in dt, return error or NULL.
> 
> Existing mux_get helper function is changed to take an extra argument
> indicating whether the mux is optional.
> In this case no error is printed, and NULL returned in case of ENOENT.
> 
> Calling code is adapted to handle NULL return case, and to pass optional
> argument as required.
> 
> To support automatic deselect for _selected helper, a new structure is
> created storing an exit pointer similar to clock core which is called on
> release.
> 
> To facilitate code sharing between optional/mandatory/selected helpers,
> a new internal helper function is added to handle quiet (optional) and
> verbose (mandatory) errors, as well as storing the correct callback for
> devm release: __devm_mux_state_get
> 
> Due to this structure devm_mux_state_get_*_selected can no longer print
> a useful error message when select fails. Instead callers should print
> errors where needed.
> 
> Commit e153fdea9db04 ("phy: can-transceiver: Re-instate "mux-states"
> property presence check") noted that "mux_get() always prints an error
> message in case of an error, including when the property is not present,
> confusing the user."
> 
> The first error message covers the case that a mux name is not matched
> in dt. The second error message is based on of_parse_phandle_with_args
> return value.
> 
> In optional case no error is printed and NULL is returned.
> This ensures that the new helper functions will not confuse the user
> either.
> 
> With the addition of optional helper functions it became clear that
> drivers should compile and link even if CONFIG_MULTIPLEXER was not enabled.
> Add stubs for all symbols exported by mux core.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

I trust you guys with this one. I think the interfaces are useful,
though, so maybe like this?

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


