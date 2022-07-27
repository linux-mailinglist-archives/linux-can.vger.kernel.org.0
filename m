Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A695821EC
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 10:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiG0ITj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 04:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiG0ITj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 04:19:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588F743E63
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 01:19:38 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oGcGV-0003jf-H1; Wed, 27 Jul 2022 10:19:35 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3FE95BBEEE;
        Wed, 27 Jul 2022 08:19:34 +0000 (UTC)
Date:   Wed, 27 Jul 2022 10:19:33 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH v1 10/24] can: tree-wide: implement
 ethtool_ops::get_drvinfo()
Message-ID: <20220727081933.yufxemvws3haj22y@pengutronix.de>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220725133208.432176-11-mailhol.vincent@wanadoo.fr>
 <CABGWkvoqkETb0H-UWhwPCk1eMwQC2ExfKUXm25Mv4R5g0kjb+Q@mail.gmail.com>
 <CAMZ6Rq+Wd412aFSiuLsjPE=aT0UQVNqp9FEZCEkjdU71hVWR0Q@mail.gmail.com>
 <CABGWkvqA5p=h7fHabH4iKoppvrypedonEnLnohgm0j+Nm-70NA@mail.gmail.com>
 <CAMZ6RqLhPHzv_zdPsE2QHOD7RgxYEu+ttWJXgjNFkE5h-8z4DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="onizkdmwx2gxacp3"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLhPHzv_zdPsE2QHOD7RgxYEu+ttWJXgjNFkE5h-8z4DQ@mail.gmail.com>
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


--onizkdmwx2gxacp3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2022 18:59:18, Vincent MAILHOL wrote:
> > > Does it make sense?
> >
> > I have already used this scheme in the c_can driver. I used this
> > scheme because I saw that it was used a lot
> > (git grep set_ethtool_ops) in the kernel.
>=20
> | $ git grep "void .*_set_ethtool_ops.*;" | wc -l
> | 46
> | $ git grep "extern const struct ethtool_ops" | wc -l
> | 43
>=20
> I did not know it was a good practice, but you are right, both schemes
> are roughly as popular (with yours slightly more popular by a small
> margin).
>=20
> > By doing so you can define
> > slcan_ethtool_ops as a static variable
> > and if possible I prefer to export functions rather than data. But it
> > can be a matter of taste.
>=20
> My taste is to export the data (to remove a function call), but as the
> maintainer, your opinion should prevail here.

I think with exporting the data instead of the function, the resulting
module will be a bit smaller. As we don't use LTO by default there's no
optimization between object files. The size of the resulting modules can
be checked with:

| ./scripts/bloat-o-meter old.o new.o

> And thanks for the explanation.
>=20
> I will also fix those two drivers:
>=20
> | $ git grep "void .*_set_ethtool_ops.*;" drivers/net/can/
> | drivers/net/can/c_can/c_can.h:void c_can_set_ethtool_ops(struct
> net_device *dev);
> | drivers/net/can/flexcan/flexcan.h:void
> flexcan_set_ethtool_ops(struct net_device *dev);

In the mcp251xfd driver there is mcp251xfd_ethtool_init(). This function
sets the ethtool_ops, but also initializes the parameters that can be
configured by ethtool (ring layout and coalescing) to default values.

Other drivers that have a dedicated function that assigns ethtool_ops
only can be optimized IMHO.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--onizkdmwx2gxacp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLg9RIACgkQrX5LkNig
011Qzgf/UXgkwgkKOoB/fVspl3tiWLCzAUCgxygYnrI96ZEZAUAccYz9xjuYpdYt
5IiNpvSXpeU1VzgA6AYv0C7q1r4bmvGvcO3zk8WdL3HgdKwwLltnVZ6wHGQQl00h
764zuiYPel9Ymmhh2Q1MrYe7mcbr07l5bhQLVWn+61BeTKHRfoPYD/FAHXG4qJg6
BXsN9Khj9t0Y3893oE1rtkaRPZFK26BCKIoyD9esCRtqnCi5ToAFvyhmU6QDaRzF
EGxBtLuCw04NqPlVFA8N1+IJYiLov0Ic1HElSdxDNr/oDsNG/K5DUEc+0A20MKZG
M2/EAnV2FOf+v5tNa0X/gwzPmWMwPA==
=Rlz7
-----END PGP SIGNATURE-----

--onizkdmwx2gxacp3--
