Return-Path: <linux-can+bounces-4255-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F9CB293B4
	for <lists+linux-can@lfdr.de>; Sun, 17 Aug 2025 17:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED8C34E10E0
	for <lists+linux-can@lfdr.de>; Sun, 17 Aug 2025 15:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA2415C15F;
	Sun, 17 Aug 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB4IwwrV"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4BD29B0;
	Sun, 17 Aug 2025 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755442925; cv=none; b=KwDzG2Lxa7sF/PWMUbqFWP01yFOUN9H8ERlyggS5DmzcwbIVM8FQC544puvQeBxwMLoAirPpI28aZAw6emPWeyaobTvpwvUX47BnGq2AcKIIsAS0iRIU0mDhJ44andYOQuB1L9umpsF0t7E/NjoxwQhUbczwq0r7B8EGGmftYxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755442925; c=relaxed/simple;
	bh=qagc0OpqwUzPrnoUD6f6TtA3Bomgc1rdbnKs4XOQJ38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJwNiylVdv9sI8DTFIVVxNueT1VmwV548K2jc2C6ZtULeKmwvLiAhJv6A3wAVQSVTWhj3Kax0GnI7EkPw84uBl6Q+QIo00G1ahJz5876SKTnrLGaVIq+zblj5C8X9uNu53BkDQuFKLkqAu2tRYmcnP9gmm3mKYqbMi15Cl6ex9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB4IwwrV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9e7437908so3487451f8f.3;
        Sun, 17 Aug 2025 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755442922; x=1756047722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0+wXNypPm/jjYIXszVkPMU2fiSMirBXbYuD96ca0Vk=;
        b=EB4IwwrVg7996PlDuJ+IqODbP9TsZ7a+BmHlDGfvMskYbcxsN43MCXSALysZP0lPBL
         5yosYVkyjyraaN+KLWxYXwQNLR0tcmjJVRchCKTC12lCgVMzvTDrZ1EtklWtQKLudC4A
         aw9bS2YEfQSTN+VM63wVDbHtEqZUBlnOnkKY1PYXVIyGgnTq8bFW/O58Nds8/VN7oC17
         bsGCUEipZv/waVUuV4XpfU2CCEOOPOxrYeX8AWTS85/kuCsoYE6sAD7+kQx35Oj+x0dy
         kiT/awhBlA+uLHLaNsUkrxDqkSv9O9j52qLds2yl6B1g1cWFjlHx7q8bAFNF82mP8ux4
         QrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755442922; x=1756047722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0+wXNypPm/jjYIXszVkPMU2fiSMirBXbYuD96ca0Vk=;
        b=C17FRHNK1t9S5trdBfrThqRiYccAHhoiXaMdYxGXxfyna/JPdUw8x77er2H4RoBnAf
         bqgSaa+kXXiZLko4FfNG/j2mYL61B4UcGBIHJz6rEcq24GpxSzKnsyctnDK3Yt+bOXAn
         mSypXHCT5Qv7/Qg1YuAOkr9iHk9zJwgaejJpbEmJ19RwdSBQICOvuZZ+uuxg7GbTvK7y
         G1/MpYNGe+XBw7RtzfCSQ29RmvVJuzYclmzU32ERCf9mmEZy3r29naF1gUcwIk5q/2AY
         CTLvTrFuqXaO1l0RlPqdpAmDE1HYH3KoUxqBGc7uvuEdmxlt4Ty0fKog9HvMpyyJW0sU
         0DIA==
X-Forwarded-Encrypted: i=1; AJvYcCW1ULIe2Dl4RDwKD4rpRVxd76KylT1WX7kXWQgWgtLYh5y6IXutN8hjVw8yIVPSQ+T1nxzSa6T9qt4=@vger.kernel.org, AJvYcCXe1w67o458TkERNm8/7hiEtGNP59zIpFnl/UrVNG1UXLneuj50gK0K+jyMUf1KepBKQtTrMtYA@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQeQiBMCe4bMej0IMM1kR5UscCxxUS4CzsyRjoW/XFdkNVeX9
	envht8CYmhzZ0A3mwhK2SYRG9dtpPvQW4aEPC7v4a4ljp4dBd/3lyYiI
