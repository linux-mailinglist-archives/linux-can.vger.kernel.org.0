Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CBF4B730E
	for <lists+linux-can@lfdr.de>; Tue, 15 Feb 2022 17:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiBOPLD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Feb 2022 10:11:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbiBOPLB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Feb 2022 10:11:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E896C95E
        for <linux-can@vger.kernel.org>; Tue, 15 Feb 2022 07:10:51 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nJzTd-0007Xm-J4; Tue, 15 Feb 2022 16:10:49 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id DAA1133D0D;
        Tue, 15 Feb 2022 15:10:48 +0000 (UTC)
Date:   Tue, 15 Feb 2022 16:10:45 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 6/6] can: peak_usb: add ethtool interface to user defined
 flashed device number
Message-ID: <20220215151045.2gsaj5c7b2edck53@pengutronix.de>
References: <20220131143103.nmp6fquyidsapw2l@pengutronix.de>
 <PA4PR03MB679736316C8D5CF2079EB794D6309@PA4PR03MB6797.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p476d6t6i453ktge"
Content-Disposition: inline
In-Reply-To: <PA4PR03MB679736316C8D5CF2079EB794D6309@PA4PR03MB6797.eurprd03.prod.outlook.com>
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


--p476d6t6i453ktge
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.02.2022 10:57:34, St=C3=A9phane Grosjean wrote:
> endianess is handled by lower level functions (see for ex
> pcan_usb_fd_get_user_devid()/pcan_usb_fd_set_user_devid() in PATCH
> 2/6).
>
> This data is really a number and must be treated as such.

What's the use case for the data/number? What's the big picture?

> The "ethtool -e" interface only displays a silly memory dump not very
> practical to read a number (especially a 32-bit one), requiring the
> use of hexdump such as:
>=20
> ethtool -e can1 raw on | hexdump -v -e '1 "%u\n"'

On a little endian system this gives:

| =E2=9E=9C (pts/0) frogger@rpi4b4:~ (master) sudo ethtool -e can0
| Offset          Values
| ------          ------
| 0x0000:         11 22 33 44=20

On a big endian we see:

| root@DistroKit:~ ethtool -e can0
| Offset		Values
| ------		------
| 0x0000:		44 33 22 11

However, if we pass it through hexdump it's always the same:

| root@DistroKit:~ ethtool -e can0 raw on|hexdump -v -e '1 "%u\n"'
| 1144201745
| =E2=9E=9C (pts/0) frogger@rpi4b4:~ (master) sudo ethtool -e can0 raw on|h=
exdump -v -e '1 "%u\n"'
| 1144201745

Why does the hexdump give the same number? I think it interprets the
memory in native endianness.

> to have a usable display. Unfortunately, these formats do not take
> endianess into account (AFAIK). Maybe you know another way?

I think from the ethtool's point of view the "EEPROM" contents is a
stream of bytes.

With your patches the EEPROM contents is not the same on big and little
endian systems, rather the EEPROM contents is a 32 bit number in native
endianness. From my point of view I think it's more consistent to have
the EEPROM contain a u32 in little endian. But I'm really interested in
the use cases.

Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--p476d6t6i453ktge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmILwnIACgkQrX5LkNig
010k8Qf/esdQfeNa9YtSFbVL+IAiTyap6d5+0V2aEcwDaVm5XyNWSkskXNE/hUiO
r0hu2eNaHW6/gCMF6c5Y4denM4sALafNBKjeiYbnTaMzYZcuPQDxq1AnSmyFtrtQ
Tf43cfmtx6MrI+iGpm2rNztZ2JgcwHjQ0/HnScnxLBSgnFUn7z1n4FKQT0eM9det
w+LnwFNK2Zlcu20CQuLfOTrsBS0fngmiw25pVr4ZAEv3Famn8cY9qEqnzVYDVovB
rQLGJSbto0qgs0gFtPmDlgbn1YAVKljDxZpezLeje3sFTddEeeMOHRj4lPRSOSzZ
7v+rb/e+pqZAkmDOCMjFfK9RAD+uWg==
=rbsE
-----END PGP SIGNATURE-----

--p476d6t6i453ktge--
