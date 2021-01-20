Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780072FCD01
	for <lists+linux-can@lfdr.de>; Wed, 20 Jan 2021 09:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbhATIzL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Jan 2021 03:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbhATIyw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Jan 2021 03:54:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9030AC0613CF
        for <linux-can@vger.kernel.org>; Wed, 20 Jan 2021 00:54:10 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l29FY-0004Uh-A7; Wed, 20 Jan 2021 09:54:00 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:26cf:9004:ca44:570])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8296B5C8880;
        Wed, 20 Jan 2021 08:53:57 +0000 (UTC)
Date:   Wed, 20 Jan 2021 09:53:56 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Loris Fauster <loris.fauster@ttcontrol.com>,
        Alejandro Concepcion Rodriguez <alejandro@acoro.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 0/3] Fix several use after free bugs.
Message-ID: <20210120085356.m7nabbw5zhy7prpo@hardanger.blackshift.org>
References: <20210119162512.5236-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x2p5sygkylj67tiu"
Content-Disposition: inline
In-Reply-To: <20210119162512.5236-1-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--x2p5sygkylj67tiu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2021 at 01:25:09AM +0900, Vincent Mailhol wrote:
> This series fix three bugs which all have the same root cause.
>=20
> When calling netif_rx(skb) and its variants, the skb will eventually
> get consumed (or freed) and thus it is unsafe to dereference it after
> the call returns.
>=20
> This remark especially applies to any variable with aliases the skb
> memory which is the case of the can(fd)_frame.
>=20
> The pattern is as this:
>     skb =3D alloc_can_skb(dev, &cf);
>     /* Do stuff */
>     netif_rx(skb);
>     stats->rx_bytes +=3D cf->len;
>=20
> Increasing the stats should be done *before* the call to netif_rx()
> while the skb is still safe to use.
>=20
> Vincent Mailhol (3):
>   can: dev: can_restart: fix use after free bug
>   can: vxcan: vxcan_xmit: fix use after free bug
>   can: peak_usb: fix use after free bugs
>=20
>  drivers/net/can/dev/dev.c                  | 4 ++--
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 8 ++++----
>  drivers/net/can/vxcan.c                    | 6 ++++--
>  3 files changed, 10 insertions(+), 8 deletions(-)
>=20
>=20
> base-commit: 1105592cb8fdfcc96f2c9c693ff4106bac5fac7c
> prerequisite-patch-id: d9d54d9159b70a5ef179d19d5add20caffbae638

As this are fixes, this should go into net/master (and then be be backporte=
d to
the stable kernels). Please rebase to net/master.

Of course there will be a merge conflict, when net-next and net are merged,=
 due
to the moving and splitting of dev.c. You anticipated this and made noted t=
hat
as a prerequisite. (BTW: I don't find a commit for
d9d54d9159b70a5ef179d19d5add20caffbae638).

The kernel way to deal with this is to inform the upstream of the problem. A
trivial merge conflict, can be I think described in words, like: "The dev.c
file has been moved, carry the patch forward." I don't know the procedure f=
or
more complicated merges :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--x2p5sygkylj67tiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmAH76EACgkQqclaivrt
76nTMAf/UtH1gVA6b+JginvPF8SfQ8ZrOEGXt3e9mDJ8hFnM3EYrkhxIt8X7+Pz+
H2F0pUUSLt/Dy/wYKZpE71cy7WT364XgJ8cRB+8XSd7Mxp6LGTQOZ5ogqU+cYQiW
5dfyLm4v8Zhn9K9adfRkunn5Vbyk24Rvs2QzmJeSbprl957FK7r3DFKvtXhD16lO
eO6/Kz4gBNcsgEcHpq8c2nNt8NtnPA+4gf8kb0EuvO0BgzFJFz47HWI0/FPdXrwa
I81l1uqE1xagn9D+rd43ukg3/UP7wjQbxwLRECgulO1GtjLJZ1MehwjRvfnt2z2M
v03l5UTqgkcinnVBNwTqXQQjMfWqXA==
=93cq
-----END PGP SIGNATURE-----

--x2p5sygkylj67tiu--
