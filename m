Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FC03ADBCE
	for <lists+linux-can@lfdr.de>; Sat, 19 Jun 2021 23:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhFSViU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 19 Jun 2021 17:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFSViT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 19 Jun 2021 17:38:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF462C061574
        for <linux-can@vger.kernel.org>; Sat, 19 Jun 2021 14:36:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1luidK-0003D3-DZ; Sat, 19 Jun 2021 23:36:06 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:8352:71b5:153f:5f88])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B87F163F7CC;
        Sat, 19 Jun 2021 21:36:05 +0000 (UTC)
Date:   Sat, 19 Jun 2021 23:36:05 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: isotp: omit unintended hrtimer restart on socket
 release
Message-ID: <20210619213605.oxgobt7fjd4ywbl5@pengutronix.de>
References: <20210618173713.2296-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bcffn6wcl7spns7l"
Content-Disposition: inline
In-Reply-To: <20210618173713.2296-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--bcffn6wcl7spns7l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.06.2021 19:37:13, Oliver Hartkopp wrote:
> When closing the isotp socket the potentially running hrtimers are
> canceled before removing the subscription for CAN idendifiers via
> can_rx_unregister().
>=20
> This may lead to an unintended (re)start of a hrtimer in isotp_rcv_cf()
> and isotp_rcv_fc() in the case that a CAN frame is received by
> isotp_rcv() while the subscription removal is processed.
>=20
> However, isotp_rcv() is called under RCU protection, so after calling
> can_rx_unregister, we may call synchronize_rcu in order to wait for any
> RCU read-side critical sections to finish. This prevents the reception
> of CAN frames after hrtimer_cancel() and therefore the unintended
> (re)start of the hrtimers.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Added to linux-can/testing

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--bcffn6wcl7spns7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDOY0IACgkQqclaivrt
76lbswf+OYndhEB+b8cCAK6vEH5Ar7M0EfK13aQUjQboFzxHiBp9UKo1fe3oHctW
pS0qjxoN+xsgU+lXhBSiVSPuQtADqyU5ZBJmef1FPl8DO6GW23xXTbCyxIW7HrUI
/cnN237EM33q4LcUYattOJWY0Sy5IbpP6d2f+n7LYWouJkyGKRhROa89WSOTgtET
bIVraHFPcnO4VLWnmcwhzOUs6cvi9bU0NKNZ7wrFeExo3QzwGxdhsz7x871Dulo6
oEIFsurwbcEXGNFVTCTNyCbWeROOF63Sapxu2gAdeqpBsEqgL9jm1twQ/E8U8w7D
i+6ids+DaNqUWyP+1hlgGJL5f8CI6w==
=HJej
-----END PGP SIGNATURE-----

--bcffn6wcl7spns7l--
