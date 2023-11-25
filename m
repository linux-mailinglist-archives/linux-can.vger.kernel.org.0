Return-Path: <linux-can+bounces-58-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A23C87F8CA9
	for <lists+linux-can@lfdr.de>; Sat, 25 Nov 2023 18:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84DE1C20AF2
	for <lists+linux-can@lfdr.de>; Sat, 25 Nov 2023 17:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4EB29439;
	Sat, 25 Nov 2023 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E01B6
	for <linux-can@vger.kernel.org>; Sat, 25 Nov 2023 09:14:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1r6wEz-00031H-F5; Sat, 25 Nov 2023 18:14:49 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1r6wEx-00BXMw-VX; Sat, 25 Nov 2023 18:14:48 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A823D253914;
	Sat, 25 Nov 2023 17:14:47 +0000 (UTC)
Date: Sat, 25 Nov 2023 18:14:47 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Thomas.Kopp@microchip.com
Cc: petter@ka-long.de, linux-can@vger.kernel.org
Subject: Re: RE: mcp251xfd on NXP LX2160A
Message-ID: <20231125-sample-slather-aea8764f0566-mkl@pengutronix.de>
References: <20231120161106.AA49E5B00817@dd15738.kasserver.com>
 <BL3PR11MB64847C895A0918D99E6A9EACFBB9A@BL3PR11MB6484.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="auzhbkv4vu4mqaba"
Content-Disposition: inline
In-Reply-To: <BL3PR11MB64847C895A0918D99E6A9EACFBB9A@BL3PR11MB6484.namprd11.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--auzhbkv4vu4mqaba
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.11.2023 07:08:24, Thomas.Kopp@microchip.com wrote:
> > [ 4493.557075] mcp251xfd spi1.2 can2: MCP2518FD rev0.0 (-RX_INT -PLL -
> > MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD o:40.00MHz
> > c:40.00MHz m:8.00MHz rs:8.00MHz es:0.00MHz rf:8.00MHz ef:0.00MHz)
> > successfully initialized.

> I can't remember encountering these format errors before. Do you have
> access to a logic analyzer and can you spi during capture insmod +
> interface up?
>=20
> Do you have anything else on the same SPI? Where's the 8 MHz coming
> from? Did you limit this in your DT?

The "m:8.00MHz" is the maximum SPI speed the driver gets from the SPI
framework.

> You could try with -CRC_REG -CRC_RX -CRC_TX to see if you're able to
> communicate with the device (this is not suited for anything in
> production though)

Depending what you have in your DT, for a "microchip,mcp251xfd" it would
be this patch:

--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -46,8 +46,8 @@ static const struct mcp251xfd_devtype_data mcp251xfd_devt=
ype_data_mcp251863 =3D {
=20
 /* Autodetect model, start with CRC enabled. */
 static const struct mcp251xfd_devtype_data mcp251xfd_devtype_data_mcp251xf=
d =3D {
-        .quirks =3D MCP251XFD_QUIRK_CRC_REG | MCP251XFD_QUIRK_CRC_RX |
-                MCP251XFD_QUIRK_CRC_TX | MCP251XFD_QUIRK_ECC,
+        .quirks =3D /* MCP251XFD_QUIRK_CRC_REG | MCP251XFD_QUIRK_CRC_RX | =
*/
+                /* MCP251XFD_QUIRK_CRC_TX | */ MCP251XFD_QUIRK_ECC,
         .model =3D MCP251XFD_MODEL_MCP251XFD,

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--auzhbkv4vu4mqaba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmViK4QACgkQvlAcSiqK
BOgZDwf/QFosRMPoWukwXzln/RpV45N2wy64Wl6a3r1a48uEVnlzESAzPOUNmA6E
YvT916Nia7heKExHifr20GHSuLz/NWHLJsEG/8rpt6zX7knmYZew2lmmvzrxo+08
qPsZl7eHUm4EXAnSRUOny3QEBcqSpN2uOULbv1Y5DEF9zIbAPcuBLXqt9UAm1hZJ
/oxg8GUgqVfFgnWWk+lhDrNrGo1LcIEpupV7tFDCjDooEO/ZTXTQcwRYt3UCVeW1
EqaeSV6qlF8DjS0YZaT23ArMs1+8S2XJGbtu3+k+e2ac7cDsHatVNOHCD6I+/dye
d8jWrlsQ3SWXCyCh5u6vS3h6UKZnsg==
=F9D2
-----END PGP SIGNATURE-----

--auzhbkv4vu4mqaba--

