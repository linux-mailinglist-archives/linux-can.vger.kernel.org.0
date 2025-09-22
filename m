Return-Path: <linux-can+bounces-4818-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1690B91CB9
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 16:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7242E175188
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DD526F476;
	Mon, 22 Sep 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="o40c9433"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A170E25A645
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552563; cv=none; b=ugu6h2QftP6oppDm0iQAsg3SFpyMzNI0gaw+i2TvtcTKOIdzhkf51wZ0ndKcm9FH9iNmGDQ8+dvgOd+OB7ChQPk1rAQtDeI/85srAc4I8ULhbng4gFG3GIYLuXY02T5K1MaBK+Ik/jYm4UsOLICLk93LsLCmHSOYX2d8OZp61nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552563; c=relaxed/simple;
	bh=bykbtif9awIBKm3O/qk/D6C7L3MfL80Kt+n3asECuK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHJJDGyDSsVtNzzaI83dZ11fgq6R9Eik6HGlp59qR+5TXQM8Oy9z8wdTeRSYNyTH4Pj5wkOJjrVhtCUz6rXlVW135cLYmaL6CfGoFu+oCl7DjD9uWa5BzcNh2/Z8sTt5eSsOoVo18oTlBLAjIFgTty/2UJXd5aFVaFO557ty2lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=o40c9433; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-36620862d27so24841411fa.1
        for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 07:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758552559; x=1759157359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bykbtif9awIBKm3O/qk/D6C7L3MfL80Kt+n3asECuK0=;
        b=o40c9433dR/xQzpeVjrcG4c0BaQiB8LpWdJjlPQG90a0wouQ1RjeOcCvubVAzMXatL
         wRMgUTyA1CtxTLg6erioE4TMR2vr132QeJk0ijBH11wTgCS9co6UV4rPXcw7SZ6WUG4G
         9+Nsa7ThgV9P66WlKnSabDfMvhDVlnHwIOe9i6FizIX4qM+W0Jnb8/On59x/0HZatagx
         qgx3ctl3zmp/I3sJHtBPpBag7nkpDj3GgPTxWlXPmSwdSfHkk5ZnaFID/l3+5OezrFOL
         2uanblri6FuNSAdm9Bk4HJhue0RKFIT2MqattmDcFKm4CjCEw5H4XFBVLowaWOLdmMkw
         sgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758552559; x=1759157359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bykbtif9awIBKm3O/qk/D6C7L3MfL80Kt+n3asECuK0=;
        b=cqC7lqUJLZzToVvhyOX6KJka74my8+yBNaDzXFC4dzSDCC9RLAmznqQeOH+Bg0I27+
         peBPFf5rcLE1xza9FCVff0LWR/jA6ObxCYrXFG97lPoLfxKGadOXrH1t5P5HbZdEYIKZ
         5HeTkd5Raihx+zNIX/k2hTESb+YJgtv2hED19KLlw/FwkAISqJdqrnYsXNCkhzGGXkJR
         8y4qd2tbdzndbTZsCNKNudnV9N6UYUxXOLqRAvCZUT7V+f/W6jvPvCRNBFx0OXs7nKD0
         2fXCm1pP2JZl/FbjXAVo/5IPFu9jM6fEsT/karHZXJiMTc9KK3D5b2XFbHE7GI7syHTo
         lcCg==
X-Forwarded-Encrypted: i=1; AJvYcCXx6vTP3ZTQdYSIPISEQW2SLUP/xgXXujlS8ea1VafKTNtX/3w6GEzX2OVIvUlK40Evi5kajHcXR0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YysbeKDkkwKS0bvm0wknt/F0ywZ71kn77EPJV2KnijtVA7K8FBn
	QbR6+QOx1szcGLjM/Z+JE5ziHf8Y5KlGiMiuXlAdTfxSeiu0fhlTTEbNEltYBYyBgGNEu9rpYXf
	QNhZJV+0s/gD3xCSizaYoE4dkKvIYMe4E8O2BS0uKLQ==
X-Gm-Gg: ASbGnctQXYos4onvRtgrBk8HF3RjC1KAdI9N7NiF9IHu9PiK5IDFokzNWw9UgTR2qCY
	8izFJlh5OVnahDopxpqHIrTAZ4s86+mZgbDK33gPjdOrt79v7zU42+dtTxLANKmFM9PH4WYaJJp
	wnZaub+kpTMRuHJcMIP4jxkeNB0HINSgTXf2cOYAI6UkBTxMNMa/BB6URUg177o4uycefCcMpgL
	7t9Y+x4yQx1QHruEruMzEv7LVYbnAidT7fq8g==
X-Google-Smtp-Source: AGHT+IGlnNt+fhE5MrqIpFvliSxDtGX2XB40jaaM5K7wfFAvtAE4jBlrlXKvYjLZOIykgctVeiSEZTwWunX74S3veto=
X-Received: by 2002:a05:651c:2109:b0:36b:8874:cdae with SMTP id
 38308e7fff4ca-36b8874d0ebmr12204601fa.15.1758552558756; Mon, 22 Sep 2025
 07:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
 <20250918064903.241372-6-viken.dadhaniya@oss.qualcomm.com>
 <CAMRc=Mf2ycyKbL35bdy5m1WBEap7Bu8OO2Q9AdZYgc04Uynf8g@mail.gmail.com>
 <20250918-daffy-steady-griffin-5299ac-mkl@pengutronix.de> <CAMRc=Mfypwopu6daCBzg90i98dbO-7rwAehkiNkA-tF074fO5w@mail.gmail.com>
 <20250922-magnetic-dashing-piculet-97f38d-mkl@pengutronix.de>
In-Reply-To: <20250922-magnetic-dashing-piculet-97f38d-mkl@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Sep 2025 16:49:07 +0200
X-Gm-Features: AS18NWBlKhLUvAddoj2mOzUueezFqF7tTTLWH1tXphnQJ1z6UNVeCHLT2id_PP4
Message-ID: <CAMRc=MdEkp6Mztoe44Nv0orX+f4ops7nh8XS7hbJS2KvQFc3Fg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] can: mcp251xfd: add gpio functionality
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, mukesh.savaliya@oss.qualcomm.com, 
	anup.kulkarni@oss.qualcomm.com, 
	Gregor Herburger <gregor.herburger@ew.tq-group.com>, mani@kernel.org, 
	thomas.kopp@microchip.com, mailhol.vincent@wanadoo.fr, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 4:43=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 22.09.2025 16:28:53, Bartosz Golaszewski wrote:
> > > > You must be rebased on pre v6.17 code, this will not compile with c=
urrent
> > > > mainline.
> > >
> > > You mean "post" v6.17? Best rebase to latest net-next/main, which
> > > already contains the new signatures for the GPIO callbacks.
> >
> > No, you read that right. The signature of the set() and set_multiple()
> > callbacks changed in v6.17-rc1 so Viken must have rebased his changes
> > on v6.16 or earlier.
>
> I'm not sure if I understand you correctly. This series must apply on
> current net-next/main, which is v6.17-rc6.
>

The GPIO driver interface changed between v6.16 and v6.17-rc1. This
series uses the old interface. It will not apply on top of v6.17-rc6.

Bartosz

