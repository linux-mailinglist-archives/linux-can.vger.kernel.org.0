Return-Path: <linux-can+bounces-2484-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033B89FA6ED
	for <lists+linux-can@lfdr.de>; Sun, 22 Dec 2024 17:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7A47A21E2
	for <lists+linux-can@lfdr.de>; Sun, 22 Dec 2024 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE24502B1;
	Sun, 22 Dec 2024 16:53:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5429E38DDB
	for <linux-can@vger.kernel.org>; Sun, 22 Dec 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734886421; cv=none; b=hG+wCPJ1s/ly3x/JUMKMedatLOvwHIWHC8PjznNzB0vsNdcwjgjS4lMjUFu5H5rgZ59fUpCHTEnyxh13T8xm5FDgzLsylZkoqeNuubVY1HMFawCwKBp4RCKZG0LhyFsi57U+7aH8onW89lvlGMCvyrenIrZ7V379CCO06Um1Bno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734886421; c=relaxed/simple;
	bh=b24JXmHyIqPfrtP3Giz1WaLiNv6wSkUBJDbwkdaKtnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKfuBuow2+pWoJ7UwHWo+uxFkUHDjSYdTv7rTWvV4HWmQSOlfMbmWuyFiRfOxz9W+9HlxwguIOS/bPsQikOCb2SmkhHGc/DTCROmf8E3ck4prAlla2hYn7n3hOQVhCWG5Ynfm+FOykYEwFdICszixZESmbAkRYAT5ygt2I3zbLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tPPCb-00079m-3w; Sun, 22 Dec 2024 17:53:13 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tPPCX-004jGl-1y;
	Sun, 22 Dec 2024 17:53:10 +0100
Received: from pengutronix.de (2a02-8206-240a-ed00-dcc8-6079-a37a-d53f.dynamic.ewe-ip-backbone.de [IPv6:2a02:8206:240a:ed00:dcc8:6079:a37a:d53f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 54814393BE0;
	Sun, 22 Dec 2024 16:53:09 +0000 (UTC)
Date: Sun, 22 Dec 2024 17:53:08 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v6 0/7] can: m_can: Add am62 wakeup support
Message-ID: <20241222-opalescent-athletic-cuttlefish-c96337-mkl@pengutronix.de>
References: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jydsmls263522sjm"
Content-Disposition: inline
In-Reply-To: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--jydsmls263522sjm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 0/7] can: m_can: Add am62 wakeup support
MIME-Version: 1.0

