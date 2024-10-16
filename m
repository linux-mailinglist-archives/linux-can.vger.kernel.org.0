Return-Path: <linux-can+bounces-1709-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2468A9A0C53
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 16:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBB61C22EDD
	for <lists+linux-can@lfdr.de>; Wed, 16 Oct 2024 14:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452C21411E0;
	Wed, 16 Oct 2024 14:16:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B0502BE;
	Wed, 16 Oct 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088179; cv=none; b=LVVOp9nxOM0lr28jMq6oACnwYYUKIYLnT2HaFSYS8RhsLpyq4wP1cHZvDqUQcqDuElh3wk+6XRx7nWEzEJxHpJCRf21t1ClDZTX5m0AmG/byRwaT79kXPUN90eZdrkWzPXVHKn8+8bJCq0NsPNBi5Mtudkxj5qqIAOv2+I+S36w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088179; c=relaxed/simple;
	bh=OG0ZoHiPmXUDWn0qYiiQHJeobdpgi9P/omaxHHZPUMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFKRXYpUNk1hiA7TrHByoIXiJMqBiTExjoP0hSFet70Ey8vUIyxr3ibN2XvVJLT4fFpicQz+CnRFX1VYW+YSlcUi0rToKEOsB5cdpbKJ95bG/SFzLHQAVh0cOgW4PJvPx8SQvzQ3cLyqwGtnM0IkdYxX1O0BklcHuA6NlPN9Ogc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e1543ab8so8452147e87.2;
        Wed, 16 Oct 2024 07:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729088174; x=1729692974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zji2jjc7lmYCBaxDKjU5IirMGrQxMUOMfum9ROWevj4=;
        b=JZjM4S21WAdUuuMHhWrX3J6YxT4/r9e8mvv5O9B460Md4Pk8Nam8X5Mx8D2XF3Iajn
         FlFBsOLJ7gcPQ8GR9PKE31vyuHyS43uBa8DR+kgUv0zOgMA7bQHSeix6CaJagCXinQ3g
         Ghb3nN6s4On5kbQQFdoUD+yF6yVKiw/H9uUwVna1bbC+npMDrq8IT6H1Gpg6WeLhkwRr
         YryQC1DvM3UUX6i5tcSSDT8PX3T5hS5/YPBG/x/0Sb4ofStupLR0/hAm0v2h9TfpLXyh
         yZa7hSpoID5a0QzJrXxHoKUdfAQFVnu0XlBAbqXGeLLV3ayAf2epDe/pgWrsGW090pWr
         xDxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUECQIJ3GiG4MC7bhBaOQxCAYQkqFT0Cc/zTyG2LWJeEFM+H/TW9xB9qOe36xk8O+AgQcdfl8QwBQbt@vger.kernel.org, AJvYcCUcxgI0UWfibGpKARDVIlZKTUyQD9s9e8X1nRhTnCQhUiIFmpJOArFisCHM/Gd49VmYWT+O8wbH@vger.kernel.org, AJvYcCXLOwkYHtGgb7M5orts+mWmwwoGWQuCGWANJYxJCSSAzH4QPSYCvUyt3+HMWti0HZWLEPmAyXFg5lPm@vger.kernel.org, AJvYcCXLaRbIHh3E6fbSu2kc8SUUhad0sy56oL2ihb6fapXxKhH/bt6RKL19amaec+14w/gGvk6oFbvHMv6Y0NBh@vger.kernel.org
X-Gm-Message-State: AOJu0YxAX4psY4LXyGZtZ0xIpomR+TcgH4iKbfqGWAeNkGFKBts1eoIc
	j4eCCeWKa66Eq7jDwU6++UEYJ4FLUrv98E/EBtJs2S67+FOoIYoShNv6x0EVE8G9bM6Il6fNgfB
	6PvzkKrPjr2ncVGFRbodOZ7rQmn4=
X-Google-Smtp-Source: AGHT+IE98DjXYsvonEn7MnmPN+JCagURuswXEjP6x9DsDz5MmxRBUXYi+4++5nWYQ8Ogm2EWnbuG+myw2gPNuaM96Gw=
X-Received: by 2002:a05:6512:1598:b0:539:905c:15c5 with SMTP id
 2adb3069b0e04-539e5521da6mr11043400e87.35.1729088173959; Wed, 16 Oct 2024
 07:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922145151.130999-1-hal.feng@starfivetech.com>
 <20240922145151.130999-4-hal.feng@starfivetech.com> <CAMZ6Rq+EM37Gvx8bLEwvhn+kUC9yGDiapwD0KX31-x-e-Rm3yQ@mail.gmail.com>
 <EAC60558E0B6E4BB+e5384c3c-ba45-48f5-a86f-a74e84309a14@linux.starfivetech.com>
 <CAMZ6RqLvzvttbCMFbZiY9v=nGcH+O3EV91c+x7GxTbkKhdTcwg@mail.gmail.com>
