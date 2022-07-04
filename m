Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C390565661
	for <lists+linux-can@lfdr.de>; Mon,  4 Jul 2022 15:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiGDNDA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 4 Jul 2022 09:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiGDNDA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Jul 2022 09:03:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5738B48D
        for <linux-can@vger.kernel.org>; Mon,  4 Jul 2022 06:02:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o8Lj3-0003cv-TQ; Mon, 04 Jul 2022 15:02:53 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-9ec8-2378-47c2-fbd7.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:9ec8:2378:47c2:fbd7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1F522A7C32;
        Mon,  4 Jul 2022 13:02:50 +0000 (UTC)
Date:   Mon, 4 Jul 2022 15:02:49 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Rhett Aultman <rhett.aultman@samsara.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Message-ID: <20220704130249.lqpqstjxaz2773zp@pengutronix.de>
References: <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com>
 <48caa879b0064ced97623bf1dad5b2d9@AcuMS.aculab.com>
 <YrLjsAOlsizMc/1c@kroah.com>
 <CAMZ6Rq+e+i0xGuWeMaGyTVyLJy=q2vQZqXjYoACws=T_B-FOGQ@mail.gmail.com>
 <YrMJ0vXR84cISTse@kroah.com>
 <CAMZ6RqJZKYOTtLpiM3ie3fNOBm8i7d8yr8n7S=yAm6twbuhGrQ@mail.gmail.com>
 <99ac782c-46e7-bbef-8f54-cf2fd67acdc@samsara.com>
 <CAMZ6Rq+FSzy5ijQZhYyVJrbe86U9faD5aPFO4cezNkN9G-USzQ@mail.gmail.com>
 <337d5316-82bb-e048-2014-b0634fadf8@samsara.com>
 <CAMZ6Rq+hPC4N=_jGioUyaG0ezTE2qM8gDZic3ETESm0P=vkU9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jkjjt4hmlx262sp7"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+hPC4N=_jGioUyaG0ezTE2qM8gDZic3ETESm0P=vkU9Q@mail.gmail.com>
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


--jkjjt4hmlx262sp7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.06.2022 10:09:16, Vincent MAILHOL wrote:
> > In light of this, while I remain committed to helping work the problem,=
 I
> > can't help but wonder if it's worth it to consider my original patch in=
 a
> > new light?
>=20
> Yes, it makes sense to take your initial patch.

done

> I will reiterate that
> I do not like the way it is done but you are fixing a memory leak and
> delaying the fix furthermore is not good.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jkjjt4hmlx262sp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLC5PcACgkQrX5LkNig
013W9QgAlfSRaOmA79WC6UVkJXGjFYphYU5hqKwM5S0jZfIPOBFbC5c6mQp0v+MN
78Ec1FquR3l5nlvJd++iQyTXQjLuOpVEBBBpvCwiGK95BMy6W7KvqUearDTCbORi
whrgyOh+atiJXD1ELPawQGvFQM8Rd8NM8CqS5rTdwlBNOrmMZ/DuJ8T1L6k2E562
YY6GL/T0zEJjE1X9BleeptoddFwdNsW2LnUM3LEJhLkm42cfVEvOsHn2WLqBlLwq
vV1sfLvQUW6s5BRWrW2eZHGP8vfRm03MzAZS9F8635V5NOz0HE9jax/nRq9Pl3h1
Uk1yP7AgXHvgvCPfHVf/c2dUu2I3Kw==
=aXbT
-----END PGP SIGNATURE-----

--jkjjt4hmlx262sp7--
