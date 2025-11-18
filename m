Return-Path: <linux-can+bounces-5498-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9011BC6A0D2
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 15:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 391DC4EF39A
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 14:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03AF341649;
	Tue, 18 Nov 2025 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N6Cf6Br6"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5FF307ACC
	for <linux-can@vger.kernel.org>; Tue, 18 Nov 2025 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475969; cv=none; b=jNrv48f5YLp0jdIRk5ys3ZcuBuryrGL60OXTxL0D/16SxEpaW5h7zf/7rffMx5sQ0XEzeJz8YavwkHj09EE/2J3dnyfyu2HESxVLXwmw+bOx7gbqb8+XtI2xNr1gtk7gZ9f9AuLZLpH+fNAcNJ4uKPAt9IZUzyNMftXlDyUslgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475969; c=relaxed/simple;
	bh=dtSqGWkc1ldKnpUb2C9k4amtBC6lYv94GuNGENLTcDw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QHNBJ8tQsZAcleck6+uA8AZ6Em6/botbF8Kg6FUFncPYt+jdoO9jRPguCc2ooWEnGFJMiAoN4uNFWcwOqKdeFfSZdE8ahdFXaVj1TKJUUmzYa14E6S8cEq6mfgikuWsHQPpisIA5asQN/HsdsN5agih6YNUoZsSUd2F9gMcjc50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N6Cf6Br6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47789cd2083so38523535e9.2
        for <linux-can@vger.kernel.org>; Tue, 18 Nov 2025 06:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763475965; x=1764080765; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6eFSRf/0mUdKLKkQtjEzRCovKGRdnNFa4p+AWg8ohLw=;
        b=N6Cf6Br6mdaTCZAzc0oFZ2gAOjd94OzyPx0R4kQg9gjh9/wAOqpWune6Ab90pu/vu7
         yZyvIjh9uk4uPMtu47saUKpJF/Kel640ffjYUgjThL7dFojaaPdOxwQDqJMIBzLocLOf
         YM3CtatC9QZA2TtrgZC7L4437PvJGyvvX6ctYY/c1vm3nyPVlge0r6LyXCaPGRthyCJ8
         v7NA3IH5cV9mwKeXCKab75mYfENT+J9l4vNPnLue2xAm6ybjaCQmI22Sq2+5Dc8h1WPg
         Kv3HTLXtN3YFMsI3W62kAu6oZdIEhM43k3I4NYxlaAm5iT/Hw+CG2lZ/Ilhj43zF/537
         brzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763475965; x=1764080765;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eFSRf/0mUdKLKkQtjEzRCovKGRdnNFa4p+AWg8ohLw=;
        b=bG4bqTSgpP11rEuvJI7K3Agsactgb/L+3k/5Dp/er8aL79iqovY5uegivWX1Nm6n5h
         z76IjGkU6H6zlitBIEybx4+uYvbd+8shss4rOiAoIzxf/NldVqE/Hwlmss8NdbrKj8vd
         mMeHGKu38hkOW+F/V2LnSfUJYgm6zdngJ74fcOro1gUXonaaZVQzeic+lFy16j9KcKic
         rG6oPe22mJP7MLcm25MvpvHGolGkZogI7loaThyt7OKSqIsXvwaHGKYaX1U1qVzAJ7hz
         45M95AjBDEmvNRQ6mOo45uVGuUM8Djfnf6mC3x0MisDPEUdGGMRmvBtQ9YALVsEoUc1+
         OjZA==
X-Forwarded-Encrypted: i=1; AJvYcCUqtT8dWmmUQReFMuO7k6tcAHg7ZUn43I04ucHK+IQDM+EPebiANBwPWhFGGaSPHgfMTLGX5awpbkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyntDvhRGiQkE9QRwx9OnADDO1AHG3L/L1krjJHfOKDHs3voqiN
	THznowSsDA/ndAA8YD4Dq1AXhrS+Kb84WKMbgW2v7NfYPC71nmiwr4EQ1rSrK57jrxU=
