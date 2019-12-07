Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8266F116166
	for <lists+linux-can@lfdr.de>; Sun,  8 Dec 2019 11:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfLHKgy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 8 Dec 2019 05:36:54 -0500
Received: from glittertind.blackshift.org ([116.203.23.228]:59242 "EHLO
        glittertind.blackshift.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbfLHKgy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 8 Dec 2019 05:36:54 -0500
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Dec 2019 05:36:52 EST
Received: from bjornoya.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:213:3bff:fe04:292])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "bjornoya.blackshift.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by glittertind.blackshift.org (Postfix) with ESMTPS id C4E5138DE9B;
        Sun,  8 Dec 2019 10:29:33 +0000 (UTC)
Received: from [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400] (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0CECB48B44D;
        Sun,  8 Dec 2019 10:29:31 +0000 (UTC)
To:     linux-can/can-utils 
        <reply+AAODILY723EPW4FZ4DOMMY536LEIFEVBNHHB5BTT7M@reply.github.com>,
        linux-can <linux-can@vger.kernel.org>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc:     David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <ore@pengutronix.de>
References: <linux-can/can-utils/issues/159@github.com>
 <linux-can/can-utils/issues/159/560816311@github.com>
From:   Marc Kleine-Budde <mkl@blackshift.org>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@blackshift.org; prefer-encrypt=mutual; keydata=
 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
 iirOhi+TKhHIvDnBVg==
Subject: Re: [linux-can/can-utils] Networking with CAN-J1939 support (Ubuntu
 Linux) ./testj1939 (#159)
Message-ID: <156e4ed7-e3fe-3da7-56b4-2ec4329e77d1@blackshift.org>
Date:   Sat, 7 Dec 2019 21:35:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <linux-can/can-utils/issues/159/560816311@github.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NK3ZjX6zotPBkfnrjTcFTQIDPQfKld1iq"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NK3ZjX6zotPBkfnrjTcFTQIDPQfKld1iq
Content-Type: multipart/mixed; boundary="wJtZ9c8KRLijrmvpRfaTEUwtk3GJ1qTz8";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@blackshift.org>
To: linux-can/can-utils
 <reply+AAODILY723EPW4FZ4DOMMY536LEIFEVBNHHB5BTT7M@reply.github.com>,
 linux-can <linux-can@vger.kernel.org>,
 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: David Jander <david@protonic.nl>, Robin van der Gracht
 <robin@protonic.nl>, Oleksij Rempel <ore@pengutronix.de>
Message-ID: <156e4ed7-e3fe-3da7-56b4-2ec4329e77d1@blackshift.org>
Subject: Re: [linux-can/can-utils] Networking with CAN-J1939 support (Ubuntu
 Linux) ./testj1939 (#159)
References: <linux-can/can-utils/issues/159@github.com>
 <linux-can/can-utils/issues/159/560816311@github.com>
In-Reply-To: <linux-can/can-utils/issues/159/560816311@github.com>

--wJtZ9c8KRLijrmvpRfaTEUwtk3GJ1qTz8
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On github a question[1] about j1939 priorities popped up:

On 12/2/19 11:53 PM, josemic wrote:
> At least in the ISOBUS standard I am not aware the the priorities 0 an =
1
> require special handling compared to the other priorities 2-7. I am not=

> aware, if this is the case for the other J1939 based standards. However=

> if this is not the case, I recommend to remove the root requirements an=
d
> capabilities requirement CAP_NET_ADMIN for the priorities 0 and 1.
> As I am not familiar with the usage of capabilities, could you please
> explain how to set the capabilities CAP_NET_ADMIN for the command line
> or any userspace program.
[1]
https://github.com/linux-can/can-utils/issues/159#issuecomment-560816311

Marc


--wJtZ9c8KRLijrmvpRfaTEUwtk3GJ1qTz8--

--NK3ZjX6zotPBkfnrjTcFTQIDPQfKld1iq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3sDREACgkQWsYho5Hk
nSBFqwgAuQw/bxJ2v5UntpuV1chyuLRe/59+MjFdz3OE9pTWciYNzAE6GOK3NsMd
nUlkr0HiGlInobqj/bZtzukN626px6qJF3NfTFc/b8vao6AhuFgvc7++0isogZbH
r/4pQ7/JDkaH6jptVL255zAP98p8F7MaodAFDqBSykiTdNoXI5aobo0thCFVYFjU
U674eYggqkAxkFrA+k5TmcdL9KklyxxUvhdpRNWQM73Oo5Y7+SFgtHrtlH+3GhdH
XuZZroKJtIbxKvFj8cc7OEbxordd5T2NZlPZmFKHvSCKwP4N26vPk8vv0wNk+n8s
N0c7JzKDHv4rOLUIARZRzjs1lOD/aw==
=LZcS
-----END PGP SIGNATURE-----

--NK3ZjX6zotPBkfnrjTcFTQIDPQfKld1iq--
