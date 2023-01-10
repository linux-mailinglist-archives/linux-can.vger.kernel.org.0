Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F706643B6
	for <lists+linux-can@lfdr.de>; Tue, 10 Jan 2023 15:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbjAJOxk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Jan 2023 09:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238758AbjAJOxf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2023 09:53:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE6765AA
        for <linux-can@vger.kernel.org>; Tue, 10 Jan 2023 06:53:34 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pFG0J-0006c5-UD; Tue, 10 Jan 2023 15:53:31 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7a66:5fec:540b:6f91])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B41B715366B;
        Tue, 10 Jan 2023 14:53:30 +0000 (UTC)
Date:   Tue, 10 Jan 2023 15:53:22 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas.Kopp@microchip.com
Cc:     Stefan.Althoefer@janztec.com, linux-can@vger.kernel.org
Subject: Re: RE: AW: AW: mcp251xfd: Bad message receiption (1/2)
Message-ID: <20230110145322.4bqwlw3owesc5myj@pengutronix.de>
References: <PH7PR11MB6498DA4A162106BD4ACB7551FBE89@PH7PR11MB6498.namprd11.prod.outlook.com>
 <FR0P281MB1966CA0C12ED24574368A36E97E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20221222130219.xrfnm54g6lfjozvs@pengutronix.de>
 <FR0P281MB19666A63278AAA9D20B6989297E99@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20221224155705.l6qx3xu34nmo3ehn@pengutronix.de>
 <FR0P281MB196615471DB16E566528E7F097F09@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966783A50BDAD455BBC7F1A97F69@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966543302DB6485C49F8A2E97F59@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966801F8A7BCC540D40A4DE97FE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB64849F53D129B61D79952538FBFF9@BL3PR11MB6484.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gmi3kq4ivbyc3jww"
Content-Disposition: inline
In-Reply-To: <BL3PR11MB64849F53D129B61D79952538FBFF9@BL3PR11MB6484.namprd11.prod.outlook.com>
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


--gmi3kq4ivbyc3jww
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.01.2023 12:50:18, Thomas.Kopp@microchip.com wrote:
> > For the last case, I attached debugger after the fail an tried to read =
=66rom the
> > socket until read returned -1:
> >     (gdb) p malloc(72)
> >     (gdb) p read(sockfd,$1,72)
> >     (gdb) print fprint_canframe_mtu(stdout, $1, "\n", 4, 72) And surpri=
se
> > surprise, there were more CAN frames in store. Refer to the log/pdf.
>=20
> I was finally able to reproduce the issue and capture a full SPI/CAN
> log when it happens. At this point it looks like the tail pointer of
> the FIFO in the MCP2518FD gets corrupted and the driver does what it's
> supposed to do and reads out lots of frames...

You mean the head pointer?

> So yeah, I see all the
> frames being read via SPI multiple times which matches what you found
> with your gdb approach.

> It's interesting to see that this wasn't noticed before - I have
> reproduced this issue also with cangen (when manually comparing TX/RX
> counters)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--gmi3kq4ivbyc3jww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmO9e98ACgkQrX5LkNig
011NlwgAj5A+gT2NJwWmpnnYAaEKv0C425e0eVCRY1aoyeGyv56gtA/1f0RQm/6s
xjB9HlTNvax3vaYBLfotXPTHxQaxsn5JG7d3smz/bExb09nEe3Omv6pD5Eg7q2u3
ZL30OBMy+jo/vHZL6i1uoU2lTvtdnWeiGzV72nQp/lAC7HoPbVHVB7T3T2hvM9TP
7QLCMmtAnDawr7Ud51UjtW1vfUnLAe8Bzy6R8MCq49job5iyef7EujGWmA7lRxs0
J1qI5l94m/gvnPs8irrhSq/aaMosyqNJnFcuMtXsIrW0niiAu1JZDMujiGwlxZBl
8+TbKJby3hzU3UQzpLvEBMUK87AIZw==
=V9/l
-----END PGP SIGNATURE-----

--gmi3kq4ivbyc3jww--
