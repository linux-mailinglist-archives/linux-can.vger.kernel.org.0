Return-Path: <linux-can+bounces-1846-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20049B6CE8
	for <lists+linux-can@lfdr.de>; Wed, 30 Oct 2024 20:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47051C20E2D
	for <lists+linux-can@lfdr.de>; Wed, 30 Oct 2024 19:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7B31CCB3F;
	Wed, 30 Oct 2024 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vk5m7Sub"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC5815D5D9
	for <linux-can@vger.kernel.org>; Wed, 30 Oct 2024 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730316742; cv=none; b=bTVNzSdCQ0Lh1FJZQViXhaqZn17o8N2b/wkDkAD9KxLStUH4I8AMTd49xiGFCKC7NWYJfOYKDIKqxiesn6GZtPRXW/iJyeWo6DFh/KRB5INziZ1sdEscjj3awexUrT30qQv6FqHm7QTOViICtkIC3obq8LmPzqxwXBJjpbyDgCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730316742; c=relaxed/simple;
	bh=usVZ4YEunIbHVvBSq748OooOQsnvI6vxSw64f7E497c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiPfmNIRR1VdfYnjYoDj4ukYoAVhXWVhIMT2y5r4Jz8kRCQmpLdeCimGDvkmIw79ZBMgnuKYclAey43ifKSJpiqFUXKIPBmgGckGZVnus78tya4gVp0e5yBMqk6pg+ABqFYp9QQtyfrFHV0cNXZ3Eq09XI5/iSbTc9BfNHqOF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vk5m7Sub; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso2197561fa.0
        for <linux-can@vger.kernel.org>; Wed, 30 Oct 2024 12:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730316738; x=1730921538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usVZ4YEunIbHVvBSq748OooOQsnvI6vxSw64f7E497c=;
        b=vk5m7SubHmGywyjEiuLTmzq4wLffQhwdVTLYb2YspBr6SNlhTQXI++sGEXTPr1kFoi
         cmLW1APnsf+ZJYhKAp3gHzhK+g+bA6/0+a3ToQKCn378QZG3u9ZQ5q16w89F70ZHjmwh
         H1wgbiN2Shl7KQO9pevvG1hc8l1ixJgte7ovHwXjpw7ppOAYEpcUO8qoDnYGdLFVFGNe
         lMlVsMBbUUl/ptasJUyEPZI1Gbg0DX3ls9yVhzA6Mu8yAIraEGk+eilQ7Q+/QqupykBH
         rvHWiet+EoQ9r9aA0wzPdSFK1RmW0AyAzK7zfJYQIO1odMRU8gnzUyCsBY5NVox4UqXT
         D1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730316738; x=1730921538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usVZ4YEunIbHVvBSq748OooOQsnvI6vxSw64f7E497c=;
        b=oj46naAna0dCBviPlMiMINdi1IHZgyp09/Xepd1koNs0AabqJsNGrnekuEmB0jC2SH
         9x9XNANkHw3e98whF3Ho8kPaQrZAeXANIww27oh5Iz4aYLEVnf729OrQYuJgGEr7Gnw2
         bNqcmufWyvsFXHGFHu2sMPxQmfuNlbOK91x+3s7LImmtiq+UDi1Sz0NFM0qN+QXWTIor
         522hJR0MvulK1m5PZ9lCfJc85o2MD/Y2pkDi2SmLwZXnDiIAmDlOHCeTHFcf6P+M5i7Q
         8OtxdUuU/mD6OfLO5UVjDFFrol7/3UFfgzhnDt0JVB+8QCr/S+HPyRxlcWbk3+Ar2ja0
         wW6A==
X-Forwarded-Encrypted: i=1; AJvYcCUAx0KEU5vGaR4lbno4nj7aqTxblg2Z+KvNrWhBr6J7fmqLvWqvCQBkA91rYtIcuwIUdk+HXJNBaMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAtlD4vvpOKRt3dzQXQ9PuglyLAjOB6jQ37txwZBFKtnz688Tw
	WtaidKdQe0oMZ36EVrTcM4+6jZ3sIaRXkW5L+tRN6BWEHKI9Tzj0fkDK3NP7BCdcTYEoQzAcwIj
	9B3jhirCrF5t+ZCut4uzt3r8bHvIW1MDG2p6FEQ==
X-Google-Smtp-Source: AGHT+IFG7ijwW0f+Mp81RtWCW2V2VJcGxvm0/VX42o/gwTzTjjOH3/XQ/oqOur+E0bOLJYsbtRDWQz/jjZOssJBW5CI=
X-Received: by 2002:a05:651c:896:b0:2fa:ce87:b7da with SMTP id
 38308e7fff4ca-2fcdc9470b8mr26994961fa.18.1730316737580; Wed, 30 Oct 2024
 12:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024085922.133071-1-tmyu0@nuvoton.com> <20241024085922.133071-3-tmyu0@nuvoton.com>
 <CAMRc=Mc+SZN=EytxY=qA-qBEAY_F17GP-7FRE9oLojLbdUoPaQ@mail.gmail.com>
 <CAOoeyxW4=+5-QMcd_wgncFC9jgx_1Zf1Tq8RTnBvVqZ1JcUBQg@mail.gmail.com>
 <CAMRc=MexqwSCDrsBS0mK0fo_MCwngAH9XVgjRuDQjw0TVUBmPw@mail.gmail.com> <CAOoeyxXRrDuKJRMb3O2h3BF1vC=pwNN3DKfnEN9LnA+jiBCTQg@mail.gmail.com>
In-Reply-To: <CAOoeyxXRrDuKJRMb3O2h3BF1vC=pwNN3DKfnEN9LnA+jiBCTQg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 30 Oct 2024 20:32:05 +0100
Message-ID: <CAMRc=Me+R_i1WxFGeVe-MRREGn1YJvUon73A4FHDOPgs8wVaCg@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] gpio: Add Nuvoton NCT6694 GPIO support
To: Ming Yu <a0282524688@gmail.com>
Cc: tmyu0@nuvoton.com, lee@kernel.org, linus.walleij@linaro.org, 
	andi.shyti@kernel.org, mkl@pengutronix.de, mailhol.vincent@wanadoo.fr, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, wim@linux-watchdog.org, 
	linux@roeck-us.net, jdelvare@suse.com, jic23@kernel.org, lars@metafoo.de, 
	ukleinek@kernel.org, alexandre.belloni@bootlin.com, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 9:57=E2=80=AFAM Ming Yu <a0282524688@gmail.com> wro=
te:
>
> >
> > No for line names - as this is a dynamic USB expander, I'd suggest to
> > have them in the driver and assign to gc->names.
>
> Could I create an array to map each of the GPIO pins?
>

Please trim the quoted email to only the relevant parts.

I'm not sure what you mean by that. There's a field in struct
gpio_chip which you can use to set the line names from the driver
code.

Bart

