Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DAE3E40C7
	for <lists+linux-can@lfdr.de>; Mon,  9 Aug 2021 09:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhHIHYj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Aug 2021 03:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhHIHYj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Aug 2021 03:24:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D92C0613CF
        for <linux-can@vger.kernel.org>; Mon,  9 Aug 2021 00:24:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mCzdx-0001FG-P9; Mon, 09 Aug 2021 09:24:17 +0200
Received: from pengutronix.de (unknown [IPv6:2a02:810a:8940:aa0:565a:9e00:3ca4:4826])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 049EF66309F;
        Mon,  9 Aug 2021 07:24:15 +0000 (UTC)
Date:   Mon, 9 Aug 2021 09:24:14 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?TcOkdGpl?= <Stefan.Maetje@esd.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH] mailmap: update email address of Matthias Fuchs
Message-ID: <20210809072414.syapcl2v7urytygg@pengutronix.de>
References: <20210806104833.102081-1-mkl@pengutronix.de>
 <10024d316c23d7be2ce6037f7994aa2af033208f.camel@esd.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="risgigwcdpvsdsfu"
Content-Disposition: inline
In-Reply-To: <10024d316c23d7be2ce6037f7994aa2af033208f.camel@esd.eu>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--risgigwcdpvsdsfu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.08.2021 15:07:43, Stefan M=C3=A4tje wrote:
> I was not aware of the .mailmap file and its workings.=20

The mailmap file works on the git log, and thus tools using it: e.g.
scripts/get_maintainer.pl.

> My question is should then also <thomas.koerper@esd.eu> be put in this
> file

Probably yes, as there are two patches by him in the Linux kernel:

| Thomas K=C3=B6rper (2):
|       can: dev: avoid calling kfree_skb() from interrupt context
|       can: esd_usb2: Fix sparse warnings

I'll update this patch.

> because he is the co-author of the patch you're reviewing atm.

For co-authorship, use the Co-developed-by tag, that was recently added:

https://elixir.bootlin.com/linux/v5.12/source/Documentation/process/submitt=
ing-patches.rst#L449

Speaking of that patch. Can you please create an entry in the
MAINTAINERS file, too? I suggest to add yourself as M: and the
socketcan@e.u as R:. The change in the MAINTAINERS file will be a second
patch in that series. Just include it the next iteration of that series.

> and his email address shows up in MODULE_AUTHOR() macro. He also left
> our company already.

In newly added changes, it makes sense that all email addresses are
working. :D

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--risgigwcdpvsdsfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmEQ2BsACgkQqclaivrt
76lOqwgAr1IYSf0dfTCapqSbuZ1GmzEx7tywKkkZFHcm7YGuOyEq7k0xoD8rXXdl
8Z/aYTe+XVdhv8tHJD0vpk7kYjn31ac18RBEKgmyHhwoA8ucCc3FZrOWuGxOXxBM
U4IbWzOpZQe9YUraeiznYS+SxvMyKS5jxaqBjKC9qen/5UU9DdzOISbiXFhHr2Cn
n1ejuJwSt0nCKQjKEuHTl1TwWocn8VsjkdQAJIO0J4XAaKQT6tzElvvUQp+/YX4X
wj/uoa/LzXbyA3CHuFiMAc+RLd5Lj+x+NyRVnVomf6Z03j5tBkWMuvcDrqwOebPe
swed81X6voXLlQHZ4j+MMENh7UsTXQ==
=tAUi
-----END PGP SIGNATURE-----

--risgigwcdpvsdsfu--
