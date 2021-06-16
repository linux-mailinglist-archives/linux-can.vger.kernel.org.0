Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEFE3A96A1
	for <lists+linux-can@lfdr.de>; Wed, 16 Jun 2021 11:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhFPJ4U (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 05:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhFPJ4U (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 05:56:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFE3C061574
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 02:54:14 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ltSFQ-0007jd-Lh; Wed, 16 Jun 2021 11:54:12 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:27:4a54:dbae:b593])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C373663D026;
        Wed, 16 Jun 2021 09:54:11 +0000 (UTC)
Date:   Wed, 16 Jun 2021 11:54:10 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 1/5] can: add new CAN FD bittiming parameters:
 Transmitter Delay Compensation (TDC)
Message-ID: <20210616095410.lsvqnismp4uydrmh@pengutronix.de>
References: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
 <20210224002008.4158-2-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="37y522dl657qwlyh"
Content-Disposition: inline
In-Reply-To: <20210224002008.4158-2-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--37y522dl657qwlyh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.02.2021 09:20:04, Vincent Mailhol wrote:
> At high bit rates, the propagation delay from the TX pin to the RX pin
> of the transceiver causes measurement errors: the sample point on the
> RX pin might occur on the previous bit.
>=20
> This issue is addressed in ISO 11898-1 section 11.3.3 "Transmitter
> delay compensation" (TDC).
>=20
> This patch adds two new structures: can_tdc and can_tdc_const in order
> to implement this TDC.
>=20
> The structures are then added to can_priv.
>=20
> A controller supports TDC if an only if can_priv::tdc_const is not
> NULL.
>=20
> TDC is active if and only if:
>   - fd flag is on
>   - can_priv::tdc.tdco is not zero.
> It is the driver responsibility to check those two conditions are met.
>=20
> No new controller modes are introduced (i.e. no CAN_CTRL_MODE_TDC) in
> order not to be redundant with above logic.
>=20
> The names of the parameters are chosen to match existing CAN
> controllers specification. References:
>   - Bosch C_CAN FD8:
> https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/c_can_fd8/use=
rs_manual_c_can_fd8_r210_1.pdf
>   - Microchip CAN FD Controller Module:
> http://ww1.microchip.com/downloads/en/DeviceDoc/MCP251XXFD-CAN-FD-Control=
ler-Module-Family-Reference-Manual-20005678B.pdf
>   - SAM E701/S70/V70/V71 Family:
> https://www.mouser.com/datasheet/2/268/60001527A-1284321.pdf
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  include/linux/can/bittiming.h | 65 +++++++++++++++++++++++++++++++++++
>  include/linux/can/dev.h       |  3 ++
>  2 files changed, 68 insertions(+)
>=20
> diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
> index 707575c668f4..91bf9f8926a7 100644
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
          ^

I think this is supposed to be a 0, not a O?
I'll send a patch

> + *	  for each transmited CAN FD frame.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--37y522dl657qwlyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDJykAACgkQqclaivrt
76lwAAgAo9vByP8zYj809G4lwfDbloUsPYlfynoHRYRB1cIBkhB1ZRhfMPCNxD5N
S82M/8PfuKIm5EPJPKXXLigOxDzjoOrap+lqDzFXhTw9EuocrCaNQ+cwrLH56j/o
feqB+nGpfQ8jRbP8xgsKKrKVYeYkoTu/oesz0ua5rAEsJkL4AaKj2WjY0U+fQW2Y
stO/r+XHbRQJ0SLE3B1QprbE1DZ+JiQj0WC26G9j571nlCGl5OfuBPrdYBM4lUCb
nby7wcvvLHV6Sf/OaE80bFkN8EDcJNPOfTmOX70mpNcZl4d1BMeEw5oTdUY1YWK5
zlmgXztyUQ1dqyIIdlRql2v0LTGZfA==
=WsMt
-----END PGP SIGNATURE-----

--37y522dl657qwlyh--
