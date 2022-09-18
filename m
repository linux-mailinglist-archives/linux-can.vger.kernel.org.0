Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5A35BBFD5
	for <lists+linux-can@lfdr.de>; Sun, 18 Sep 2022 22:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIRUb5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 18 Sep 2022 16:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiIRUb4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 18 Sep 2022 16:31:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB20140E9
        for <linux-can@vger.kernel.org>; Sun, 18 Sep 2022 13:31:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oa0xF-0006g3-Va; Sun, 18 Sep 2022 22:31:54 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:9e88:da4f:2587:9741])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6C246E56D9;
        Sun, 18 Sep 2022 20:31:53 +0000 (UTC)
Date:   Sun, 18 Sep 2022 22:31:44 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Daniel Trevitz <daniel.trevitz@wika.com>,
        Ryan Edwards <ryan.edwards@gmail.com>
Subject: Re: [PATCH] can: gs_usb: add switchable termination support
Message-ID: <20220918203144.6c2lpg4cnir36n4n@pengutronix.de>
References: <20220918202348.675850-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="inv74gnz4vfkvfqp"
Content-Disposition: inline
In-Reply-To: <20220918202348.675850-1-mkl@pengutronix.de>
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


--inv74gnz4vfkvfqp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.09.2022 22:23:48, Marc Kleine-Budde wrote:
> The candleLight community is working on switchable termination support
> for the candleLight firmware. As the the Linux CAN framework supports
> switchable termination add this feature to the gs_usb driver.
>=20
> Devices supporting the feature should set the
> GS_CAN_FEATURE_TERMINATION and implement the
> GS_USB_BREQ_SET_TERMINATION and GS_USB_BREQ_GET_TERMINATION control
> messages.
>=20
> For now the driver assumes for activated termination the standard
> termination of 120=CE=A9.
>=20
> Link: https://github.com/candle-usb/candleLight_fw/issues/92
> Link: https://github.com/candle-usb/candleLight_fw/pull/108
> Cc: Daniel Trevitz <daniel.trevitz@wika.com>
> Cc: Ryan Edwards <ryan.edwards@gmail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

[...]

> +static int gs_usb_get_termination(struct net_device *netdev, u16 *term)
> +{
> +	struct gs_can *dev =3D netdev_priv(netdev);
> +	struct gs_termination_state state;
> +	int rc;
> +
> +	rc =3D usb_control_msg_recv(interface_to_usbdev(dev->iface), 0,
> +				  GS_USB_BREQ_GET_TERMINATION,
> +				  USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
> +				  dev->channel, 0,
> +				  &state, sizeof(state), 1000,
> +				  GFP_KERNEL);
> +
> +	return rc;
> +}
> +
> +static int gs_usb_set_termination(struct net_device *netdev, u16 term)
> +{
> +	struct gs_can *dev =3D netdev_priv(netdev);
> +	struct gs_termination_state state;
> +	u16 actual_term;
> +	int rc;
> +
> +	if (term =3D=3D GS_USB_TERMINATION_ENABLED)
> +		state.state =3D cpu_to_le32(GS_CAN_TERMINATION_STATE_ON);
> +	else
> +		state.state =3D cpu_to_le32(GS_CAN_TERMINATION_STATE_OFF);
> +
> +	rc =3D usb_control_msg_send(interface_to_usbdev(dev->iface), 0,
> +				  GS_USB_BREQ_SET_TERMINATION,
> +				  USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
> +				  dev->channel, 0,
> +				  &state, sizeof(state), 1000,
> +				  GFP_KERNEL);
> +
> +	if (rc)
> +		return rc;
> +
> +	rc =3D gs_usb_get_termination(netdev, &actual_term);

I'm not sure if we need this. The usb_control_msg_send() should only
return if the request succeeds.

I'll add a gs_usb_get_termination() call to the probe function, so that
the driver knows the termination state.

> +	if (rc)
> +		return rc;
> +
> +	if (term !=3D actual_term)
> +		return -EIO;
> +
> +	return rc;
> +}
> +

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--inv74gnz4vfkvfqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMngC4ACgkQrX5LkNig
011Y2AgAoEBIiWMU4iJ0ZuDsCFB3nykI5W2Cqewg3OX52Z3ACPshfVEASYBfhR8T
DRZzaPsbanGvtfcITvwDIXnU6Bm3xaJQ4atavSOH5Yggrg8pwRQ36tJMcrIWvbhy
P0pWCV+orpHOZrmcrV7R7QMAsA6mn4EdH6tyVegrjyeGIIIyFOpx5ATiuTe8nYFh
ZifOCY+eLU1fx1xquZ4PuJtoK4405YeP3TkE8iBmtwQSFY2DgAaS8pMn7Oy7NvMM
rvr7/XwlwFl/D0D/1M6lx/obB0XDinART+vrOlO0Lnz8lZrXuYLCIWDdE7KGVhpF
mJ1G6GHo3xSG9k4xN35jEcTC+Bhn6A==
=jRz2
-----END PGP SIGNATURE-----

--inv74gnz4vfkvfqp--