In-Reply-To: <CAMZ6RqLvzvttbCMFbZiY9v=nGcH+O3EV91c+x7GxTbkKhdTcwg@mail.gmail.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Wed, 16 Oct 2024 23:16:03 +0900
Message-ID: <CAMZ6RqK428Pvwrgc=KPKjetZaTC8R55HzypMooOTziM8eMMxHg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] can: Add driver for CAST CAN Bus Controller
To: Hal Feng <hal.feng@linux.starfivetech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	William Qiu <william.qiu@starfivetech.com>, devicetree@vger.kernel.org, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Hal Feng <hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"

On Wed. 16 Oct. 2024 at 14:05, Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
> On Tue. 15 Oct. 2024 at 18:33, Hal Feng <hal.feng@linux.starfivetech.com> wrote:
> > On 9/23/2024 11:41 AM, Vincent MAILHOL wrote:
> > > Hi Hal,
> > >
> > > A few more comments on top of what Andrew already wrote.
> > >
> > > On Mon. 23 Sep. 2024 at 00:09, Hal Feng <hal.feng@starfivetech.com> wrote:
> > >> From: William Qiu <william.qiu@starfivetech.com>
> > >>
> > >> Add driver for CAST CAN Bus Controller used on
> > >> StarFive JH7110 SoC.
> > >>
> > >> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> > >> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> > >> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > >> ---

(...)

> > >> +
> > >> +       if (priv->cantype == CAST_CAN_TYPE_CANFD) {
> > >> +               priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK | CAN_CTRLMODE_FD;
> > >> +               priv->can.data_bittiming_const = &ccan_data_bittiming_const_canfd;
> > >> +       } else {
> > >> +               priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK;
> > >> +       }
> > >
> > > Nitpick, consider doing this:
> > >
> > >   priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK;
> > >   if (priv->cantype == CAST_CAN_TYPE_CANFD) {
> > >           priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
> > >           priv->can.data_bittiming_const = &ccan_data_bittiming_const_canfd;
> > >   }
> >
> > OK.
> >
> > >
> > > Also, does you hardware support dlc greater than 8 (c.f.
> > > CAN_CTRLMODE_CC_LEN8_DLC)?
> >
> > The class CAN (CC) mode does not support, but the CAN FD mode supports.
>
> So, CAN_CTRLMODE_CC_LEN8_DLC is a Classical CAN feature. Strictly
> speaking, this does not exist in CAN FD. Do you mean that only the
> CAST_CAN_TYPE_CANFD supports sending Classical CAN frames with a DLC
> greater than 8?
>
> If none of the Classical CAN or CAN FD variants of your device is able
> to send Classical CAN frames with a DLC greater than 8, then this is
> just not supported by your device.
>
> Could you share the datasheet so that I can double check this?

I received the datasheet from a good samaritan. With this, I was able
to confirm a few things.

1/ Your device can support CAN_CTRLMODE_CC_LEN8_DLC:

This is shown in the datasheet at:

  Table 3-52 Definition of the DLC (according to the CAN 2.0 / FD specification)

DLC values 9 to 15 (binary 1001 to 1111) are accepted by the device.
When sending and receiving such frames, can_frame->len is set to 8 and
can_frame->len8_dlc is set to the actual DLC value. Use the
can_cc_dlc2len() and can_get_cc_dlc() helpers for this.


2/ Your device can support CAN_CTRLMODE_TDC_AUTO:

This is documented in the datasheet at:

  8.8 TDC and RDC

This will allow the use of higher bitrates (e.g. 4 Mbits/s) in CAN-FD.
You can refer to this commit for an example of how to implement it:

  https://git.kernel.org/torvalds/c/1010a8fa9608


3/ Your device can support CAN_CTRLMODE_3_SAMPLES:

This is called triple mode redundancy (TMR) in your datasheet.


4/ Your device can support CAN_CTRLMODE_LISTENONLY:

This is documented in the datasheet at:

  3.9.10.2. Listen Only Mode (LOM)


5/ Your device can support CAN_CTRLMODE_ONE_SHOT:

This is documented in the datasheet at:

  6.5.3 Single Shot Transmit Trigger


6/ Your device can support CAN_CTRLMODE_BERR_REPORTING:

This is shown in the datasheet at:

  Table 3-24 Error Counter Registers RECNT (0xb2) and TECNT (0xb3)


7/ Your device can support CAN_CTRLMODE_PRESUME_ACK:

c.f. the SACK (self acknowledge) register


So your device comes with MANY features. I would like to see those
implemented in your driver. Most of the time, adding a feature just
means writing one value to a register.

Please let me know if any of this is unclear.


Yours sincerely,
Vincent Mailhol

