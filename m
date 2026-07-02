Return-Path: <linux-can+bounces-7969-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XZafHQ+MRmpNYQsAu9opvQ
	(envelope-from <linux-can+bounces-7969-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 18:04:31 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E086F9E02
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 18:04:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=PRBdzR5F;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7969-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7969-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86A53301F6E5
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 16:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5934B30C366;
	Thu,  2 Jul 2026 16:02:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D76830C16C;
	Thu,  2 Jul 2026 16:02:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008159; cv=none; b=LMRCXuNHAC3X/6934MWOBRCcxZluzGdnCC7HHEi8WQU0xrGkiG0BN1OOf2yDFQHmk67TCnS86ciDzOoYkRI1zDcxNUd68yMP9TGkbI1OUVRCsK1RAyc0KRbQ914MV90f/gUGKK1qsI19gqR9ULW4+oeOggc2ULMrcwIInQKyejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008159; c=relaxed/simple;
	bh=Om1A/qUPAE+RvRc9QOCiGXLsDeJqGK2rZLRnc+C2LPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/Rw/DGodzGCsy3VqeTK5NaSVGxAdAdPGXs3o44ECbr5KdVjxCFfz2JUy/7/elxNHTPqZn9nB7b3pLQR1QIEssAX1iB3/TXN3PMOukKPxlz3Zl6uNFAwWjp7kN1BQVp3OiA2mXNFHRqRSLsmDgnhzB9OsjNa3uyUYp+B4LKYt98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=PRBdzR5F; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Om1A/qUPAE+RvRc9QOCiGXLsDeJqGK2rZLRnc+C2LPU=; b=PRBdzR5FrpwlcK69ZWsZm+uEdL
	nHKCecM0P3uNqXRCLMZ4e5saOl2fHva7y6aB+iizLxJ5rSNgl5cLsYRc0MP0jZAYG+N+CjwDIgtxL
	USbLfTdmx6Go5xHgm3Ipn5r7o5/8WqscetSYzfLsvbrSPKvFHmkkKDVmWzlG9b6RaTXch9YGUM1Q3
	Ur2Z4NKK4n23iEY5JG53LPPskGXXTH1TmsI9rZHpC69Dlef40qlEKq2in+xLCMAfe13uQdC9ZkdSu
	/l1MX/nAJ99AAxxsxM3aUZKNdzDMiY8kZ94gMFC+yP6rx8IQJFfjZdKMaozCb4Y1ML/fMYOQgbeWa
	yQ4zqj/Q==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can <linux-can@vger.kernel.org>, 1579567540@qq.com
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
 linux-kernel <linux-kernel@vger.kernel.org>, Cunhao Lu <1579567540@qq.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v2 2/4] can: rockchip: add RK3588 CAN support
Date: Thu, 02 Jul 2026 18:02:25 +0200
Message-ID: <3527453.usfYGdeWWP@diego>
In-Reply-To: <tencent_F077D309CDB6CC4802CC086D8009E29BDF06@qq.com>
References:
 <20260702140654.2961561-1-1579567540@qq.com>
 <tencent_F077D309CDB6CC4802CC086D8009E29BDF06@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:1579567540@qq.com,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:kernel@pengutronix.de,m:conor+dt@kernel.org,m:dmitry.torokhov@gmail.com,m:shengjiu.wang@nxp.com,m:pengpeng@iscas.ac.cn,m:rmk+kernel@armlinux.org.uk,m:ebiggers@kernel.org,m:mario.limonciello@amd.com,m:kmehltretter@gmail.com,m:dlan@kernel.org,m:sboyd@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:heiko.stuebner@cherry.de,m:krzk@kernel.org,m:conor@kernel.org,m:dmitrytorokhov@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7969-lists,linux-can=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	FREEMAIL_TO(0.00)[pengutronix.de,vger.kernel.org,qq.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,nxp.com,iscas.ac.cn,armlinux.org.uk,amd.com,vger.kernel.org,lists.infradead.org,qq.com,cherry.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DKIM_TRACE(0.00)[sntech.de:+];
	TAGGED_RCPT(0.00)[linux-can,dt,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,sntech.de:dkim,sntech.de:email,sntech.de:from_mime,diego:mid,qq.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13E086F9E02

Am Donnerstag, 2. Juli 2026, 16:06:52 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb 1579567540@qq.com:
> From: Cunhao Lu <1579567540@qq.com>
>=20
> Add support for the RK3588 CAN controller by introducing a dedicated
> model ID and OF match entry.
>=20
> The block is closely related to the existing RK3568 variants, but it
> cannot reuse their match data unchanged. In particular, RK3588
> encodes RX_FIFO_CNT in bits 7:5 instead of 6:4, so the RX path needs
> SoC-specific handling.
>=20
> The RX FIFO count bitfield difference was found by comparing Rockchip's
> vendor kernel 6.1 CAN support for RK3568 and RK3588. Runtime testing on
> RK3588 also confirms that bits 7:5 are needed.
>=20
> Enable the existing erratum 5 empty-FIFO workaround for RK3588.
> Heiko reproduced erratum 6 on RK3588, so enable that workaround as
> well.
>=20
> Keep RKCANFD_QUIRK_CANFD_BROKEN enabled for RK3588, so CAN-FD stays
> disabled for now. Local testing did not reproduce the two known CAN-FD
> trigger frames that cause Error Interrupts on RK3568 variants. Instead,
> RK3588 shows a different CAN-FD failure mode: CAN-FD frames without BRS
> work in this setup, but BRS with a data bitrate different from the
> nominal bitrate immediately drives the controller bus-off.
>=20
> Reported-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> Link: https://lore.kernel.org/lkml/20260630164336.3444550-4-heiko@sntech.=
de/

I think you might want to drop that above. If anything a Co-developed-by
would be applicable, but from the (small) size of the change, that also
isn't really necessary for me :-)


> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>





