Return-Path: <linux-can+bounces-7944-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8Q63DFc8RWo29AoAu9opvQ
	(envelope-from <linux-can+bounces-7944-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 18:12:07 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C95946EF91D
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 18:12:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=MaTGrKK+;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7944-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-7944-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90A5330B4B14
	for <lists+linux-can@lfdr.de>; Wed,  1 Jul 2026 16:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88504949E0;
	Wed,  1 Jul 2026 16:02:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445FC49250D;
	Wed,  1 Jul 2026 16:02:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921744; cv=none; b=Jj7JUEs091zNMBV5D70yxoXmay4GGWcWN5f30jYbbnR0lZstiGQU2MEAiwn1SznTJ/kFs3ta77mzlRD+MAoMTmdx7IjZHS1xiPNrXnwwknPL68q0LMguz9TWcm/X+QD/LrfO38DHp7yg0T7/1XnIqHMbMgp0iW7aeV4D5KYtP6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921744; c=relaxed/simple;
	bh=AG83QuzuUjrjSLK52HpMiWn4MKRX6i2rEPMtXcZoDSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAJwf0lTbPlAEenhn3o6hp92XjuOZiVizvKWWDRyRA9rmJgKTZ+n+CIYLRosQt0G6k6CKYVmlEN5vNAQX9hnPaTKq1nPWUMYC/JFpCoXur873TaZvFwj/Q/qp8qp5C2JlzgH/k3SP25mD1RXDcd81b2Q3+wxl8iqXKPb5B7oRpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=MaTGrKK+; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Oi59Gfv03QRh4wuEQ3UJG1fGRKD0h5n2wK8ssSfHsFY=; b=MaTGrKK+eqnG+SYj6BecTVg4tW
	7qdxK+Va41Q2jRAT+9P3v8pxHfhrcHqMtM0ibxcke4vKH8rCytyJ5qNXhNiPiPlw7DlvHvWuAPj/b
	vEzF/SktlyChlwRuHUHMup59gXxjv9f5OA8ur9ozlYgSkytj0D7Y3tS6nkskdPA6syEzkUyFnz8DT
	9XXxi41yPrqj3MDFzGyFtq/Up91i4+qDj2lA4ZUy+FDVdkSVkCRzYSycpnyM+fOwlV4iQCmEkssL4
	urBkcySQ3HphZQ2h7vbr4Qm7iVrhM4RZntqzA3KBN8ad0mcymjnmgG1b5p6DbRWg+MwZufHFsSLAF
	+2QOQenw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 =?UTF-8?B?8J+Sqy4yMjA=?= <1579567540@qq.com>
Cc: linux-can <linux-can@vger.kernel.org>, mailhol <mailhol@kernel.org>,
 kernel <kernel@pengutronix.de>, robh <robh@kernel.org>,
 krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] can: rockchip: add RK3588 CAN-FD support
Date: Wed, 01 Jul 2026 18:02:02 +0200
Message-ID: <3077724.o0KrE1Onz3@diego>
In-Reply-To: <tencent_AF88C27E354DFF34B132BC0906236A01A408@qq.com>
References:
 <20260701070128.2096267-1-1579567540@qq.com>
 <20260701-flashy-crocodile-of-flowers-a6a23e-mkl@pengutronix.de>
 <tencent_AF88C27E354DFF34B132BC0906236A01A408@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:1579567540@qq.com,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:kernel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,qq.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[sntech.de:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-7944-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sntech.de:dkim,sntech.de:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C95946EF91D

Am Mittwoch, 1. Juli 2026, 14:29:22 Mitteleurop=C3=A4ische Sommerzeit schri=
eb =F0=9F=92=AB.220:
> Hi Heiko, Marc,
>=20
> thanks for the review.
>=20
> > please use a real name, not an alias.
>=20
> I will use my real name in future revisions.
>=20
> > Funnily enough, we seem to have worked on the same topic
> > at the same time :-)
> >
> > https://lore.kernel.org/lkml/20260630164336.3444550-1-heiko@sntech.de/
>=20
> I missed Heiko's series before sending mine, sorry for the noise.
> (But it really is a very interesting coincidence.)
> Since the series overlap, I am happy to base further work on Heiko's
> series, or to let Heiko fold the RK3588 RX_FIFO_CNT bitfield change into
> his v2 if that is preferred.

I don't think we need two people working on this and you did the better
investigation into the differences, so you should get the credit :-)

So I guess my preference would be to:
=2D pick up the erratum 6 into your patch
=2D add my haikou patch to the series - that way we also get a user
=2D handle Krzysztof's comment from
  https://lore.kernel.org/linux-rockchip/20260701-sensible-cryptic-ocelot-5=
8035b@quoll/

  as both our bindings have the same structure, so I guess it should be

    oneOf:
       - enum:
             rockchip,rk3568v2-canfd
             rockchip,rk3588v2-canfd
       - items:
           - const: rockchip,rk3568v3-canfd
           - const: rockchip,rk3568v2-canfd

And submit that as v2.


> For RX_FIFO_CNT, I found the bitfield difference by reading Rockchip's
> vendor kernel 6.1 driver and comparing the CAN support for RK3568 and
> RK3588. The vendor driver uses different RX FIFO count bitfields for the
> two SoCs, and my testing on RK3588v2 also indicates that bits 7:5 are
> needed. I can add a short note about this in the commit message or
> code comment.

It's already in the commit message, so that should be fine


> One more question about RKCANFD_QUIRK_CANFD_BROKEN: in my RK3588v2 test
> setup the two known CAN-FD trigger frames did not cause an Error
> Interrupt or Error-Warning. I also ran a 12 hour CAN-FD stress test with
> can0/can1 directly connected, 200 MHz CAN clock, 500 kbit/s nominal
> bitrate and 1 Mbit/s data bitrate. That test included periodic
> transmission of the two CANFD_BROKEN frames, variable DLC CAN-FD frames,
> CAN-FD+BRS+EFF load, and a canfdtest run with 19,417,129 frames without
> data mismatch.
>=20
> Would it make sense to leave RKCANFD_QUIRK_CANFD_BROKEN disabled for
> RK3588v2, or have you seen this issue on RK3588 as well?

I was more going by the fact that even Rockchip removed every mention of
the -FD from all documentation, so was assuming it still being broken as
before. But if it actually works, then personally I'm more than fine with
enabling CAN-FD :-D .

I guess Marc might have more insight where the FD issue triggered on
the RK3568.


Heiko



