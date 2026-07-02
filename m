Return-Path: <linux-can+bounces-7955-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EqvjFDhJRmofNwsAu9opvQ
	(envelope-from <linux-can+bounces-7955-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 13:19:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 997646F6934
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 13:19:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7955-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7955-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F158830EDAB1
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 11:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7CD3E7BC4;
	Thu,  2 Jul 2026 11:11:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77DD3EAC84;
	Thu,  2 Jul 2026 11:11:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990719; cv=none; b=mzmofRbXgnwGXqcwf/laixK6m5PuFW2vfmOktXx/1LdHqDuaObp026EtCcTtb+dFaabUeCUROSRBnvx+ez/So2ScVTImUifxI4EwUkJwiFa9d2wYTNCgWrnRx0iLBljNDUP9LTe6DXydUBgwhowCLkS9GmnUjq/+c/t1H2GGPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990719; c=relaxed/simple;
	bh=cdJr/kOzbXQE8tDPk0CbR1Qy+r4K+Zj0csh//ZnLIak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJbjGijtQYasQ+qxB+/ySfTBck+P+0Df01YvZ7U5xsN7CfjhqOYFj4/7GSN9T6jaUnKrPi8gqN+w8ueCpf5b+u6ahOqAxE7CUydtc+GYCeIR/S7OcAFAwvUIj/Varxgz5JRBTfU8e4C8URth2trB16k46IusK42uUhuKGwCo33Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C89A0200A6D;
	Thu, 02 Jul 2026 13:11:47 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wfFKd-005jUk-2D;
	Thu, 02 Jul 2026 13:11:47 +0200
Received: from pengutronix.de (ip-185-104-138-148.ptr.icomera.net [185.104.138.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 00F2F55E2E3;
	Thu, 02 Jul 2026 11:11:44 +0000 (UTC)
Date: Thu, 2 Jul 2026 13:11:43 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu <1579567540@qq.com>
Cc: heiko <heiko@sntech.de>, linux-can <linux-can@vger.kernel.org>, 
	mailhol <mailhol@kernel.org>, kernel <kernel@pengutronix.de>, robh <robh@kernel.org>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-rockchip <linux-rockchip@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] can: rockchip: add RK3588 CAN-FD support
Message-ID: <20260702-accelerated-shoebill-of-elevation-76f536-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <tencent_C422347432620914231601BC882C7E604D08@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g3juocogafd37lbu"
Content-Disposition: inline
In-Reply-To: <tencent_C422347432620914231601BC882C7E604D08@qq.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7955-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS(0.00)[m:1579567540@qq.com,m:heiko@sntech.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:kernel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[qq.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	RCPT_COUNT_TWELVE(0.00)[12];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,pengutronix.de:mid,pengutronix.de:url,pengutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 997646F6934


--g3juocogafd37lbu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] can: rockchip: add RK3588 CAN-FD support
MIME-Version: 1.0

On 02.07.2026 17:23:59, Cunhao Lu wrote:
> Hi Marc,
>
> > Is the SoC you're using actually a 'v2' silicon revision? At least on
> > the rk3568 the downstream kernel has code to read the revision.
>
> The kernel reports the CAN-FD controller as rk3588v2 rev2.2:
>
>   rockchip_canfd fea60000.can can0: Rockchip-CANFD rk3588v2 rev2.2 (errat=
a 0x0000) found
>   rockchip_canfd fea70000.can can1: Rockchip-CANFD rk3588v2 rev2.2 (errat=
a 0x0000) found
>
> Following your earlier feedback, I have changed the v2 series to use
> rockchip,rk3588-canfd instead of rockchip,rk3588v2-canfd unless we get
> more information about RK3588 CAN-FD errata and SoC silicon revisions
> from Rockchip.
>
> > Compile the latest https://github.com/linux-can/can-utils/ and test:
> >
> > $ cangen can0 -I 2 -Li -Di -p 10 -f -g 1 -c32 -b
> > $ cansequence -rv can1 -f
>
> I tested with can0 and can1 directly connected. The CAN clock was
> 200 MHz, and the interfaces were configured as follows:
>
>   ip link set can0 down
>   ip link set can0 type can bitrate 500000 sample-point 0.8 dbitrate 1000=
000 dsample-point 0.8 fd on
>   ip link set can0 up
>
>   ip link set can1 down
>   ip link set can1 type can bitrate 500000 sample-point 0.8 dbitrate 1000=
000 dsample-point 0.8 fd on
>   ip link set can1 up
>
> Without BRS, this test ran for 15 minutes without problems:
>
>   cangen can0 -I 2 -Li -Di -p 10 -f -g 1 -c32
>
> With BRS enabled:
>
>   cangen can0 -I 2 -Li -Di -p 10 -f -g 1 -c32 -b
>
> the test only worked when dbitrate was equal to bitrate, for example
> with both set to 1M. If dbitrate differed from bitrate, the
> controller went bus-off immediately.
>
> So my current conclusion is that CAN-FD itself works on RK3588, but the
> support appears incomplete: using a faster data phase with BRS does not
> work in my setup.

Then CAN-FD is broken. :/

Maybe in a later patch we can hack something, to allow working
configurations.

> This looks different from the issue described by the current
> RKCANFD_QUIRK_CANFD_BROKEN comment. That quirk is about specific
> CAN-FD frames triggering Error Interrupt or Error-Warning during
> reception. In my test the non-BRS CAN-FD frames work, while the failure
> is tied to using BRS with a data bitrate different from the nominal
> bitrate, which immediately drives the controller bus-off.

Can you update the description of the quirk for the rk3588 and add how
to reproduce it?

> Given this result, should I still keep CAN-FD disabled for RK3588, or is
> it acceptable to enable CAN-FD but document that BRS with a faster data
> phase is currently not working?

Please keep it disabled for now.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g3juocogafd37lbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCakZHbAAKCRDMOmT6rpmt
0kH7APkB+Ph02O8jbLwNPVHdiuMu717y5tk5YAdnacU9kEQ/+gEAieWkfM/cPVcW
4Yv+JL1RKIjpy4cM0fRvq9mHrjox3QQ=
=m2rP
-----END PGP SIGNATURE-----

--g3juocogafd37lbu--

