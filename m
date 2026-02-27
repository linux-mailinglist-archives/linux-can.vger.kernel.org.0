Return-Path: <linux-can+bounces-6649-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJfgBaihoWnEvAQAu9opvQ
	(envelope-from <linux-can+bounces-6649-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Feb 2026 14:52:40 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AF91B7EBF
	for <lists+linux-can@lfdr.de>; Fri, 27 Feb 2026 14:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 143CD30138BC
	for <lists+linux-can@lfdr.de>; Fri, 27 Feb 2026 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD6938BF66;
	Fri, 27 Feb 2026 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKTp/tLu"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D90239E7E;
	Fri, 27 Feb 2026 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200354; cv=none; b=cUaJOZ9+BJXJe4zob6UY7ikXFv0Tn0ciF++iYnKHmGNTJ97/IGn9FB+FR/rWuK2yI1ph+X6jrylmfqdK53M3Wh3jcSzc6YVwSVZ4aq4+WSYaPCBXagpMaYLSMTTpyZyO8Gz+UujhWPsuVoe+257YBu4uIFpGpM2JWSRMfQ9yf3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200354; c=relaxed/simple;
	bh=1aioRZsT/x015BhRflc0NizKTzba3nmZZdRjXLysTLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeaIhWh2PaCukL7i5iZbGMuNm/9NFXgXwo68x70SUsCuJRGXmEE+Jj9af6RJJqjHg/G3NfbbOqPEVn3B24AIxgCSEvscMkeP6y92bryKX/TnkT1tjOQr8zJOeIESZ+plguHTL0Uic+G+cBZNhzkkA1wNzguaqeQ/ZwkZkpLcQiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKTp/tLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C076BC19423;
	Fri, 27 Feb 2026 13:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772200354;
	bh=1aioRZsT/x015BhRflc0NizKTzba3nmZZdRjXLysTLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZKTp/tLu+wqzSPRuDSsgiiAj+iG35J5v43Y0sjKtzn3ByCpGg6WGzAZh10dKcs94N
	 SScd4MzCSMOaib46Rj80zqtgiPVuKuIA0ZXF92yxf/r8I8/udV/xItmlrxR1FsHR0q
	 //5CEUy5kcR5lE9mod7Z2ov6Ey/1mcganvINJK6o7UvSCs8QCwHXylRP1zxrwaJ4Im
	 9YRKhj429gJ11KkgSp6oV7+GGJLcmuPTqgZMGYRBShWSIKG0EUrrgnx5z/O+DOgBAh
	 m5CBn36upkSlQh52p+FTi/q/CnGLw89qSiKJL7YVAmHovGT8wA7X1LGCA9yiOtFLRP
	 20cNtPCl9A9tA==
Date: Fri, 27 Feb 2026 19:22:31 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v11 1/9] phy: can-transceiver: rename temporary helper
 function to avoid conflict
Message-ID: <aaGhn_vBoruYDqji@vaman>
References: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
 <20260226-rz-sdio-mux-v11-1-c2a350f9bbd3@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226-rz-sdio-mux-v11-1-c2a350f9bbd3@solid-run.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6649-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,renesas.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4AF91B7EBF
X-Rspamd-Action: no action

On 26-02-26, 15:21, Josua Mayer wrote:
> Rename the temporary devm_mux_state_get_optional function to avoid
> conflict with upcoming implementation in multiplexer subsystem.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

