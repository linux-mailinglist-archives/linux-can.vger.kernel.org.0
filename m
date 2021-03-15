Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D602A33C0AD
	for <lists+linux-can@lfdr.de>; Mon, 15 Mar 2021 17:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhCOP7a (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 Mar 2021 11:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCOP7F (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 Mar 2021 11:59:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B08C06174A
        for <linux-can@vger.kernel.org>; Mon, 15 Mar 2021 08:59:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lLpcU-0002zv-G0; Mon, 15 Mar 2021 16:59:02 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:91fd:fdb9:356d:9a2d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D00C45F5D28;
        Mon, 15 Mar 2021 15:59:00 +0000 (UTC)
Date:   Mon, 15 Mar 2021 16:59:00 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 4/5] can: add netlink interface for CAN-FD Transmitter
 Delay Compensation (TDC)
Message-ID: <20210315155900.a6l5l5aeuvsgn55x@pengutronix.de>
References: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
 <20210224002008.4158-5-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="claa2ydl5f2a7cxu"
Content-Disposition: inline
In-Reply-To: <20210224002008.4158-5-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--claa2ydl5f2a7cxu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.02.2021 09:20:07, Vincent Mailhol wrote:
> Add the netlink interface for TDC parameters of struct can_tdc and
> can_tdc_const.
>=20
> Contrary to the can_bittiming(_const) structures for which there is
> just a single IFLA_CAN(_DATA)_BITTMING(_CONST) entry per structure,
> here, an IFLA_CAN_TDC* entry is added for each of the TDC parameters
> of the newly introduced struct can_tdc and struct can_tdc_const.
>=20
> For struct can_tdc, these are:
> 	IFLA_CAN_TDCV
> 	IFLA_CAN_TDCO
> 	IFLA_CAN_TDCF
>=20
> For struct can_tdc_const, these are:
> 	IFLA_CAN_TDCV_MAX_CONST
> 	IFLA_CAN_TDCO_MAX_CONST
> 	IFLA_CAN_TDCF_MAX_CONST
>=20
> This is done so that changes can be applied in the future to the
> structures without breaking the netlink interface.
>=20
> All the new parameters are defined as u32. This arbitrary choice is
> done to mimic the other bittiming values with are also all of type
> u32. An u16 would have been sufficient to hold the TDC values.

I just had a look at the ethtool-netlink interface:

| Documentation/networking/ethtool-netlink.rst

this is much better designed than the CAN netlink interface. It was done
by the pros and much later than CAN. :D So I'd like to have a similar
structure for new CAN netlink stuff.

So I think I'll remove this patch for now from can-next-testing. The
kernel internal interface to tdc is still OK, we can leave it as is and
change it if needed. But netlink is user space and I'd like to have it
properly designed.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--claa2ydl5f2a7cxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBPhEEACgkQqclaivrt
76kl8Qf+J4tDslM4VNAhhcjOdBGXweZMng5DnLon7LRR/DxfX5Eh21c9agyRqrH3
LiOnGZevytsa63Trb7LPomFB0b2+yqnYrcLfy4n11j3DAO6tQXiDoTuzrE+HIBtt
7Gp+rdeqoZyTmlFjfzQhd9ln9g5k6iRmCYK5cfguqtranL8IgDBrzT9re1k/Uvjr
6iEPXKYtW0XrZX8Ju9X3o4aPTVBOQjgfr7YSuF+yD9kqUh4Vt1ha2r7BRhMQMP9n
y6+uxx9EC0ge+HXf54LRAF4YxnSfQLIQ5RQQbrE4FaH6KJTiB5Q+of9EMWJz4Hbm
XyhYvMv1ZDjtHPDtzcicy2lbRJ4BOw==
=5C+6
-----END PGP SIGNATURE-----

--claa2ydl5f2a7cxu--
