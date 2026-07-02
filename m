Return-Path: <linux-can+bounces-7974-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xktEIEuXRmq1ZQsAu9opvQ
	(envelope-from <linux-can+bounces-7974-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 18:52:27 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2224D6FAACA
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 18:52:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=Gh4yA0Cj;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7974-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7974-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6310C3092B81
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 16:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8B6343884;
	Thu,  2 Jul 2026 16:42:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C66318EC1;
	Thu,  2 Jul 2026 16:42:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010541; cv=none; b=qeeSxv/yAJY3V2yw2iYC1cMrA9qEZpDaQ3y8eUeRPKcn6OceLF05GXAAkabQeybLjJ3tlvlGHgG0u2xOypG8VkzXqgIZOWs0paT9I7oZZV7NWGBk8NkvYwRzOimL30bmLRd/yI8fmGqL6T+7eoOAVl9GB3Gnkn8gaR6xiRbY7t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010541; c=relaxed/simple;
	bh=19tSqHTiXThbwMokl1+GXrVaAiFggpQsx8rgNAxcl/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAwx54JImtIOdYrPLi00U8tWigfluaeKGL/86941VVrjne0N6QMM0vh9hyhihMUkWUsXhYXCssvxMPXLdXphNBZJU9Z/VEWFc6flWlW/DcgKWyzj8JnvrMx1m8XxIBH3KsKmiaAFHekgBYwknJN1F6FvYykcsFvp17QCICN3sMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Gh4yA0Cj; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=8BWKyXVtcU1aypz3TbPj5gFArFFOSYSIbmVQ2MSXUbc=; b=Gh4yA0CjfBzQMYw+w02KsUA+fF
	ztrApVsVi2MusGUVZp4iEF/Gk+GJukF8T4u7eAYy/511gB2XClPj4s3M5/wVq9Qk0QhuW0kXT6ITz
	LNrQhfcTLIDpfIfIU7iCGG89Qnav9aVloi3J/qh8nVGLmFWgCDmnLNmuvlzbwuR895lhl9OGm3OxR
	qwi/6W+EzNVi4+jgoXdfTarwbjr+VvyPDA0ORr7/8JuynSvQg/+dLgaD8sc5Zdk4UH1MNX51o6pqk
	gTyfm2326qpd8JQzoYc8t0fk77XGNSFJgun8WSgBnaTAlM3kLui18eNUP2ChiQelzRjz6Low3KX5M
	0JpUaBBg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can <linux-can@vger.kernel.org>, 1579567540@qq.com,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, kernel <kernel@pengutronix.de>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Eric Biggers <ebiggers@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Karl Mehltretter <kmehltretter@gmail.com>, Yixun Lan <dlan@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH v2 1/4] dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
Date: Thu, 02 Jul 2026 18:42:06 +0200
Message-ID: <4310510.6PsWsQAL7t@diego>
In-Reply-To: <636d10c0-670d-4586-b604-7559d2a24185@kernel.org>
References:
 <20260702140654.2961561-1-1579567540@qq.com> <2459655.BjyWNHgNrj@diego>
 <636d10c0-670d-4586-b604-7559d2a24185@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:1579567540@qq.com,m:krzk@kernel.org,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:kernel@pengutronix.de,m:conor+dt@kernel.org,m:dmitry.torokhov@gmail.com,m:shengjiu.wang@nxp.com,m:pengpeng@iscas.ac.cn,m:rmk+kernel@armlinux.org.uk,m:ebiggers@kernel.org,m:mario.limonciello@amd.com,m:kmehltretter@gmail.com,m:dlan@kernel.org,m:sboyd@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:conor@kernel.org,m:dmitrytorokhov@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7974-lists,linux-can=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	FREEMAIL_TO(0.00)[pengutronix.de,vger.kernel.org,qq.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,nxp.com,iscas.ac.cn,armlinux.org.uk,amd.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DKIM_TRACE(0.00)[sntech.de:+];
	TAGGED_RCPT(0.00)[linux-can,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:dkim,sntech.de:email,sntech.de:from_mime,vger.kernel.org:from_smtp,qq.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2224D6FAACA

Am Donnerstag, 2. Juli 2026, 18:39:53 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Krzysztof Kozlowski:
> On 02/07/2026 18:01, Heiko St=C3=BCbner wrote:
> > Am Donnerstag, 2. Juli 2026, 16:06:51 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb 1579567540@qq.com:
> >> From: Cunhao Lu <1579567540@qq.com>
> >>
> >> RK3588 integrates a Rockchip CAN-FD controller variant that is not
> >> fully compatible with RK3568v2. The RX FIFO count register field is
> >> encoded in bits 7:5 on RK3588, while RK3568v2 uses bits 6:4.
> >>
> >> Add a dedicated rockchip,rk3588-canfd compatible to describe this
> >> variant. Do not use rockchip,rk3568v2-canfd as a fallback, because that
> >> would describe a register layout that does not match the hardware.
> >>
> >> Changes in v2:
> >> - Use enum for the single-compatible entries, as suggested by Krzyszto=
f.
> >> - Reword the commit message to explain the hardware difference instead
> >>   of referring to Linux driver match data.
> >>
> >> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> >=20
> > after fixing  Krzysztof's comment:
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> >=20
> > and doing dtbscheck of the binding against the dt-patches:
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
>=20
> Makefile/build level steps are not testing. Please don't provide such
> tags for bindings. Otherwise all bindings would carry Rob's tag, because
> he wrote the bot which does such testing.

ok ... will keep that in mind for the future


Heiko



