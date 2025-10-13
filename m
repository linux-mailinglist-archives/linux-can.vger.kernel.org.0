Return-Path: <linux-can+bounces-5166-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5F1BD2D2B
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 13:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD0C189D24F
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 11:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4515F261581;
	Mon, 13 Oct 2025 11:44:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF0825FA10
	for <linux-can@vger.kernel.org>; Mon, 13 Oct 2025 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355862; cv=none; b=jSLCSemV2IcWu3ZbW4ifcTeJT3IToAzPWElnAKGYd3tEYhVOPUib/cVhY/xGkm+2hfrIP3o0SL6lMAfeN22mpldNENUhr6QFQ7Yj+B6qLlaS1g1GF/KeFZrkuxb7H82hZ6oZ+BberntxI3PSCrwM0sjix7iEjDcQ3W77SNHG90k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355862; c=relaxed/simple;
	bh=8eC1BSK/uBIfeMwtMf/eRDAxHcCKFEYEtghB3gXrNbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IR90qVcCez9jj75Ov9nOLiMGYV3t2NNqQMw4Gc+tuUnMPh8Y0/FvhWV1Qfi+0jvJr6RTAcP34cM/1Wwu7WWGVZHWmL5jK50ma00+ioM9UGkIG00aLVDs4zJ/SYNlh3EHni3kIIjCbyKf4urjWuBlvmM6r30iFbsGTdJGm8jDxwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8GyA-0004Pm-QG; Mon, 13 Oct 2025 13:44:02 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8Gy9-003NPs-2b;
	Mon, 13 Oct 2025 13:44:01 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 77709484B87;
	Mon, 13 Oct 2025 11:44:01 +0000 (UTC)
Date: Mon, 13 Oct 2025 13:44:00 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH v3 2/2] phy: add basic support for NXPs TJA1145 CAN
 transceiver
Message-ID: <20251013-burrowing-elk-of-coffee-210990-mkl@pengutronix.de>
References: <20251013-tja1145-support-v3-0-4a9d245fe067@liebherr.com>
 <20251013-tja1145-support-v3-2-4a9d245fe067@liebherr.com>
 <20251013-unyielding-turquoise-mamba-76a0ea-mkl@pengutronix.de>
 <20251013113605.GA177845@legfed1>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7p5ebwh66hrkwuao"
Content-Disposition: inline
In-Reply-To: <20251013113605.GA177845@legfed1>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--7p5ebwh66hrkwuao
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] phy: add basic support for NXPs TJA1145 CAN
 transceiver
MIME-Version: 1.0

On 13.10.2025 13:36:05, Dimitri Fedrau wrote:
> Am Mon, Oct 13, 2025 at 11:51:51AM +0200 schrieb Marc Kleine-Budde:
> > On 13.10.2025 11:19:19, Dimitri Fedrau via B4 Relay wrote:
> > > Add basic driver support for NXPs TJA1145 CAN transceiver which bring=
s the
> > > PHY up/down by switching to normal/standby mode using SPI commands.
> >=20
> > The PHY supports standby and sleep mode. Does the PHY framework provide
> > a way to configure this?
> >=20
>=20
> Didn't find anything related.
>=20
> > Why do you put the transceiver into standby not in sleep mode?
> >=20
> Datasheet states:
>=20
> Standby mode is the first-level power-saving mode of the TJA1145A,
> featuring low current consumption. The transceiver is unable to transmit
> or receive data in Standby mode, but the INH pin remains active so voltage
> regulators controlled by this pin will be active.
>=20
> Sleep mode is the second-level power saving mode of the TJA1145A. In Sleep
> mode, the transceiver behaves as in Standby Mode with the exception that
> pin INH is set to a high-ohmic state. Voltage regulators controlled by th=
is
> pin will be switched off, and the current into pin BAT will be reduced to=
 a
> minimum.
>=20
> I'm assuming that the sleep state would fit into some suspend,
> power-off, ... scenario, because the INH pin maybe used to control
> regulators.

That makes sense, and I think it depends heavily on the use case of the
system. This can be implemented as soon as the need arises.

For the whole series:

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7p5ebwh66hrkwuao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjs5f0ACgkQDHRl3/mQ
kZyjqggArjAF75JX1jsP6Oh6UDJKXTCUtRYB0X1u1QmOgNOCdkMtH44l59g81+nW
5Vm1QYld8NkdmyPu3FugSdCDDxDnVFLX2v9Bwake5eRSHm9RSQFZ1hSblqVZQ0Bx
ULlWXPZrS+QdhCmtdSAbi7iEbvZtxYcf9M/qjH8vRdpSJ+5BRZ/vIyfwMxJPJgms
BM6jflWj7zTTFR9EM/9vwlnRc7Hrfe+woZ0BM7aYYjY8ibmWe9Xe6R5m6QQBtDUv
5PILzA2mxoUkZ/LGXi0OgExuwZp+1LdrLRat+4ZsLTGQqSMHKypuwrB89Z0qMkIv
/izuJx1+Sy5HQFcgLMVZYdkB9hOKpg==
=tHfi
-----END PGP SIGNATURE-----

--7p5ebwh66hrkwuao--