On 19.12.2024 20:57:51, Markus Schneider-Pargmann wrote:
> Hi,
>=20
> Series
> ------
> am62, am62a and am62p support Partial-IO, a poweroff SoC state with a
> few pin groups being active for wakeup.
>=20
> To support mcu_mcan0 and mcu_mcan1 wakeup for the mentioned SoCs, the
> series introduces a notion of wake-on-lan for m_can. If the user decides
> to enable wake-on-lan for a m_can device, the device is set to wakeup
> enabled. A 'wakeup' pinctrl state is selected to enable wakeup flags for
> the relevant pins. If wake-on-lan is disabled the default pinctrl is
> selected.
>=20
> After feedback from Nishanth and Krzysztof, I moved to a wakeup-source
> property that can be a list of powerstates in which the device is wakeup
> capable. This describes special cases like Partial-IO where the device
> is powered off but pins can be sensible to changes and trigger a wakeup.
>=20
> It is based on v6.13-rc1.
>=20
> Partial-IO
> ----------
> This series is part of a bigger topic to support Partial-IO on am62,
> am62a and am62p. Partial-IO is a poweroff state in which some pins are
> able to wakeup the SoC. In detail MCU m_can and two serial port pins can
> trigger the wakeup.
> A documentation can also be found in section 6.2.4 in the TRM:
>   https://www.ti.com/lit/pdf/spruiv7
>=20
> This other series is relevant for the support of Partial-IO:
>=20
>  - firmware: ti_sci: Partial-IO support
>    https://gitlab.baylibre.com/msp8/linux/-/tree/topic/am62-partialio/v6.=
13?ref_type=3Dheads
>=20
> Testing
> -------
> A test branch is available here that includes all patches required to
> test Partial-IO:
>=20
> https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-partialio/=
v6.13?ref_type=3Dheads
>=20
> After enabling Wake-on-LAN the system can be powered off and will enter
> the Partial-IO state in which it can be woken up by activity on the
> specific pins:
>     ethtool -s can0 wol p
>     ethtool -s can1 wol p
>     poweroff
>=20
> I tested these patches on am62-lp-sk.
>=20
> Best,
> Markus
>=20
> Previous versions:
>  v1: https://lore.kernel.org/lkml/20240523075347.1282395-1-msp@baylibre.c=
om/
>  v2: https://lore.kernel.org/lkml/20240729074135.3850634-1-msp@baylibre.c=
om/
>  v3: https://lore.kernel.org/lkml/20241011-topic-mcan-wakeup-source-v6-12=
-v3-0-9752c714ad12@baylibre.com
>  v4: https://lore.kernel.org/r/20241015-topic-mcan-wakeup-source-v6-12-v4=
-0-fdac1d1e7aa6@baylibre.com
>  v5: https://lore.kernel.org/r/20241028-topic-mcan-wakeup-source-v6-12-v5=
-0-33edc0aba629@baylibre.com
>=20
> Changes in v6:
>  - Rebased to v6.13-rc1
>  - After feedback of the other Partial-IO series, I updated this series
>    and removed all use of regulator-related patches.
>  - wakeup-source is now not only a boolean property but can also be a
>    list of power states in which the device is wakeup capable.
>=20
> Changes in v5:
>  - Make the check of wol options nicer to read
>=20
> Changes in v4:
>  - Remove leftover testing code that always returned -EIO in a specific
>  - Redesign pincontrol setup to be easier understandable and less nested
>  - Fix missing parantheses around wol_enable expression
>  - Remove | from binding description
>=20
> Changes in v3:
>  - Rebase to v6.12-rc1
>  - Change 'wakeup-source' to only 'true'
>  - Simplify m_can_set_wol by returning early on error
>  - Add vio-suuply binding and handling of this optional property.
>    vio-supply is used to reflect the SoC architecture and which power
>    line powers the m_can unit. This is important as some units are
>    powered in special low power modes.
>=20
> Changes in v2:
>  - Rebase to v6.11-rc1
>  - Squash these two patches for the binding into one:
>    dt-bindings: can: m_can: Add wakeup-source property
>    dt-bindings: can: m_can: Add wakeup pinctrl state
>  - Add error handling to multiple patches of the m_can driver
>  - Add error handling in m_can_class_allocate_dev(). This also required
>    to add a new patch to return error pointers from
>    m_can_class_allocate_dev().
>=20
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

LGTM, next we need Krzysztof Kozlowski's ACK for DT bindings update. The
dts changes (patches 5...7) will not go via the CAN tree but AFAICS via
Vignesh Raghavendra.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jydsmls263522sjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdoQ/IACgkQKDiiPnot
vG8slwf+PEhjyVyymqMXJI7WO4KDV5Dt3PhLwECF7uTVWkpjrtpMpPlkZZHNHojX
4sw0LeKZJzXWmmxIW1QS8IXWeD6VRlVlihLMqpfFioxqWtbRvxgaPbhqJw8+7P3c
Hq/wocZvllJXc3vWgSlYM943Bhpo7Mp4MBrkPEH1uL/xDfVgxozVf2NRYqu+O22A
0657vbr7yRte/5+YB/aiHGKs9KtowpYEEJyK4HQHR4N9HqxPFGYGCmLABdswdmcj
OQWoQUKQ0P27lnb7E54KE893tAoXA5n9z9Iu1SoxGdaEJLQ4NII/Qewd1MiNlhzV
UfKlUvl1KNcqqA8KQEdpBeSGFuZLFw==
=L59V
-----END PGP SIGNATURE-----

--jydsmls263522sjm--

