Return-Path: <linux-can+bounces-4551-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8E8B4A662
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 11:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE253A2C19
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 09:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB1A2367D3;
	Tue,  9 Sep 2025 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VUzcNvxh"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563D1257423
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408505; cv=none; b=RgbwmIzlBGUn+8JKVNBkn+8pXjWsyf1BgxYQfPrQcz65SOGboBCnTX7zjXaq1jGC26IMMyVF0CNspT3nTtLOoLpPsqGxEqbUNNl4oOB8uu+q1QSwiLnz7/UngIftCcmjnjfrgZ2Ae6NQMwsvDoVjBYSfg8ze9iYqJhquKFSMAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408505; c=relaxed/simple;
	bh=SHCuv21a0PmkZ3IqzacqlCUqqBfVHT8ztUt3GyP0Xwk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=kJPMPHuVDIcfDbNgStPyTC4xLPtWfdcrRMpcyiSgIVXpwCJsm8PWlVdpnHgiTPkM01oxz+i7Lad9yzhwgGvJH+JlKR5NvFDC/ITM4tTdJqGS83Jcddy4NJNhdvBvA5lJbmqkxfckhazyu9nlDvHcu8WR4OxC3ZEXiFY3lAQc+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VUzcNvxh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0428b537e5so854296766b.3
        for <linux-can@vger.kernel.org>; Tue, 09 Sep 2025 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757408501; x=1758013301; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=THgFqyUU6oBIw9DqIC4fFT0Yw2qcAsNwkmGZMvCJdj0=;
        b=VUzcNvxhoZrp9F7rsT+dnHdJtxcyLZ9l2M2USyzH6zj4HYBdv4PCo8Md5nQSQ0UlfH
         aiEBWzl0zyTwC1qdejmk6uIDBHuB32cw0HxWIh7jdauVpkS4cKjiETHH1VGcTwMfHY9q
         AQtaRMxllP46k7ADRrKoMaoHCLKV3Ls9MEQpNsXv2z+RAgBd94saA7X8C9xcuh7G8jSh
         UpQw4v8IDlA4cmc7pXuFxHiQ5sVhR0Tzsooxvxv9EAfSC8SDUZIXoPdWUrVl73h12vwD
         AU3fqj+hxGU8gUEWcTcIrAjJYeOsDBluJQI4rKkSC5gX9DiJwHH82PIs4EE4OwuOS/eH
         39RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408501; x=1758013301;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THgFqyUU6oBIw9DqIC4fFT0Yw2qcAsNwkmGZMvCJdj0=;
        b=d4ikBexbG0OReJlhoJ0jY3377YzyGZHfCXu5wP21QBD5l7yKuDV/sSiYFqWLykuZTb
         Xf4/amhOYvhPgLaLnKMmUFh7lx+eQ4wWkhsCC8dL0W7xtf4br3GV9GgO9+pHPUIUiemF
         RvwKshlYI5dm08S1e85tx5ZbgPNlXwBOzzSUfvbGlYaQ/Lq2s5CuXZMbKkdYE+RNkrC4
         dIUKL1mvmHHtXk012WwvcrZ9Br+H2EkeGRIQqOetn2pAGscJ51yqLdr7nBBKtqgFHMH0
         H2Jqzsc82xlbn+0RA4NfILKf/flHa3yPLw6JsBCj36EQ+FVrmrTNrbVxXY0jXhWmqL7l
         eNPA==
X-Forwarded-Encrypted: i=1; AJvYcCVpiU0juEVRGZl1D0IQDFx/fbpSclb0NspzFun+cwROtBq/Xe4X9AvtkQn0gm/1UWIgokf6LAYdG08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDo68C6KQ1AABvNlan+OxlF80divReWBcmbReaoZvITJbEIeiu
	mFG8lIxC+gv1kFABSEiuD72Yrrir9U5xjobnSN51GGbFtWQirNp4eikOS3njZMWkcuI=
X-Gm-Gg: ASbGncsF2d5nVMHaJOTZRW3ZIai58KJarf/D3JUPPbaSob2Rqg10WiKxM311dE+OoA7
	mTtBIfjiT/HB1Y0cOG2KMTmEYqRA43I/4Qti8QdOptHlhul/3e6JMAQfAmPBhsZw1VtvfNI5g7+
	CMgqqASoBMfZEVUPv+CbcuXdpS90JiwRwTXRhkrhzbqQJHO2A0FfVW5R/rEHnfmcRDt1f1JYnEX
	ByQXyf35blhTJQXxY467Pa25cNgjqOxYSdEKhuOli+qEc8eouW1oSjJlpz8AvckiT/Y7CIUIwQQ
	zkFMGamTbb8Pggm6KNieDfJzMGuPCtkKckSpz9lhnsdIeIMS0MoSvigRa9dcjKZ5z+tlnMx+od9
	cqL33qKTJHNvHGX4guFPtA99ORw==
X-Google-Smtp-Source: AGHT+IFs9mgyL/udjHjU9D6wDPeoGBJPpea0OrEmcpsbckvBK165wPCTYLCReGQQHbf+rnhXmzr3Dg==
X-Received: by 2002:a17:907:9955:b0:b07:6537:264c with SMTP id a640c23a62f3a-b076537276cmr224609066b.37.1757408499028;
        Tue, 09 Sep 2025 02:01:39 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b04148f95b5sm2222632666b.92.2025.09.09.02.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=8749dbbaa76367b0613af13f6a0ec75df7b6bb443ddc49af7eaba5fedcd3;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 09 Sep 2025 11:01:32 +0200
