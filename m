Return-Path: <linux-can+bounces-7972-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b/dFJ7egRmoTagsAu9opvQ
	(envelope-from <linux-can+bounces-7972-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 19:32:39 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9836FB6DB
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 19:32:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=Num2A+5+;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7972-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7972-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3643302B769
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AFF323417;
	Thu,  2 Jul 2026 16:36:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB502D8DC4;
	Thu,  2 Jul 2026 16:36:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010217; cv=none; b=JmVBhv8Ap8iXnzScgurrTMOwF4NxTKKU9C7OcT+tt4QcC4ez2xOv/evr1uDzk7MsuxTM9d/GYzr5wOYQiaDj6Hq4BJmEi6feZkookjGIZGeMQ9u9x2RBGKBStdUgz8fPOS1Ogmxk4aZNjJmETdBtABijuMlIe5sTHHJBu7sgung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010217; c=relaxed/simple;
	bh=dUpLWUSZeHCbnarM9STL88HVq9YMEGabh6ksEsFN9PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhyJ4ibOEv2Qzw6+M9393plybxif/jkEXHhdxR3U9PKW0P8sOzUfm32DmyxZd6MtQvbDlnMNP6dFhw0yRlu1YM5CjMrJeWFn5WU1zfpJyoEhwkjVF9LFv/Zw4VF7IIyic1CoFQx1JxNa84IVTbWxVhLJPw9h5+4R3XfhZVZUhVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Num2A+5+; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=dUpLWUSZeHCbnarM9STL88HVq9YMEGabh6ksEsFN9PE=; b=Num2A+5+4Fd1ZIrorLsEytnkVt
	9jN67/IIhlYNOJDwVyAVNKx5NjRVrouv4JpQ43ezzCpdzqHbJimO1FbKa9rDe5UJr7IorYmoo2jDo
	nUu4F/0XaZVYH8CoKWyMI1Z+GYpvY3rIWAeYPlH1hL8uHLZlN3S5gmWR8cLQwtPUTX294vlC4pFRM
	g89ajIdO2CgdqBy3kfm8zurgzeGZ893srcJ9SRbrsUI/coucNboYla5laznUD/GrmDRRcjcXylSNB
	Vhfo+wNqbk1WsOue/TX4vEah44zz3m6kv2Evow1EeCucsxhOJs1MJLQcxi5KivPCmHu/DalMxTq93
	A1IVo5ug==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can <linux-can@vger.kernel.org>, Cunhao Lu <1579567540@qq.com>
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
 linux-kernel <linux-kernel@vger.kernel.org>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v2 2/4] can: rockchip: add RK3588 CAN support
Date: Thu, 02 Jul 2026 18:36:41 +0200
Message-ID: <6281926.UjTJXf6HLC@diego>
In-Reply-To: <tencent_8BE421601F31C26FB9E99FA6440629016D05@qq.com>
References:
 <20260702140654.2961561-1-1579567540@qq.com> <3527453.usfYGdeWWP@diego>
 <tencent_8BE421601F31C26FB9E99FA6440629016D05@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:1579567540@qq.com,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:kernel@pengutronix.de,m:conor+dt@kernel.org,m:dmitry.torokhov@gmail.com,m:shengjiu.wang@nxp.com,m:pengpeng@iscas.ac.cn,m:rmk+kernel@armlinux.org.uk,m:ebiggers@kernel.org,m:mario.limonciello@amd.com,m:kmehltretter@gmail.com,m:dlan@kernel.org,m:sboyd@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:heiko.stuebner@cherry.de,m:krzk@kernel.org,m:conor@kernel.org,m:dmitrytorokhov@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[pengutronix.de,vger.kernel.org,qq.com];
	TAGGED_FROM(0.00)[bounces-7972-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,nxp.com,iscas.ac.cn,armlinux.org.uk,amd.com,vger.kernel.org,lists.infradead.org,cherry.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[sntech.de:+];
	TAGGED_RCPT(0.00)[linux-can,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:dkim,sntech.de:email,sntech.de:from_mime,qq.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,diego:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B9836FB6DB

Am Donnerstag, 2. Juli 2026, 18:34:04 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Cunhao Lu:
> > I think you might want to drop that above. If anything a Co-developed-by
> > would be applicable, but from the (small) size of the change, that also
> > isn't really necessary for me :-)
> >
> >
> > > Signed-off-by: Cunhao Lu <1579567540@qq.com>
> >
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>=20
> Sorry about that. This is my first contribution to the Linux kernel, and
> I have not fully understood yet which tags are appropriate in which
> situations. Please bear with me.

no worries, I think you're doing really great for your first contribution


Heiko

> I will add your Co-developed-by tag in v3, together with your
> Signed-off-by as required for Co-developed-by.
>=20
> Best regards,
> Cunhao
>=20
>=20
>=20
>=20
>=20





