Return-Path: <linux-can+bounces-3485-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1EDA9C31F
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 11:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508739273CF
	for <lists+linux-can@lfdr.de>; Fri, 25 Apr 2025 09:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B801F4612;
	Fri, 25 Apr 2025 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mwa.re header.i=@mwa.re header.b="U8jTMOCw"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F40E22E3E1
	for <linux-can@vger.kernel.org>; Fri, 25 Apr 2025 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745572714; cv=none; b=GMr+uwR77p+yZCyJRCVYHoS77yUD6LCc8EozOjodmqzNnrqx1itCZsrSa/FY/oXXOYGTeNpeXux3eeLhSEKtpXgvPQM8zASmMiEyh2GEj/tRHTzM2lttPWYRuyFyrrjH/ccOMedjZQxcQwnZW2J0tz4AB8Avn3+slFERQhrFPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745572714; c=relaxed/simple;
	bh=S3Ck7vwc07MYkEysfARCrCCCX/V3182fdfUPmdNoVyo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dXkZCtLOLRz5v7K1tTAdXK3ihznye6yMSbKL/GMFV9hVrizCWfNln4yQYci7iTAMqYTthwyb2HBw8Yt4raukvsS3jE9nvyLuFLgAmapej03plkObC9LGuxLxVHgW5FRZifSnKBg8R1TNtMjXx3MeWD/s1umtHlOI6p+rs1Oru1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mwa.re; spf=pass smtp.mailfrom=mwa.re; dkim=pass (2048-bit key) header.d=mwa.re header.i=@mwa.re header.b=U8jTMOCw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mwa.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mwa.re
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39ac9aea656so2398418f8f.3
        for <linux-can@vger.kernel.org>; Fri, 25 Apr 2025 02:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mwa.re; s=google; t=1745572711; x=1746177511; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S3Ck7vwc07MYkEysfARCrCCCX/V3182fdfUPmdNoVyo=;
        b=U8jTMOCw/kXdkFy9QKP8c2E8arPcg/MPEDhyD72nlo+pP4gvo1KYh+/upszNk6ytXE
         ytg5S59bXBi1HH4xzLmideznPwLIBMcFQOaaD2vXYvyinQ3Du9NKEA/pngw10WZJOQ9S
         hkyBke3+jC1/ITLyWU37G1TnNf1l9GeR9kPu6PuMFugGqUbdCZQwJCa+t+AdSuZmT9iY
         /0w9ldfU7Bg5ejnUUKu875oaRjouxgqALMsPsu2ANy3dKX18NoTdPMJ4NLpKm0/cLlpx
         WVW4ww4mQFwsk9QCKeEeLjRgbkBqlgN0jZ3LgusGLrvHRIoKkQHLTlCRm6WKb2AeFJ6E
         gFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745572711; x=1746177511;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S3Ck7vwc07MYkEysfARCrCCCX/V3182fdfUPmdNoVyo=;
        b=ntFoeHHHwkILHJewbcuDKMP1mf6ejj5SjSOE3/uiRtc1V+aYls9ZA/uB/DKO6h8te3
         6S+mnes2Y5Zqxm2IU7qn631M9P4GpRbmHXmUPt6V9KfytlkRxhUBPJJmtmprYoCFcZoh
         x/JD3ZsrkRWhlBldf2GU3DdTv5vjHu73vJHPu1LxQ+wMvQGbE2pLid4FwW2xKvh/68E5
         pA4NtK/PutX19zjEihP3C8TU6EyVXneQDFAy+92Z6X230YEYGavefFcPasUQFS+CsSEX
         AKUafAuGCAidadXb4BGq5xd8wCjTFuJTA5Scb/ijRoXm5GH72mjq08fY+nLgbgiQmjQk
         nIEA==
X-Forwarded-Encrypted: i=1; AJvYcCUD0fSo81/c1KCfX1Uanfbw1X0MUdqOjNWrfAbmgOKgfQVyfzoCiR6zXcZdh1eT5ph2LrGK6Bt+2YE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9iy0z21woVXS+I3SZEsp7adu6RxRrZ+DEgfL6Y5nWW56b9/w0
	KGBayk1lNshVkhS7bWG5r++5XE+nKMWWf1lmM2cJtgjsUDeh+C2xiJmr2ZQLsXE=
