Return-Path: <linux-can+bounces-1762-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2559AFAB9
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 09:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6871C21AD8
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 07:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1228B1B3940;
	Fri, 25 Oct 2024 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VwDx68tr"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D5D18BB9A
	for <linux-can@vger.kernel.org>; Fri, 25 Oct 2024 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840370; cv=none; b=Kmdizipxddvl1kqUjBTjyBHbLpzGVV+4jIv1FOpVfvBRDcMGSjLF8w5I97i/g/lHexGEGHHJFyuFHkYbZd6+/aXryOl3CgfzUXAL6LYWhu2bTl4LTqIasYVvGn4c5Mtqcvyoo+ly1E7NmlauCMQM9WIZppVjDY/Z6bq7sMmY/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840370; c=relaxed/simple;
	bh=HC2Mbq8H1D35xf3SMfYvRoEmmrQoX8W7uq2ioXVudgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ot2VgBzbJF+DGWe2+2wMlDRFpqS8wMQtLaQ/mBNwrqTIcSMXLx5eCfCypxehESseeZLn3rtR0yGlzwcwpk2jLxnLWHPvSKvJT3lrh3yTDTsZQhs4AYfyvTxuqbPYPn3W1kOv7i6MwWTximEMDuD7NLOqxZG+yhTl23rTc6xR4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VwDx68tr; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e63c8678so1838503e87.0
        for <linux-can@vger.kernel.org>; Fri, 25 Oct 2024 00:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729840366; x=1730445166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HC2Mbq8H1D35xf3SMfYvRoEmmrQoX8W7uq2ioXVudgE=;
        b=VwDx68trJOHSsWQo9WUGnSEAmOFysRMKlJZscIBWsPaJtCO1t65rbNP0HAMjqdS4Jk
         h6NPU4t327TVnN8dC6S0ypDA2c1Anl5ucr8MaqIY2mnc8QMxGo6NTbyF7e5+SMhE1cdn
         BLXlc5wYPVFeeEcOElP9NWLhpGi9MN3Bl1bCJHT0Bzppmy6s+nSJprQ9LlCtq4aqMisF
         kz0SS06afT6Xz9kHIH1wyj38ZPX6z7YtU3rFv6KdMNOG0P1O380HK8zy7oa9n6VLPOOB
         R2/zv0jTcGfkzXDweDau9yeUmGBRStcyj105kGrJfpiCW1Lr4/D0P831SAmhjJBsRle/
         eXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729840366; x=1730445166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HC2Mbq8H1D35xf3SMfYvRoEmmrQoX8W7uq2ioXVudgE=;
        b=wmkeIFrdzkzU4Hrfc5MOWvtgtW3xF3RbB561r4Jw3Vunb+qloUjPvRVfgRCnzEY15+
         LfjG9KPJiZqTJD94xdFWYRxex7MWWrJNG4BmERIMCHnL0DRp/v+y/YO1Qh5U3aoZV5Ay
         3KA/yJKOJhdSo8eM66HEOS6tdqzHKSAh9LsVCO1S+19S8CZuWlrNLkYS2s2/n4nAYuIF
         i0adC8mnByWolhaq/fMSo+CUvX0KX4i9JCjPYeUHQq3PMSbTEnn8ff4Z2wHhfXF6wSjU
         MeNvaoipPFSB+JK81ckg1gQKZk6260wd4oEET4mOZCzW2Ompfoy42leY5MYktgP7cKPl
         BpSA==
X-Forwarded-Encrypted: i=1; AJvYcCW9o9rQebIVZu9vIyLTjTfNR/QZ2Ea6ymIGNZyqiCrIguqjXv/r5veVNe7tBJCqYIDjqna7lkJhk1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLE1T42GWy7O8DzBHgxXI3qpLrQFfrD8CUQPdiD0UbbRPfEXql
	d2x6uqPkotTWeLVZldR+vimxqy6hQ832k3s39C1LxbejswckqhFqvZePcUXLoI//6fRQ+DlxiM1
	DqchA3YBLlPQmXTQwzFrXMlQxsMXm+/ebvkL7Iw==
X-Google-Smtp-Source: AGHT+IG4ZkZxGF4NwcleHDZ3mgXgDSPpilfwYHN2H/azOjoznqSNOFszAT/+13NowS/a3VwELdmMHRhJSJW6LQ/W5NU=
X-Received: by 2002:a05:6512:3185:b0:536:a533:c03a with SMTP id
 2adb3069b0e04-53b1a3069bfmr4629650e87.17.1729840365974; Fri, 25 Oct 2024
 00:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024085922.133071-1-tmyu0@nuvoton.com> <20241024085922.133071-3-tmyu0@nuvoton.com>
 <CAMRc=Mc+SZN=EytxY=qA-qBEAY_F17GP-7FRE9oLojLbdUoPaQ@mail.gmail.com> <CAOoeyxUUOCSaDLK8=ox3hwDVu=Ej-ds4=FsS8F+9GfiE-8HYvg@mail.gmail.com>
In-Reply-To: <CAOoeyxUUOCSaDLK8=ox3hwDVu=Ej-ds4=FsS8F+9GfiE-8HYvg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 25 Oct 2024 09:12:34 +0200
Message-ID: <CAMRc=Mcbs_Qtac-jPDU2BgT0WNy4PgCaGJT6H2i7SQAg+JfycA@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] gpio: Add Nuvoton NCT6694 GPIO support
To: =?UTF-8?B?5ri45a2Q5rCR?= <a0282524688@gmail.com>
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

On Fri, Oct 25, 2024 at 4:53=E2=80=AFAM =E6=B8=B8=E5=AD=90=E6=B0=91 <a02825=
24688@gmail.com> wrote:
>
> Dear Bart,
>
> Thank you for your comments.
>

I'm not going to read HTML email. Please resend as plain text.

Bart

