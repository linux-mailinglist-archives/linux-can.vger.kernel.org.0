Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0136C6880C5
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 15:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjBBOzE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 09:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjBBOyw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 09:54:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC2310273
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 06:54:24 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNayc-0005fH-Uw; Thu, 02 Feb 2023 15:54:15 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:fff9:bfd9:c514:9ad9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0826616D686;
        Thu,  2 Feb 2023 14:54:14 +0000 (UTC)
Date:   Thu, 2 Feb 2023 15:54:05 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, Jannik Hartung <jannik.hartung@tu-bs.de>
Subject: Re: [PATCH can-next] can: gw: give feedback on missing
 CGW_FLAGS_CAN_IIF_TX_OK flag
Message-ID: <20230202145405.kufeou6ykrqaqbgr@pengutronix.de>
References: <20230125055407.2053-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="crtl46eshwiykw5v"
Content-Disposition: inline
In-Reply-To: <20230125055407.2053-1-socketcan@hartkopp.net>
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


--crtl46eshwiykw5v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.01.2023 06:54:07, Oliver Hartkopp wrote:
> To send CAN traffic back to the incoming interface a special flag has to
> be set. When creating a routing job for identical interfaces without this
> flag the rule is created but has no effect.
>=20
> This patch adds an error return value in the case that the CAN interfaces
> are identical but the CGW_FLAGS_CAN_IIF_TX_OK flag was not set.
>=20
> Reported-by: Jannik Hartung <jannik.hartung@tu-bs.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--crtl46eshwiykw5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmPbzooACgkQvlAcSiqK
BOh7MAf8DOnbSjZ3h6E2buAOaaqoDK5DYkNyWuK2qmTd151YfnXCHTmm+3OIeQbr
6v0AWG8KfW+n+fbg/w2izj7azX3E21/mS7I3kNNcccQLdj5E2yLJPoxkUzjWQFsT
0MV75d7+S4svsrSSh+E80UItiGIKoESEjLZXa02KX5STXsu5SKQXgOqTF08H5BDA
hUpHqM9pIPIxk9bOCSMDTi/0bgl6q4YxXtvXPGdmaDBYK3a4wGOUiDOl5nfLxhTd
S3ZJDK3tz66IAhYjfUwYJ3aHNllWuQkQQ0JZOmaqzisZKuNfMDBIPal/ifJXnB2D
3PsfSeY7rrBB8Vn+xXnvF2ZG96YW0g==
=pR1x
-----END PGP SIGNATURE-----

--crtl46eshwiykw5v--
