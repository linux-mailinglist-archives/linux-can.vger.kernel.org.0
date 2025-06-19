Return-Path: <linux-can+bounces-3871-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FCEAE0493
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 13:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B391649A5
	for <lists+linux-can@lfdr.de>; Thu, 19 Jun 2025 11:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FE522F76F;
	Thu, 19 Jun 2025 11:56:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D2A221FB5;
	Thu, 19 Jun 2025 11:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334218; cv=none; b=mV1vJSBVl/OsvvobAa/ictXoZ/EU8mZqZ4qGq8xhDf9m1UlvoUaR1AKcy8urqAOhZWcmCOo4XcB1fncFi4DCXUw/Ua+7xCdDVTRleL3vFLKIG5RxDbma2pUqdH5iAlLF8ZE6IV0DwWjLH3UKaMrnq65K2OKJxzlXKlPurJggiJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334218; c=relaxed/simple;
	bh=8gpgFAMcvUJ6Rja32ErDKR6th+vyq1ETj1ydtbmRPkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVnZId2MmQ6wp0siZedzUlfrB1X6xYEgIQeGx5Vf99+VSJCtBf2Qw/+b7HrXdwDuLQheSeI0YkDMqCOeF5rdnTA6+OoNiuNtDR6KKCDWeqA6JlGWRxGqNYCUoBI7J6D3mIZfJTu80mOMps9qRCnTVjVftXSJus6SfENQCUeEKos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4e7fb730078so216456137.1;
        Thu, 19 Jun 2025 04:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750334213; x=1750939013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOekpUHLxVl+H9ogVNkhekXa6Qv+Gfytq3jYEtN/Fk8=;
        b=UUaPUTqFPR+yc1uobCeOCmB02VwPFvbAI8Cuyp+kCNBn/NYCDTk7yl1dGQBbA4sW1R
         5okh3N9MsQ7V1Oc1ltLzHfBTR006u9vjSvfeHNUfO54tZoSM9J8tulcEXwRCaj6NfDpI
         8xyeDRNBK1z5kNIloyp+LqyeACm/3jVDCXdyuN2Jm6idfPoJK+TPxvTsfTfopXlHBU4G
         bNR7Nr2C2lSnJz2ajC69q2s4n+cnctnyafyG4KuzUAi9EKNqmCVSgWGESyUOEYyK/lut
         EvHsylTo8Owmf2ZQ5PXfUytJr0g+INLyWJXJKELEPTe1TTbMWoG5kbUX9AgF4ppkko3N
         Rdsw==
X-Forwarded-Encrypted: i=1; AJvYcCUQgd09bTbAfRbdTyqxvdOoPf29TqR5OH1yyTKND4BJ5nODLNMQeQym4uJtZG/km63dvDGxjKTP@vger.kernel.org, AJvYcCVSbOMiLnHOkQM4B3P54qrIwjhkvGeihXtRDdoCnFbQdRc15uzZmsbNUJ37yDyqCqX4OLglYU7V3Cms82Q8iYoxgpM=@vger.kernel.org, AJvYcCVi3lyfU88U0Li6+nonA3Q7S0dJvq3cBY8owyMGqbjq53iDcX6Xnvp2Yph9Fw9OCjCYr8TLS0pVUZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUlXqWRI+6djl7Hlb+tEBs+PlgK7aeu+JHu411CAM1wqGJ1tm
	xvXhg7obxRXN6KmU4URzxJFYJE07JkfBzOzEOE+PJxMQHDn+UeNLVp94SezdSg7X
X-Gm-Gg: ASbGnctNA2O3Tuz79yqwkXPW/FTzal7d5DrtVMSLvPRSO+hvdnblXTQ79DxKwLpb6oU
	jZliDp/ShrbK2iX9TF2Gbv1aV7jSe0/mNgAo+qnhVFceJj0uCUShmAEd5pG+3mcaQUIDfjgkFPu
	/9aB5OsLIzSYe5tRfz/4LVdyu7I9qX5XXVsbhqUbrEErE5OoDandF/wDeSN7aF+/vvr7Ltvc/yB
	rkuOq2By8ma8e9rSzvKww+ONlKy8tSX+Y2q9H9AsiCFFRjTL1ApWd31OmD7H/tS0qqtVu0cjqbJ
	k+bnV3+x1AHZE2ZqXVeQshdEh5QrvrbJSl+AZ+ji8M6Ch4+eDIJrxY9yooE5iYIyHbDeXoehFBe
	/di08BwqBGKQ9t2USxGcharB8+8O6jfZXcAQ=
