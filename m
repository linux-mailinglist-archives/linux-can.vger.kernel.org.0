Return-Path: <linux-can+bounces-6246-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNsvDJmxcGmKZAAAu9opvQ
	(envelope-from <linux-can+bounces-6246-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 11:59:37 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C73D3559E7
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 11:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 008D56645C3
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71F547B425;
	Wed, 21 Jan 2026 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="dz7OEZuA"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F1D466B4D;
	Wed, 21 Jan 2026 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768992130; cv=none; b=DPDjxoz/g+SSLpZNLdpvT7+GVWBb0gsX4eGHvd/vNr4pUeBtIk99R0jQxfS0b+6WWoc7VjMKnXGOWUSV8Ou+qOWW7e1tciDYP04uBz0eMr8RkxNVHjwc5OTyxu+kZ+5vhIxBynYILGbDs8UN6BGDlZ2XQnCZ6T7fBDEltgOTljA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768992130; c=relaxed/simple;
	bh=6Mm+8vvI82qWANtr0924YRHfmaPBHTkKc0qZ79hky3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uA/yZtkctUJ0tmSUNJEjkVBn3TWq4mAZONvHraf1TUcl/WACkDLdHVj0s5d7W0F7dxNqGwtPvNVQQ2rK2vEhkeeAx4TWwCqZdZu515ZNHXgM7RPC9cp4qJFY5FHBIPGPnaGcs4qXOwniIIWp+dz2RDHMoB6RVMJCXT6HuNa8Yuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=dz7OEZuA; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zscoPbAmvaBIRYYbo4mpG1SqTAb008m2Pl3AR9bRiGQ=; b=dz7OEZuASZtsmaiXkF8jYgXP9a
	w3cJUYrWcpA7PBV9qalUgu2ggp/lw9eEeLq/yQ10tZxqa6+dKqBxX8zFtKQJF4ov9bCKHNZS0mckw
	08Wrc+FQfGmYpoeUar0EoVjZAhlMx1c2KhemQRwK1e6paEcxhmt4CJKneVPqHv3O3Asgh8x+igIYr
	NquodIvuh4+iBo4qN8fMpXZu1WlQmYRS3/qHc5Sp+oh3yIqNlHRTPdETZfP/yAi+s+JBmAMmlaLXh
	aqGGUWxUhpQVk4c6rB63PLMXq40LMY9yrD4MeYgvJ6XZKCRUGWr4wM0LW3n72nCn2PA41+BhcdDzD
	R6GWy8Rw==;
Date: Wed, 21 Jan 2026 11:39:41 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik
 <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, Andi Shyti
 <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Yazan Shhady
 <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, Mikhail
 Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 5/7] i2c: omap: switch to new generic helper for
 getting selected mux-state
Message-ID: <20260121113941.68328962@kemnade.info>
In-Reply-To: <20260121-rz-sdio-mux-v6-5-38aa39527928@solid-run.com>
References: <20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com>
	<20260121-rz-sdio-mux-v6-5-38aa39527928@solid-run.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kemnade.info:s=20220719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6246-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kemnade.info:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andreas@kemnade.info,linux-can@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kemnade.info,none];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kemnade.info:email,kemnade.info:dkim,kemnade.info:mid,solid-run.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,glider.be:email]
X-Rspamd-Queue-Id: C73D3559E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 21 Jan 2026 11:20:42 +0200
Josua Mayer <josua@solid-run.com> wrote:

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
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

