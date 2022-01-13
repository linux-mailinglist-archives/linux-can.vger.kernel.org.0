Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98EB48DF69
	for <lists+linux-can@lfdr.de>; Thu, 13 Jan 2022 22:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbiAMVKX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 13 Jan 2022 16:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiAMVKX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 13 Jan 2022 16:10:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECC0C061574
        for <linux-can@vger.kernel.org>; Thu, 13 Jan 2022 13:10:22 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n87MT-0007dS-9w; Thu, 13 Jan 2022 22:10:21 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 62C1018133;
        Thu, 13 Jan 2022 21:10:19 +0000 (UTC)
Date:   Thu, 13 Jan 2022 22:10:18 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Neeli <sneeli@xilinx.com>
Cc:     Srinivas Goud <sgoud@xilinx.com>,
        Naveen Kumar Gaddipati <naveenku@xilinx.com>,
        Prasad Beer Prasad <prasadbe@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Subject: Re: Queries on CAN frame work
Message-ID: <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wv5znby7ov7f3bvj"
Content-Disposition: inline
In-Reply-To: <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--wv5znby7ov7f3bvj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.01.2022 21:30:04, Marc Kleine-Budde wrote:
> > Recently we did few experiments with our CANFD network. Stuff error
> > observed with different Nominal and Dataphase prescaler configuration
> > values, which we get from the frame work.
> >=20
> > For lower baud rates separate prescalers are working good, but when we
> > switch to high baud rates(like 4Mbps and 5Mbps) observed the BUSOFF
> > state(Due to stuff errors) on IP(Xilinx).
> >=20
> > With shared prescaler(low prescalers) we are not seeing the issue..
> >=20
> > In Iso spec also mentioned to avoid tolerance, we have to maintain
> > common TQ for Nominal and Data phase.

This is a known problem with the current arbitration and data bit rate
calculation. They are done independently of each other, resulting in not
common pre-scalers and thus not common TQ.

> > Spec: ISO 11898-1:2015(E)  page no :50
> >=20
> > " If the same time quantum length is used in the nominal bit time and
> > in the data bit time and the positions of the sample points in the
> > nominal bit time are the same in all CAN nodes of a network, then
> > optimum clock tolerance is accomplished for networks using FD frames."
> >=20
> > CIA:
> > https://can-newsletter.org/uploads/media/raw/f6a36d1461371a2f86ef0011a5=
13712c.pdf
> >=20
> > From above CAN-newsletter also suggested the same in recommendation 2 a=
nd 3.

I'll have a look at the newsletter and see what changes need to be done
to the existing algorithm.

> > Recommendation 2: Set the BRPA bit-rate prescaler equal BRPB
> > Recommendation 3: Choose BRPA and BRPD as low as possible
> >=20
> > Is there any possibility in framework to use shared prescalars for
> > Nominal and Dataphase?.

Not yet.

> > One more question. How to calculate TDCO ?, is there any generic
> > formula for this ?.

Vincent (Cc'ed) can help you on this.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wv5znby7ov7f3bvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHglTcACgkQqclaivrt
76mDEAgAk8PATw8kxRwiaSnMttpDpZvtNw0+DZv77W9c1QEMs2QS9M8GwYSEJm5X
ISGemVa60BhUhi00ayTjF/KtPw5p1nDWV5zbVMonOWoEINxtVDnanag/sFmpL5eW
6DZSPdM/+eL7gUSdhGodaveqXBPRkpONRI6iZ1xuIT1uodQNKP3OAlPflbvzLVxm
8wBIkodc9G/JkZLnoQj9GkigxvClI2a/nCAl4+DMsaKlVaaXm3Re49oF1J+ptO0i
Hzz++QXN4tSvq7LW0oHCwcLI5CeN1ucgv66QFrBDvG5Prgmombh9WBbWfm9ZHCM3
xY4L2ne9acCJSG+ggVm7iBLQq7A5Gg==
=u+eM
-----END PGP SIGNATURE-----

--wv5znby7ov7f3bvj--