X-Gm-Gg: ASbGncsPo+0ah2CmI0zRgWvQN+HYr651N+4y1N6g2+eKJpk8CZJZb7gcgJuudd/nNj3
	/Ngv2gh55xKQ1I8qm9x5GkQ9aA+T2YEff6pYTs+F1C9BzReg3m5rnh359s8D4AD/iY09l7HwdgL
	gtGKSfWsKlPU0mMsHZHiMaBppqeM0WYigBrWROCaU/ElEYVQw+7dfXiwFI0DHwc1YkdY0dTnwCM
	YyQ7CnRmoVpHXmle7UpUoce0DHYmXjVoUx3O2HleiMdt9xENr/14bJbyAbYZQzPC/NkyBOZs4NX
	j0ffirebejd42Vm8Ww5a8N71kOMZaOn1VE0EzBgvSgBV8c5OCm4opBZnXpbUMeSL/GpbYinTd6i
	adNO+gmpoAL4yhvKXskMllDdvnl8IyywzgKE7jQORTZ1d1I5jl14XJJAVZr6i
X-Google-Smtp-Source: AGHT+IEQ5vGNjDKw/FMeH2tWklD/UbfDoFhOhBQHtlgDzf47wYWeVe/EdLz8oKAljKkaIjI2FC0Vvw==
X-Received: by 2002:a05:6000:4382:b0:3b7:859d:d62b with SMTP id ffacd0b85a97d-3bc6800f468mr4114300f8f.8.1755442921458;
        Sun, 17 Aug 2025 08:02:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6863d9a4sm9555204f8f.61.2025.08.17.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 08:02:01 -0700 (PDT)
Date: Sun, 17 Aug 2025 16:02:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefan =?UTF-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "mkl@pengutronix.de" <mkl@pengutronix.de>, Frank Jungclaus
 <frank.jungclaus@esd.eu>, "mailhol.vincent@wanadoo.fr"
 <mailhol.vincent@wanadoo.fr>, socketcan <socketcan@esd.eu>,
 "horms@kernel.org" <horms@kernel.org>, "socketcan@hartkopp.net"
 <socketcan@hartkopp.net>, "olivier@sobrie.be" <olivier@sobrie.be>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/6] can: esd_usb: Fix possible calls to kfree() with
 NULL
Message-ID: <20250817160200.76467a18@pumpkin>
In-Reply-To: <9e30abd4fe42b56158debde0caf71ebac89cc8cb.camel@esd.eu>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
	<20250811210611.3233202-2-stefan.maetje@esd.eu>
	<ee619a2d-a39d-4f48-ba18-07d4d9ef427e@linux.dev>
	<9e30abd4fe42b56158debde0caf71ebac89cc8cb.camel@esd.eu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Aug 2025 14:57:44 +0000
Stefan M=C3=A4tje <stefan.maetje@esd.eu> wrote:

> Am Dienstag, dem 12.08.2025 um 13:33 +0100 schrieb Vadim Fedorenko:
> > On 11/08/2025 22:06, Stefan M=C3=83=C2=A4tje wrote: =20
> > > In esd_usb_start() kfree() is called with the msg variable even if the
> > > allocation of *msg failed. =20
> >=20
> > But kfree() works fine with NULL pointers, have you seen any real issues
> > with this code? =20
>=20
> Hello Vadim,
>=20
> I've not seen real problems with this code. And when I posted the patch I
> knew that kfree() can cope with NULL pointers. But in any case calling a
> *free() function with a NULL pointer sends shivers over my spine and I
> want to avoid to stumble over this again and again.

The only time it is worth the check in the caller is the case where it
is normal for the pointer to be NULL.

But for an error exit it is safer to have one exit path that tidies everyth=
ing
up rather than lots of them where there is the opportunity to exit via the
wrong one.

	David