X-Gm-Gg: ASbGncsbRZeZHVlJylFgx3Hpt3GHl5dQyiN/ObB7hdzF8VDXrIGq9dwKI2Q4ku34m6O
	wiLW8tb6XWYVWzWWnTNYjBJzDJ7nhBkSPCTtD8p+2GzNDokQdrZuQHuTn7jaNZKaOF6e+yNgHLr
	aRMtRweJZqtiD3p6vmnNBI0we5sn6qNifObJzo+23nP5cJ/v2Qk4DasKkf7g2CmV55PMQOmeJBy
	NJFS39rYy9tyJ0/PxlgVxYH9VL3VIAgXwvUQfMRUwA5y4YxCmZKMfzl5v4PSHY+r4MFrjDqIKTO
	vC62dx0SdwmFRqmfQe4L+jqoyoCPHSRYK8VBDPG1A+ZakX2RA5sEqNSXu6FWTpL59gcTT7EQ+ME
	RgFwx9p34IWOKPGnQFtdWuDh3/JVxJh0S68QDiEa8t8hPU2ewbD8KYqR6Sr9pw8+79JP/IR7A8D
	0dlZbh
X-Google-Smtp-Source: AGHT+IG6x/lhK+h5GasR1mA9rEpN12PdK10sIRGdHQM9KNZCS+hGxybPvmTIla/49tFBusYMBKM3uA==
X-Received: by 2002:a05:600c:1f12:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-4778fe9b250mr147607805e9.20.1763475964709;
        Tue, 18 Nov 2025 06:26:04 -0800 (PST)
Received: from localhost ([62.246.248.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779d722bc5sm191235735e9.2.2025.11.18.06.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 06:26:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=4ee8043362d364b1fe436053fe1886ae328261158bc2d2b8a53591aebd05;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 18 Nov 2025 15:25:58 +0100
Message-Id: <DEBW1ZAX5AHE.319VIBB6A654P@baylibre.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, <linux-can@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add myself as m_can reviewer
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>, "Chandrasekar Ramakrishnan" <rcsekar@samsung.com>
X-Mailer: aerc 0.21.0
References: <20251022-topic-mcan-reviewer-v6-18-v1-1-885ec5e43493@baylibre.com> <20251022-lorikeet-of-fortunate-plenty-43e085-mkl@pengutronix.de> <20251116-rustling-tapir-of-health-03361a-mkl@pengutronix.de>
In-Reply-To: <20251116-rustling-tapir-of-health-03361a-mkl@pengutronix.de>

--4ee8043362d364b1fe436053fe1886ae328261158bc2d2b8a53591aebd05
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Marc,

On Sun Nov 16, 2025 at 5:09 PM CET, Marc Kleine-Budde wrote:
> Hello Chandrasekar,
>
> On 22.10.2025 19:46:47, Marc Kleine-Budde wrote:
>> Hello Chandrasekar,
>>
>> I've seen not much review feedback from you....
>>
>> On 22.10.2025 11:10:09, Markus Schneider-Pargmann wrote:
>> > As I have contributed to the m_can driver over the past years, I would
>> > like to continue reviewing new patches.
>> >
>> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> > ---
>> >  MAINTAINERS | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 46126ce2f968e4f9260263f1574ee29f5ff0de1c..835dfe1a16c975fb3ab46b=
c7ed736cde61ec0bf5 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -15394,6 +15394,7 @@ F:	drivers/net/phy/mxl-gpy.c
>> >
>> >  MCAN MMIO DEVICE DRIVER
>> >  M:	Chandrasekar Ramakrishnan <rcsekar@samsung.com>
>> > +R:	Markus Schneider-Pargmann <msp@baylibre.com>
>>
>> ...Maybe you want to give the maintainer hat to Markus?
>
> Since I haven't heard from you, I'll pass the maintainer hat on to
> Markus if he wants to take it over.
>
> Markus, what do you think?

Yes, I would like to take over, thanks. I will send a patch later.

Best
Markus

--4ee8043362d364b1fe436053fe1886ae328261158bc2d2b8a53591aebd05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaRyB9hsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlN1
TQD+MBSpggicm+2fg2LGb8X6UDvrS+TopTtInG7gDq8UP8cBAOzj40u751c9npgC
ZIIqHTpyQW3Vz7gXWsYTA99aHugG
=Nidz
-----END PGP SIGNATURE-----

--4ee8043362d364b1fe436053fe1886ae328261158bc2d2b8a53591aebd05--

