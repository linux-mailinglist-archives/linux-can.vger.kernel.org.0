Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE625755E5
	for <lists+linux-can@lfdr.de>; Thu, 14 Jul 2022 21:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiGNThx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Jul 2022 15:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbiGNTho (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Jul 2022 15:37:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2D5655BC
        for <linux-can@vger.kernel.org>; Thu, 14 Jul 2022 12:37:37 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oC4eV-0002fA-Qs; Thu, 14 Jul 2022 21:37:35 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0FAAFB10E2;
        Thu, 14 Jul 2022 19:37:34 +0000 (UTC)
Date:   Thu, 14 Jul 2022 21:37:34 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/5] can: canxl: introduce CAN XL data structure
Message-ID: <20220714193734.y7er5i7hsd7dqxie@pengutronix.de>
References: <20220714160541.2071-1-socketcan@hartkopp.net>
 <20220714160541.2071-2-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5wca65ymnomkmnb6"
Content-Disposition: inline
In-Reply-To: <20220714160541.2071-2-socketcan@hartkopp.net>
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


--5wca65ymnomkmnb6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.07.2022 18:05:37, Oliver Hartkopp wrote:
> This patch adds defines for data structures and length information for
> CAN XL (CAN with eXtended data Length) which can transfer up to 2048
> byte insinde a single frame.
>=20
> Notable changes from CAN FD:
>=20
> - the 11 bit arbitration field is now named 'priority' instead of 'can_id'
>   (there are no 29 bit identifiers nor RTR frames anymore)
> - the data length needs a uint16 value to cover up to 2048 byte
>   (the length element position is different to struct can[fd]_frame)
> - new fields (SDT, AF) and a SEC bit have been introduced
> - the virtual CAN interface identifier is not part if the CAN XL frame
>   struct as this VCID value is stored in struct skbuff (analog to vlan id)

Where do we put the ADS bit (Arbitration Data Sequence Bit Rate
Switching from Arbitration to Data Phase)?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5wca65ymnomkmnb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLQcHsACgkQrX5LkNig
0132hwf/ZVX/gZpe4KPxWvZeGCYpSn8a5/NrZERvuecLgLHuQsEjI0YbejhlPdS+
JQUy5lujiM59RJ4hR5nYDs+eRQUarfxxlEdAdS/quuoTg8w72Gp0oHCWW4b3SxFT
AIt/gS0bd89uZ+u7Ky8P8r/7bLFcgqjYrS1ZqC0u8rl91xl7iSFCiv7GqWjAUeyS
C4zlVWNXDrya2bTquIbZ++QSEdJEcXgLU3FInLmxZih2KxM+w9uR2Emof9ou5AgY
JU+cX3uUL6362ZtZN5TIZAw8tIr/d9SKVaGU6uqitcBp2S5YmB7OINrTER+fvAyL
tA5iJ55ef/3Nu79EIqky4QPn/XHmyw==
=QxIS
-----END PGP SIGNATURE-----

--5wca65ymnomkmnb6--
