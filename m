Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027C04849C5
	for <lists+linux-can@lfdr.de>; Tue,  4 Jan 2022 22:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiADVSG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Jan 2022 16:18:06 -0500
Received: from mout01.posteo.de ([185.67.36.65]:44011 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232604AbiADVSF (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 4 Jan 2022 16:18:05 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 45EDF240028
        for <linux-can@vger.kernel.org>; Tue,  4 Jan 2022 22:18:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1641331084; bh=46G0f4xIlxWZfmN8CFXK9DuizrBElN0OGzIfWA69QP0=;
        h=From:Subject:To:Cc:Date:From;
        b=gWVWPGsBnYTeLhihf4eZ9hNx/7e7tnlblLqWwGO2H7F+QIi5zj6p3uKXXmoIOiJem
         pccI6fsE2836HlmWtdhxMPlJQSc0sEQ1TG1JPHu8TXx/yGC+hClqzCsekJjNshbLpQ
         eWVMHDyUasoIJx06hY2pi5GB/cGgPELBxtVDyCtE4zdjno2iYsHUUAVH6Y90Ir8u6R
         udMFovjWg8+0xvKgtIulyQ2rh4ruJ64Jd1zVBRaXJejHzsyeqpAcH8Ydx5DKDyFmfC
         liSUZfqrFL2xG/PVIJEOaKUzIelMaoz/jKI9xxnNLOl3COkXkK+BJ3ufYnTlB0/b1r
         F07q00GeaoD+g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4JT57H5kVVz9rxP;
        Tue,  4 Jan 2022 22:18:03 +0100 (CET)
From:   Patrick Menschel <menschel.p@posteo.de>
Subject: Re: can-isotp: TX stmin violations
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        =?UTF-8?Q?Maik_Allg=c3=b6wer?= <maik@llgoewer.de>
Cc:     linux-can@vger.kernel.org
References: <20220103155254.3htprmrdjur3ke3l@ganymed>
 <d54c6374-bdf4-dfe8-9e9c-5547a743afdb@hartkopp.net>
 <27389f5f-1681-7440-15bd-3c67e4e5daa9@posteo.de>
 <c20468e2-0f9f-bcca-da0f-f3f6470d91be@hartkopp.net>
Message-ID: <6175074d-6562-91c9-3dce-22ca99815910@posteo.de>
Date:   Tue,  4 Jan 2022 21:18:03 +0000
MIME-Version: 1.0
In-Reply-To: <c20468e2-0f9f-bcca-da0f-f3f6470d91be@hartkopp.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="V6UoKhR8NcVBHZbHPcq44c8DD7djczG9X"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V6UoKhR8NcVBHZbHPcq44c8DD7djczG9X
Content-Type: multipart/mixed; boundary="YF7WOSEaT8KLcZwOlcTw26QgcswhrElmm";
 protected-headers="v1"
From: Patrick Menschel <menschel.p@posteo.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, =?UTF-8?Q?Maik_Allg=c3=b6wer?=
 <maik@llgoewer.de>
Cc: linux-can@vger.kernel.org
Message-ID: <6175074d-6562-91c9-3dce-22ca99815910@posteo.de>
Subject: Re: can-isotp: TX stmin violations
References: <20220103155254.3htprmrdjur3ke3l@ganymed>
 <d54c6374-bdf4-dfe8-9e9c-5547a743afdb@hartkopp.net>
 <27389f5f-1681-7440-15bd-3c67e4e5daa9@posteo.de>
 <c20468e2-0f9f-bcca-da0f-f3f6470d91be@hartkopp.net>
In-Reply-To: <c20468e2-0f9f-bcca-da0f-f3f6470d91be@hartkopp.net>

--YF7WOSEaT8KLcZwOlcTw26QgcswhrElmm
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Am 04.01.22 um 13:37 schrieb Oliver Hartkopp:
>> actually spec says *average* gap time should not fall below STMIN.
>=20
> I did not see this average gap recommendation so far.
>=20
> Only:
>=20
> 9.6.5.4
> SeparationTime minimum (STmin) parameter definition
>=20
> The ST min parameter shall be encoded in byte #3 of the FC N_PCI.
>=20
> This time is specified by the receiving entity. The STmin parameter
> value specifies the minimum time
> gap allowed between the transmissions of two ConsecutiveFrame network
> protocol data units (CFs).

Hi,

the *average* info is from a german translation.

There is a note at the end of the section where it states that due to
jitter in networking, *average* st's comply to STmin.

I confirm that this note is not in the English ISO15765-2-2016.

Regards,
Patrick




--YF7WOSEaT8KLcZwOlcTw26QgcswhrElmm--

--V6UoKhR8NcVBHZbHPcq44c8DD7djczG9X
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE6VSgQlqXIUKDwAxHMeZuMM+vuE4FAmHUuYsFAwAAAAAACgkQMeZuMM+vuE6X
6Q//ZzGFBAVOHaDbWUYbkcGrwLAQO56yxIKk+CYewIXwdqg6Iso5okYohXtUe8KJg16YNo4R1Qet
7WoUJCJrmRncWyxFrimQHmXsqTMW+f8XlJmrgX2FCTDFz3o42aB1gA2DlD2/R2S7nLFbGrIXc6VH
iekMItlaT9y6yb6cgKoTji6RivYHu5t4RvrfZJ+ShPfT5AyZMN3mSrGmec7RRSwrDHhSQXwXb4iF
RJngc0jStHy0GwY+aVw+kYGfT3Fn0Kd5WpsbLARtrhiMU5jKbBX+z/mG3cRTQX0Z0hguJDhfVsBr
AwisX4Dl6OuZslbXnMoHzRoP8rdPHUj5zzyV0qaJ3VTgu9BZ750FjdoUQhSFbyT2N95Saxj/qUVY
PUNbKIWxJAGzp22/0N3MAUAliQzOfqe0oZoM/uXhgEFua9Os6V1PLPRkFChDDcMWNLWTDbZWL0CM
N//ZvwwuWEFMx0MJ9NBGB84+Fv1nKrAhcedUK8OmaAKP7xxI3YMsZa61tX2S21byfDrWqFgEVSTx
kiJ5K5NxPeTvPcUeaYSGNJL3ZxXf11RL+ABAw7BNDa9GphwecoVSHKaqjmW2YOrKjpKs7C5v7kWI
VeEY1UCuYvI0JqQoWs9ZkqUedJKHb+xJG/lD7KzKO+QTW7ymyvMC+tVii/kqhhalPf303gxfx4nq
RuU=
=xFy9
-----END PGP SIGNATURE-----

--V6UoKhR8NcVBHZbHPcq44c8DD7djczG9X--
