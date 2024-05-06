Return-Path: <linux-can+bounces-580-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D468BCB92
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 12:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17A90B21692
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 10:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEAB14262C;
	Mon,  6 May 2024 10:04:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7561422C5
	for <linux-can@vger.kernel.org>; Mon,  6 May 2024 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989880; cv=none; b=sXWu7Ag4jmCw8zYNPHtkpg+gSsTb9/Dc4lrET8l/MFF4jD5A8qjRoguLcjZXCJZFA5AGqWhAfa3YS41c4zR9i6VnwKI/TBXdW4ahHyemFgzJ1K/iOcDR8HIGi8cMh5lZEBs2br0+a9PyhNIZun+kTRKh9GOyM8vcPQZzwyBTWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989880; c=relaxed/simple;
	bh=Rz3tmv5M/BfVTz9Dbv2NDSl77o9Q9ZlEusLzU94Zsv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uuk/tEPRPNZ3hl7VxS/abDMIdp3+nkVnAx1YgzV7pZxZkfJ56hz8dySWyfd5JyMrKu0qZLaPW72xHqTwUP2JELciq33T6sxsoGSArKCfxTZXVYunuuD/DOSZ6LgRh+Bn0g1b8GMWIH2jZGw5SAvTQ246LbMrhnKXbKv+5BuH7KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s3vCw-0008UR-FG; Mon, 06 May 2024 12:04:30 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s3vCv-00GFGh-5D; Mon, 06 May 2024 12:04:29 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BF3952CB452;
	Mon, 06 May 2024 10:04:28 +0000 (UTC)
Date: Mon, 6 May 2024 12:04:28 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] can: m_can: don't enable transceiver when probing
Message-ID: <20240506-chicken-of-perfect-abundance-39fc79-mkl@pengutronix.de>
References: <20240501124204.3545056-1-martin@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="io6j4e57pbuwe7sr"
Content-Disposition: inline
In-Reply-To: <20240501124204.3545056-1-martin@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--io6j4e57pbuwe7sr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Markus,

do you have time to review this patch? I want to send a PR tomorrow.

regards,
Marc