Message-Id: <DCO5BG5X9CN4.1YYZWJ5FYBLDG@baylibre.com>
Subject: Re: [PATCH v9 1/4] dt-bindings: can: m_can: Add wakeup properties
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Markus Schneider-Pargmann" <msp@baylibre.com>, "Rob Herring"
 <robh@kernel.org>
Cc: "Chandrasekar Ramakrishnan" <rcsekar@samsung.com>, "Marc Kleine-Budde"
 <mkl@pengutronix.de>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Vishal Mahaveer" <vishalm@ti.com>, "Kevin
 Hilman" <khilman@baylibre.com>, "Dhruva Gole" <d-gole@ti.com>, "Sebin
 Francis" <sebin.francis@ti.com>, "Kendall Willis" <k-willis@ti.com>,
 "Akashdeep Kaur" <a-kaur@ti.com>, "Simon Horman" <horms@kernel.org>,
 "Vincent MAILHOL" <mailhol.vincent@wanadoo.fr>,
 <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com> <20250820-topic-mcan-wakeup-source-v6-12-v9-1-0ac13f2ddd67@baylibre.com> <20250822143549.GA3664230-robh@kernel.org> <DCD1YPX4T779.ADK4JCGW1MU7@baylibre.com>
In-Reply-To: <DCD1YPX4T779.ADK4JCGW1MU7@baylibre.com>

--8749dbbaa76367b0613af13f6a0ec75df7b6bb443ddc49af7eaba5fedcd3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Rob,

On Wed Aug 27, 2025 at 10:04 AM CEST, Markus Schneider-Pargmann wrote:
> Hi Rob,
>
> On Fri Aug 22, 2025 at 4:35 PM CEST, Rob Herring wrote:
>> On Wed, Aug 20, 2025 at 02:42:25PM +0200, Markus Schneider-Pargmann wrot=
e:
>>> The pins associated with m_can have to have a special configuration to
>>> be able to wakeup the SoC from some system states. This configuration i=
s
>>> described in the wakeup pinctrl state while the default state describes
>>> the default configuration. Also add the sleep state which is already in
>>> use by some devicetrees.
>>>=20
>>> Also m_can can be a wakeup-source if capable of wakeup.
>>>=20
>>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>>> ---
>>>  .../devicetree/bindings/net/can/bosch,m_can.yaml   | 25 ++++++++++++++=
++++++++
>>>  1 file changed, 25 insertions(+)
>>>=20
>>> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml=
 b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>>> index c4887522e8fe97c3947357b4dbd4ecf20ee8100a..0e00be18a8be681634f2537=
8bb2cdef034dc4e6b 100644
>>> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>>> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>>> @@ -106,6 +106,26 @@ properties:
>>>          maximum: 32
>>>      minItems: 1
>>> =20
>>> +  pinctrl-0:
>>> +    description: Default pinctrl state
>>> +
>>> +  pinctrl-1:
>>> +    description: Can be Sleep or Wakeup pinctrl state
>>> +
>>> +  pinctrl-2:
>>> +    description: Can be Sleep or Wakeup pinctrl state
>>> +
>>> +  pinctrl-names:
>>> +    description:
>>> +      When present should contain at least "default" describing the de=
fault pin
>>> +      states. Other states are "sleep" which describes the pinstate wh=
en
>>> +      sleeping and "wakeup" describing the pins if wakeup is enabled.
>>> +    minItems: 1
>>> +    items:
>>> +      - const: default
>>> +      - const: sleep
>>> +      - const: wakeup
>>
>> This doesn't allow '"default", "wakeup"' which I think you want.
>>
>> "sleep" and "wakeup" seem mutually exclusive and really are just the=20
>> same thing. Both apply to the same mode/state. Whether you can wake from=
=20
>> it is just an additional property (of the state).=20
>>
>> So I think you want:
>>
>> items:
>>   - const: default
>>   - enum: [ sleep, wakeup ]
>>
>>
>> Or you should just drop 'wakeup' and just support wakeup with 'sleep'=20
>> when 'wakeup-source' is present.
>
> Thanks for your feedback. I see they seem to be mutually exclusive, but
> I think they serve different purposes. The sleep state describes the
> pins when sleeping with wakeup disabled. The wakeup state describes the
> pins when sleeping or off and wakeup is enabled.
>
> Only allowing one of the two states or only using the sleep state will
> enable or disable wakeup statically, there is no way to choose one or
> the other.
>
> For my specific setup, the name of a sleep state is also kind of
> misleading. The SoC is in a poweroff state and sensitive to activity on
> the pins configured for wakeup. It is not just sleeping, it will do a
> fresh boot once woken up.=20

Just wanted to ask if this makes sense for you and is OK?

Thanks
Markus

--8749dbbaa76367b0613af13f6a0ec75df7b6bb443ddc49af7eaba5fedcd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaL/s7BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPb
MwEA1AUcXz7Q3hxvU+ALV0paJLOFNCB7ZfOzPKKJXRc4XPIA/jm1qqRlS+1YfbLG
Rx5k/8XUtqoSYSOnxaHZoC2wPKYJ
=mxfq
-----END PGP SIGNATURE-----

--8749dbbaa76367b0613af13f6a0ec75df7b6bb443ddc49af7eaba5fedcd3--

