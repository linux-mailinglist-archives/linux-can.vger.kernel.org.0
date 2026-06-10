Return-Path: <linux-can+bounces-7801-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GhppOwUHKWomPAMAu9opvQ
	(envelope-from <linux-can+bounces-7801-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 08:41:10 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C61C666581
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 08:41:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QAYVMr3V;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7801-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7801-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72F8B30037C7
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 06:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F302B3749F4;
	Wed, 10 Jun 2026 06:37:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210A372663;
	Wed, 10 Jun 2026 06:37:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073441; cv=none; b=I1j1kV9mhrUGOjSCCiVjz1310AVASjWOFhBeCwBKJQ4CrTkU10GzCjkOsT0zpLRG/jWHYgW+OSHAR3C9sfVvSuz772Q0nASICHA5BetjnTx9S7TfCkHW49y1XROMGvdQpo3Uao8tOBd+SCtWn2ckNBu3qF3jkj4u9kSB4h1rH3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073441; c=relaxed/simple;
	bh=y36luLyiZgtidk6T4HAJPmApUtNgxc9AfIJ6R+zzYvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNtn1mcJWDtSQqofcq/757oDXq3uXAiJWaRpxYiIvFtTfkxjDv88VC01B1nFYBXJxCkkoMF/gu+JerHm9us1YZ75FiHsAMbpRxMnWxkISla/ggOKNHNI7w/kPSlBwCBfqi5ZYMNWzPGOAPE1Ddfk0kQHz5F4uxKwgUnZ0WFZHjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAYVMr3V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521781F00893;
	Wed, 10 Jun 2026 06:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781073440;
	bh=i0peh9BPV0yzb2/7tAvDBxb+1fXYB7Zsg7ey2Fi9LQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QAYVMr3VL8i2R9MeuoZCwTDDw/WAweSOBhiktrpWJhL+hTPub+f2EIUM4Yv/U1+kL
	 dH14bFzLv0AZQc/ccBmiiqSs7Qf6QC5+ex30l4EaWXrhWBlRCmp6HYRgAUE4JaFuSz
	 KIGnTwNyPOtu4FwyPVeX0AVPu4q22k/Qzz3cRBFtzdznfuOysKgdbTfhw8kf297+R3
	 MvRB88EUQbQmKjLcGMZyr08CfxtxRP+grSU77RDkEvUulRhOcoFTJJxDEQzfhIvgH0
	 YSjrNDUrzvUtUXH2RGaGrwXJmA/NRwJEx0GRISOLETlqcLzcSNsJUa1H01VXxUqzvG
	 goTUKOfj3pH0g==
Date: Wed, 10 Jun 2026 08:37:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	NXP S32 Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>, 
	Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
	Eric Chanudet <echanude@redhat.com>, Andra-Teodora Ilie <andra.ilie@nxp.com>, 
	Larisa Grigore <larisa.grigore@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v5 4/8] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC
 support
Message-ID: <20260610-crouching-wild-mushroom-c8bf6a@quoll>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
 <20260609142954.1807421-5-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609142954.1807421-5-ciprianmarian.costea@oss.nxp.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ciprianmarian.costea@oss.nxp.com,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:festevam@gmail.com,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:s32@nxp.com,m:clizzi@redhat.com,m:aruizrui@redhat.com,m:eballetb@redhat.com,m:echanude@redhat.com,m:andra.ilie@nxp.com,m:larisa.grigore@nxp.com,m:conor.dooley@microchip.com,m:haibo.chen@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7801-lists,linux-can=lfdr.de];
	FORGED_SENDER(0.00)[krzk@kernel.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,redhat.com,microchip.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nxp.com:email,quoll:mid,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C61C666581

On Tue, Jun 09, 2026 at 04:29:50PM +0200, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Add NXP S32N79 SoC compatible string and interrupt properties.
> 
> On S32N79, FlexCAN IP is integrated with two interrupt lines:
> one for the mailbox interrupts (0-127) and one for signaling
> bus errors and device state changes.
> 
> Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
> Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>

You cannot test a binding (in a meaning what "testing" means). Building
code is not testing.

> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>

Not possible.

Best regards,
Krzysztof


