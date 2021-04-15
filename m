Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29F836044B
	for <lists+linux-can@lfdr.de>; Thu, 15 Apr 2021 10:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhDOIdV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 15 Apr 2021 04:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhDOIdU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Apr 2021 04:33:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424CAC061574
        for <linux-can@vger.kernel.org>; Thu, 15 Apr 2021 01:32:58 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lWxQm-0005sk-96; Thu, 15 Apr 2021 10:32:56 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:983:856d:54dc:ee1c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B7C6260F284;
        Thu, 15 Apr 2021 08:32:54 +0000 (UTC)
Date:   Thu, 15 Apr 2021 10:32:54 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Erik Flodin <erik@flodin.me>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: CAN_RAW_RECV_OWN_MSGS and filters
Message-ID: <20210415083254.lxm2y7xdz2s2qalo@pengutronix.de>
References: <CAAMKmofMUGrXPynSQXcvFCvB3nJXYrvosv63Aq4tcxyFok=rgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3trjvxg2lp4danh5"
Content-Disposition: inline
In-Reply-To: <CAAMKmofMUGrXPynSQXcvFCvB3nJXYrvosv63Aq4tcxyFok=rgA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--3trjvxg2lp4danh5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.04.2021 21:22:50, Erik Flodin wrote:
> I've been using a raw CAN socket with RECV_OWN_MSGS enabled to get a
> transmission confirmation when a frame has been sent. Today when I
> tried to enable filters to limit what I receive to only those frames
> that I'm interested in I noticed that the filters also affected
> reception of my own frames. So in order to receive all frames that I
> send I must also add a filter that matches all frames that I send.
>=20
> Is this the expected behavior?

At least it's implemented this way.

On TX complete of a CAN frame it's pushed into the RX path of the
networking stack, along with the information of the originating socket.

Then the CAN frame is delivered into AF_CAN, where it is passed on to
all registered receivers depending on filters. One receiver is the
sending socket in CAN_RAW. Then in CAN_RAW the it is checked if the
sending socket has RECV_OWN_MSGS enabled.

> I can see why it works the way it does, but I had expected that
> setting the RECV_OWN_MSGS flag would give me all frames sent on the
> socket. Is there a way to get my expected behavior without having to
> set a filter that matches all frames that I plan to send?

I don't think there's a way to do that without modifying the kernel
code. One option is to add a new sockopt RECV_OWN_MSGS_ALL or
RECV_OWN_MSGS_UNFILTERED. The CAN_RAW can then register another receiver
at AF_CAN for own messages only.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--3trjvxg2lp4danh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmB3+jMACgkQqclaivrt
76nAlgf/c0HZC7/2ttyTK2UmvSOBR6pZPfKAsw96tyZKu+wTsnvbSEVBuAEOVGOg
il7X1BGs5exHqAxqLCkexYO4Tqx1nzMFbG9uWSCINsC0bL7Ve+xymKEcOCIie8sF
oprsoXbuvUFB4kv7UZvuD2KEntz+pcAhnSHkXifaDSCbHHZdZ5VrhrL0ynn55EgN
tgUXdMCb/0mb6E00vuMg82yhcgL6B5dosFrI1GQu7K02sS25NLkvKWlzecq2OQph
mng/D/GGcDejvmFoBHImXlZZKmN8V72vJjm/HNK0GHOVOC+FJqW39LMGtyNMV7Cr
KBAYN5ULpijLv6BJAL0MOKDDGRC4iQ==
=w0rH
-----END PGP SIGNATURE-----

--3trjvxg2lp4danh5--
