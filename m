Return-Path: <linux-can+bounces-4380-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1164B37CDA
	for <lists+linux-can@lfdr.de>; Wed, 27 Aug 2025 10:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029C35E6FF7
	for <lists+linux-can@lfdr.de>; Wed, 27 Aug 2025 08:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DA732145C;
	Wed, 27 Aug 2025 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fDMVk27s"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BEE32A3FD
	for <linux-can@vger.kernel.org>; Wed, 27 Aug 2025 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281897; cv=none; b=CuW1D7A0PkIFcCAfldOXTpRBSjIJb1RoLilmjq6p34Ls+zKyjR1HrGBQvt1aWEXvGD+ZMXrFuVqJ6463DsMFFF/rn+N24ZB0kFSmJRJ/wHgpoaC8vzQ7SlkRiwUPbiMYXMOqGP1+l3uaPzhPnCN5X/anV/h+/ebpkzr3xB162ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281897; c=relaxed/simple;
	bh=g+KW9TEeVGqYphEisf/ETPbXzv+fd0lBq6e6n0plR/M=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=aukj5UIIAkDjECafrBjsWU6q6tV9PRiQsT7uKuuthDQL5fHATctKlcwzW52NvVNHuqZcPMeCffq6L/9MJvD8SdCeZ0ag54DYqAGKKg14S5xBSWuAGl5uhDLvogo35sw/1dwlY3SATiW1OpYuI0x1IBazep7RHf2olNjxUDoBcIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fDMVk27s; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61c3360bbaeso5311277a12.1
        for <linux-can@vger.kernel.org>; Wed, 27 Aug 2025 01:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756281893; x=1756886693; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o38urx3Y5liCjRZycGC30h3AxkEKhcqPAFepRrs3ec0=;
        b=fDMVk27sioxSQfUj+NERtZPfo0GlsETGlORLyy3ZT+lzjJ+z7XeF8r4tSxc0W5mxVb
         bR1216Db1cFXjPU5M+QfdPo42l5ADMzwKKtiJSdV6Fzzs7dsUwQ2krYvIYga30Mke6pJ
         g/Ua8WLE5hc34IjEPCvocqcCgC0bkFTVsmDc65dVV3mPsBGaT+9RvfqapaXrOncOp27b
         HtG1x7KsEuupa8heo31rfFHSHwaCO4TXQAHNi3x7A0UQYPGE2cXCGG6xDS51QUFul2yn
         T+zhWRtcrR5mDXVvKWIl9r0pVwu9/G2MdYTgH/5kGxriNy196EG+AssHwdv9TkZkmC1v
         JeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756281893; x=1756886693;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o38urx3Y5liCjRZycGC30h3AxkEKhcqPAFepRrs3ec0=;
        b=fvZsvAWzTrFQLJqoijSsVsS2XUJbhennwiMQWfkLqB8qncgaWoZeD+P1Paj5VdiCUd
         68DQhCFoh9K5lKE6aWtjjwfG9r4TLbgb0LztKyM+zavHhsVqUcYEJlHO+QIpVhQ5+Vud
         748H7F7rL7JVaSkapWXeBwNHglQniTBdj7gSt0oA/p9Y6/XdP+cg+FiZr6144QW4dH25
         nuPtB1rdpcggNW8Iw9SyfjtKNupNkfviizN4vFRRXcMnOuWaplU6hM5gNB9yPgpQlgFo
         /1Nn7tbbOXC7sjns/2QxP7mqyhjJ5+1QH3liUJaNOm/hwxANAdyhs3SO80ZuYF0fs+6K
         8nuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYE+aiG0meDD4rDL9ldVMECwhswZa/HfO8hPOUPEcEk3nZaw8h0JZQDP+UeT7AmB8jbRLjyaFUgj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWWi5V7COK4DIOJHiZnY4DW4Z4HgCuk1Qu7dSyGaemQWcXpWhN
	xvyAw3Muv9xmCTtlrYeJhpKFoXYQvxY0LyEJU9keiRfrfS9f4mio3gZKfXbm2EY6Ak8=
X-Gm-Gg: ASbGnctcPTlFzuCuOaOzNbtw/dh7OaYMeCbtkpBbX01OeLffaeOWq0B7JN4UME6jWwH
	F1m6hK4edTvcNs4L95FdFQ/00aN2Lvgj1XxdilisgKP5l4WJwRuodMJd0IGMQCJkQiMtm4OzAmA
	GBkubOUc34LIQmPEXvTk+NjcRgIEJCNVr6zBMV7IHX34uk21o85t2lR9xuh9VAiY6Gb02srzIft
	OVItYOCP7igsLboR6uxGu6sYmmzvpGguSn/WSAgGGsdUiuspGJF/BcrgX7U9ayVlDmNlYl+zUK+
	E8r25ZotPztlnipNfpDesUWHICVrvCHT3EhAUzjBGcDypbDTFXO9/EKoyhj4Osz5B1qe1VOdfSb
	RGDot1oHOt5ZMI/Zn2LAH4yyJmmEvnk3gQXJeZC3ouI8cWxMi
