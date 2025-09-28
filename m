Return-Path: <linux-can+bounces-5046-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5FABA75AE
	for <lists+linux-can@lfdr.de>; Sun, 28 Sep 2025 19:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D316A7A6CE0
	for <lists+linux-can@lfdr.de>; Sun, 28 Sep 2025 17:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E77025393B;
	Sun, 28 Sep 2025 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb0zuWnG"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B159925228C
	for <linux-can@vger.kernel.org>; Sun, 28 Sep 2025 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759081684; cv=none; b=fTnSQAvE9sidsDt8b6D/9XzqbSC2okog1YGxWNa0j/ZGrFRRZoEcLC4qIND+0AFI/Ag7Yr8HDTzx85cvukrLgMcSXwP+8PlzsiwxVwlLDxHK3tE0O3WrCaF4tBZhmy1Bj0XHVGl+zeNNRdTRcU7UNWJYPre8r+YmQPZy9Yk/u0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759081684; c=relaxed/simple;
	bh=bb144XaT3ozq0w1qVMTiSOGlsjiwTNHYJ14plQdks2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLbZpnUpqmQOfFgfNk9f9KFBDmDZ4DwEd0iKsb8eDTIBHOZ4NxeuV6b6U0gJLOI/cLLVMu3u24X8oVI58YNLhhNQNCD6J9hHp4blvhPgArVeeE+4jnHGzEFyaXtqZWr9I7ZmaAIJo3zoZ7JzkHJUN1ai7ztEVucUCuk9fv4QcNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb0zuWnG; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b5565f0488bso2622441a12.2
        for <linux-can@vger.kernel.org>; Sun, 28 Sep 2025 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759081682; x=1759686482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bb144XaT3ozq0w1qVMTiSOGlsjiwTNHYJ14plQdks2w=;
        b=Qb0zuWnG7QsrX/EU9TbJnVXw4X5o8e31mNf+on9sXdE1YI5XWKrRTWkEjS7IM+9RVW
         uechN8gGX5DTdFPKQjG+mzpbae0lYH+ScjU7crsVuW5yOZ0RMpM30ev9cYR6cmj8AfoF
         ywfs/kfzrjRChzNR4vaRfotI9XMCcZ/zSTWccbByOnWDZUNPE/QDzvpcc3jTIwAPHVFt
         nzGcOwB3vIZCZNmAMZ2xS+nNJ0kuD7ZbRW6f77tLn8vBiqqWkE55buYvHvRa2jsn3BFP
         QS9h3/i3xvQ7kr+uhwC8wqFD5mItEKAE+JW9WogderX7yim21ES9H1W6rLcPK5rDW8TR
         prcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759081682; x=1759686482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bb144XaT3ozq0w1qVMTiSOGlsjiwTNHYJ14plQdks2w=;
        b=NjQuikQCZxkYMU459j6YrBx0RnSbHs8rfL5tr55rBQ45Kx3CLHrBffEOxHJiCZuJKs
         wL5gazZyAX+UkRjhki7z8Jh4VF/Hpu/bgndjPn24II3CW5DOOrcZ8MiMN+SBdG9DS+Ot
         yhMBuftoPlWf0X6r6owE/LOAFvCJxj7D9ciHJkPUot6dObjQCw4IzkMTm4tND1AMGsLU
         HzLZcOnf3CxWIpfH4NMOhsx4/2nVpAex6cchdIIFvjjDkA6xHHfGh7Bb5oEYw18il+3y
         zdyV0t0nLUmRdNNLHoy4QYCgyX8R8VrtxCv5nUBvyabsFexRRhTk5a1oRcx4DmVleSwe
         ARuA==
X-Forwarded-Encrypted: i=1; AJvYcCXSXu19pfecR83+4Md1mwijO27KoKGhS3Nm2B6mKVPbnhphoqpFjMJ9FK352xUpXz7GwQ2VkdxVWWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSz06VXfIdlbKYG8k90vBzjY0Phe0MpJsnWLzX6ZpLe0hY7MbX
	ywY3ijNWfGahJ4zxOBPYdvaUdd6rd8nxSoFGPW9IojXJ4kjRuC6x1oedayi4yC/TrAS6f1Bclzr
	R10u/ZwvbhhdCehKIrZYQ2D9hRrvN0xs=
X-Gm-Gg: ASbGnctf9W3KkPzDz1aAqL/JVowcbDcGC7IRJH3kaN9r+CRB75HNS3kzTGW3SQqTeWH
	NnOc6+WOdsN2vzbLnjRoNqPRUTxHz2HJiVRUx6ZE0t9O4hv1pWDfAeBp6jrMWKObn06b2KDlGR3
	vDpFyR5Ty30FV+9k51cXwGDgC3Ar6NnodV/kPMnRv7RFXlMdUqBXvf1/2q8hUV3LioK5hwea2oF
	ijLGEGBk71CDgka7Zk=
X-Google-Smtp-Source: AGHT+IGIhTRX0vPWXRnKGbM7/t9PfWgMfG3icRhXm/bikRRYDgSLLR3zWm4hL7da1xUZ+6JNLVBVdbp7N1oWnUBqBMY=
X-Received: by 2002:a17:902:cf0d:b0:27d:69bd:cc65 with SMTP id
 d9443c01a7336-27ed4a96a83mr141161955ad.45.1759081681919; Sun, 28 Sep 2025
 10:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOprWosSvBmORh9NKk-uxoWZpD6zdnF=dODS-uxVnTDjmofL6g@mail.gmail.com>
 <20250919-lurking-agama-of-genius-96b832-mkl@pengutronix.de>
 <CAOprWott046xznChj7JBNmVw3Z65uOC1_bqTbVB=LA+YBw7TTQ@mail.gmail.com>
 <20250922-eccentric-rustling-gorilla-d2606f-mkl@pengutronix.de> <CAOprWoucfBm_BZOwU+qzo3YrpDE+f-x4YKNDS6phtOD2hvjsGg@mail.gmail.com>
In-Reply-To: <CAOprWoucfBm_BZOwU+qzo3YrpDE+f-x4YKNDS6phtOD2hvjsGg@mail.gmail.com>
From: Alexander Shiyan <eagle.alexander923@gmail.com>
Date: Sun, 28 Sep 2025 20:47:49 +0300
X-Gm-Features: AS18NWDPKklTiLrxKFeYvofRAgeM8OwBQfBPUfJA357z4XaPxxHtrQTv3DSxvMw
Message-ID: <CAP1tNvTD2uhK79VB_PT0JByv_VVy245WH-3a1ZaG1-Khw5_vaw@mail.gmail.com>
Subject: Re: Possible race condition of the rockchip_canfd driver
To: Andrea Daoud <andreadaoud6@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello.

> > > Could you please let me know how to check whether my RK3568 is v2 or v3?
> >
> > Alexander Shiyan (Cc'ed) reads the information from an nvmem cell:
> >
> > | https://github.com/MacroGroup/barebox/blob/macro/arch/arm/boards/diasom-rk3568/board.c#L239-L257
> >
> > The idea is to fixup the device tree in the bootloader depending on the
> > SoC revision, so that the CAN driver uses only the needed workarounds.
> >
>
> Thanks, it is not easy to correlate this because I am currently not using
> barebox. I'll try this later.

I think this can be done from the userspace.
Build the driver as a module, get the SoC version, then modprobe it
with an alias for the desired version.

