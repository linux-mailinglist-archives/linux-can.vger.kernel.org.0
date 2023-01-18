Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6206672C4C
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 00:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjARXLV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 Jan 2023 18:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjARXLU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2023 18:11:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3777539A9
        for <linux-can@vger.kernel.org>; Wed, 18 Jan 2023 15:11:19 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pIHaK-0005gc-4Y; Thu, 19 Jan 2023 00:11:12 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:edde:b534:8a61:9dbc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B290D15B2FD;
        Wed, 18 Jan 2023 23:11:09 +0000 (UTC)
Date:   Thu, 19 Jan 2023 00:11:01 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>, kernel@pengutronix.de
Subject: Re: AW: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Message-ID: <20230118231101.yljudlupwnvnjpmj@pengutronix.de>
References: <20230111222042.1139027-1-mkl@pengutronix.de>
 <FR0P281MB1966FB48421E718CFD09E7A997C19@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h2kjd6sry32ug3ot"
Content-Disposition: inline
In-Reply-To: <FR0P281MB1966FB48421E718CFD09E7A997C19@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
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


--h2kjd6sry32ug3ot
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.01.2023 08:43:29, Stefan Alth=C3=B6fer wrote:
> Tested this on two raspberry CM4 with two MCP1518 controllers each.
> CAN frames are sent (and received) by both sides "simultaneously". In
> 67 h of testing an average of about 100 fifo errors occurred for each
> CAN controller. No wrong messages we received by the application.
>
> Tested-by: Stefan Alth=C3=B6fer <Stefan.Althoefer@janztec.com>

Added, thanks.

> Just to make sure I'm correctly understanding the issues impact: The
> driver reads one complete timed-back message (76 bytes)

The driver reads the RX FIFO head index and has a cached tail index. It
calculates the number of pending messages (which are too many in the bad
case) and reads them from the chip. It reads n * 76 bytes. This might be
some CAN frames too much.

> and then re-syncs to the fifo to read the now hopefully correct
> pointers: Hence there is a spurious extra latency of about < 100 us
> (assuming *' 10 MHz SPI clock)?

The latency introduced by the erratum is "76 bytes * number of old
messages", if the controller is configured for CAN-FD, it's only 20
bytes in the CAN-2.0 mode.

Note: I haven't invested much time in the optimization of CAN-FD, as it
was not important for our customers. There are several options:
- In CRC SPI transfer mode at max 252 bytes are read from the RAM,
  however the chip should support up to 1020 bytes in one transfer.
- The driver always reads full 76 bytes in CAN-FD mode. Splitting the
  transfer in to 2 parts might be more performant for small CAN-FD
  frames. In the first transfer the driver would read the timestamp, ID
  and DLC and some amount of data, after decoding the DLC the remaining
  data can be read in a 2nd transfer.

Contact me if you are interested. :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--h2kjd6sry32ug3ot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPIfIEACgkQrX5LkNig
012fAggApIetPTV4REOzXUzRxvZWNDduPOC6WzQmYr9NnCERD7MiWBkQ/QpXIV7Y
W4jtjV1Zv2BvZI9cxJ++D91U+LNwrHOvahYZoljbyKU8DxF8VDx3iN5l4TxFxpX8
NFdgvZAyRu0E685Tss81TDrLjCsQ6sC9MY5kQ6gpNMauvalvCobtzaiR/XI2Bl2P
ryX021ecrG3aukDlqeNQqx0F0yzWs75VCAmAgoR1dm1+5zf/Bi3p+zI2Zps/BIuS
POAgOXyP+mm/Rjz12YxnIJoFiYILdqeWGYSf0eNZcRoiuiC5WkOswYn4SBsnt3CS
3OzEBZyMrQPil5h4lYx1O+dPzRG3kA==
=GchS
-----END PGP SIGNATURE-----

--h2kjd6sry32ug3ot--
