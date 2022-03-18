Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525F74DD963
	for <lists+linux-can@lfdr.de>; Fri, 18 Mar 2022 13:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiCRMGm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Mar 2022 08:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiCRMGl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Mar 2022 08:06:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96A52E044C
        for <linux-can@vger.kernel.org>; Fri, 18 Mar 2022 05:05:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nVBM6-0003bK-Li; Fri, 18 Mar 2022 13:05:18 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1ddb-5eff-56d9-d971.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1ddb:5eff:56d9:d971])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E33EE4E85C;
        Fri, 18 Mar 2022 10:01:31 +0000 (UTC)
Date:   Fri, 18 Mar 2022 11:01:31 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Neeli <sneeli@xilinx.com>
Cc:     Srinivas Goud <sgoud@xilinx.com>,
        Naveen Kumar Gaddipati <naveenku@xilinx.com>,
        Prasad Beer Prasad <prasadbe@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Subject: Re: Queries on CAN frame work
Message-ID: <20220318100131.3hbz7pi63kf2n7je@pengutronix.de>
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
 <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
 <20220115232621.4ybmmrmgogies3o5@pengutronix.de>
 <DM6PR02MB538689AA158B340FE287CF05AF3A9@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220317220033.pxfioxhgxmm55b3f@pengutronix.de>
 <DM6PR02MB53866545ABAF3FBC596D43A6AF139@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220318083054.iukyynbnrnrvtrqd@pengutronix.de>
 <DM6PR02MB5386167ECF8C0CE87AC15DA6AF139@DM6PR02MB5386.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2gokvesow5kq2ywy"
Content-Disposition: inline
In-Reply-To: <DM6PR02MB5386167ECF8C0CE87AC15DA6AF139@DM6PR02MB5386.namprd02.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
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


--2gokvesow5kq2ywy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.03.2022 09:54:37, Srinivas Neeli wrote:
> > No, you are not. As explained in my last mail, there's no struct
> > can_bittiming_const in the mainline driver that matches your "ip"
> > output.
>=20
> Just cross checked the mainline driver and our internal driver.
> I am not seeing difference in struct can_bittiming_const structures.
> We are using 5 structures=20
> CAN - 1 structure
> CANFD 1.0 - Arbitration 1, data phase 1
> CANFD 2.0 - Arbitration 1, data phase 1
> Please check below link once.
> https://elixir.bootlin.com/linux/latest/source/drivers/net/can/xilinx_can=
=2Ec#L216

static const struct can_bittiming_const xcan_bittiming_const =3D {
	.name =3D DRIVER_NAME,
	.tseg1_min =3D 1,
	.tseg1_max =3D 16,
	.tseg2_min =3D 1,
	.tseg2_max =3D 8,
	.sjw_max =3D 4,
	.brp_min =3D 1,
	.brp_max =3D 256,
	.brp_inc =3D 1,
};

Looking at your "ip" output

| https://lore.kernel.org/all/DM6PR02MB538689AA158B340FE287CF05AF3A9@DM6PR0=
2MB5386.namprd02.prod.outlook.com/

it says:

          xilinx_can: tseg1 1..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-i=
nc 1
          xilinx_can: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp=
-inc 1

> Could you please let me know if I miss anything?

That does not match to the "struct can_bittiming_const
xcan_bittiming_const" you referenced
(https://elixir.bootlin.com/linux/latest/source/drivers/net/can/xilinx_can.=
c#L216).

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--2gokvesow5kq2ywy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmI0WHgACgkQrX5LkNig
012jxAf+PomGBprqiTKD6HIbHrSce0qOTiJznJ4ibSzaNbJmeKutKKyHAKOPPcTM
CaUe0b1S+I7HecEQKlhHzt/CWIkhVwTguLdxIAd+PjWTbcop/09eKWT6tQc7AVUY
g0lufs6uBqxQWjyYA+VRc2qTYwXUhClu96uoMZmKK5/gSN8EvDMW/dCdpbJNVWAJ
ZdsVY3adcMI0XbUmuw1aZ4dtvQnBeESdyHYbdMp3VY7I9YRO9UIWZIP4+6Nc5g/s
XQZydNK+ibmYM3YATLTdJxZl23SYbk1CwOG/KILI4Z0UxJ/lz5pd6LPY125hlxEE
WN7BtisNC30fydrxkrs0KG0Znzh58A==
=Yu5d
-----END PGP SIGNATURE-----

--2gokvesow5kq2ywy--
