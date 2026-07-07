Return-Path: <linux-can+bounces-8078-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h6MsEVvyTGq1sQEAu9opvQ
	(envelope-from <linux-can+bounces-8078-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 14:34:35 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8281071B65C
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 14:34:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8078-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8078-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4885F3014C5D
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 12:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA08840D560;
	Tue,  7 Jul 2026 12:34:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5876440A94D
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 12:33:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427641; cv=none; b=s6O9nyXE7GSBl95PPkhrQmzk4zU1jY0ureOBdQU1xh5b1C7vP59VvF3cuRmBGgU2mLamCtfRTTuO5nb9HTLtQge1dLFWpnq1ud6KA3sP7LGwND1j6o39Ec6R+VyQVANTDV4m6DB9oYbexXbSSRtH2C+S/ZWeXPKOf6RLpN+zgDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427641; c=relaxed/simple;
	bh=ojnKP+omkT+7pDzc1+VWtlREBemEjiYeqydLbtI83YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8XpRCrSnYiB68eiHFeVnr7qsThJ+ONOs1v8X3P9xQbvESLnXiRoD/MT2eqTX4K8UsvhuORyNQth1ZS923MqANurIGUstBmbbnEIugV16yXZm3DtcVmNlQ8231rVV0vVmgYseTlSP/w+cRpVd7CnnMIC2HwuEV0wwD0mSthKAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E863C2025F3;
	Tue, 07 Jul 2026 14:33:49 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wh4zl-000a2m-2g;
	Tue, 07 Jul 2026 14:33:49 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 893A5562467;
	Tue, 07 Jul 2026 12:33:49 +0000 (UTC)
Date: Tue, 7 Jul 2026 14:33:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3 6/7] can: bcm: extend bcm_tx_lock usage for data and
 timer updates
Message-ID: <20260707-nocturnal-jellyfish-of-destiny-201f7d-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260707-bcm_fixes-v3-0-84600ca6d889@hartkopp.net>
 <20260707-bcm_fixes-v3-6-84600ca6d889@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2jngkjfgc6v2kueb"
Content-Disposition: inline
In-Reply-To: <20260707-bcm_fixes-v3-6-84600ca6d889@hartkopp.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8078-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:devnull+socketcan.hartkopp.net@kernel.org,m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[pengutronix.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,socketcan.hartkopp.net];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8281071B65C


--2jngkjfgc6v2kueb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 6/7] can: bcm: extend bcm_tx_lock usage for data and
 timer updates
MIME-Version: 1.0

On 07.07.2026 12:16:13, Oliver Hartkopp via B4 Relay wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
>
> Stage new CAN frame content for an existing tx op into a kmalloc()'d
> buffer and validate it there, mirroring the approach already used in
> bcm_rx_setup(). Only copy the validated data into op->frames while
> holding op->bcm_tx_lock, so bcm_can_tx() and bcm_tx_timeout_handler()
> can no longer observe a partially updated or unvalidated frame.
>
> Also move the kt_ival1/kt_ival2/ival1/ival2 updates in bcm_tx_setup()
> under op->bcm_tx_lock, and read kt_ival1/kt_ival2/count under the same
> lock in bcm_tx_set_expiry() and bcm_tx_timeout_handler(), closing the
> torn 64-bit ktime_t read on 32-bit platforms.

Can you update the comment in struct bcm_op::bcm_tx_lock accordingly?

Marc

> Fixes: c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2jngkjfgc6v2kueb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCakzyKAAKCRDMOmT6rpmt
0vryAP497Qu3bFgNAdKqa8gb92wJmhD92iYM9Mbd5jTGQWSJhgD/e9n1Tw6eVG14
gv+2p8Te7cGi5q7ISlnVLpHcdNiFswY=
=A1qD
-----END PGP SIGNATURE-----

--2jngkjfgc6v2kueb--

