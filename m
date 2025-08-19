Return-Path: <linux-can+bounces-4261-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB0EB2BAB4
	for <lists+linux-can@lfdr.de>; Tue, 19 Aug 2025 09:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE85188799D
	for <lists+linux-can@lfdr.de>; Tue, 19 Aug 2025 07:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CFD22D9F7;
	Tue, 19 Aug 2025 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fF2q3ZpC"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E3D1CAA79
	for <linux-can@vger.kernel.org>; Tue, 19 Aug 2025 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588557; cv=none; b=R9qk/qfMeKWtTucmmNNH/McwaVeqL3Eqv3D9jQP7b5MV9cKRHFn/5/hqm/Xp68Rjw0dY5t3OtyQ/T84kCT+NI1gMwv31N1oNRpADX2SQzxJzZ7eI3JS71U8O4BKFJTJVysaBrYCauyt+NlK1PtZiWyAHWP2Z9s8R/uUxxx19aFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588557; c=relaxed/simple;
	bh=m1aYf3xZAZVvz4CxnxX2rny5oQi/QetklYuiYkrwR7I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=gNq8/56LGIRcU9UFALv//Juwv8Uk/Bq1hr3wVGEVAY+ZRIEUnvyIu/qqP3SlRLqaSCPNhDZnXRQEly3CgOeMFDNpt/PQI2nauGjcSmmAbA4KrxG9oXtsC67gXyHFp3SRkvEw49+Om/4FwBXxVBkR45YFagneEs+k8BsdvAgUgl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fF2q3ZpC; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61a1663bd7dso3809091a12.1
        for <linux-can@vger.kernel.org>; Tue, 19 Aug 2025 00:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755588554; x=1756193354; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O9ZFTd8tc9t9Q9OjuU9qYv3SoRwzk7BH/sXXxyKX4kU=;
        b=fF2q3ZpCq8weP7+x1oEF7k2TI73n+07WkIeZdiF1gLXBidJgDNt0b9a0WuMF7u9f5M
         QEe5Is7Sn2JtvxvZN9nodhh7Pi8WOnVWfc3pBac3eX6cBGPUwMlwZFJCCdbgkeKG5k45
         uyYdcoZNmOZZ1dXJlA8EMG/WmKX9HViSUNuEMylDRxhyCDw0N8W5y/QWdZDy7mEj6g/g
         CnBhJwQmbZSrEYazk8bJDy1JgdIjgGfDoHCkXdngB2FQDmLlD85XFXzw0WsD2buwVWJg
         JNqBzLeALxux22f4jybxIcmglEU6HuEpjB6RgAoNPBmTL4k0x6AvMofCR6z2v/pBChVy
         gENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588554; x=1756193354;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9ZFTd8tc9t9Q9OjuU9qYv3SoRwzk7BH/sXXxyKX4kU=;
        b=g47V1vXSqDMhuL4vuYyZAeDh/4TgwY1tNMmTUPexMLAxUXvpf3pyEeGjjrp0mrgqyl
         sDDascM78ECYSxtZ4dlf2b1sYg8T6ot3MOn+W8GvEocvRL2MWAy4PUj6scOrfH6TTv41
         Fw+fmybHBTcEMNUC5HFn0A68zn0u2OGOslcKIKrikr4iVovZVpabURhb0PqyYBZkIJ1/
         c/rov114eNBEbG5OG1DrdXKUx4gYjPYwElcRuJgdZ3ggCwo+ansuVMYsQVUfrv5l4dfj
         4uRtVHUj7gXqhP3FmQPD0L0jH3nWZGnWr5OB2M31S34GQSl01WXqU138yLWA2UHY+YNo
         u91Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuAkWwaXGeclLCqEVje1DjZbhj2+BCnVsGDXyk4AuY2ygxx7/2S5f7iSX7VmBmUG7Pk9cLBX2+jf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMr+GuUsFpn+HcuHkblzkUqzuE5IMCF9A9dI5o3WlfJGcQEsMb
	AEa2BEXgR4+IA6bxqSBYcMltEB9wqV29tt72foOWa2yo30DNGXUda6MjjstvUMJA2qk=
X-Gm-Gg: ASbGncu0mnVjrLKIYWcv6Z5Pibao8Cs42H0wBNBebZaqPxAllFwC7y+bc/P0xmuLU5Q
	fk7xsfdKuD17r6e6fnxTffAB5KgATVrmYg70Bkbk6Z0Um+dLKRwO9Q8wncqi3Zuf+B9rlM3U0KW
	9wgmaqDFoJ6i+YetoORHge+rdAPPSgda5durw3VVJl2z6YHZ7NWOLQ7kJ9hZUH3ZGPyUm3Byn8x
	1OqmQDENzVrAR44EM2L2UgnbhEsN6rhB8Bq0rCJSs+q4/4RY8o76nmYJhaXhtRUezfzUJxwCuM+
	5Y7JYP2eUs4xiVrF+U0tzYmiBd/TCmMCN7z+TTO3i8gP1wPio+APlje5ArppniPQ7kGE4eq0Blx
	W3jN2eo6j9ubeJQ==
X-Google-Smtp-Source: AGHT+IE9wLYwAW2XtUVFFG4Q3+Y1T5+7hm1Q9Ud5QfsQac1N+Q9TsAULmLjg/st6avEy4koFeXHX4A==
X-Received: by 2002:a05:6402:440a:b0:608:f493:871c with SMTP id 4fb4d7f45d1cf-61a7e6e082fmr1337394a12.14.1755588554037;
        Tue, 19 Aug 2025 00:29:14 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61a755d9d26sm1201899a12.10.2025.08.19.00.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 00:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e73662955d5075bedea110cf04232664a8d147c373d1a0aa2f0fc2ec91d6;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 19 Aug 2025 09:29:02 +0200
