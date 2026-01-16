Return-Path: <linux-can+bounces-6179-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E68D3335F
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 16:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57E1C3022824
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 15:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F072E336EE0;
	Fri, 16 Jan 2026 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lHtku2A/"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED591212549;
	Fri, 16 Jan 2026 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577293; cv=none; b=g646lYUGjuTYb3RGTl2p3a72KkJLDlfx348eJiG5xRL5+VT0NhWbAw1ibgiwuNNXeBLPmU44G88XGksxYHd3u2jMTTf87Jn644+MUK/D6if39FXFsjhbWeOlJPMOUkTl6qcgt/mZN3c9eOQhaWYAlQB7KERyXzOxCNWFOghHqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577293; c=relaxed/simple;
	bh=p28wsltP7RbEcNDqMMw+Y09tpfeno4ESj0N431W8pj4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=MhBUgDcKY398F7iZND5D4R0lqVd5UnROAX6GzfNDetj2p0Rdtm5h3jZgzNlDImgBQF2NfvLkfGAOhpx0jxrKPfu7LlClgQkvTB7D8VVizndA0U+GHZkrHK6gKNxRcneiyNEoQCxxhlG2kDfWRZcNScZcQwwPZUXvwECqnGPyLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=lHtku2A/; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768577288; x=1769182088; i=markus.elfring@web.de;
	bh=p28wsltP7RbEcNDqMMw+Y09tpfeno4ESj0N431W8pj4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lHtku2A/PIA9fGS0qfmAg0tJgmpMYheYguSacpkun6O6sodmP88XONvQTt4ExeOY
	 JzxrGULN/ytsGtf1v9B5yxeX5Qyd8MG5xEgWmGnjyDRAbDBiACeD21uj+JfKmm9g/
	 A5qPOaWEckV37IIf5I+K/80kwTWEe7ZYegFXAillWa2EyA8KVdZkTG/2QpTe+alq7
	 sxMoiu+aDN0xUGmfpMFKqVDzJ6YFvRjAkGy1zInQpJp2dWp7y09dB7vNL96KFHQpY
	 bYXneYrz5Uh7znEdPTl/1AO3eYrjZyiIlKGdhkis77oJOZ2cAspN1z+E+N5OnfRhV
	 wgv+DaVxa6JCTjFGUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.218]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5j5k-1viOZe2ptC-00ALUT; Fri, 16
 Jan 2026 16:28:08 +0100
