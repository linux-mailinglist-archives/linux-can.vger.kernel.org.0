Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2439A5B4740
	for <lists+linux-can@lfdr.de>; Sat, 10 Sep 2022 17:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiIJPPb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 10 Sep 2022 11:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIJPP2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 10 Sep 2022 11:15:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6667D29821
        for <linux-can@vger.kernel.org>; Sat, 10 Sep 2022 08:15:25 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oX2CW-0005Th-N0; Sat, 10 Sep 2022 17:15:20 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:5d6d:d9c1:7e9:f0f7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9E756DF736;
        Fri,  9 Sep 2022 12:29:48 +0000 (UTC)
Date:   Fri, 9 Sep 2022 14:29:47 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas.Kopp@microchip.com
Cc:     linux-can@vger.kernel.org, mark@baggywrinkle.co.uk
Subject: Re: [PATCH 5/5] can: bittiming: can_calc_bittiming(): use Phase Seg2
 / 2 as default for SJW
Message-ID: <20220909122947.sqbbpabrnft7jacs@pengutronix.de>
References: <20220907103845.3929288-1-mkl@pengutronix.de>
 <20220907103845.3929288-6-mkl@pengutronix.de>
 <BL3PR11MB64844BD45DE7FDE94BDE47BCFB419@BL3PR11MB6484.namprd11.prod.outlook.com>
 <871qsmt3mq.fsf@hardanger.blackshift.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bmrd7vwtgo5o4mnn"
Content-Disposition: inline
In-Reply-To: <871qsmt3mq.fsf@hardanger.blackshift.org>
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


--bmrd7vwtgo5o4mnn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.09.2022 21:57:16, Marc Kleine-Budde wrote:
> > Thanks for your work on this! May I ask why Phase Seg2 / 2 is chosen?

[...]

> And I tested with SJW=3Dmax from mcp251x (not the mcp251xfd) with SJW=3Dm=
ax
> to a peak USB adapter with SJW=3D1 - the peak adapter fails to receive CAN
> frames:

> With SJW =3D Phase Seg2 / 2, it works.

Correction:

My test:

    TX (mcp2515, 20 MHz OSC) -> RX (PEAK USB)

Is broken [1] if the PEAK USB uses SJW=3D=3D1, independent of the SJW of the
mcp2515 (the sender).

The test works if the PEAK USB uses SJW=3DPhaseSeg2/2.

regards,
Marc

[1] The PEAK USB fails to receive CAN frames with certain contents:
    fails: aaa#aa.00.00.55.00.55.ab.55
    works: aaa#aa.00.00.55.00.55.aa.55

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--bmrd7vwtgo5o4mnn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMbMbkACgkQrX5LkNig
010SlAf+M78SkmZXgqYFKQbHkOUuuqW0m+uWcZYUjMwV+BJezfYv4AD/NA1RGmIe
QGdjWRth6DQo8pQ+XDO6Vohg2z+rur031zUvlLQZQ5LntJFJMt5OWjCPEqkNGRuN
OnOb5pY0k7kJBNWpFX0LyWItOAJ6PJoilAj/yOv7g2Q0GYK969OPchx8GAp+O6jV
+g0/zmHRfpFQy+AZNp/PIBy4CBj4qFrVXQZuGE909iJBvUk6zad9q8a9iD/Q+Wbi
QNuKmmVWU434uGtPJjURnHK2mHqn+vm/wQJ0LZqRTTJmzxbTiiAwkUnSasLQljeZ
BSwKMUX6CyOWjO4726TnY/2E+oPF1A==
=l5LV
-----END PGP SIGNATURE-----

--bmrd7vwtgo5o4mnn--
