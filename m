Return-Path: <linux-can+bounces-4812-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E190B9149F
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 15:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C29A18A2523
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE98A3093A1;
	Mon, 22 Sep 2025 13:06:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74BB30AAC5
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546380; cv=none; b=pWirTtU9qs2ucAZD8vclVzCLUK5J/+ACHD7CQyUFF4DtxSQexAg9yrBcmU2+NE2+yCJ0afJ9Ku0rjR5f/qd3pnUtwPza45S160yEVmhSqEu+lTHzgANTHP8oZbRZDcI7vPreAmQWTPV2GgQOZ7iSxaFbWJVZ+Dk5rB3tLo8eHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546380; c=relaxed/simple;
	bh=I6ZGiUHkaV3q8D7YuIXJ4aV456Z1kWyj8oDDmcqNdco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CY4euZ9JhYyhPPNRsFEPjF0w8F9rXqDCfB4nq1CKaSOg2hPnHbmjaofhSkIeA1sSbkAav6ZLyVtkp4BTNIHNlnVPvwXwvbsTKaTAtdZ1/0UXHgWS+2bCYWq3T+wINt1Ni0CXqnNeA/lATmbpqLg1sBUUHbU+5YbfcjNPGbdIw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0gF3-0002kz-LE; Mon, 22 Sep 2025 15:06:05 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0gF2-002b7I-2h;
	Mon, 22 Sep 2025 15:06:04 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7668D477008;
	Mon, 22 Sep 2025 13:06:04 +0000 (UTC)
Date: Mon, 22 Sep 2025 15:06:04 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>, Robert Nawrath <mbro1689@gmail.com>, 
	Minh Le <minh.le.aj@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/20] can: netlink: refactor
 CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
Message-ID: <20250922-rational-mastodon-of-sufficiency-6b49f1-mkl@pengutronix.de>
References: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
 <20250910-canxl-netlink-prep-v2-7-f128d4083721@kernel.org>
 <f9854748-78c1-4852-a610-e839e9c91df3@kernel.org>
 <20250922-amber-spider-of-control-90be7c-mkl@pengutronix.de>
 <9cfdcf56-2f47-4cfd-9fd6-2c6fa4476752@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ilpyit2enyh5yb4p"
Content-Disposition: inline
In-Reply-To: <9cfdcf56-2f47-4cfd-9fd6-2c6fa4476752@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ilpyit2enyh5yb4p
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 07/20] can: netlink: refactor
 CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
MIME-Version: 1.0

On 22.09.2025 20:14:16, Vincent Mailhol wrote:
> On 22/09/2025 at 18:43, Marc Kleine-Budde wrote:
> > On 20.09.2025 16:24:42, Vincent Mailhol wrote:
>=20
> (...)
>=20
> >> @Marc, do you think you can send your next PR to net soonish?
> >>
> >> I would like to rebase this series and the "rework the CAN MTU logic" =
series on
> >> top of the MTU fix:
> >>
> >> https://lore.kernel.org/linux-can/20250918-can-fix-mtu-v1-0-0d1cada939=
3b@kernel.org/
> >>
> >> But to do so, I first need to wait for the MTU fix to appear on net-ne=
xt and
> >> there is not so much time left before the end of the development windo=
ws.
> >=20
> > This series looks fine to me. After -rc1, please check for any
> > ndo_change_mtu, because the Nuvoton CAN-FD driver will go mainline, but
> > not via the net-next tree.
>=20
> Thanks for the head-up!
>=20
> At the moment, that driver is in Lee's tree, so I was thinking of directly
> preparing the fix patch and sending it to the netdev team and Lee so that=
 both
> are aware of the upcoming conflict.
>=20
> I will resend my two series in the next few days as soon as the MTU fix a=
ppears
> in net-next.

I don't know how much time we have between the merge of net into
net-next and the acceptance of the last PR by the network team for the
next merge window. We will see.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ilpyit2enyh5yb4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjRSbkACgkQDHRl3/mQ
kZx4GggAjTygZ+/Yy6FIq69q/pVBRRyuJwI4mRaP2sM3wr8++UhyWrjAgtq0EFIW
PHGC7ZyfW45cLWx6lwR1ORGBVWQGie64ZWFZwxgxlQ0sfjfyA6O23M8FTnaFFT1B
N8fdVjOpFjV5JGE4a2x1DXJCEF4B+u4kalp11GYgsN4LtnjKO2USVqBAxTwj3fem
WT4Q6N3ZUrvl6//DFaqWKhKSDOyVK3rm8HPbMcfdg8MHctEp9idRvj66K+ML+FuK
B0Ckvmbqb/zzKMUXXr2o+dGALGcF09prDykFa/QBKdS8LHQ2rSa6anTdNL1vz4Sr
Q7xL4lfbqHdoSPewVp/6scIhNxwK+w==
=RiYl
-----END PGP SIGNATURE-----

--ilpyit2enyh5yb4p--

