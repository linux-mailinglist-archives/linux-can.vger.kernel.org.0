Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE1F5800A5
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 16:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbiGYOWX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 10:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiGYOWW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 10:22:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC5412740
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 07:22:21 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oFyyQ-0001Ac-FA; Mon, 25 Jul 2022 16:22:18 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 24F41B9A6B;
        Mon, 25 Jul 2022 14:22:17 +0000 (UTC)
Date:   Mon, 25 Jul 2022 16:22:15 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH v1 18/24] can: dev: add generic function
 can_eth_ioctl_hwts()
Message-ID: <20220725142215.ww7hktoizjgskkpl@pengutronix.de>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220725133208.432176-19-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xcz6nrccmksktrdu"
Content-Disposition: inline
In-Reply-To: <20220725133208.432176-19-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--xcz6nrccmksktrdu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.07.2022 22:32:02, Vincent Mailhol wrote:
> Tools based on libpcap (such as tcpdump) expect the SIOCSHWTSTAMP
> ioctl call to be supported. This is also specified in the kernel doc
> [1]. The purpose of this ioctl is to toggle the hardware timestamps.
>=20
> Currently, CAN devices which support hardware timestamping have those
> always activated. can_eth_ioctl_hwts() is a dumb function that will
> always succeed when requested to set tx_type to HWTSTAMP_TX_ON or
> rx_filter to HWTSTAMP_FILTER_ALL.
>=20
> [1] Kernel doc: Timestamping, section 3.1 "Hardware Timestamping
> Implementation: Device Drivers"
> Link: https://docs.kernel.org/networking/timestamping.html#hardware-times=
tamping-implementation-device-drivers
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/net/can/dev/dev.c | 29 +++++++++++++++++++++++++++++
>  include/linux/can/dev.h   |  1 +
>  2 files changed, 30 insertions(+)
>=20
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 7ad56d31cec9..750dc7cae9d4 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -322,6 +322,35 @@ int can_change_mtu(struct net_device *dev, int new_m=
tu)
>  }
>  EXPORT_SYMBOL_GPL(can_change_mtu);
> =20
> +/* generic implementation of netdev_ops::ndo_eth_ioctl for CAN devices
> + * supporting hardware RX timestamps
> + */
> +int can_eth_ioctl_hwts(struct net_device *netdev, struct ifreq *ifr, int=
 cmd)
> +{
> +	struct hwtstamp_config hwts_cfg =3D { 0 };
> +
> +	switch (cmd) {
> +	case SIOCSHWTSTAMP: /* set */
> +		if (copy_from_user(&hwts_cfg, ifr->ifr_data, sizeof(hwts_cfg)))
> +			return -EFAULT;
> +		if (hwts_cfg.tx_type =3D=3D HWTSTAMP_TX_ON &&
> +		    hwts_cfg.rx_filter =3D=3D HWTSTAMP_FILTER_ALL)
> +			return 0;

I have a WIP hwts patch series for the mcp251xfd. IIRC the driver is
allowed to add RX timestamps to more packages than requested without
failing, so the relevant code my WIP patches looks like this:

+       switch (config.tx_type) {
+       case HWTSTAMP_TX_OFF:
+               break;
+       default:
+               return -ERANGE;
+       }
+
+       switch (config.rx_filter) {
+       case HWTSTAMP_FILTER_NONE:
+               clear_bit(MCP251XFD_FLAGS_TIMESTAMP_RX, priv->flags);
+               break;
+       default:
+               set_bit(MCP251XFD_FLAGS_TIMESTAMP_RX, priv->flags);
+               config.rx_filter =3D HWTSTAMP_FILTER_ALL;
+       }

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xcz6nrccmksktrdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLepxUACgkQrX5LkNig
0118NggAiZ3/ysG7wzdholwKQwgv0IwGsg7CSSVH9wFOcFCSUThAva2r3bLD46h9
prn9ffrUz5Q2zMC3sIeGCMQ2MYLCzU2lApp1nVytUZFr1FYLrls3dIl49GS1vZa2
CyDCl6bX/HjvbjQoJNy7uhleftLqwfKjAqR97yiTe0rngahOeJtG59kvPZZb0DBV
JokbYUc6AV/bVP3CC0ShkbgT4Ey5qSsoS9Pz6yqzF5lTt32joTWBk5XZjngvoGs1
qIi7v2aqf8fuU4zd37G2i9tJW0992R7nENvPFwTM8uVbHHnE28mznhaFjuymnzq/
yRVlzBPkA6XOu4McPKajdxdErXyKLg==
=VOIy
-----END PGP SIGNATURE-----

--xcz6nrccmksktrdu--
