Return-Path: <linux-can+bounces-6659-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAIpAhRipWmx+wUAu9opvQ
	(envelope-from <linux-can+bounces-6659-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 11:10:28 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7181D6185
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 11:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E52A83012B5C
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 10:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FA3395DA0;
	Mon,  2 Mar 2026 10:10:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3EE37880E
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446224; cv=none; b=gsnv5ZHDPWej7odmgggQYN2MiDoIonlexi1NZwWRAdfNLutyAExycf0CLD7jv/E2jwgMrayL4k6dwwoyulpik7el83fkLWpWTMHQ+tW/XpGoI3PnM5rs8VuP8MVnX7/VoIaba9OpZhOFOuC3X69Yv+evzKfeBP/QuII99I9RoYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446224; c=relaxed/simple;
	bh=HFmrn6I+xHjhuCfTKcKqTrYKdInumV0LKUzQhkAK8OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMjO4Lccdyc3Kmo0PIMfYrCYJN6DOZztp1tHufXFanS7c4Ju5OtFUNZa719KeKFqDI91sP05crSBFRqMwQjC0r6hVGK7W1zkOV+K8cfm049Yj4wyBshAe43lCmANkmgZ+vejmA3hRV0Ag9HJ/qjCBIqhBLPb37ibFDgu9T0HE9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx0EF-0000ze-5F; Mon, 02 Mar 2026 11:10:19 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx0EC-003MXa-26;
	Mon, 02 Mar 2026 11:10:18 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BDF664F503D;
	Mon, 02 Mar 2026 10:10:17 +0000 (UTC)
Date: Mon, 2 Mar 2026 11:10:17 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
	Maximilian Schneider <max@schneidersoft.net>, Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] can: gs_usb: gs_can_open(): always configure bitrates
 before starting device
Message-ID: <20260302-big-rugged-kittiwake-718a92-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260219-gs_usb-always-configure-bitrates-v2-1-671f8ba5b0a5@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nqdi7kpewccyzlip"
Content-Disposition: inline
In-Reply-To: <20260219-gs_usb-always-configure-bitrates-v2-1-671f8ba5b0a5@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6659-lists,linux-can=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.843];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:url,pengutronix.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC7181D6185
X-Rspamd-Action: no action


--nqdi7kpewccyzlip
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: gs_usb: gs_can_open(): always configure bitrates
 before starting device
MIME-Version: 1.0

On 19.02.2026 13:57:34, Marc Kleine-Budde wrote:
> So far the driver populated the struct can_priv::do_set_bittiming() and
> struct can_priv::fd::do_set_data_bittiming() callbacks.
>
> Before bringing up the interface, user space has to configure the bitrate=
s.
> With these callbacks the configuration is directly forwarded into the CAN
> hardware. Then the interface can be brought up.
>
> An ifdown-ifup cycle (without changing the bit rates) doesn't re-configure
> the bitrates in the CAN hardware. This leads to a problem with the
> CANable-2.5 [1] firmware, which resets the configured bit rates during
> ifdown.
>
> To fix the problem remove both bit timing callbacks and always configure
> the bitrates in the struct net_device_ops::ndo_open() callback.
>
> [1] https://github.com/Elmue/CANable-2.5-firmware-Slcan-and-Candlelight
>
> Cc: stable@vger.kernel.org
> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devic=
es")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nqdi7kpewccyzlip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaaViBwAKCRDMOmT6rpmt
0vJzAQCaOhW7srL9w/HX+zYctQwI9peKEZtlGJQiA5nq0933ggD+Nqucvcw1RIts
fcapjSdo6DHRaVSBOq+3Rs4TK/aDsAc=
=rHnh
-----END PGP SIGNATURE-----

--nqdi7kpewccyzlip--

