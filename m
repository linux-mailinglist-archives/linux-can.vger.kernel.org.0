Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1315F8E917
	for <lists+linux-can@lfdr.de>; Thu, 15 Aug 2019 12:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbfHOKgH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 15 Aug 2019 06:36:07 -0400
Received: from mout01.posteo.de ([185.67.36.65]:54945 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730996AbfHOKgG (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 15 Aug 2019 06:36:06 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id A376B16005E
        for <linux-can@vger.kernel.org>; Thu, 15 Aug 2019 12:36:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1565865362; bh=PKqnAXG8UVIxvR9A6uJyFgFrvP0MCP0Gou7jgPoW0E8=;
        h=To:Cc:From:Openpgp:Autocrypt:Subject:Date:From;
        b=VDNRM1aAihOSwUnISOOrMr8c8jCM2Uckf1DW+GtXgukVzuKhFw35BJXpndK8edcp6
         NkpFNG21m40/phapoun14tFS9ByGjCyGBW7SI38wnL47slzP/+EMPzIdJaCKE93/S5
         bY3nfKH/48jTXTtBJpFPSV61Rojrs7nCZfCp0bkMPykpFB7cSaFk4JBPIXcmdEZYQE
         8I7ymlM8tochqXSnISavoTr2BJ3irz1luaTIm6VqD+U1Jg+F+IaBk9HFi/33cnJYLL
         ilERN42YUvwz1QjjVmZpbY3E4v9vblAiBJLwoVkZxC50PnzIpD9YbtPMAnc8egrWaF
         5WtpCtOYHw0Og==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 468NCN583tz6tmH;
        Thu, 15 Aug 2019 12:36:00 +0200 (CEST)
To:     "FIXED-TERM Buecheler Konstantin (ETAS-SEC/ECT-Mu)" 
        <fixed-term.Konstantin.Buecheler@escrypt.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <3f71bdff8f4f4fe19ad9a09be89bc73d@escrypt.com>
 <f78bb414-4165-3f56-151a-47ab4a8a645d@pengutronix.de>
From:   Patrick Menschel <menschel.p@posteo.de>
Openpgp: preference=signencrypt
Autocrypt: addr=menschel.p@posteo.de; prefer-encrypt=mutual; keydata=
 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 pOd6
Subject: Re: can: tcan4x5x: spi bits_per_word issue on Raspberry PI
Message-ID: <e6577cc2-89fc-9428-b73e-47f41eff2949@posteo.de>
Date:   Thu, 15 Aug 2019 12:35:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f78bb414-4165-3f56-151a-47ab4a8a645d@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="vQT5u7hggtb8jXDpNZwMiiaNAZYWXKcWx"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vQT5u7hggtb8jXDpNZwMiiaNAZYWXKcWx
Content-Type: multipart/mixed; boundary="NapcEqp2WcSHJTseK8ZjLpjxpS33Xz9r0";
 protected-headers="v1"
From: Patrick Menschel <menschel.p@posteo.de>
To: "FIXED-TERM Buecheler Konstantin (ETAS-SEC/ECT-Mu)"
 <fixed-term.Konstantin.Buecheler@escrypt.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <e6577cc2-89fc-9428-b73e-47f41eff2949@posteo.de>
Subject: Re: can: tcan4x5x: spi bits_per_word issue on Raspberry PI
References: <3f71bdff8f4f4fe19ad9a09be89bc73d@escrypt.com>
 <f78bb414-4165-3f56-151a-47ab4a8a645d@pengutronix.de>
In-Reply-To: <f78bb414-4165-3f56-151a-47ab4a8a645d@pengutronix.de>

--NapcEqp2WcSHJTseK8ZjLpjxpS33Xz9r0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Am 15.08.19 um 10:34 schrieb Marc Kleine-Budde:
>> Now I have another really confusing problem. Anything I write to SPI i=
s written little endian. The tcan chip expects big endian.=20
>> Anything I read from SPI is treated as little endian but is big endian=
=2E Does anyone know why this happens?=20
>> Is there a flag or something I can set for the SPI device/wire to fix =
this?
>=20
> Have you changed the bits_per_word to 8? Then you read just a stream of=

> bytes. If you tread them as an u32 they are in host order.
>=20
> Marc
>=20


Hi,

from my experience with SPIDEV on RPI, the driver uses a char array for I=
/O.
As the RPI code is build little endian, logically little endian comes
out of SPI. You basically have to invert the bit and byte order by hand
for a big endian slave.

Clock Phase and Clock Polarity are also an issue on the RPI as at least
SPIDEV kindly overlooks any options set previously.
I had my share of this while writing a test app for a MAX31855 IC and
ended up casting a little endian array to a big endian structure.

Regards,
Patrick


--NapcEqp2WcSHJTseK8ZjLpjxpS33Xz9r0--

--vQT5u7hggtb8jXDpNZwMiiaNAZYWXKcWx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6VSgQlqXIUKDwAxHMeZuMM+vuE4FAl1VNY8ACgkQMeZuMM+v
uE6mNxAAvMMu2LF5ivnfQLRkmsc4f1CdmFgIKOPCZTvinPM8oZCiEaY4Hzam7He/
YnwnRYaLuNmIRa0+0mrcgnr7DYNqcuLzZ3wQv1kTnPYinCO4hvQcRYZVv94g3znp
RBadAxXQwUI/k4JdvJltNHWgysBPk+N4Bc3f7R+hvqys2hjHW7vA+Mc1cXvejT0I
i/eKVVHvbd/YyyMGgnqpjFIUWUtZC4XmDAz8Ii/csRXoLt8lHzRsSK4MsZYtsHIa
VScRlClIH0nzyq4xyo7nHBrQNCN8I172rOpe7PXaiPuyLXooys1dQ1CE4kfiFlML
4sLU/EmNwZbrIM77ot0QMXVphxMDYc0BQHkgKSQzDRfz2a6NNMHqKDpLt49Vh9fe
3/9swHA6WH4bdZs+GwOwWZPQKP46xbzY694vEvSBHumlP/csz5zC8cs8zVm8f4qj
KkdAGBRxsV7MmJ+k6FqKX5hbhascqYOMXC33/xsDSkjIrxaO4LV1NSgCbZ5gv5bH
/SUBFAlTEOtiyGrLG7x+7HdVzkDd/rmmkIlB0ZwCSIhYvt0nAEbteJHlXSF3nTXr
UY2Oq2M+zPbk9F9VjkxWzIloxJLNzV06HfM0Bi3+oojJOS9fx+S95GhYdyCMw4m7
Br4jFtk/lJc99DVcD7NBGjOJ600PZ5V4bXjlIPffItwp3+qjVB4=
=hQiS
-----END PGP SIGNATURE-----

--vQT5u7hggtb8jXDpNZwMiiaNAZYWXKcWx--
