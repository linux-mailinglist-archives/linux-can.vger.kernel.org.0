Return-Path: <linux-can+bounces-5261-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DF8BF82BE
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 20:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D93423F2A
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 18:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077EF34B18F;
	Tue, 21 Oct 2025 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Uc6eMg/z"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD43303A06
	for <linux-can@vger.kernel.org>; Tue, 21 Oct 2025 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072975; cv=none; b=XTyZcPyT9Dylrjx92cH2sXfOB8KjcRyjLw8ekkSmgGNK5HFSz1jk2zUKDdZCuAUZOYVVettnZ8q6Wu9U4jau64EySJhuyPDbjykufdAlOf09ypdbetIC4EnBImv8LybqqyQOh5kYsGTcK/DqsNCRK3o8BvhXTzZJ5MMUBIKyjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072975; c=relaxed/simple;
	bh=iJqLIFVdRqsAJ9nTQozNmtTq5rkisBXmJuWmzMEKJUk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nNVwR1BvKo904Yy9MjLoUkpl35tsGZYvXNPyYFkQIdqh1+lFBajJ0ceJdtgiJE55I32fNiigJKi4fmRr3Uq1W79CFH3V/6lU8U2htPeLswBvS0PTS0hop6EMt4FxtNna07BKjIblXlxiU5D/Mw6/WXDdp+taMQ2EiG9veKk5YfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Uc6eMg/z; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-421851bcb25so3533145f8f.2
        for <linux-can@vger.kernel.org>; Tue, 21 Oct 2025 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761072972; x=1761677772; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iJqLIFVdRqsAJ9nTQozNmtTq5rkisBXmJuWmzMEKJUk=;
        b=Uc6eMg/zUQ1W0PIiMFV4VrLKuQVpJwpqv3AcnhrLHppDH8MVBJxk+S9RjFAWYCFYoE
         gSHyBB0IQ1jjtaaQCKjBwbybiu+nwiYkguQSM5Yy7muwIzEVbFC2xOhir7e8XJ/d3hSA
         EAEH/uJeyPuGliTC7A07J0yvx89BOlU2bk/iTwSPvKwUkh06YfqlknrDl7aqVsQc1T9b
         PeX7c6KMlAIdSBkx7bIrbQz8u7M79kyfc8opLX1uBLT1stBR8Q8st9U+ablybebRg+AY
         blsCinHHvBWYdHKrZyTTm1M2k6W/W2fsQbbH0KcNcqp68OYVToKpWUZ/XeCAXJ5Q4FgB
         bsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761072972; x=1761677772;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJqLIFVdRqsAJ9nTQozNmtTq5rkisBXmJuWmzMEKJUk=;
        b=gHLrjP9AUtbXogZuo7cuC0YOy9d1NmhTMj/qolT7Wub9WzDDfuID77jeQ6GRNbMnOr
         qc1FBXuAaAX3VdyvldYVs/cmIPJP0YtjzhGyfr8sVv+ieqBsc+It6jAJdIZWnks8ILDT
         QBWs/r4tHxGRP0EdG+a9D5pofdETGueQGrISQSIypaW6PB8aeVOz23zc1YkpHYUM7F0W
         Wdm5s48W0VI4MfVBnVdQVKMjSr0JjwoXL+FSRLBiiAVtUEp+8PjTv7D1iB7dPLRuYCRg
         KL66ZcdKYBllJV6ykgUuuHUVNzNejdmRSagqc+a/uq3cgAOFEIBZJcx/blY3U+rPnOxa
         wXeA==
X-Gm-Message-State: AOJu0YwwWLRGyhzyXTo/vBpS//c3bIpPgrKmABBZYRFl4rs11QlSOB1J
	Vdf52w84FWNVUXRZvv9q50mZs88lOlHTpF0U+vKSeKdqQDMkRdM4uCAqOtKbALYWFdI=
X-Gm-Gg: ASbGnctgWqSjzMMUTCx8D29rlEbLFJ0tDr0ek0jIuUim2seAdmImuHzaUS8BdXWNWN1
	v5kM1dWoyF0KAX06BqBvX275V5q3A8F9vCJMJSr93beEw7U56wyz4Q/PIPStUN1Z951V9l4vUsb
	/UEezAspmi0P/3eeiep4pycxBuyi8pOf63Q+qowrmrmRlOF9M402E/4XP5jeEMqOocAC+4gR5h/
	TPSoaLqFrUq1GuqFr1oLtQu14ZYqkNP9bz00fwZYqJBe2wK3V0rDZeGue8C5uvtmYRSNtb4T/N/
	NmHHC8x6MXvDGArkPKViGQhHV4lOiNiJAwT7H7qCsPZrbY9BPyDLxbhsACDHWDDd6NuhB1qz+8q
	z6ikZYstN5HPTxkKjHfPHo+Gas77Jl8Ll58tHbAkoFnNbhAtwVg88q+FGKklIqP94GQwsqVbQ1R
	xIITvA0bmF9rrWBw==
X-Google-Smtp-Source: AGHT+IE8OGe8fEFLvfk5DNFLba6SYnev9wcr2pWlSh+j4b7Y5U5zyPSIaOk7L6voNwKVhoV6jsZ8gQ==
X-Received: by 2002:a05:6000:186a:b0:3ec:ea73:a91e with SMTP id ffacd0b85a97d-42704d1432amr12331874f8f.12.1761072971335;
        Tue, 21 Oct 2025 11:56:11 -0700 (PDT)
Received: from localhost ([195.52.63.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce178sm21529969f8f.46.2025.10.21.11.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=356ffc8a324e0a829a516123b3657bd48d13b9a156b81beae6c01aa993b7;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 21 Oct 2025 20:56:01 +0200
Message-Id: <DDO89HU3O3J7.1OORIVD4XMXSL@baylibre.com>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
Subject: Re: [PATCH 0/7] can: m_can: various cleanups
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Chandrasekar Ramakrishnan"
 <rcsekar@samsung.com>, "Vincent Mailhol" <mailhol@kernel.org>, "Markus
 Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
 <20251017-fervent-encouraging-oxpecker-3b09d4-mkl@pengutronix.de>
In-Reply-To: <20251017-fervent-encouraging-oxpecker-3b09d4-mkl@pengutronix.de>

--356ffc8a324e0a829a516123b3657bd48d13b9a156b81beae6c01aa993b7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Oct 17, 2025 at 4:22 PM CEST, Marc Kleine-Budde wrote:
> On 08.10.2025 21:07:35, Marc Kleine-Budde wrote:
>> While working on the m_can driver, I created several cleanups commits, m=
ake
>> m_can_init_ram() static, rename hrtimer function, convert debugging and
>> error output to netdev_(), replace open coded register write by
>> m_can_write(), remove not needed error messages and sanity checks and do=
n't
>> wake up hte controller during m_can_get_berr_counter() if the interface =
is
>> down.
>>=20
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> Applied to linux-can-next.
>
> Marc

Sorry, a bit late due to vacation. The patches look good to me.

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best
Markus

--356ffc8a324e0a829a516123b3657bd48d13b9a156b81beae6c01aa993b7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaPfXQhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlP2
XwEAiF2/0OQky25ZjBWmOlwnAMsOtFDfXv/7EOUwFS7iSn8BAPK5w81k7APIPc7F
wN6/kDeQIt8JfQH0Z8is5yOg75sG
=cCo2
-----END PGP SIGNATURE-----

--356ffc8a324e0a829a516123b3657bd48d13b9a156b81beae6c01aa993b7--

