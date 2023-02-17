Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7042169AF92
	for <lists+linux-can@lfdr.de>; Fri, 17 Feb 2023 16:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBQPcn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 17 Feb 2023 10:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjBQPck (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Feb 2023 10:32:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FB070973
        for <linux-can@vger.kernel.org>; Fri, 17 Feb 2023 07:32:39 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pT2iy-0000kx-Eq; Fri, 17 Feb 2023 16:32:36 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:f841:9dc3:753d:4a94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 09F5E17C2FF;
        Fri, 17 Feb 2023 15:32:35 +0000 (UTC)
Date:   Fri, 17 Feb 2023 16:32:33 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can <linux-can@vger.kernel.org>
Cc:     Peter Fink <pfink@christ-es.de>,
        Ben Evans <benny.j.evans92@gmail.com>,
        Christoph =?utf-8?Q?M=C3=B6hring?= <cmoehring@christ-es.de>,
        Alexander Schartner <aschartner@christ-es.de>,
        Eric Evenchick <eric@evenchick.com>,
        Venelin Efremov <ghent360@iqury.us>
Subject: candlelight CAN-FD TX echo
Message-ID: <20230217153233.m2k4qcecux2up22k@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7qfk7sjrkrpd6wx3"
Content-Disposition: inline
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


--7qfk7sjrkrpd6wx3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm currently addinf CAN-FD support to the Candlelight firmware and
looking at the TX echo message from the CAN device to Linux. In your
firmware for CAN-FD frames, are you echoing the whole CAN FD structure
gs_host_frame with 64 byte data, or the classic CAN gs_host_frame with 8
byte data?

The Candlelight I use only works in full-speed USB (12 Mbit/s) max,
which means that the maximum transmission size is 64, which results in a
TX echo consisting of 2 USB transmissions. The Linux driver makes no use
of the data in the TX echo frame, so a classic CAN TX echo would
suffice.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--7qfk7sjrkrpd6wx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmPvng0ACgkQvlAcSiqK
BOh4owf/YvkeObVNpEz4Sv6xUovheV/4NAgMxdCfbZ6gxL6wbilm6GkvJHL9zR3i
KsMCvoFvPJRRrqmdGqz/QzGfn38mhRY3vEX/OvSi5j7fiHkE7kAe3Gfv6fAHkG9O
TLUX89AFpSB1RtW0Lz0P1co9o7sa2ctnjW4CmupxiRl0eDpHPS68ZZGYexC9+TZX
Wld2Ffyf8Sg7j+mUkath5uwSmr22JUyooHKDOLnydKXTQvSVgWLhLNQDAW/WMlGv
IKckpr0C6Nb/NeMnxWD8C7U+ePYAHmO38F4nQlRcDmmVB/6sesJOnt5AejHjAWpD
t5hRMmUIRoXCMRNtRoPPFJPS0MyMgw==
=WxDj
-----END PGP SIGNATURE-----

--7qfk7sjrkrpd6wx3--
