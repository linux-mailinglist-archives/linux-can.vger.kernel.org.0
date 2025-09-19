Return-Path: <linux-can+bounces-4763-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E607B8B0EF
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 21:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2475A04487
	for <lists+linux-can@lfdr.de>; Fri, 19 Sep 2025 19:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A260727932F;
	Fri, 19 Sep 2025 19:11:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AEA283141
	for <linux-can@vger.kernel.org>; Fri, 19 Sep 2025 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309087; cv=none; b=s8KQqF3FOP8N/zn29QQESGIo+0v35Pur0UzMDF2HEtzTXtecTgXNgLe3SFv7jhUJ7HV8rbUErk8S1NJDS72GPqdcW2k0gxQu3hiCGjNhJAU8u/0Uliz1tFXfhQx5sLCDkEH9BvyObd9YvicVHjBwZM7xewbPelQNZcGsL5aVeqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309087; c=relaxed/simple;
	bh=fJ9NrCI2MnKJVF0y9MVjIWlY1cIc3TMrxlHdOqfrI0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keyFV/WcDSGkKruQ2ZuWyEYciAXDfuQ39UofcrEj2KokQIugm1eeYHg8kfx3RxcweL1aKmavRCE/d8fM7ueuq2KmN3SgqaKcPyI4wLgZFaKLUxHxWv4c3itQF3EYGhP/zQ+T7m4dVTndnmC5lC9/L4DzCbht/02W+dgNpx2pwM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzgVg-0003TW-4W; Fri, 19 Sep 2025 21:11:08 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzgVe-0029df-3A;
	Fri, 19 Sep 2025 21:11:07 +0200
Received: from pengutronix.de (ip-185-104-138-125.ptr.icomera.net [185.104.138.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BF5294751F9;
	Fri, 19 Sep 2025 19:11:02 +0000 (UTC)
Date: Fri, 19 Sep 2025 21:11:00 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Peng Fan <peng.fan@nxp.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
	Haibo Chen <haibo.chen@nxp.com>, linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/9] phy: phy-can-transceiver: Add dual channel
 support for TJA1048
Message-ID: <20250919-placid-mauve-crayfish-4bac17-mkl@pengutronix.de>
References: <20250909-can-v6-0-1cc30715224c@nxp.com>
 <20250909-can-v6-3-1cc30715224c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ddcs7xwxfzkwj3u5"
Content-Disposition: inline
In-Reply-To: <20250909-can-v6-3-1cc30715224c@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ddcs7xwxfzkwj3u5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 3/9] phy: phy-can-transceiver: Add dual channel
 support for TJA1048
MIME-Version: 1.0

On 09.09.2025 13:40:13, Peng Fan wrote:
> - Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy has two
>   channels.
> - Alloc a phy for each channel
> - Support TJA1048 which is a dual high-speed CAN transceiver with sleep
>   mode supported.
> - Add can_transceiver_phy_xlate for parsing phy
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/phy/phy-can-transceiver.c | 91 ++++++++++++++++++++++++++++-----=
------
>  1 file changed, 65 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-tran=
sceiver.c
> index 6415c6af0e8414a6cc8d15958a17ee749a3f28e9..f06b1df76ada023f432dce892=
c3346f45397ab54 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -17,6 +17,7 @@ struct can_transceiver_data {
>  	u32 flags;
>  #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
>  #define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
> +#define CAN_TRANSCEIVER_DUAL_CH		BIT(2)
>  };
> =20
>  struct can_transceiver_phy {
> @@ -29,6 +30,7 @@ struct can_transceiver_phy {
>  struct can_transceiver_priv {
>  	struct can_transceiver_phy *can_transceiver_phy;
>  	struct mux_state *mux_state;
> +	int num_ch;

As a flexible array this looks like:

struct can_transceiver_priv {
        struct can_transceiver_phy *can_transceiver_phy;
        int num_ch;
        struct mux_state mux_state[] __counted_by(num_ch);
}

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ddcs7xwxfzkwj3u5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjNqsEACgkQDHRl3/mQ
kZxw3Af+PBvxMN1nt5aRZStLzP5rPgSQdXAJRyW4P7nGZlb7LEBiFIiAeFkNhNOz
xUXylSex50EhW2f23ZQar/WxcJ77N70yVV0DWbGHllNfK36ZVBPcjQ2qio0qk3rW
WTlyQYrMjS0WCKpIlWHw9qBCR+Ph7+rzz9+TTQiYEsxW6vG/AAhyK7+0jI+bePdh
0tDpTPadOfy+fO+sK8Sc8zS+/YDo8VlAJGBlPokJN52ikH8deUo5m1PgB66hM+pS
JF8fzV9FLUxgD5pNQ6jGryJBwz3VclLmXdx4uR8cF9c1X+OOrgEbKz60t+1qqaZx
/iXcb09yK9e/3fk7SWEzyT/KniCEuw==
=XG5h
-----END PGP SIGNATURE-----

--ddcs7xwxfzkwj3u5--