Message-ID: <a251e98d-3940-4562-a8e9-985f652d22f0@web.de>
Date: Fri, 16 Jan 2026 16:28:07 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, LKML <linux-kernel@vger.kernel.org>
References: <20260116-can_add_missing_set_caps-v1-1-7525126d8b20@pengutronix.de>
Subject: Re: [PATCH] can: dev: alloc_candev_mqs(): add missing default CAN
 capabilitied
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260116-can_add_missing_set_caps-v1-1-7525126d8b20@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:erMytk2hxVTSLSicyAnBpoMzflnt4BQoA1pcVbSEazdweZ59MaL
 EIzzIQBA2H6guqaaHpOKTbzYK7rVRJ4WFchDxHyyXgAzTg9amJ59/WKRsqvc9+7ij5Ok46d
 lbsBVuc0JEz5Py73TVcvfq1a8TGL5O+ka7fAQjlpSE6WzsNvyKab+8m1zVzoOoSTX2Ei/fR
 9vDcM1tYe6An9PtV800rQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0alkK9u4rck=;VGbP0CarJqrPMjN9gxRzTkLG4Fe
 Yk0os524zdCeIh1vmakWw9edtDiVamHcazfOvK/s6RI8zbUnBbpZaj0p50pZC9Z81zq4j3Ukr
 EOsuJNYaM/xAH0PZM9SNZa5cY1z0LeSYcEJ2bCNJq6jpv0GzWAun1sghQv9nB6+Ww/zGdKAS2
 Y5lX7OrOU3YCEIcxv8z5C0WHG1gLH8gqcYJLOHENlvpJwjowapqo/qEOTQ0r6/fW+qbCwHa30
 K7R9aEqCUVvzCsVeTjJHfTe4zJdRc5KG95GS/FOGcXK9WxzGyi0Efqgco9mCaBR+aCNiP/LJT
 s1gWIQqLzYBtgz+K0GTgRtJC+FFlBVzGolt+ROE1RB21MdPVzsw/OKOJwAuAoPPggBLaewL8F
 YQCe2niwsgiYjCWotuhnwzz52GEjVobhBGsSm7iubFvBHtnUIh0KJ4DuAAhmpjQhqeKkmd/lA
 8EX+7O2LjVWSh/KqOzriuiP3m+eMbrqJA4j47f5zMeYrFM6fiVT6rPUNF9QI99bhvjq7um19i
 zDixg9mBBrb6A9G9X5Dn5nSIBvMGL13T9a4Guj/mSjB7JFSsZ8WDg864s1xPrigwOr1KBnJ7I
 hY8FAkZ7/Bzl3fs9r1ST65oZiofkGjl6JUlEYaUlai7aId+KkrAyYqaZnvUYGV8qcjlExFQSK
 Z1uJEG/7sBR9Nb3ojreEB2OC8mlkNyEfB9tkh4hfCFD7ghMKIOzFOU8QmqK+aFmxYXpWWwynl
 RBQ9HaLHJVcDL2UYVPFIWxjeB5ezZEbaeGvS8aXuFozlb6dkR/go6NNZ8oawcJRuik+FO1mr6
 0fiSZVDbEVbSaXg5AwDysKEnZqRQPeBHZxAtRQEi4TSOxg7/LZeFyh9zrf4HI2/d8aG+vnE0n
 B+CPKZlg6jMIvqgZRLpfbdMrXW/xDKA2gwAU5ZXfJOmxFugJhXKJtCWBB4Y+Uf9yws5b0Nkvu
 AGNNF8K3YMqs/cMpn9lkXgCJtKRH+oo+3roSz6mKd6cR4sxnT9Vb07f1I2y/5S2gSGtwqpW1k
 MEwuVrbj0p7ZqyOvYQB4I3XqbtPQ47j3JHvVGUlJRnFX8bJGl3Nr98Av+tjfpXYVcqeX0NEyc
 KIr2lRDtcpZESdVtBaTBwC7016egtvLDABIULAFjmIQV5ej/hZabQAl7OEwfWIgfprkpLMB0F
 e/A8Du6bymxkY2dWP9VzTYWpKsDUsqCxbfS54XXVreYeKgnjPId+WnN7xYml2rCBja5cbS3Gv
 WImmeJeqNPbHqdrvLtkJpVo2q10KTv7R39m0Adva0rVMhoExjTbmKeYlyCKD36O1/NTOIGpGV
 UJiqrRAdWQR/GYtl/uaT69dNZKXlJNSSzVWE05tAotVeHCpVQZzJr61eF/72w0E+eLVwUoOYa
 sVl4FVhhFOuH3Tf75z/ssCkRsqwsTyAXxFSQujX1sQlN3Glm999uBeDQ1arAKF71kCDzXHWMI
 9uFvphrPViANliDRVqvUxnmTS6XwJzjwgjFHp8N2xe7Rujo4jvjBYGh1+87bK837pMQzdX4TY
 L8zN0Wdc5aaNQTTEzMaIJ7cfA4TciOBaJ1S53CXI3M9yEfipHkER4uM8DqsyY7PUFEnZPhkAt
 bRRw7fG8msVswsv3OLUnEXBfefZNENt2iBdmA7btL+EBlzubArNLf0QSww+jFRo5WF0D2dMD6
 28f7Xke/dC9nlGJJzBaLmSrjswpnyiKX8oTd/ZxQnA2f6u29PB2P8VcHTfHLC5AyDe4MoMOrA
 FZ2K00efkj0POsxUbfa+TDSGPBopGQFgxD7ErySAwWO3SNYCrI1dBXiInun5T7jJiJfx2vbzs
 4aE2UTWuxnDdXnXb/YM1+CveC/KlDtH1Yz0h8iZkAuM435KGa/CmzcHp2M1jJlOehfyALbMUx
 pqBbAAMfIpXzU9lvQLWseVSRw9rf+ahEftff0IcqdWZjIF/fKlw7RupEIEcsseId3BDSMpMjX
 htqNa6mFVmg5WjyqW/e0DXQI+NAkWp9MwK3aIXf/xztW0HTbWGAQyRgvO34niRQVE9BpruAEX
 XE+1j4yckb04CBfjZ5J68xWeFB/V3vD+1dix1WV2/4FMlIVuYhnAbLODDUloTZAiflkVgjVQJ
 cg/dDzykfL0taDY6a19zTYQcxgh1Rch9g+v1mu/bM2mrm5jWIJDHRV3VjdxU1o9JSUpkK4CHx
 y7EYSyNOdeKIfvT+Tj62gcVWxsesTgjXA73BWyB84JEn047EwhLDnk0e6bILhcmA0nCI45qJv
 r32WP1UNxAaNRIyQSo7z1uBa8xcXTpc9n8pRchm8vfjDR655GA6u2eo3MvShw8IBGuY0Q2GUb
 auKZmgzNaHTKukx79VpKf4oWBntlBr/2/SdicX5N2BRXISs8Zz5uKhMJCKwCX3IMf+FUcGStJ
 cTYYjJzMXPWAqspWBH9cBUnSXvy0wfnBmO9ZAwMEtzgMQpV+POeRUXQBAWYuYiWky8yUo8pcn
 v6nTsslvsGqM6F/g7b42cCoU0GvqdWPykMUnkPsG5x3N5ZTvbV80+DwxQO2cjra4VaeMNmMpq
 jm2Fhuf2fLu2HFR85d4NylYIfQJbTOIf0fLyT8SicY51vQsIQnV18o5IXHB7jdXc1/fm1iNih
 1zXJeh245zNRraA40ufjak5qhPqoqpMZNNvObHu1+lAnQDqwlAReqZ9Q9Xc8v1GWXW4rLxPGG
 A1lPJJkWRGMZ0oW7qF6aKqIbp1a6wPZUCFEvowaVAQ9TWIaI7zUNKK+iBf76/lOZ/loW68hL4
 YiqKE37tT/24EPYRcRSH4TgGN9nguVsR+eqSf4jiIYWcBOX9H6yacPLNau4Ma8fNWFtRegu7W
 d6yqXXpzUrYi/Rm2+g7xxXaia3ZyHFapsEX38Z2CcXLCW8VreacESUJ4+ghRffNLTPtukpRO3
 3/jV20tifYitDBL6RQLpyApATlKg68uXzYlZFlN93oC8Ee+cQY/f7LLa3PVGZ4sYRRuwevSJE
 /dLCuj9Jvbndp3eFLQAV/Ld15y5mAuhHXuXCvkqMhn+ldZ7kPy8mCtU5armUHeVBUXJfXetS+
 gpCba4e1d1EUuMyWL3r3ZvXByqBHxXpJsI2l8OqE//8VGvZGwjC9JPfx3kvqc40UZRSK966aU
 g4F+DxN39NBrt1L2mizafyPH4GK6d0S8VdQHjOqmroL61tLx/Cwvt7ioktMMfx3JICJQYz55Q
 jt81lPwOo5PA6ZUpxp5u4yb/s4FkwgofTwe2OLGN1MCC9HFoYfGipwTLWEXfYeGH8VUJOYw0r
 f+5hJ4LQH5HcJ8ykCaCl+nCN/l4aU7rbO3NDlgMx9Ci6WcxeqfgDNFyd+Zx4GO1D9cHp+RBkU
 1mXonyZgKapUI9mODsNpUkWewxSvdFGGhHNUjwDoLcJ7SvGtmsn4+zkRS5PLSPTZkfCDRqlPR
 EKF1aFssolvr0CVAAW5paQzcmAgfQ3tyWO6ljtkYu15cxo+0sqo2V0Pc6Ms3a8YFKyB1nuP05
 j5CheWlAj1lRG2/68Gry4eMet6azqrBbRIkgOKiRnz9HAeIqW/J4vVT9cLEostq8hjItTxBtl
 7jUXr76V6Z4z7scSOxqFPYAUbHuDhUSRUhGxosUD6bGyyjGs89PFNuvjs/rumrQ8xWT/U1Ghk
 ztgwyHkAySb20Ps2bGoi3llqmkQNw7DoqKfzG5Bmy0K1aayAXuyS2SrxAFsg/nF1h4AbVGL19
 4+WZXHcVLxqY5vvAMUBNr6mrhqS1odww6dPaC1cyn+ZZsnhzVW9pzAq9bUveMHuQLLXo4JrJu
 5MvAaXv583gLHl3WNPV74nBUBcp0DrY4FPM9ZCGlFIee3IxeEjMQGmXu4okyRy8HY5gqES9Pl
 fhTy1JXNUB6vTaDUN/kV/c62cEG+fTn+maDyni2YTmEOwCt0d4rohuxBKFcsEOROqB8uTAmTW
 uGOiXZme40IzyqoSiCqciWrgYK0LStLA681GrnlfKRTQK4SCWnpGuSITkcVTV3MpZNqjlOqxU
 7BuaZvasEBzLbsvrtuL8d5EqP8j0KTFrORgDvAnEqQnWvIE8mVtwe75JYV2TCYPYe9r2GgFNQ
 JY4IrzIkxN6jmWWRqZ8ab42D751PQgfNl9JHg0d+s/MC6+wPZPZ4fmgW+cv20TKO7iinrVE14
 OEa5vfr5dQE8pgcb7Ji5yMUux2fQmrkhHNSfbJQY7m/yPKZ9GbuSKbG2lD0oWme5ufd+auhvk
 7TJn0BRIfYS/geO32fdsyUXMOuPSra8Rt2sndRsKP0LDvJmq5k2C1Li96A4/IzC5KLXyBH/vc
 gsK9WX7IdCfvo3LNcKlxM51LsUT6vaNSmBPQ9ryVVk3YsYMNWU+p60x18g3nwxabwwV9uUUID
 9a/UM1uw2rE981gTynGRQRY9SQyOxptuHQkBKkBWFVe3+FWDSHTgzPKs221iyThOGswYzXN6Y
 Nbo3GiDT5KswKJUloQFHspEcthEgW+bobF312tVRKefVUa6LudNknXrBV5HID6RFDsQClD60U
 ZeOeRoeNg1dHkEHIJOdoFZEXZGuNfwXDDL/68Mhc+EsmTK+C+oFDCVqhcgDZ0nH0FobW3BnqZ
 7FU0nfxK9R59JPhZ6yEAl3D3xAzceSCBzgBtlek+h1RkhAIfFdkfovAhBPpkGH1vSxezRPMSY
 gffriSCWvsYvjI1CbTRpy61WEVZUQI+OaMAjah5Ytq0cCp3lruB79lPCL0+Tvue+I8jPxFnAw
 E+e4wdr4Os0bD5nQjfX7Nt8blL0GIQUQL0Hioql7lj/Hvaq2rX/En1SwA15OgXmBlF0ONWd44
 F2PwkKkYri09/HMCRJacjqbQHSRMXRWfhFaDsyUkp7JwlkWwWGr83I9KQeiXhYphZWxOqw2J8
 tlhW5KNulX2Jbz+9giXTC5ugy6d7Rrh7X3wsOB22rv/0++heit9VInOJU+tOjNVmLGKNVVC6q
 7wkQYOUBozE/l/L0vO1AeYNOXqY4cmihQtpqMcRh0UJXYykpF3TvGFdvCZq/C1MnuKz3zz22V
 oS8urmahvBC1MFwjb+WCAa6NI1XnLY8miNpbkmbk66i+7J0iDwzkrPKfP4zG90QpRu1QsNJjl
 SSQ+dHQ2q/AjLUUeZjODEfRi5bjt8Mi20/fSVAK7PYnh+ZrQyqDoGi2vxydUH0GIzisUA==

=E2=80=A6
> Fix this problem by setting the default capabilities to CAN-CC in
> alloc_candev_mqs() as soon as the CAN specific ml_priv is allocated.

Please avoid a typo in the summary phrase.

Regards,
Markus

