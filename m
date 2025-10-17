Return-Path: <linux-can+bounces-5227-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD537BEA761
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 18:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A379F1AE641F
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658BF25CC79;
	Fri, 17 Oct 2025 16:02:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED81625D209
	for <linux-can@vger.kernel.org>; Fri, 17 Oct 2025 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716953; cv=none; b=Cwqxek1KkW+05MdfPxLdaxoHsCpPx8PSG1Spr3k65z3b4OZ9scJlyO2jt0WH9Hpac9ggLaL10TJM8dpWraCb5QfVBiOnuTr+ouUjKWpHsVyxi7TmDNmWVUsqvaUsy6+aHVTKA9O90wi0Olt4yVMX0mlHp9w4Rx6gmL5SijkTT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716953; c=relaxed/simple;
	bh=7pnwO9ocWsSmARWhWORudDHyt94U84Wbc7RgQgo5MQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wc8dU7MkA0o//B7K9kp7GfGUE77dtucjXTFNWHUmZxASs4q2Yk4E2HixYbm9SNdAFh4jU103nwiiUB2CqCgshNqOdXnUhSH6YyGT9bdT7rcbQttSvtEmLa955/Np6wPaREk9P3N80Dxg+jmgUuqM3Pb26fbW+DSX2YwAO0P87Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9muM-0003ML-Jf; Fri, 17 Oct 2025 18:02:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9muL-0045FL-2X;
	Fri, 17 Oct 2025 18:02:21 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 767D1489404;
	Fri, 17 Oct 2025 16:02:21 +0000 (UTC)
Date: Fri, 17 Oct 2025 18:02:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>, Robert Nawrath <mbro1689@gmail.com>, 
	Minh Le <minh.le.aj@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] can: netlink: add CAN XL
Message-ID: <20251017-spirited-ruby-carp-5d7fe9-mkl@pengutronix.de>
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
 <20251017-spectacular-xanthic-swan-9427e8-mkl@pengutronix.de>
 <a729eeda-22d8-4f3e-bb6b-0cd2f3a06d2a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vvbf7cai7jwked76"
Content-Disposition: inline
In-Reply-To: <a729eeda-22d8-4f3e-bb6b-0cd2f3a06d2a@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--vvbf7cai7jwked76
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/9] can: netlink: add CAN XL
MIME-Version: 1.0

On 18.10.2025 00:40:22, Vincent Mailhol wrote:
> On 17/10/2025 at 22:53, Marc Kleine-Budde wrote:
> > On 13.10.2025 20:01:22, Vincent Mailhol wrote:
> >> Following all the refactoring on the CAN netlink done in series [1],
> >> [2] and [3], this is now time to finally introduce the CAN XL netlink
> >> interface.
> >>
> >> Similarly to how CAN FD reuses the bittiming logic of Classical CAN,
> >> CAN XL also reuses the entirety of CAN FD features, and, on top of
> >> that, adds new features which are specific to CAN XL.
> >>
> >> Patch #1 adds a check in can_dev_dropped_skb() to drop CAN FD frames
> >> when CAN FD is turned off.
> >>
> >> Patch #2 adds CAN_CTRLMODE_RESTRICTED. Note that contrary to the other
> >> CAN_CTRL_MODE_XL_* that are introduced in the later patches, this
> >> control mode is not specific to CAN XL. The nuance is that because
> >> this restricted mode was only added in ISO 11898-1:2024, it is made
> >> mandatory for CAN XL devices but optional for other protocols. This is
> >> why this patch is added as a preparation before introducing the core
> >> CAN XL logic.
> >=20
> > What about merging patches 1+2 now?
>=20
> If patch 1 had to be squashed,

Sorry - I was offering you to take patches 1+2 into can-next-testing
now.

> it should probably be in patch 3
> "can: netlink: add initial CAN XL support". The MTU workaround as
> introduced in patch 1 does not share any of the logic of the
> CAN_CTRLMODE_RESTRICTED as introduced in patch 2. Patch 1 is really
> just a preparation for CAN XL. You could remove patch 2 from the
> series and it will still work (aside from missing one of ISO mandatory
> features). Remove patch 1, and the thing breaks apart because it is
> required by patch 3.
>=20
> If I were to squash 1 and 2, I am not sure how I would describe those
> two different changes in a single patch message.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vvbf7cai7jwked76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjyaIgACgkQDHRl3/mQ
kZw5dgf9Hl7TWYBa57CItoz+e98AvXno7s92zcIQYCJ0ZIb7Dr9hGNETjfYPzZsc
AI5QN1BrjNsTRkJGOHfr58+zE1rMlXvrpgHqfUnlBsi1XaKDvxj9989j3vS8FN6J
ej7IzmHkp/V/SDbkaeEgDW7LyPmSOgu0P2BjMqkAdgza61zt8eRxOiao68o9AhiX
AnqZA75DB6dtiq9qP0C9pCYpYBWDTsn88QEGodgP5W7PRMXPVc4/YQB2F6Jp+8iJ
gaJg8f33wUm9wzukB9Oxegu0dg8SrXaSFjsjrxTRnFfBbUOlA6YKTFtL9hA0uFT5
B6dslMxtlKnKxn/7KmSrfb3K4db2CQ==
=elj5
-----END PGP SIGNATURE-----

--vvbf7cai7jwked76--

