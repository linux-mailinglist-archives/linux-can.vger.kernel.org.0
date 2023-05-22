Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DA470B773
	for <lists+linux-can@lfdr.de>; Mon, 22 May 2023 10:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjEVIUB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 May 2023 04:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjEVIT4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 May 2023 04:19:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4616AB7
        for <linux-can@vger.kernel.org>; Mon, 22 May 2023 01:19:55 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1q10lk-0000SI-GG; Mon, 22 May 2023 10:19:52 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C88EC1C9683;
        Mon, 22 May 2023 08:03:15 +0000 (UTC)
Date:   Mon, 22 May 2023 10:03:15 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Marcel Hellwig <git@cookiesoft.de>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        Marcel Hellwig <mhellwig@mut-group.com>
Subject: Re: [PATCH] can: dev: add transceiver capabilities to xilinx_can
Message-ID: <20230522-untainted-saga-f05e02fdb66d-mkl@pengutronix.de>
References: <20230417085204.179268-1-git@cookiesoft.de>
 <CAMZ6RqJqwyJQ17EJd0eV_8tbsC5b16nbuQj3uD38BeRzSdPc3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xtzwnswlwv7ehunt"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJqwyJQ17EJd0eV_8tbsC5b16nbuQj3uD38BeRzSdPc3Q@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--xtzwnswlwv7ehunt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.05.2023 16:58:02, Vincent MAILHOL wrote:
> Hi Marcel,
>=20
> Style check only (I am not yet familiar enough with the devicetree).
>=20
> On Mon. 17 Apr. 2023 at 18:01, Marcel Hellwig <git@cookiesoft.de> wrote:
> > Currently the xilinx_can driver does not support adding a phy like the
> > "ti,tcan1043" to its devicetree.
> >
> > This code makes it possible to add such phy, so that the kernel makes
> > sure that the PHY is in operational state, when the link is set to an
> > "up" state.
> >
> > Signed-off-by: Marcel Hellwig <git@cookiesoft.de>
> > ---
> >  drivers/net/can/xilinx_can.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> > index 43c812ea1de0..6a5b805d579a 100644
> > --- a/drivers/net/can/xilinx_can.c
> > +++ b/drivers/net/can/xilinx_can.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/types.h>
> >  #include <linux/can/dev.h>
> >  #include <linux/can/error.h>
> > +#include <linux/phy/phy.h>
> >  #include <linux/pm_runtime.h>
> >
> >  #define DRIVER_NAME    "xilinx_can"
> > @@ -215,6 +216,7 @@ struct xcan_priv {
> >         struct clk *bus_clk;
> >         struct clk *can_clk;
> >         struct xcan_devtype_data devtype;
> > +       struct phy *transceiver;
> >  };
> >
> >  /* CAN Bittiming constants as per Xilinx CAN specs */
> > @@ -1419,6 +1421,12 @@ static int xcan_open(struct net_device *ndev)
> >         struct xcan_priv *priv =3D netdev_priv(ndev);
> >         int ret;
> >
> > +       ret =3D phy_power_on(priv->transceiver);
> > +       if (ret) {
> > +               netdev_err(ndev, "%s: phy_power_on failed(%d)\n", __fun=
c__, ret);
>=20
> From the Linux kernel coding style:
>=20
>   Printing numbers in parentheses (%d) adds no value and should be avoide=
d.
>   Link: https://www.kernel.org/doc/html/latest/process/coding-style.html#=
printing-kernel-messages
>=20
> Also consider %pe to print the mnemotechnic instead of the value:
>=20
>           netdev_err(ndev, "%s: phy_power_on failed: %pe\n", __func__,
> ERR_PTR(ret));

Good point. phy_power_on() already writes an error message:

| https://elixir.bootlin.com/linux/v6.3/source/drivers/phy/phy-core.c#L343

I'll remove that from this patch.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xtzwnswlwv7ehunt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRrIcAACgkQvlAcSiqK
BOjYLwf/SG2j6BDvXxyQC+bCI+t+OEDE2yVufB50HwcC45cY/1cWvMaSf5QBECqt
M2+a6gygc9xb9FIA24kHsUu6QARbkc80czOYelkdpF8fYIAJnVS4L7gsyUrMmWj1
hV50zZzS2iKnyyvbqzjwXnLeJ7/N9s4BMwp4cNGGYy19aa0rSbK1zxwFoYXtsujE
AQMOzbAi79hyYLHl+hwMb58maqVlLk14yGLcKR5J+ckC6tXG7V+9JV4jOFH1hW3Z
Sk2lVSiMPNTnMTJLsmiG12qtlnTE9wtnaPXBH0+0KXV2llPTNuS7YP+ANBZBfohq
jXEZnQGrJmCAGohRTf4VqkvVJ8gsBA==
=TZLP
-----END PGP SIGNATURE-----

--xtzwnswlwv7ehunt--