On 01.05.2024 14:42:03, Martin Hundeb=C3=B8ll wrote:
> The m_can driver sets and clears the CCCR.INIT bit during probe (both
> when testing the NON-ISO bit, and when configuring the chip). After
> clearing the CCCR.INIT bit, the transceiver enters normal mode, where it
> affects the CAN bus (i.e. it ACKs frames). This can cause troubles when
> the m_can node is only used for monitoring the bus, as one cannot setup
> listen-only mode before the device is probed.
>=20
> Rework the probe flow, so that the CCCR.INIT bit is only cleared when
> upping the device. First, the tcan4x5x driver is changed to stay in
> standby mode during/after probe. This in turn requires changes when
> setting bits in the CCCR register, as its CSR and CSA bits are always
> high in standby mode.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@geanix.com>
> ---
>=20
> Changes since v1:
>  * Implement Markus review comments:
>    - Rename m_can_cccr_wait_bits() to m_can_cccr_update_bits()
>    - Explicitly set CCCR_INIT bit in m_can_dev_setup()
>    - Revert to 5 timeouts/tries to 10
>    - Use m_can_config_{en|dis}able() in m_can_niso_supported()
>    - Revert move of call to m_can_enable_all_interrupts()
>    - Return -EBUSY on failure to enter normal mode
>    - Use tcan4x5x_clear_interrupts() in tcan4x5x_can_probe()
>=20
>  drivers/net/can/m_can/m_can.c         | 131 +++++++++++++++-----------
>  drivers/net/can/m_can/tcan4x5x-core.c |  13 ++-
>  2 files changed, 85 insertions(+), 59 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 14b231c4d7ec..7974aaa5d8cc 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -379,38 +379,60 @@ m_can_txe_fifo_read(struct m_can_classdev *cdev, u3=
2 fgi, u32 offset, u32 *val)
>  	return cdev->ops->read_fifo(cdev, addr_offset, val, 1);
>  }
> =20
> -static void m_can_config_endisable(struct m_can_classdev *cdev, bool ena=
ble)
> +static bool m_can_cccr_update_bits(struct m_can_classdev *cdev, u32 mask=
, u32 val)
>  {
> -	u32 cccr =3D m_can_read(cdev, M_CAN_CCCR);
> -	u32 timeout =3D 10;
> -	u32 val =3D 0;
> -
> -	/* Clear the Clock stop request if it was set */
> -	if (cccr & CCCR_CSR)
> -		cccr &=3D ~CCCR_CSR;
> -
> -	if (enable) {
> -		/* enable m_can configuration */
> -		m_can_write(cdev, M_CAN_CCCR, cccr | CCCR_INIT);
> -		udelay(5);
> -		/* CCCR.CCE can only be set/reset while CCCR.INIT =3D '1' */
> -		m_can_write(cdev, M_CAN_CCCR, cccr | CCCR_INIT | CCCR_CCE);
> -	} else {
> -		m_can_write(cdev, M_CAN_CCCR, cccr & ~(CCCR_INIT | CCCR_CCE));
> -	}
> +	u32 val_before =3D m_can_read(cdev, M_CAN_CCCR);
> +	u32 val_after =3D (val_before & ~mask) | val;
> +	size_t tries =3D 10;
> +
> +	if (!(mask & CCCR_INIT) && !(val_before & CCCR_INIT))
> +		dev_warn(cdev->dev,
> +			 "trying to configure device when in normal mode. Expect failures\n");
> +
> +	/* The chip should be in standby mode when changing the CCCR register,
> +	 * and some chips set the CSR and CSA bits when in standby. Furthermore,
> +	 * the CSR and CSA bits should be written as zeros, even when they read
> +	 * ones.
> +	 */
> +	val_after &=3D ~(CCCR_CSR | CCCR_CSA);
> +
> +	while (tries--) {
> +		u32 val_read;
> +
> +		/* Write the desired value in each try, as setting some bits in
> +		 * the CCCR register require other bits to be set first. E.g.
> +		 * setting the NISO bit requires setting the CCE bit first.
> +		 */
> +		m_can_write(cdev, M_CAN_CCCR, val_after);
> +
> +		val_read =3D m_can_read(cdev, M_CAN_CCCR) & ~(CCCR_CSR | CCCR_CSA);
> =20
> -	/* there's a delay for module initialization */
> -	if (enable)
> -		val =3D CCCR_INIT | CCCR_CCE;
> -
> -	while ((m_can_read(cdev, M_CAN_CCCR) & (CCCR_INIT | CCCR_CCE)) !=3D val=
) {
> -		if (timeout =3D=3D 0) {
> -			netdev_warn(cdev->net, "Failed to init module\n");
> -			return;
> -		}
> -		timeout--;
> -		udelay(1);
> +		if (val_read =3D=3D val_after)
> +			return true;
> +
> +		usleep_range(1, 5);
>  	}
> +
> +	return false;
> +}
> +
> +static void m_can_config_enable(struct m_can_classdev *cdev)
> +{
> +	/* CCCR_INIT must be set in order to set CCCR_CCE, but access to
> +	 * configuration registers should only be enabled when in standby mode,
> +	 * where CCCR_INIT is always set.
> +	 */
> +	if (!m_can_cccr_update_bits(cdev, CCCR_CCE, CCCR_CCE))
> +		netdev_err(cdev->net, "failed to enable configuration mode\n");
> +}
> +
> +static void m_can_config_disable(struct m_can_classdev *cdev)
> +{
> +	/* Only clear CCCR_CCE, since CCCR_INIT cannot be cleared while in
> +	 * standby mode
> +	 */
> +	if (!m_can_cccr_update_bits(cdev, CCCR_CCE, 0))
> +		netdev_err(cdev->net, "failed to disable configuration registers\n");
>  }
> =20
>  static void m_can_interrupt_enable(struct m_can_classdev *cdev, u32 inte=
rrupts)
> @@ -1403,7 +1425,7 @@ static int m_can_chip_config(struct net_device *dev)
>  	interrupts &=3D ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TFE | IR_TCF |
>  			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F);
> =20
> -	m_can_config_endisable(cdev, true);
> +	m_can_config_enable(cdev);
> =20
>  	/* RX Buffer/FIFO Element Size 64 bytes data field */
>  	m_can_write(cdev, M_CAN_RXESC,
> @@ -1521,7 +1543,7 @@ static int m_can_chip_config(struct net_device *dev)
>  		    FIELD_PREP(TSCC_TCP_MASK, 0xf) |
>  		    FIELD_PREP(TSCC_TSS_MASK, TSCC_TSS_INTERNAL));
> =20
> -	m_can_config_endisable(cdev, false);
> +	m_can_config_disable(cdev);
> =20
>  	if (cdev->ops->init)
>  		cdev->ops->init(cdev);
> @@ -1550,6 +1572,11 @@ static int m_can_start(struct net_device *dev)
>  		cdev->tx_fifo_putidx =3D FIELD_GET(TXFQS_TFQPI_MASK,
>  						 m_can_read(cdev, M_CAN_TXFQS));
> =20
> +	if (!m_can_cccr_update_bits(cdev, CCCR_INIT, 0)) {
> +		netdev_err(dev, "failed to enter normal mode\n");
> +		return -EBUSY;
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -1603,33 +1630,20 @@ static int m_can_check_core_release(struct m_can_=
classdev *cdev)
>   */
>  static bool m_can_niso_supported(struct m_can_classdev *cdev)
>  {
> -	u32 cccr_reg, cccr_poll =3D 0;
> -	int niso_timeout =3D -ETIMEDOUT;
> -	int i;
> +	bool niso_supported;
> =20
> -	m_can_config_endisable(cdev, true);
> -	cccr_reg =3D m_can_read(cdev, M_CAN_CCCR);
> -	cccr_reg |=3D CCCR_NISO;
> -	m_can_write(cdev, M_CAN_CCCR, cccr_reg);
> +	m_can_config_enable(cdev);
> =20
> -	for (i =3D 0; i <=3D 10; i++) {
> -		cccr_poll =3D m_can_read(cdev, M_CAN_CCCR);
> -		if (cccr_poll =3D=3D cccr_reg) {
> -			niso_timeout =3D 0;
> -			break;
> -		}
> +	/* First try to set the NISO bit. */
> +	niso_supported =3D m_can_cccr_update_bits(cdev, CCCR_NISO, CCCR_NISO);
> =20
> -		usleep_range(1, 5);
> -	}
> +	/* Then clear the it again. */
> +	if (!m_can_cccr_update_bits(cdev, CCCR_NISO, 0))
> +		dev_err(cdev->dev, "failed to revert the NON-ISO bit in CCCR\n");
> =20
> -	/* Clear NISO */
> -	cccr_reg &=3D ~(CCCR_NISO);
> -	m_can_write(cdev, M_CAN_CCCR, cccr_reg);
> +	m_can_config_disable(cdev);
> =20
> -	m_can_config_endisable(cdev, false);
> -
> -	/* return false if time out (-ETIMEDOUT), else return true */
> -	return !niso_timeout;
> +	return niso_supported;
>  }
> =20
>  static int m_can_dev_setup(struct m_can_classdev *cdev)
> @@ -1694,8 +1708,12 @@ static int m_can_dev_setup(struct m_can_classdev *=
cdev)
>  		return -EINVAL;
>  	}
> =20
> -	if (cdev->ops->init)
> -		cdev->ops->init(cdev);
> +	/* Forcing standby mode should be redunant, as the chip should be in
> +	 * standby after a reset. Write the INIT bit anyways, should the chip
> +	 * be configured by previous stage.
> +	 */
> +	if (!m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT))
> +		return -EBUSY;
> =20
>  	return 0;
>  }
> @@ -1708,7 +1726,8 @@ static void m_can_stop(struct net_device *dev)
>  	m_can_disable_all_interrupts(cdev);
> =20
>  	/* Set init mode to disengage from the network */
> -	m_can_config_endisable(cdev, true);
> +	if (!m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT))
> +		netdev_err(dev, "failed to enter standby mode\n");
> =20
>  	/* set the state as STOPPED */
>  	cdev->can.state =3D CAN_STATE_STOPPED;
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_ca=
n/tcan4x5x-core.c
> index a42600dac70d..d723206ac7c9 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -453,10 +453,17 @@ static int tcan4x5x_can_probe(struct spi_device *sp=
i)
>  		goto out_power;
>  	}
> =20
> -	ret =3D tcan4x5x_init(mcan_class);
> +	tcan4x5x_check_wake(priv);
> +
> +	ret =3D tcan4x5x_write_tcan_reg(mcan_class, TCAN4X5X_INT_EN, 0);
>  	if (ret) {
> -		dev_err(&spi->dev, "tcan initialization failed %pe\n",
> -			ERR_PTR(ret));
> +		dev_err(&spi->dev, "Disabling interrupts failed %pe\n", ERR_PTR(ret));
> +		goto out_power;
> +	}
> +
> +	ret =3D tcan4x5x_clear_interrupts(mcan_class);
> +	if (ret) {
> +		dev_err(&spi->dev, "Clearing interrupts failed %pe\n", ERR_PTR(ret));
>  		goto out_power;
>  	}
> =20
> --=20
> 2.44.0
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--io6j4e57pbuwe7sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmY4qykACgkQKDiiPnot
vG9WfAf9HJYGbTFMRm1lRu3J2FSXiSgiz4A1zPlHZXudfUyAI4ZMhGtFuZcP5C/N
Py2Rq69JW9WJKU4/LY0eLGx6Efi2ySc206KKOAs8Ysfnasmq+uobI1OrEpx/AVT+
bDvAzcy8Vo3Z+yNUOBkZbdsUAAxoUCbKglN+jCbt2n6G064MegICkbx6J2vMuSQ8
Tpt+iAEU4ipjk2D57OsGjzxaqNW9V2l6BddEAx9jdRmQsvgtB/UWNvpEC8Q5FLXB
EbpyLpVNx5d5Ol/ZDRFXQFjsuGz/Y/z4dKivA7lOy2QO+wpfE1RDf0MRTOax+jTA
R3JVp4V0nU4JKkKG66x05EMIadjm1w==
=0KEb
-----END PGP SIGNATURE-----

--io6j4e57pbuwe7sr--

