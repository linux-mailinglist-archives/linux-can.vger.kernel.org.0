Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40C652CCFE
	for <lists+linux-can@lfdr.de>; Thu, 19 May 2022 09:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiESH3J (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 May 2022 03:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiESH24 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 May 2022 03:28:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCA78AE5F
        for <linux-can@vger.kernel.org>; Thu, 19 May 2022 00:28:53 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nraaa-0006dc-6D; Thu, 19 May 2022 09:28:52 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3B05081CFC;
        Thu, 19 May 2022 07:03:13 +0000 (UTC)
Date:   Thu, 19 May 2022 09:03:11 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH can-next] can: can-dev: remove obsolete CAN LED support
Message-ID: <20220519070311.3im3ptomr7x5iobi@pengutronix.de>
References: <20220518154527.29046-1-socketcan@hartkopp.net>
 <20220518202134.77ir3bohv2tl6vi6@pengutronix.de>
 <4113f480-ab6a-3c1e-ff20-8778468e15c5@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="723dqu5yzomrln2n"
Content-Disposition: inline
In-Reply-To: <4113f480-ab6a-3c1e-ff20-8778468e15c5@hartkopp.net>
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


--723dqu5yzomrln2n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.05.2022 08:18:30, Oliver Hartkopp wrote:
> Hi Marc,
>=20
> found a typo while reading your answer ...
>=20
> On 18.05.22 22:21, Marc Kleine-Budde wrote:
> > On 18.05.2022 17:45:27, Oliver Hartkopp wrote:
> > > Since commit 30f3b42147ba6f ("can: mark led trigger as broken") the
> > > CAN specific LED support was disabled and marked as BROKEN. As the co=
mmon
> > > LED support with CONFIG_LEDS_TRIGGER_NETDEV should to this work now t=
he
>                                                       ^^
>=20
> to -> do

fixed

> m(
>=20
> Btw. did you see this patch for can-next?
>=20
> https://lore.kernel.org/linux-can/20220517145653.2556-1-socketcan@hartkop=
p.net/T/#u
>=20
> That was very short after the patch from Jakub so you probably missed
> it.

Indeed. Added to linux-can-next/testing.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--723dqu5yzomrln2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKF660ACgkQrX5LkNig
012syAgAjlpds4nX8cqbdnLMwX7WLvqixNZSwUIYdLG/cGJjhToxhwK6cOFtecft
nnlSCzf6YEOGX0hlpgDUvKPV+a8TVUTm/S2iMZk3H6Rwt9bnp9igYcA6oiohTVbu
A1g/qHKpEp2l9XDf0u0ngA4/h/j8aPtTXS96UkihOYZy6I7X0unZ69kDzzJ1tae8
oAI3xjpeuCnzb6tmZi07Zew8Fwf7ikIZXh4UwCDUzvF8GUFqfL5hVrWCS3uHkXxU
TXdhvNyb/ngNG0EpjSdgLkrrCPx1LT77ydn9mXGNu4x9zzBIXlsdRaPwzkS+wzAs
9DvKIvqRgBYCyli8m/HL+GSfDses7g==
=rEj0
-----END PGP SIGNATURE-----

--723dqu5yzomrln2n--
