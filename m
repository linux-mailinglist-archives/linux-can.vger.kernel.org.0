Return-Path: <linux-can+bounces-6063-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB48D089C5
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 11:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A46313008CA2
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 10:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD483331207;
	Fri,  9 Jan 2026 10:37:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2277332EC1
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955032; cv=none; b=iog+XfknkdKnIWKXo1dcww3ItGO4r/kz2XzBhMHMgI+0X6b8sdzVvHulSE79RWRz70PzC/a8drG9+4YLH9ceA31RivOy1O+bkCzJi20mPubNBmWiml1TGBYQwJSDgdzfyAiL7uYzwkY3VWQkSEM3Q9LhVrLE0xNuJzPZ+yyMkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955032; c=relaxed/simple;
	bh=ooFQ3SdZpM8Gs6wpHxJDVeglc/Vau08ttnDFkqusRXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u21V4x1i2vEY9687/C1sjn+AxmPRwK4LV546NVPtMglWP7YUBFiU73F9LIKmsUUDmW9EshZHhhMJLMRRi8Z+v5BKwVJsCy4PABuUUdLbBlG/Kb1JJgk9lm7NF94+l1y+mCk9HErZFqvl76SE1Xfui0kSSq/Y3kTP83UibMM2Yq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ve9rc-0006DH-Je; Fri, 09 Jan 2026 11:37:04 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ve9rc-009paE-0Q;
	Fri, 09 Jan 2026 11:37:04 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9F9E34C979D;
	Fri, 09 Jan 2026 10:37:03 +0000 (UTC)
Date: Fri, 9 Jan 2026 11:37:01 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH 2/3] can: propagate CAN device capabilities via ml_priv
Message-ID: <20260109-fearless-diamond-gaur-90b52a-mkl@pengutronix.de>
References: <20260101191330.1836-1-socketcan@hartkopp.net>
 <20260101191330.1836-2-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3htkqkz6pzkkp2uq"
Content-Disposition: inline
In-Reply-To: <20260101191330.1836-2-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--3htkqkz6pzkkp2uq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] can: propagate CAN device capabilities via ml_priv
MIME-Version: 1.0

Can you please add a cover letter to this series.

more comments inline...

On 01.01.2026 20:13:29, Oliver Hartkopp wrote:
> Commit 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
> caused a sequence of dependency and linker fixes.
>
> The entire problem was caused by the requirement that a new network layer
> feature needed to know about the protocol capabilities of the CAN devices.
> Instead of accessing CAN device internal data structures which caused the
> dependency problems this patch introduces capability information into the
> CAN specific ml_priv data which is accessible from both sides.
>
> With this change the CAN network layer can check the required features and
> the decoupling of the driver layer and network layer is restored.
>
> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev/dev.c     | 24 ++++++++++++++++++++++++
>  drivers/net/can/dev/netlink.c |  1 +
>  drivers/net/can/vcan.c        | 15 +++++++++++++++
>  drivers/net/can/vxcan.c       | 15 +++++++++++++++
>  include/linux/can/can-ml.h    | 25 +++++++++++++++++++++++++
>  include/linux/can/dev.h       |  1 +
>  6 files changed, 81 insertions(+)
>
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 091f30e94c61..aaa669fc0d2b 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -373,10 +373,33 @@ void can_set_default_mtu(struct net_device *dev)
>  		dev->min_mtu =3D CAN_MTU;
>  		dev->max_mtu =3D CAN_MTU;
>  	}
>  }
>
> +void can_set_cap_info(struct net_device *dev)
> +{
> +	struct can_priv *priv =3D netdev_priv(dev);
> +	u32 can_cap =3D CAN_CAP_CC;

I personally I would move the CAN_CAP_CC into the else branch. YMMV.

> +
> +	if (can_dev_in_xl_only_mode(priv)) {
> +		/* XL only mode =3D> no CC/FD capability */
> +		can_cap =3D CAN_CAP_XL;
> +	} else {
> +		if (priv->ctrlmode & CAN_CTRLMODE_FD)
> +			can_cap |=3D CAN_CAP_FD;
> +
> +		if (priv->ctrlmode & CAN_CTRLMODE_XL)
> +			can_cap |=3D CAN_CAP_XL;
> +	}
> +
> +	if (priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
> +			      CAN_CTRLMODE_RESTRICTED))
> +		can_cap |=3D CAN_CAP_RO;
> +
> +	can_set_cap(dev, can_cap);
> +}
> +

