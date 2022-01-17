Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE1F49074A
	for <lists+linux-can@lfdr.de>; Mon, 17 Jan 2022 12:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiAQLsy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jan 2022 06:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiAQLsy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jan 2022 06:48:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5436C061574
        for <linux-can@vger.kernel.org>; Mon, 17 Jan 2022 03:48:53 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n9QVI-0000co-3l; Mon, 17 Jan 2022 12:48:52 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id F25121A7F4;
        Mon, 17 Jan 2022 11:48:50 +0000 (UTC)
Date:   Mon, 17 Jan 2022 12:48:47 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Srinivas Neeli <sneeli@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        Naveen Kumar Gaddipati <naveenku@xilinx.com>,
        Prasad Beer Prasad <prasadbe@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: Queries on CAN frame work
Message-ID: <20220117114847.pqxbvsxiwr4uelu4@pengutronix.de>
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
 <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
 <CAMZ6RqJTO8X+YZBb5g0WjObeB=oR1QzguazahsBhJOTz5+1MoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lywzx5ju277n4u2l"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJTO8X+YZBb5g0WjObeB=oR1QzguazahsBhJOTz5+1MoQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--lywzx5ju277n4u2l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.01.2022 19:16:02, Vincent MAILHOL wrote:
> By the way, Marc, did you get an answer from Microchip on the relative
> TDCO topic for the mcp25xxfd?
> c.f. https://lore.kernel.org/all/20210817094306.iyezzml6m7nlznri@pengutro=
nix.de/

IIRC the datasheet you found:

| http://ww1.microchip.com/downloads/en/DeviceDoc/Section_56_Controller_Are=
a_Network_with_Flexible_Data_rate_DS60001549A.pdf

is correct:

| 10 =3D Auto; measure delay and add CFDxDBTCFG.TSEG1; add TDCO

But back when I asked by contact was on holidays, and currently he's on
holidays, too. I'll refresh my mind next month, when he's back.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--lywzx5ju277n4u2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHlV5wACgkQqclaivrt
76livggAomUvcevn0lF6BZfLHuHffYvQQspv7Pq7T6Qxb+X+jc8XMcTC9K9s5CxA
v2CQz8+Vy6MHP3NB83qTfZCJFugQdCdPhEP9ViAFrfm6Xo3RsKZQwfXqvjJnwQI0
osHZYF14qAo3ed0OEXpA+O9ime/JioKN06ell4ulINjw+iYvKw/st6NXReVZcEqZ
Dblg5t83bU9HLCBBh4PnGlSCbhqcCkZlcB2G7798YZ14MavVF6mndmDH4xGGjkvv
vxFAWFEPUL+vZSI/5welC9z2Bev14QDywTtOvWOiRtHHhlAj7XctLC3jAuz5cV80
yRu67X8B7tFfYwiWITqDpM7BLLtW2A==
=ipv7
-----END PGP SIGNATURE-----

--lywzx5ju277n4u2l--