X-Google-Smtp-Source: AGHT+IHAZruNO8PxiQDS6YA+oxemi3oPab4ygrNWQ7snhZ/72+NK1dE4fWGZyqEZWKw8iTnURGRP8A==
X-Received: by 2002:a17:907:6096:b0:afe:7d3b:8463 with SMTP id a640c23a62f3a-afe7d4ace6fmr1003276666b.62.1756281892878;
        Wed, 27 Aug 2025 01:04:52 -0700 (PDT)
Received: from localhost (83-97-14-186.biz.kpn.net. [83.97.14.186])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afeaf41dc6fsm283102066b.18.2025.08.27.01.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 01:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=41c8a4c6eaeda649630e38b4e0028da409cd67aaf3a4c32373d96e5bca68;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 27 Aug 2025 10:04:32 +0200
Message-Id: <DCD1YPX4T779.ADK4JCGW1MU7@baylibre.com>
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Rob Herring" <robh@kernel.org>
Cc: "Chandrasekar Ramakrishnan" <rcsekar@samsung.com>, "Marc Kleine-Budde"
 <mkl@pengutronix.de>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Vishal Mahaveer" <vishalm@ti.com>, "Kevin
 Hilman" <khilman@baylibre.com>, "Dhruva Gole" <d-gole@ti.com>, "Sebin
 Francis" <sebin.francis@ti.com>, "Kendall Willis" <k-willis@ti.com>,
 "Akashdeep Kaur" <a-kaur@ti.com>, "Simon Horman" <horms@kernel.org>,
 "Vincent MAILHOL" <mailhol.vincent@wanadoo.fr>,
 <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 1/4] dt-bindings: can: m_can: Add wakeup properties
X-Mailer: aerc 0.20.1
References: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com> <20250820-topic-mcan-wakeup-source-v6-12-v9-1-0ac13f2ddd67@baylibre.com> <20250822143549.GA3664230-robh@kernel.org>
In-Reply-To: <20250822143549.GA3664230-robh@kernel.org>

--41c8a4c6eaeda649630e38b4e0028da409cd67aaf3a4c32373d96e5bca68
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Rob,

On Fri Aug 22, 2025 at 4:35 PM CEST, Rob Herring wrote:
> On Wed, Aug 20, 2025 at 02:42:25PM +0200, Markus Schneider-Pargmann wrote=
:
>> The pins associated with m_can have to have a special configuration to
>> be able to wakeup the SoC from some system states. This configuration is
>> described in the wakeup pinctrl state while the default state describes
>> the default configuration. Also add the sleep state which is already in
>> use by some devicetrees.
>>=20
>> Also m_can can be a wakeup-source if capable of wakeup.
>>=20
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> ---
>>  .../devicetree/bindings/net/can/bosch,m_can.yaml   | 25 +++++++++++++++=
+++++++
>>  1 file changed, 25 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml =
b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>> index c4887522e8fe97c3947357b4dbd4ecf20ee8100a..0e00be18a8be681634f25378=
bb2cdef034dc4e6b 100644
>> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>> @@ -106,6 +106,26 @@ properties:
>>          maximum: 32
>>      minItems: 1
>> =20
>> +  pinctrl-0:
>> +    description: Default pinctrl state
>> +
>> +  pinctrl-1:
>> +    description: Can be Sleep or Wakeup pinctrl state
>> +
>> +  pinctrl-2:
>> +    description: Can be Sleep or Wakeup pinctrl state
>> +
>> +  pinctrl-names:
>> +    description:
>> +      When present should contain at least "default" describing the def=
ault pin
>> +      states. Other states are "sleep" which describes the pinstate whe=
n
>> +      sleeping and "wakeup" describing the pins if wakeup is enabled.
>> +    minItems: 1
>> +    items:
>> +      - const: default
>> +      - const: sleep
>> +      - const: wakeup
>
> This doesn't allow '"default", "wakeup"' which I think you want.
>
> "sleep" and "wakeup" seem mutually exclusive and really are just the=20
> same thing. Both apply to the same mode/state. Whether you can wake from=
=20
> it is just an additional property (of the state).=20
>
> So I think you want:
>
> items:
>   - const: default
>   - enum: [ sleep, wakeup ]
>
>
> Or you should just drop 'wakeup' and just support wakeup with 'sleep'=20
> when 'wakeup-source' is present.

Thanks for your feedback. I see they seem to be mutually exclusive, but
I think they serve different purposes. The sleep state describes the
pins when sleeping with wakeup disabled. The wakeup state describes the
pins when sleeping or off and wakeup is enabled.

Only allowing one of the two states or only using the sleep state will
enable or disable wakeup statically, there is no way to choose one or
the other.

For my specific setup, the name of a sleep state is also kind of
misleading. The SoC is in a poweroff state and sensitive to activity on
the pins configured for wakeup. It is not just sleeping, it will do a
fresh boot once woken up.=20

Best
Markus

--41c8a4c6eaeda649630e38b4e0028da409cd67aaf3a4c32373d96e5bca68
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaK68EhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlN4
dwEAmJszUShVvXfS2LCmLmEu7BZUsJ2zzz7SGnnInFEs3FEBAOcxPEuvnj7hWYdH
3c/Loa6iaWxbVEoBV2+H35Z3algJ
=jiEZ
-----END PGP SIGNATURE-----

--41c8a4c6eaeda649630e38b4e0028da409cd67aaf3a4c32373d96e5bca68--

