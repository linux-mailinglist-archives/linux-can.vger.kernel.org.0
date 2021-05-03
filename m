Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62C437134F
	for <lists+linux-can@lfdr.de>; Mon,  3 May 2021 12:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhECKDn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 3 May 2021 06:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhECKDn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 3 May 2021 06:03:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE2FC06174A
        for <linux-can@vger.kernel.org>; Mon,  3 May 2021 03:02:50 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ldVPc-0003eg-O0; Mon, 03 May 2021 12:02:48 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1b0:e062:be12:b9c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4969D61AFF5;
        Mon,  3 May 2021 10:02:47 +0000 (UTC)
Date:   Mon, 3 May 2021 12:02:46 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can <linux-can@vger.kernel.org>
Cc:     kayoub5@live.com
Subject: More flags for logging
Message-ID: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ztiqbtpowxp3xr3p"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ztiqbtpowxp3xr3p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

on github Ayoub Kaanich writes:

https://github.com/linux-can/can-utils/issues/291

-------->8-------->8-------->8-------->8-------->8-------->8--------

The SocketCAN API is a great initiative for standardizing the CAN
interface API. This request tries to extend this initiative for more use
cases.

Context:

The SocketCAN was adopted by libpcap and tcpdump as the standard format
for logging CAN Frames in PCAP and PCAP-NG. See:

https://www.tcpdump.org/linktypes/LINKTYPE_CAN_SOCKETCAN.html
https://github.com/wireshark/wireshark/blob/master/epan/dissectors/packet-s=
ocketcan.c
https://www.wireshark.org/docs/dfref/c/can.html

Problem:
Applications that perform logging, usually need more details that normal
applications, for the sake of debugging later on. Flags needs to be
reserved/allocated in the SocketCAN API, so that logging applications
can make use of them in the PCAP format. The flags does not need
necessary need to be implemented by SocketCAN, they just need to be
marked as reserved for such use case.

Needed Flags:
FDF Flag

- Since CAN Frames and CAN-FD frames can co-exist in the same bus,
  logging application needs to know if a normal CAN Frame was
  transmitted on a CAN-FD bus, namely was the FDF bit set or not.
 =20
 ACK bit in data frame
- Some logging hardware can act as a "spy", meaning that it records CAN
  Frames, but does not set the ACK bit
- A way to know for a given frame (FD or not), was the ACK bit set or
  not.
- Current API allow detecting missing ACK, but it does not report what
  Frame had a missing ACK.

-------->8-------->8-------->8-------->8-------->8-------->8--------

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ztiqbtpowxp3xr3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCPykMACgkQqclaivrt
76llOwf/f/WmNt2GCdQuun8fXpSb/O8F8XJkKyBGaaeEnVPLSJYuQ4KFEkoI8Oyl
z9iSScrjwyHPhf8adeaaixJIFfk5PwyLSDMNTeaaUWkqENahPvCt0a3PnwYGQ1rs
Km5eV4ZQIsgAoGsAfKsnKs2jQZYp4UMbAwN9OM/4J7ElyNsy1fxi7HY9lUonX79/
DYfs70trrYEywrsqax/xfNVv3FQITUKvgDYQWVnp9QZFHnNwqweua7BHC5xHWB+b
MHcYMpa9rnsNvgsOKmJcZGFNVOyJ+A8dXrIZbE6CscgzCpz8+YLThsO42gN/jJsx
n4oIqzNP1wIR6J+KjPvsLLXLkmpT2g==
=r3gu
-----END PGP SIGNATURE-----

--ztiqbtpowxp3xr3p--
