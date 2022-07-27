Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BED582549
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 13:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiG0LUE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 07:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiG0LUD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 07:20:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0368B7CE
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 04:20:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oGf55-0002Rh-4A; Wed, 27 Jul 2022 13:19:59 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AE028BC10F;
        Wed, 27 Jul 2022 11:19:57 +0000 (UTC)
Date:   Wed, 27 Jul 2022 13:19:54 +0200
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
Message-ID: <20220727111954.lkmsl2g6lwcvjdyz@pengutronix.de>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220725133208.432176-11-mailhol.vincent@wanadoo.fr>
 <CABGWkvoqkETb0H-UWhwPCk1eMwQC2ExfKUXm25Mv4R5g0kjb+Q@mail.gmail.com>
 <CAMZ6Rq+Wd412aFSiuLsjPE=aT0UQVNqp9FEZCEkjdU71hVWR0Q@mail.gmail.com>
 <CABGWkvqA5p=h7fHabH4iKoppvrypedonEnLnohgm0j+Nm-70NA@mail.gmail.com>
 <CAMZ6RqLhPHzv_zdPsE2QHOD7RgxYEu+ttWJXgjNFkE5h-8z4DQ@mail.gmail.com>
 <20220727081933.yufxemvws3haj22y@pengutronix.de>
 <CAMZ6RqKpV0_xhj=n5tE0Cm3+s00dR6LbvTWXsT3Y=r5wiFp9wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y6un6un5cuo2getx"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKpV0_xhj=n5tE0Cm3+s00dR6LbvTWXsT3Y=r5wiFp9wA@mail.gmail.com>
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


--y6un6un5cuo2getx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.07.2022 18:05:15, Vincent MAILHOL wrote:
> Yes, but this is not related to the timestamp series. So if I do it, I
> will do it separately (and I do not commit that I will do it).

That didn't age well :)

Thanks a lot,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--y6un6un5cuo2getx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLhH1gACgkQrX5LkNig
013Uywf9FtR1X7QZXBd7z0/qKwU9RfKQ6f3L8wtfmHtAwLOrMFVGcWN0lr6sigPV
rxkJRb4NqoKvRKCptY4SpWie0RyGTGdNwavjwiqTn9HPvbO7tyVxeyJxVyPSzrk4
PyIR6uqSLpsPIk8bU2YxSjB4j3yCQQ/sGALL+aY0FUIkMJzueImAGl3SuTs/1TaF
2PQxxuGnIqDnsaRIzp3Lp0mrnFw+HpItu24QI4Pi98nqFyLioA00vhRmPC/HFyVV
TonWsilFcU4HpTqUTzZeAVgd3Er6rfJztFD7TC11ebeuTv5qjYS1jWi7VhZokHNY
Wwzy/mXyqnQhlfw5dPKkXUyXAfGAIw==
=3Q36
-----END PGP SIGNATURE-----

--y6un6un5cuo2getx--