Message-Id: <DC6876NJBA2V.3OEXXYEA6Z9TK@baylibre.com>
Subject: Re: [PATCH v8 1/4] dt-bindings: can: m_can: Add wakeup properties
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Markus Schneider-Pargmann" <msp@baylibre.com>, "Marc Kleine-Budde"
 <mkl@pengutronix.de>
Cc: "Chandrasekar Ramakrishnan" <rcsekar@samsung.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Vishal Mahaveer" <vishalm@ti.com>, "Kevin
 Hilman" <khilman@baylibre.com>, "Dhruva Gole" <d-gole@ti.com>, "Sebin
 Francis" <sebin.francis@ti.com>, "Kendall Willis" <k-willis@ti.com>,
 "Akashdeep Kaur" <a-kaur@ti.com>, "Simon Horman" <horms@kernel.org>,
 "Vincent MAILHOL" <mailhol.vincent@wanadoo.fr>,
 <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com> <20250812-topic-mcan-wakeup-source-v6-12-v8-1-6972a810d63b@baylibre.com> <20250813-energetic-hare-of-pizza-6ad6df-mkl@pengutronix.de> <DC680MA7LMN0.33Q95D1CT5TVK@baylibre.com>
In-Reply-To: <DC680MA7LMN0.33Q95D1CT5TVK@baylibre.com>

--e73662955d5075bedea110cf04232664a8d147c373d1a0aa2f0fc2ec91d6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Aug 19, 2025 at 9:20 AM CEST, Markus Schneider-Pargmann wrote:
> Hi,
>
> On Wed Aug 13, 2025 at 9:23 AM CEST, Marc Kleine-Budde wrote:
>> On 12.08.2025 11:10:22, Markus Schneider-Pargmann wrote:
>>> The pins associated with m_can have to have a special configuration to
>>> be able to wakeup the SoC from some system states. This configuration i=
s
>>> described in the wakeup pinctrl state while the default state describes
>>> the default configuration.
>>>=20
>>> Also m_can can be a wakeup-source if capable of wakeup.
>>>=20
>>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>>> ---
>>>  .../devicetree/bindings/net/can/bosch,m_can.yaml   | 22 ++++++++++++++=
++++++++
>>>  1 file changed, 22 insertions(+)
>>>=20
>>> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml=
 b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>>> index c4887522e8fe97c3947357b4dbd4ecf20ee8100a..ecba8783198fc1658fcc236=
d8aa3c89d8c90abbd 100644
>>> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>>> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
>>> @@ -106,6 +106,22 @@ properties:
>>>          maximum: 32
>>>      minItems: 1
>>> =20
>>> +  pinctrl-0:
>>> +    description: Default pinctrl state
>>> +
>>> +  pinctrl-1:
>>> +    description: Wakeup pinctrl state
>>> +
>>> +  pinctrl-names:
>>> +    description:
>>> +      When present should contain at least "default" describing the de=
fault pin
>>> +      states. The second state called "wakeup" describes the pins in t=
heir
>>> +      wakeup configuration required to exit sleep states.
>>> +    minItems: 1
>>> +    items:
>>> +      - const: default
>>> +      - const: wakeup
>>> +
>>
>> This breaks at least the stm32mp15 SoCs that define a sleep state:
>>
>> &m_can1 {
>> 	resets =3D <&rcc FDCAN_R>;
>> 	pinctrl-names =3D "default", "sleep";
>> 	pinctrl-0 =3D <&m_can1_pins_b>;
>> 	pinctrl-1 =3D <&m_can1_sleep_pins_b>;
>> 	status =3D "okay";
>> };
>
> I am struggling to find binding documentation that explicitly lists
> this sleep pinctrl state. So what is the intended purpose here? Also the
> driver does nothing with this at the moment right?
>
> I mean I can also add a sleep state to the binding or just leave the
> binding empty so it can be anything, but that feels wrong.

Sorry, I missed the sleep use in the driver, will add it to the binding. I =
am
wondering why it wasn't in the binding before.

Thanks!

Best
Markus

>
> Best
> Markus
>
>>
>>>    power-domains:
>>>      description:
>>>        Power domain provider node and an args specifier containing
>>> @@ -122,6 +138,12 @@ properties:
>>>      minItems: 1
>>>      maxItems: 2
>>> =20
>>> +  wakeup-source:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    description:
>>> +      List of phandles to system idle states in which mcan can wakeup =
the system.
>>> +
>>> +
>>
>> One newline should be enough.
>>
>>>  required:
>>>    - compatible
>>>    - reg
>>>=20
>>> --=20
>>> 2.50.1
>>>=20
>>>=20
>>>=20
>>
>> Marc


--e73662955d5075bedea110cf04232664a8d147c373d1a0aa2f0fc2ec91d6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaKQnvxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPP
rAEAix0I/gCgDfYKzMJnmHATT2WVT1En56x9X5XEKWTKVuEBAMYebehnEGgV7WUd
4T8g6EWORqZoNeTDer5yG3A2eCEI
=Ol5u
-----END PGP SIGNATURE-----

--e73662955d5075bedea110cf04232664a8d147c373d1a0aa2f0fc2ec91d6--

