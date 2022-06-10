Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62533546496
	for <lists+linux-can@lfdr.de>; Fri, 10 Jun 2022 12:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348835AbiFJKuc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 Jun 2022 06:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348856AbiFJKuF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Jun 2022 06:50:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325E22F2972
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2022 03:46:39 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nzc9y-0007z0-AF; Fri, 10 Jun 2022 12:46:34 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BEE9190FEB;
        Fri, 10 Jun 2022 10:46:28 +0000 (UTC)
Date:   Fri, 10 Jun 2022 12:46:28 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Rhett Aultman <rhett.aultman@samsara.com>,
        linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.org>,
        Alan Stern <stern@roland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/3] drivers: usb/core/urb: Add URB_FREE_COHERENT
Message-ID: <20220610104628.t35pzsosgh7yjevf@pengutronix.de>
References: <alpine.DEB.2.22.394.2206031547001.1630869@thelappy>
 <20220609204714.2715188-1-rhett.aultman@samsara.com>
 <20220609204714.2715188-2-rhett.aultman@samsara.com>
 <CAMZ6Rq+rEoOmy5PQ=oiaohcc=H5GFbZMfECACwe_qjEQXwuxuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ogqhqzug3e5znu2r"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+rEoOmy5PQ=oiaohcc=H5GFbZMfECACwe_qjEQXwuxuQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ogqhqzug3e5znu2r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.06.2022 09:18:51, Vincent MAILHOL wrote:
> On Fri. 10 juin 2022 =C3=A0 06:11, Rhett Aultman <rhett.aultman@samsara.c=
om> wrote:
>=20
> The From tag goes at the beginning of the patch.
>=20
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>=20
> > When allocating URB memory with kmalloc(), drivers can simply set the
> > URB_FREE_BUFFER flag in urb::transfer_flags and that way, the memory
> > will be freed in the background when killing the URB (for example with
> > usb_kill_anchored_urbs()).
> >
> > However, there are no equivalent mechanism when allocating DMA memory
> > (with usb_alloc_coherent()).
> >
> > This patch adds a new flag: URB_FREE_COHERENT. Setting this flag will
> > cause the kernel to automatically call usb_free_coherent() on the
> > transfer buffer when the URB is killed, similarly to how
> > URB_FREE_BUFFER triggers a call to kfree().
> >
> > In order to have all the flags in numerical order, URB_DIR_IN is
> > renumbered from 0x0200 to 0x0400 so that URB_FREE_COHERENT can reuse
> > value 0x0200.
> >
> > From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>=20
> Move the From tag from here to the first line.

Usually git send-email places the "From:" automatically at the beginning.

> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Rhett, please add your S-o-b here, too, as the patch went though your
hands.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ogqhqzug3e5znu2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKjIQEACgkQrX5LkNig
010tkQf+L/bCdKOkfzwKI0nckgM7Z2g3BKS9YOe0wFs2gYJnmkYUIH2b2/QtGSci
933t2bhOXV+yKmolzrsbKZ4YNo5nq0W8QDjSI1uZepH0du1AO56urogVC1sxC+kw
nUy3MwUHDZxJtsALFgYtNlhuPG7YqJFMXJJ6JK6Kd826DldsT7Hgh2+X7RQi6pea
l3l5Gp/msi5p7oowp9+zmO8nqlvpitbCAN2DvYeEzWVvL0S2vmzhA4qTBnlwIKvC
13DIOhoMp/Hmvh+N/YtrFCiI9KAVsXV2LXPkuS+CsjfzlYISEoXK0kSTfC/Awgub
bGJYZPPMGqWlkrOCGAPP+y/XMaRFfw==
=KxgR
-----END PGP SIGNATURE-----

--ogqhqzug3e5znu2r--
