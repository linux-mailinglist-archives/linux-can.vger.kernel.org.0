Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924643729FB
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 14:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhEDMVP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 08:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhEDMVP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 08:21:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89EDC061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 05:20:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ldu2F-0003Ta-63; Tue, 04 May 2021 14:20:19 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4880:7cee:6dec:c8f9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2274961BC2D;
        Tue,  4 May 2021 12:20:18 +0000 (UTC)
Date:   Tue, 4 May 2021 14:20:17 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [REPOST PATCH 0/4] can: m_can: various regmask-related cleanup
Message-ID: <20210504122017.suk5coyk6nmc54y7@pengutronix.de>
References: <20210504114900.351170-1-torin@maxiluxsystems.com>
 <20210504115433.nz3q4fbr62hecnmj@pengutronix.de>
 <20210504115847.b3t6zbgxxd5gntct@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kwcrxxzckbfupczv"
Content-Disposition: inline
In-Reply-To: <20210504115847.b3t6zbgxxd5gntct@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--kwcrxxzckbfupczv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.05.2021 12:58:47, Torin Cooper-Bennun wrote:
> On Tue, May 04, 2021 at 01:54:33PM +0200, Marc Kleine-Budde wrote:
> > What's the base commit for this series?
> >=20
> > regards,
> > Marc
> >=20
> > --=20
> > Pengutronix e.K.                 | Marc Kleine-Budde           |
> > Embedded Linux                   | https://www.pengutronix.de  |
> > Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> > Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
>=20
> Effective base is:
>=20
> 644022b1de9e - can: m_can: m_can_receive_skb(): add missing error handlin=
g to can_rx_offload_queue_sorted() call
>=20
> (This series rebases onto can-next/testing without conflicts)

Hmmm...not here:

| =E2=9E=9C (pts/13) frogger@hardanger:socketcan/linux (next=E2=9C=97) git =
lg -1                                                                      =
 =20
| 644022b1de9e (HEAD -> next) can: m_can: m_can_receive_skb(): add missing =
error handling to can_rx_offload_queue_sorted() call
|=20
| =E2=9E=9C (pts/13) frogger@hardanger:socketcan/linux (next) git am -s --r=
eject ./20210504_torin_can_m_can_various_regmask_related_cleanup.mbx
| Applying: can: m_can: use bits.h macros for all regmasks
| Checking patch drivers/net/can/m_can/m_can.c...
| error: while searching for:
|=20
|                 net->stats.tx_errors++;
|                 if (cdev->version > 30)
|                         putidx =3D ((m_can_read(cdev, M_CAN_TXFQS) &
|                                    TXFQS_TFQPI_MASK) >> TXFQS_TFQPI_SHIFT=
);
|=20
|                 can_free_echo_skb(cdev->net, putidx);
|                 cdev->tx_skb =3D NULL;
|=20
| error: patch failed: drivers/net/can/m_can/m_can.c:449
| Applying patch drivers/net/can/m_can/m_can.c with 1 reject...
| Hunk #1 applied cleanly.
| Hunk #2 applied cleanly.
| Hunk #3 applied cleanly.
| Hunk #4 applied cleanly.
| Hunk #5 applied cleanly.
| Hunk #6 applied cleanly.
| Hunk #7 applied cleanly.
| Rejected hunk #8.
| Hunk #9 applied cleanly.
| Hunk #10 applied cleanly.
| Hunk #11 applied cleanly.
| Hunk #12 applied cleanly.
| Hunk #13 applied cleanly.
| Hunk #14 applied cleanly.
| Hunk #15 applied cleanly.
| Hunk #16 applied cleanly.
| Hunk #17 applied cleanly.
| Hunk #18 applied cleanly.
| Hunk #19 applied cleanly.
| Hunk #20 applied cleanly.
| Hunk #21 applied cleanly.
| Hunk #22 applied cleanly.
| Patch failed at 0001 can: m_can: use bits.h macros for all regmasks
| hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
| When you have resolved this problem, run "git am --continue".
| If you prefer to skip this patch, run "git am --skip" instead.
| To restore the original branch and stop patching, run "git am --abort".
|=20
| =E2=9E=9C (pts/13) frogger@hardanger:socketcan/linux (next=E2=9C=97) cat =
drivers/net/can/m_can/m_can.c.rej
| diff a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c    (=
rejected hunks)
| @@ -449,8 +419,8 @@ static void m_can_clean(struct net_device *net)
| =20
|                 net->stats.tx_errors++;
|                 if (cdev->version > 30)
| -                       putidx =3D ((m_can_read(cdev, M_CAN_TXFQS) &
| -                                  TXFQS_TFQPI_MASK) >> TXFQS_TFQPI_SHIFT=
);
| +                       putidx =3D FIELD_GET(TXFQS_TFQPI_MASK,
| +                                          m_can_read(cdev, M_CAN_TXFQS));
| =20
|                 can_free_echo_skb(cdev->net, putidx);
|                 cdev->tx_skb =3D NULL;

regards
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--kwcrxxzckbfupczv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCRO/4ACgkQqclaivrt
76miXAf7B2InW17d+El+/rc4NXmbGWvPwWR7c1jqexwojr8xJPLYxOusQBet86Ab
0eLMnXHZJFLeacYPJnNR/HAwRe0vxgsXsU33XbjuQAoemWQOhGidxfGOn3s3NkWU
u+142kr5Aws8+PkN0ye4+cYujEG5BdUbHEFelzA5US0tk0Kc+53aQMsTZbiIvS1i
+H3rJDYSXYAAJFr6bUDTbvI+f6IopvS19h028bZH+DRUK+LNYLYodeJKJeThn9K9
TpUkYQsAZvqEP7KQNy7juGLGqLID2mYq49IeTzJYpwHW0v0d/pmGDoh6W78UAkDh
Oz4dpnahvnAgqxA8HOdK5jNv6/IyKg==
=m1t2
-----END PGP SIGNATURE-----

--kwcrxxzckbfupczv--
