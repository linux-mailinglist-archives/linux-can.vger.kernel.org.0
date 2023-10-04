Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B581B7B8060
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 15:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242582AbjJDNNf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 09:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242435AbjJDNNf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 09:13:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41884A6
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 06:13:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qo1gw-0007oC-Nu; Wed, 04 Oct 2023 15:13:30 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qo1gw-00B2iZ-B8; Wed, 04 Oct 2023 15:13:30 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0F34422EF52;
        Wed,  4 Oct 2023 13:13:30 +0000 (UTC)
Date:   Wed, 4 Oct 2023 15:13:29 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 27/27] can: at91_can: switch to rx-offload implementation
Message-ID: <20231004-legend-steering-cef2e7df066f-mkl@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
 <20231004-at91_can-rx_offload-v1-27-c32bf99097db@pengutronix.de>
 <CAMZ6RqLoyCOsTuYCryr++yZw036cF2VyEbxawQSKvM-54aaHuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wqxvjk5nonbpslkx"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLoyCOsTuYCryr++yZw036cF2VyEbxawQSKvM-54aaHuA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--wqxvjk5nonbpslkx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.10.2023 21:55:41, Vincent Mailhol wrote:
> On Wed. 4 Oct. 2023 at 18:24, Marc Kleine-Budde <mkl@pengutronix.de> wrot=
e:
> > The current at91_can driver uses NAPI to handle RX'ed CAN frames, the
> > RX IRQ is disabled an a NAPI poll is scheduled. Then in at91_poll_rx()
>                      ^^
>=20
> and
>=20
> > the RX'ed CAN frames are tried to read in order from the device.
> >
> > This approach has 2 drawbacks:
> >
> > - Under high system load it might take too long from the initial RX
> >   IRQ to the NAPI poll function to run. This causes RX buffer
> >   overflows.
> > - The algorithm to read the CAN frames in order is not bullet proof
> >   and may fail under certain use cases/system loads.
> >
> > The rx-offload helper fixes these problems by reading the RX'ed CAN
> > frames in the interrupt handler and adding it a list sorted by RX
>                                                ^
>=20
> adding it *to* a list?

both fixed.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wqxvjk5nonbpslkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUdZPYACgkQvlAcSiqK
BOhXIwf+Nuq8LEIi4Xf+tnyQ5G3QFXAMsNpkEq7qBJjlz0pAxrZGL0ahRJKtmNzf
0kEhyPypNlbItytzHj6HE+m4YOa4UvCPHnHNOzGRYUvhytwqEupTkDUc/3niHvZj
W/jOGNs3x2rREiTYrNOOOQGYnecIFMjc8nTX/KU5H4dEgqeytVLCM4bW9Pfoy/S+
BkaeIasqgY4ZJbLKhcaxX2RyXFKQcV8c/QGY1vbMq/aPmOJ/Mm53zI5iX9GwarND
hIU5d4KWKN37LLc8mLeJbgP2s3BWA1rFkGOFeCDnODt9zB/izFns7OPLTGN7mK10
27SuYpyUKv8XNiYNDA0DDgb36l4h1g==
=yuSy
-----END PGP SIGNATURE-----

--wqxvjk5nonbpslkx--
