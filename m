Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813FD55B161
	for <lists+linux-can@lfdr.de>; Sun, 26 Jun 2022 13:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiFZK5z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Jun 2022 06:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiFZK5x (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Jun 2022 06:57:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231C4E00E
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 03:57:53 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o5Pxf-0002KR-BU; Sun, 26 Jun 2022 12:57:51 +0200
Received: from pengutronix.de (p200300ea0f229100c1f120485ffcf4df.dip0.t-ipconnect.de [IPv6:2003:ea:f22:9100:c1f1:2048:5ffc:f4df])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E9B909F860;
        Sun, 26 Jun 2022 10:57:49 +0000 (UTC)
Date:   Sun, 26 Jun 2022 12:57:49 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org,
        Rhett Aultman <rhett.aultman@samsara.com>
Subject: Re: [RFC PATCH] can-roundtrip-stats: a tool to benchmark
 transmission time
Message-ID: <20220626105749.hlnvv57yfwbjrto6@pengutronix.de>
References: <20220626075317.746535-1-mailhol.vincent@wanadoo.fr>
 <20220626090744.pycu3katdt6vir2l@pengutronix.de>
 <CAMZ6RqLVKMznm_n4j079rcYLjhj8QjmeM3=bYUeXm_rozmQNVg@mail.gmail.com>
 <7640a651-80c8-cfe8-c6bd-0b0d60ee3c2a@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tufthpnccxhcbnmq"
Content-Disposition: inline
In-Reply-To: <7640a651-80c8-cfe8-c6bd-0b0d60ee3c2a@hartkopp.net>
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


--tufthpnccxhcbnmq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.06.2022 12:31:59, Oliver Hartkopp wrote:
> > What I was thinking is that tools such as tcpdump are able to get TX
> > packets of ethernet interfaces even if not normally visible (because
> > contrary to CAN, there is no default loopback). I was wondering if the
> > same could be done with error queues, but as you can guess my research
> > did lead anywhere. I also guess there is no official support but then,
> > I am wondering how hard it would be to hack the error queues to expose
> > them to the privileged processes.
>=20
> I wonder whether error queues are the right mechanism or if control messa=
ges
> needed to be extended here - like for (hardware) rx timestamps.

I think error queues are the official way for TX timestamps. Nonetheless
tcpdump support for TX timestamps would be interesting.=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--tufthpnccxhcbnmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmK4O6kACgkQrX5LkNig
013Qggf/bP91j9M/+SnyB/zRbSM9jJ/Pss7SOLekjtjOXzXrXGBFRmrwd+0Dj9tH
d6/Uy4t3IvQ1os+GF6Fbbol+f8TMalC1vB3VU5vbORH/tRzEx158QUGGCNaomu6W
hc5C4vwxiTHFJ5zRo1/Abn4vY2P6oK0vIS3UbJfX15vdJmMcd2PfyUWhIu+uo30n
gRsoizkYiJq8fcBBUa0TD3TU4GtKzPJDx3ELjrAdX7fei9TViRE1FAE3vsEs+cxu
FANuHzMdzvAVAMVuJkdv+s770t5KmyA6UquCU3sdXpcshTFomIfJ88fKE6QQzYNH
oHr0SryzcVQkzQtOpcnXmQmBgXxY1Q==
=Nw8I
-----END PGP SIGNATURE-----

--tufthpnccxhcbnmq--
