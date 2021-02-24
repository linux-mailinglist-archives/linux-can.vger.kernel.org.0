Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915193237F3
	for <lists+linux-can@lfdr.de>; Wed, 24 Feb 2021 08:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhBXHc2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 24 Feb 2021 02:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbhBXHcY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Feb 2021 02:32:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D478C06174A
        for <linux-can@vger.kernel.org>; Tue, 23 Feb 2021 23:31:44 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lEoe6-0007x9-HG; Wed, 24 Feb 2021 08:31:42 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:280d:dce7:6e3c:8a49])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 241765E81C5;
        Wed, 24 Feb 2021 07:31:41 +0000 (UTC)
Date:   Wed, 24 Feb 2021 08:31:40 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 1/5] can: add new CAN FD bittiming parameters:
 Transmitter Delay Compensation (TDC)
Message-ID: <20210224073140.vinoopn5zoxvyuq3@pengutronix.de>
References: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
 <20210224002008.4158-2-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kjuwgecv2wim3sni"
Content-Disposition: inline
In-Reply-To: <20210224002008.4158-2-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--kjuwgecv2wim3sni
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.02.2021 09:20:04, Vincent Mailhol wrote:
> --- a/include/linux/can/bittiming.h
> +++ b/include/linux/can/bittiming.h
> @@ -1,5 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /* Copyright (c) 2020 Pengutronix, Marc Kleine-Budde <kernel@pengutronix=
=2Ede>
> + * Copyright (c) 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>   */
> =20
>  #ifndef _CAN_BITTIMING_H
> @@ -10,6 +11,70 @@
> =20
>  #define CAN_SYNC_SEG 1
> =20
> +/*
> + * struct can_tdc - CAN FD Transmission Delay Compensation parameters
> + *
> + * At high bit rates, the propagation delay from the TX pin to the RX
> + * pin of the transceiver causes measurement errors: the sample point
> + * on the RX pin might occur on the previous bit.
> + *
> + * To solve this issue, ISO 11898-1 introduces in section 11.3.3
> + * "Transmitter delay compensation" a SSP (Secondary Sample Point)
> + * equal to the distance, in time quanta, from the start of the bit
> + * time on the TX pin to the actual measurement on the RX pin.
> + *
> + * This structure contains the parameters to calculate that SSP.
> + *
> + * @tdcv: Transmitter Delay Compensation Value. Distance, in time
> + *	quanta, from when the bit is sent on the TX pin to when it is
> + *	received on the RX pin of the transmitter. Possible options:
> + *
> + *	  O: automatic mode. The controller dynamically measure @tdcv
> + *	  for each transmited CAN FD frame.
                         ^^^
transmitted

Fixed while applying to linux-can-next/testing. As net-next ist still
closed, there is still some time to the next pull request and I'll
squash patches if needed.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--kjuwgecv2wim3sni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA2ANkACgkQqclaivrt
76lkOwf8DhsjXMEiFMUswhIm02D/9ydLhxz6VQekGzM6S41VHJ6FYaDhhuUCW0xg
dCdBPguk+GgeCO+ZYnzNvAVIfaU7NsgMY+a0K+WzI7rMpNDp9ffE8ZXpoLKicHA0
/if7kSA2VA2BavfeVjrAIv6xvAMLUGHErO8XozwIoaAL4tPTkiqnhjlTp+i+v6ae
qunxWnY475e3y3aT7YmmcLv1EE9oYdu/6JQizGuMbJgQD98O1X47cn3zpBtdd4uF
3m1xmqzfJfyjdFA1hHDf3zPnOo0TQTPERrvXB/SnFpbkhPsD7hQxp8lVg8Aq0E0u
nYpLev69dEPkw0t4FJ61MN2Ix+YOZQ==
=xGJw
-----END PGP SIGNATURE-----

--kjuwgecv2wim3sni--