X-Google-Smtp-Source: AGHT+IHUdje8djMOJ6vGdfnq6/CfUq2jHO/6QR8A/m7Dc+6do4a+BpGZQ6c2bc5Npn5cfNyWr1Z5OQ==
X-Received: by 2002:a05:6102:dcd:b0:4e4:5e11:6848 with SMTP id ada2fe7eead31-4e7f62db333mr15418479137.23.1750334212811;
        Thu, 19 Jun 2025 04:56:52 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87f0fa1551bsm2233395241.15.2025.06.19.04.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 04:56:52 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-87f2a0825e1so73403241.2;
        Thu, 19 Jun 2025 04:56:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7RdkEIL3uujE0waJjEgpfXyjPevK/NUQ8WKx6f67VAmDMjnaDMtkQk8MIxys5MnXebb8EUIgj@vger.kernel.org, AJvYcCVEG3+iD7oRQUXww7HfivtKSHwb2tUW0VdH3DeDbmKcFjGaCBbSRZqakovzkTo42tJGiV1dQemD6cE=@vger.kernel.org, AJvYcCVEeFPHIEvPeQ/JjouPtX4td8MCVFhk+9MwmFjaShb+Wu6u5Feg0bNKeB+NyAn4IqFX5BWr7+HX2j/k7EDpu80+qtU=@vger.kernel.org
X-Received: by 2002:a05:6102:508b:b0:4e2:aafe:1bde with SMTP id
 ada2fe7eead31-4e7f61b60b9mr15809836137.9.1750334211820; Thu, 19 Jun 2025
 04:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <292b75b3bc8dd95f805f0223f606737071c8cf86.1750327217.git.geert+renesas@glider.be>
 <88b0892f-5994-4b7a-9de3-eab39075acaa@wanadoo.fr>
In-Reply-To: <88b0892f-5994-4b7a-9de3-eab39075acaa@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Jun 2025 13:56:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVKx7+errmKfzEZmuan0sRFw0-NXEORtntfyksgpAy8_g@mail.gmail.com>
X-Gm-Features: Ac12FXxLqCQOLmUYExvuxFVIHkAzYSxdzJTT0HSJUsvD4i8ZwRv-VEuUpXdyQuw
Message-ID: <CAMuHMdVKx7+errmKfzEZmuan0sRFw0-NXEORtntfyksgpAy8_g@mail.gmail.com>
Subject: Re: [PATCH] can: rcar_canfd: Describe channel-specific FD registers
 using C struct
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Jakub Kicinski <kuba@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Thu, 19 Jun 2025 at 13:12, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> On 19/06/2025 at 19:13, Geert Uytterhoeven wrote:
> > The rcar_canfd_f_*() inline functions to obtain channel-specific CAN-FD
> > register offsets really describe a memory layout.  Hence replace them by
> > a C structure, to simplify the code, and reduce kernel size.
> >
> > This also gets rid of warnings about unused rcar_canfd_f_*() inline
> > functions, which are reported by recent versions of clang.
> >
> > Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > Reported-by: Jakub Kicinski <kuba@kernel.org>
> > Closes: https://lore.kernel.org/20250618183827.5bebca8f@kernel.org
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Fast-tracked because of the clang warnings.
>
> Make sense.
>
> @Jakub, OK for me if you want to directly pick this patch without going through
> the linux-can tree.
>
> > Changes compared to Vincent's original suggestion
> > (https://lore.kernel.org/420d37b1-5648-4209-8d6f-1ac9d780eea2@wanadoo.fr):
> >   - Move rcar_canfd_f to the old RCANFD_F_*() location,
> >   - Update RSCFDnCFDCmXXX comment.
> >   - Rename struct rcar_canfd_f to struct rcar_canfd_f,
>                                            ^^^^^^^^^^^^
> rcar_canfd_f_c ;)

Oops, right...

> >   - Rename cbase to fcbase,
> >   - Drop static_assert(),
> >   - Drop unused car_canfd_*_reg() functions.
> >   - Drop simple wrappers around {read,write}l(),
>
> Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