[...]

> diff --git a/include/linux/can/can-ml.h b/include/linux/can/can-ml.h
> index 8afa92d15a66..ff77097ae79f 100644
> --- a/include/linux/can/can-ml.h
> +++ b/include/linux/can/can-ml.h
> @@ -44,10 +44,16 @@
>
>  #include <linux/can.h>
>  #include <linux/list.h>
>  #include <linux/netdevice.h>
>
> +/* exposed CAN device capabilities for network layer */
> +#define CAN_CAP_CC 0x1U /* CAN CC aka Classical CAN */
> +#define CAN_CAP_FD 0x2U /* CAN FD */
> +#define CAN_CAP_XL 0x4U /* CAN XL */
> +#define CAN_CAP_RO 0x8U /* read-only mode (LISTEN/RESTRICTED) */

Can we use BIT() here?

> +
>  #define CAN_SFF_RCV_ARRAY_SZ (1 << CAN_SFF_ID_BITS)
>  #define CAN_EFF_RCV_HASH_BITS 10
>  #define CAN_EFF_RCV_ARRAY_SZ (1 << CAN_EFF_RCV_HASH_BITS)
>
>  enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
> @@ -62,10 +68,11 @@ struct can_dev_rcv_lists {
>  struct can_ml_priv {
>  	struct can_dev_rcv_lists dev_rcv_lists;
>  #ifdef CAN_J1939
>  	struct j1939_priv *j1939_priv;
>  #endif
> +	u32 can_cap;
>  };
>
>  static inline struct can_ml_priv *can_get_ml_priv(struct net_device *dev)
>  {
>  	return netdev_get_ml_priv(dev, ML_PRIV_CAN);
> @@ -75,6 +82,24 @@ static inline void can_set_ml_priv(struct net_device *=
dev,
>  				   struct can_ml_priv *ml_priv)
>  {
>  	netdev_set_ml_priv(dev, ml_priv, ML_PRIV_CAN);
>  }
>
> +static inline bool can_cap_enabled(struct net_device *dev, u32 cap)
> +{
> +	struct can_ml_priv *can_ml =3D can_get_ml_priv(dev);
> +
> +	if (!can_ml)
> +		return true;

Why is the capability enabled, if the device doesn't have a CAN ml_priv?

> +
> +	return (can_ml->can_cap & cap);
> +}
> +
> +static inline void can_set_cap(struct net_device *dev, u32 cap)
> +{
> +	struct can_ml_priv *can_ml =3D can_get_ml_priv(dev);
> +
> +	if (can_ml)

IMHO it's a bug if can_ml is NULL, it should not be ignored silently.
Maybe just de-ref the NULL pointer?

> +		can_ml->can_cap =3D cap;
> +}
> +
>  #endif /* CAN_ML_H */

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3htkqkz6pzkkp2uq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlg2kEACgkQDHRl3/mQ
kZwkagf/aE9mUm8LdJhvAlHe/I3BeWBE4M+UYD9ua67HFskPfIsUmHwBGvswgjAB
MahAoVE03rD7v14IJImesgPbgXWkfItucpgypGCmiOuh0ndIYUzf3VvT5eq+7GMV
k/sEOpn+JpmiYQuWLI/LCfWAO8CbFz25qz4Dpt3rA0U+YdpgAtMqnfbmRkCqaeAA
EIyqwrPPBRR5iISuzIIQo11M1UopWrxHrCpT0OmyFc50IDHZvVQrFq5HJl6tmb7N
VMBpfxQMOmx2DHZ+5RP80G0SW0kyeNJpn2oetspxguA/18ibMz4tcSxgn+tdtmoZ
WcLll573FnvKb79Uw5X/1VFKDZJ5lQ==
=Wmv+
-----END PGP SIGNATURE-----

--3htkqkz6pzkkp2uq--