X-Gm-Gg: ASbGncsJsfsiCZ5CPFQjt5H1rIEIyBqdsdPaRvf2WJ/vAlLOhn0v2WbrQlsBpoY7Asq
	4/pDiGhkQpaLHwVFkyl6EGsNAZ/BeFs9xqfPteSGaKS9shxLyfobNGUUSc/Pc/5JPdLio3TR5m3
	JwqbxAeDFFsSX3KNyITUJ8vJOA1ycfGnLI26xNbAqWpHv27zwvmgbtcnOTJpMMaj0bPHXwVyCqJ
	jzKSM8IROmT7xhqhD4RRrKqN0dhOS1cjZE02qKUIkG+Q9dGfmiNCeUbfuy2lNjoQ4Gb+46egZlI
	+ZZtVQyoh4uxz4hfUO4CFv1DcFIUDS5UtPYw/WoR8IIQIu+ZGOTNCmqBvdNKYUJ7hqXZxIIpNfj
	m
X-Google-Smtp-Source: AGHT+IEy07M1Kka6h0pm1sIZsbtuaQoKm69f7gu2Qjmv8Z2/gVciyi0ynSFrOvtZvI9ezjUo9BawLA==
X-Received: by 2002:adf:e28e:0:b0:39a:c9fe:f069 with SMTP id ffacd0b85a97d-3a074e4261amr818270f8f.30.1745572710598;
        Fri, 25 Apr 2025 02:18:30 -0700 (PDT)
Received: from mw-ac-stu-3.corp.mwa.re (static-195-14-251-13.nc.de. [195.14.251.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5c82fsm1714217f8f.85.2025.04.25.02.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 02:18:30 -0700 (PDT)
Message-ID: <1f4d6de1f452021511301070e76695d1e56a14a1.camel@mwa.re>
Subject: Re: [PATCH] can: m_can: initialize spin lock on device probe
From: Antonios Salios <antonios@mwa.re>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, rcsekar@samsung.com, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, lukas@mwa.re,
 jan@mwa.re,  Markus Schneider-Pargmann	 <msp@baylibre.com>
Date: Fri, 25 Apr 2025 11:18:29 +0200
In-Reply-To: <CAMZ6Rq+QVHAh8HvWcn8rAYGE8VoJmhQUxOFNqBpijSQz10Dodg@mail.gmail.com>
References: <20250424125219.47345-2-antonios@mwa.re>
	 <20250424-industrious-rottweiler-of-attack-e7ef77-mkl@pengutronix.de>
	 <a5684bfe-981e-4ba3-bbea-d713b5b83160@wanadoo.fr>
	 <2fe59c0c7e0f7b9369976501790fce5beaea5bc7.camel@mwa.re>
	 <CAMZ6Rq+QVHAh8HvWcn8rAYGE8VoJmhQUxOFNqBpijSQz10Dodg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-25 at 16:18 +0900, Vincent Mailhol wrote:
> I guess this is because your kernel has CONFIG_DEBUG_SPINLOCK:

Indeed.

> Without it, this would have been a more severe NULL pointer
> dereference.

Strangely, a NULL pointer dereference does not occur, when I try again
with CONFIG_DEBUG_SPINLOCK disabled. The kernel does not crash, at
least on rv64.

Looking through the implementations of arch_spinlock_t, it seems that
only PARISC's implementation would cause problems in this case since it
uses an array.

https://elixir.bootlin.com/linux/v6.15-rc3/source/arch/parisc/include/asm/s=
pinlock_types.h#L11

I think I'm missing something, why do you think a NULL pointer deref
would occur in this case?


Thanks for your feedback!

--=20
Antonios Salios
Software Engineer

MachineWare GmbH | www.machineware.de
H=C3=BChnermarkt 19, 52062 Aachen, Germany
Amtsgericht Aachen HRB25734

Gesch=C3=A4ftsf=C3=BChrung
Lukas J=C3=BCnger
Dr.-Ing. Jan Henrik Weinstock

