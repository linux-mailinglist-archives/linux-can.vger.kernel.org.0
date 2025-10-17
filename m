Return-Path: <linux-can+bounces-5229-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 678B6BEAC45
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 18:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF531AE0848
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D707B29C325;
	Fri, 17 Oct 2025 16:34:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A229B78E
	for <linux-can@vger.kernel.org>; Fri, 17 Oct 2025 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718873; cv=none; b=Qmq36rdy1XAD5O41L7rbqC6M5tZY9Xg5gOd7fOR0eV61Ow516Xde9485sLAc4Wz343+a1syMljhrGxQ/CQRIX03SJZJp2/m1lGgXL+W+t1EDT93VtOPtOZzQfp5pf+JZ9FOpH9BUNy4wCu3Y3XbNuoeW6F1PlHFv1kMAIO0TdZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718873; c=relaxed/simple;
	bh=Y+quj2nMrX8T2/bCZKuYoUxb00H1HfgCQ9qcx+pt0GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUirm7vyS4MssjPQ0G0p872sOVutyFPmOZzn5l3qqwavq7cgNsTjEYsxIKtN4wGI3tZWmQYHBatNBsl5teCoSl4J+OnlKDTqfAN4loO14sYNUOg7llJmxRGqRNSngpnXBmJ8SOfcWkZosk6WBfM9BtIeQAsh5e1rJBSbbZFJkUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9nPM-0007ty-Pd; Fri, 17 Oct 2025 18:34:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9nPM-0045aY-0M;
	Fri, 17 Oct 2025 18:34:24 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B8364489458;
	Fri, 17 Oct 2025 16:34:23 +0000 (UTC)
Date: Fri, 17 Oct 2025 18:34:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>, Robert Nawrath <mbro1689@gmail.com>, 
	Minh Le <minh.le.aj@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] can: netlink: add CAN XL
Message-ID: <20251017-enchanted-quiet-civet-84dd47-mkl@pengutronix.de>
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
 <20251017-spectacular-xanthic-swan-9427e8-mkl@pengutronix.de>
 <a729eeda-22d8-4f3e-bb6b-0cd2f3a06d2a@kernel.org>
 <20251017-spirited-ruby-carp-5d7fe9-mkl@pengutronix.de>
 <913f6723-a8be-4bce-9a57-0b5c7f2348ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ynlnffnlvabptqix"
Content-Disposition: inline
In-Reply-To: <913f6723-a8be-4bce-9a57-0b5c7f2348ef@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ynlnffnlvabptqix
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/9] can: netlink: add CAN XL
MIME-Version: 1.0

On 18.10.2025 01:20:31, Vincent Mailhol wrote:
> >>> What about merging patches 1+2 now?
> >>
> >> If patch 1 had to be squashed,
> >=20
> > Sorry - I was offering you to take patches 1+2 into can-next-testing
> > now.
>=20
> Ah! This makes more sense. Sorry for misreading you.
>=20
> Yes, you can pick those two. But could you just push your
> can-next-testing branch to git.kernel.org after picking those? This
> way, I can rebase my series on top of it instead of dealing with some
> complex dependencies.

Right, taking only part of the series makes things more complicated.
Better keep them for now.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ynlnffnlvabptqix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjycAcACgkQDHRl3/mQ
kZyR9Qf/dHuXg1h123QUJyH2OMIy1Nk7/Oc943idmDDkWRNNS2o+0182Kuk7KXhl
859937scZQgT1aZcV4d3nDCBwyDKsKKBELciJ8hP6fYLz4u4vFTwVHIkryWzT6Hg
VjRHV348u6Ezu9rUz3le7c8P8NVS7dydmucRrZXc+aaaNwCmKsdgEmLk0Ol74ch4
upAWaKWiNw8es3iuXwHBLaHRAu3h71N1l+D1HtaXr+9MQZzEhL6Ts59sYf4JryCu
gyjYTpHfYgS7Z1p2YXQmfJNqumn/NSW/gr+GcSpjVDgU2e1zcoeeyPGYBVo00LIb
g9nVUnNfmXHCFQ4KCjp4Mrk8yaUROA==
=3ttD
-----END PGP SIGNATURE-----

--ynlnffnlvabptqix--

