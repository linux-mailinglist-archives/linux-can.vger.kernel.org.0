Return-Path: <linux-can+bounces-6491-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN3fMmtmg2nQmQMAu9opvQ
	(envelope-from <linux-can+bounces-6491-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 04 Feb 2026 16:31:55 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D17AE8CA7
	for <lists+linux-can@lfdr.de>; Wed, 04 Feb 2026 16:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D616831D460F
	for <lists+linux-can@lfdr.de>; Wed,  4 Feb 2026 15:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147CA421A15;
	Wed,  4 Feb 2026 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="me/u1gQI"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E241C319
	for <linux-can@vger.kernel.org>; Wed,  4 Feb 2026 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218402; cv=none; b=SjSZRQaNH/4pPdX6V9lRfbz1GBqlxUEifhGP0xODjf8qkNx1whPrYSxgydMY1JwoDPUkbtPB9K8795jnZyuqDbWkcgxxS9Adnnwg3n8u239zoWCOwpoi+1qDzNqaafFOKkDSgRubFOstXWAd+fLGr+c7Gk39aOhKdJLwPf7c8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218402; c=relaxed/simple;
	bh=EPJA/uh8iTFDZsW7kgP1KlgwFkZNsETk3q8ogYxI8+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRQvyE0ebCIOUc0tf2k1E90eFun2Wp+2iGk/rFVK1GzAGMaOZltvClemOUBx7bsI+TTrOPOZd+rw+u7RHxXkBzbA4D7Gi4yzdqlKnfvjgP/ht0Lz+lzq6xhWkft70Kiq55Fl/KDaP6vlk1uNzKCyVgjl9wNGyWtUWkDv3cvl0/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=me/u1gQI; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=RTl3
	4GdapOHrIFn2PsIr7Sa6lCunHmnETaAYG/rtoLw=; b=me/u1gQID+44jQjIesVI
	qxsadN9LfXybobPB9QcuFB8skQaPT+uIozPEagA/w+78A09XQP/zu3W07vGxYxNu
	R9DgZPmtDhZu/8vG/MA/U3QCizJ6h5rVTBV/XVv4Lgaq8n81m3swfOOhBs9+uwog
	seJ76VcdLcG1LqPz0toy0VR8+bsNUW+AcvokqjjeergnSxqvAFLMvUP6tofpPv6X
	QacoOUtIQ6/km4mduTorqF+DV44PFzt56fch+KJNRe72JaP05yGVSn9IBVae2Wu0
	hetMvSlaz7Qv2rp70r8IchiOtk2wUpMFESyLtXYmqlGyNSbMfYVYFntOAyu878kC
	ww==
Received: (qmail 2408564 invoked from network); 4 Feb 2026 16:19:58 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Feb 2026 16:19:58 +0100
X-UD-Smtp-Session: l3s3148p1@cTHPFgFKnLgqAAAQagvIAoH29ntsUY5F
Date: Wed, 4 Feb 2026 16:19:58 +0100
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
Subject: Re: [PATCH v8 4/7] phy: can-transceiver: drop temporary helper
 getting optional mux-state
Message-ID: <aYNjniyEZ355QE28@shikoro>
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-4-024ea405863e@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-rz-sdio-mux-v8-4-024ea405863e@solid-run.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sang-engineering.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6491-lists,linux-can=lfdr.de,renesas];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:email,sang-engineering.com:email,sang-engineering.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D17AE8CA7
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 03:01:37PM +0200, Josua Mayer wrote:
> Multiplexer subsystem has now added helpers for getting managed optional
> mux-state.
> 
> Switch to the new devm_mux_state_get_optional helper.
> 
> This change is only compile-tested.
> 
> Acked-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


