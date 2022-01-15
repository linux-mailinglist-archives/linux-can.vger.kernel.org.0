Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AD548F9CD
	for <lists+linux-can@lfdr.de>; Sun, 16 Jan 2022 00:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbiAOX03 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 15 Jan 2022 18:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiAOX03 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 15 Jan 2022 18:26:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A71C061574
        for <linux-can@vger.kernel.org>; Sat, 15 Jan 2022 15:26:28 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n8sRH-0002Rq-4I; Sun, 16 Jan 2022 00:26:27 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 85C74199A4;
        Sat, 15 Jan 2022 23:26:25 +0000 (UTC)
Date:   Sun, 16 Jan 2022 00:26:21 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Neeli <sneeli@xilinx.com>
Cc:     Srinivas Goud <sgoud@xilinx.com>,
        Naveen Kumar Gaddipati <naveenku@xilinx.com>,
        Prasad Beer Prasad <prasadbe@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Subject: Re: Queries on CAN frame work
Message-ID: <20220115232621.4ybmmrmgogies3o5@pengutronix.de>
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
 <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dnslfj2n4okqmye5"
Content-Disposition: inline
In-Reply-To: <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--dnslfj2n4okqmye5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.01.2022 22:10:18, Marc Kleine-Budde wrote:
> On 13.01.2022 21:30:04, Marc Kleine-Budde wrote:
> > > Recently we did few experiments with our CANFD network. Stuff error
> > > observed with different Nominal and Dataphase prescaler configuration
> > > values, which we get from the frame work.
> > >=20
> > > For lower baud rates separate prescalers are working good, but when we
> > > switch to high baud rates(like 4Mbps and 5Mbps) observed the BUSOFF
> > > state(Due to stuff errors) on IP(Xilinx).
> > >=20
> > > With shared prescaler(low prescalers) we are not seeing the
> > > issue..

Can you please provide me:
- the bit timing constants of the IP core for the arbitration and data
  phase
- the bit rate for the arbitration and data phase
  (especially where the framework calculates not common prescalers)
- the clock rate of the CAN bus clock

Can you also provide the hand calculated bit timing parameters for the
above scenarios?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--dnslfj2n4okqmye5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHjWBsACgkQqclaivrt
76kaugf/X/OPFL1MjzZirqxyNE1hrtvyCPjnrYoyxfImYA+xj5GBIWq34+NAX/Am
qzICCiuELdUcpKK9UtmxO3ypOpyrG5xvKORV7NliQRWNAIdliXGOWtudBTtLJvKN
qu2sJqZtIM18kwy7nfohlP/E6ByygOSZYXJvWCXzK5P3NwUBQrjlPwjCPaquBSsG
OS1/XOcKiH8NKbOcsybEvx+Xvxh31q9ctDRIY3Fm/t9o/kTV4lM6jtc89gooRcX1
iSXX6UnTTuvvzIddd3Enlr8IDS9aFhb4U/rS/C3dQ9MD1JByvOVhNKbCB5CrbT67
nAkwx+ZEukY8ES+i+qQs873M86QfGA==
=R3zj
-----END PGP SIGNATURE-----

--dnslfj2n4okqmye5--
