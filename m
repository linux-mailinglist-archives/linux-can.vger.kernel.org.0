Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD583512C1A
	for <lists+linux-can@lfdr.de>; Thu, 28 Apr 2022 08:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244662AbiD1HBO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 28 Apr 2022 03:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbiD1HBL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Apr 2022 03:01:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7CF986C7
        for <linux-can@vger.kernel.org>; Wed, 27 Apr 2022 23:57:58 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1njy68-0004WM-RX; Thu, 28 Apr 2022 08:57:56 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-6c64-eec7-9c08-9d9e.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:6c64:eec7:9c08:9d9e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BF4B46F6AE;
        Thu, 28 Apr 2022 06:54:41 +0000 (UTC)
Date:   Thu, 28 Apr 2022 08:54:41 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: isotp: remove re-binding of bound socket
Message-ID: <20220428065441.r4vmbpr5gs3efv2e@pengutronix.de>
References: <20220422082337.1676-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oshw7ycocop6aela"
Content-Disposition: inline
In-Reply-To: <20220422082337.1676-1-socketcan@hartkopp.net>
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


--oshw7ycocop6aela
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Oliver,

On 22.04.2022 10:23:37, Oliver Hartkopp wrote:
> As a carry over from the CAN_RAW socket (which allows to change the CAN
> interface while mantaining the filter setup) the re-binding of the
> CAN_ISOTP socket needs to take care about CAN ID address information and
> subscriptions. It turned out that this feature is so limited (e.g. the
> sockopts remain fix) that it finally has never been needed/used.
>=20
> In opposite to the stateless CAN_RAW socket the switching of the CAN ID
> subscriptions might additionally lead to an interrupted ongoing PDU
> reception. So better remove this unneeded complexity.
>=20
> Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Which branch should I apply the patch to?

[ ] can
[ ] can+stable
[ ] can-next

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--oshw7ycocop6aela
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJqOi4ACgkQrX5LkNig
012A6wf/YJG45nh2z/XuoohytX0fP2OE1d7etulhkykU8roQHpBRMwp1KlmWL7RR
VzhhTWaoqDrNldRzqoanlMqoVg4iJRlA2fE+28koKHE4Xsx3dsK6rGYxVsLxqveo
2KlgQlFxLIH1FWshhBSvBFe2QIg3GC3YqIeFBzAmMEnvnXCwaxY8lHoTPQkxc17N
JfisrP5izDeTFtf6265m4CIb9vOrPMNfa3L2qJB560MTLk8LnwIxCJ27luehkpU9
lq7cGNDBvZSEfkK925q0Et0D5as6wMD4Pq4/gT41Lxbq9h8ZQfI//tHP9CZlpZxN
G75J7Up6OdN/LQ/kBJDhuyy9D/HnNA==
=eLpf
-----END PGP SIGNATURE-----

--oshw7ycocop6aela--
