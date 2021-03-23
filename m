Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29E03458D3
	for <lists+linux-can@lfdr.de>; Tue, 23 Mar 2021 08:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCWHe7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Mar 2021 03:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhCWHet (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Mar 2021 03:34:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90B3C061574
        for <linux-can@vger.kernel.org>; Tue, 23 Mar 2021 00:34:48 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lObYl-0006G3-OR; Tue, 23 Mar 2021 08:34:39 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:c81e:25b5:b851:4b31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9CB5B5FDC07;
        Tue, 23 Mar 2021 07:34:37 +0000 (UTC)
Date:   Tue, 23 Mar 2021 08:34:37 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Subject: Re: [kbuild-all] Re: include/linux/compiler_types.h:315:38: error:
 call to '__compiletime_assert_536' declared with attribute error:
 BUILD_BUG_ON failed: offsetof(struct can_frame, len) != offsetof(struct
 canfd_frame, len) || offsetof(struct can_frame, data) != offsetof(struc...
Message-ID: <20210323073437.yo63wreqnubbeqby@pengutronix.de>
References: <202103210435.I0fiBGAC-lkp@intel.com>
 <dad98ebd-77a4-3305-e681-278cabe38793@hartkopp.net>
 <7f4f7e1c-194b-a903-d474-e3b742556a55@intel.com>
 <f8075a19-10e1-abf9-6d59-1a46454b74b1@hartkopp.net>
 <b10903ca-c424-b305-d981-fe0004500190@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jucf3zuhpwlugk7g"
Content-Disposition: inline
In-Reply-To: <b10903ca-c424-b305-d981-fe0004500190@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--jucf3zuhpwlugk7g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.03.2021 10:54:40, Rong Chen wrote:
> I tried arm-linux-gnueabi (gcc version 10.2.0) and the problem still
> exists, btw we prefer to not use the latest gcc compiler to avoid
> false positives.

FWIW:

I'm using latest debian arm compiler and the BUILD_BUG never triggered.
gcc version 10.2.1 20210110 (Debian 10.2.1-6)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jucf3zuhpwlugk7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBZmgoACgkQqclaivrt
76mwaAgApUoTTkXx1qY9IZ6zUEu3JH4lUypUxxju76Zhf60CX36mqvNnIjhxDUxd
7vycnZt5Num4MHOF4e9tWEXgCw/bpkYfCSQ+6Ygov0EN7smROs8ACqYeWOmEt1Ew
atTH+OdgHKf2nW7yrYZVlOnb93kKgqwEaxbSONFwRh7SPSjKId3lqACYzHNL7g4P
QJ7Y9UQHAOAUL9gsYcVzsAba8izsQ2F1Fwu3YTnyU2Evd13NmuZ4pBY5UCb6EI6C
3zFgtmtaKrz4p629gZVEsT+KXU/HHygdyNc7cnRZfJ2G30rcezKQub4dGcxeeics
LKxxexIVwnCelLjh+zqqO/uFM5KJMA==
=atgV
-----END PGP SIGNATURE-----

--jucf3zuhpwlugk7g--
