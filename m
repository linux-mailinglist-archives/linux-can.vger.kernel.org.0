Return-Path: <linux-can+bounces-7942-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PfIAIrP8RGpo4goAu9opvQ
	(envelope-from <linux-can+bounces-7942-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 13:40:35 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E176ECE90
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 13:40:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7942-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7942-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36E2F309E8CE
	for <lists+linux-can@lfdr.de>; Wed,  1 Jul 2026 11:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5213E834F;
	Wed,  1 Jul 2026 11:37:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F7C4218B8;
	Wed,  1 Jul 2026 11:37:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905840; cv=none; b=BCeC0CA41sLoqftpB1UuNioagpGthffqyXxh/QV24qb6kt1UKyU3TAM9SG9DXlOqOMJLIwRlb/LaLtDOjLkRayRuI3PAUwNM/OHDPr/237i7pTz8MYgR7NZwKMoWNWQhtMSmKdiyRS+4/MlqOklMnsXClkwdEhgVCPVKQm3sz2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905840; c=relaxed/simple;
	bh=fFamLJXyVNWLfc4YsfADaYv0ySxF115qkDAdWhni5/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYRkUsumTviaOvo4P/xOvN6zyDLEjk3MXywQrWOWKWRn/qq/dr+r1dBcI/wMXMjuxjinyfvJ7Z6pyDrz3+QDJcL95otJH9j2mlq6ixm5gubOtZs+kWfJ5LumNXsugDjwXXkANviFXN8ejWNHgnq1u0AXh8+zXQFYZT5B1ubwDd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869201F000E9;
	Wed,  1 Jul 2026 11:37:13 +0000 (UTC)
Message-ID: <df099fd8-6b6d-4b9e-80c4-0797d9ec5844@tuxon.dev>
Date: Wed, 1 Jul 2026 14:37:11 +0300
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: rcar_canfd: Change the initializing flow for clocks
 and resets
To: Biju <biju.das.au@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Tu Nguyen <tu.nguyen.xg@renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, Duy Nguyen
 <duy.nguyen.rh@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:biju.das.au@gmail.com,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:p.zabel@pengutronix.de,m:tu.nguyen.xg@renesas.com,m:biju.das.jz@bp.renesas.com,m:duy.nguyen.rh@renesas.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:linux-can@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bijudasau@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[tuxon.dev];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,pengutronix.de,kernel.org,glider.be];
	FORGED_SENDER(0.00)[claudiu.beznea@tuxon.dev,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7942-lists,linux-can=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:mid,tuxon.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0E176ECE90



On 6/25/26 16:51, Biju wrote:
> From: Tu Nguyen<tu.nguyen.xg@renesas.com>
> 
> Testing CANFD on RZ/G3E shows that many registers do not reset to their
> initial values with the current flow of deasserting resets first and then
> enabling clocks.
> 
> Based on the HW manual, clocks should be supplied first and the
> resets deasserted afterward.
> 
>   section 7.4.3 Procedure for Activating Modules: RZ/G2L
>   section 4.4.9.3 Procedure for Starting up Units: RZ/G3E
> 
> So, update the order of the initializing flow for resets and clocks
> to match the hardware manual, resetting all CANFD registers to their
> initial values. Also update rcar_canfd_global_deinit() to assert
> resets before disabling clocks, so the teardown path mirrors the new
> init ordering.
> 
> Fixes: 76e9353a80e9 ("can: rcar_canfd: Add support for RZ/G2L family")
> Signed-off-by: Tu Nguyen<tu.nguyen.xg@renesas.com>
> Signed-off-by: Biju Das<biju.das.jz@bp.renesas.com>

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

