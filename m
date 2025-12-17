Return-Path: <linux-can+bounces-5866-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B0ECC6827
	for <lists+linux-can@lfdr.de>; Wed, 17 Dec 2025 09:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B46A3054820
	for <lists+linux-can@lfdr.de>; Wed, 17 Dec 2025 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD14349B11;
	Wed, 17 Dec 2025 08:15:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com [209.85.217.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215BE1DF73C
	for <linux-can@vger.kernel.org>; Wed, 17 Dec 2025 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765959323; cv=none; b=aYYdM4zXj4HofQey4wdWfWZDzNTHg8wTGr5cAF2+WxxVS06I7vIa52oTZui1mbkGSX9T4stbDTYyzI7/Ru/F1Vlkl4K/xMsn4XEHHPg0PEDkuYKiy5F4wgD/rx3mSJq7UHivmdp79gVQqJUbMEroMSGPF+blSHWz1daxPfSU9CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765959323; c=relaxed/simple;
	bh=XjGbtOPnxn5ziPdpc7g6S6MqyGKvLokVPCWE3c8w+yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9R3xq9U0T3mfBta9mcgmViIqlg59KCWRsC7t17mztwot6LNiWzgQlXVBlc8nqh+Udzj7qrNW8igElw+1hxcIqcm41vK54rrBlXeM0vipZloZaQDaF3BarfjxPivGBXf5iPkSX7N6jdfq8JnVPyRm7iBwrUrXVEx7rRB94mnNoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f68.google.com with SMTP id ada2fe7eead31-5dfa9bfa9c7so3893474137.1
        for <linux-can@vger.kernel.org>; Wed, 17 Dec 2025 00:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765959320; x=1766564120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rym4p+SQ3MsVDrU2KotDsjjR/+PnxDtYr8m/dR/i6BU=;
        b=pYEnjhbFhho33ifeBKp+JQ4fMpJz4/TbTws2IgIRJLkCH9oKAtZMqs0qttFwCfWJ6m
         YfvC9cBoU9H+r3AbooS70a3qB4c42R9qnQS97xuT+YoRXgRme6LVwA9eIGv2dZ0hG59W
         VplhUoQ0YGkEAEU3LHJrefDEZDQCoat9ysL3F3r3Uv2alZYbtg5hd4wGrUgNW285qjYx
         jEqKMtPsbIESj3foWpUDU2GkMHa02Um9CkO0ZT6dSClcKrInMuIptiz7qwNC5K+RUag+
         G/0BiiXj3igWQn/zAW7bodLYx54egQTSxwz0BeWN5ni4StITZXls1KR7BkRsQr3tKInt
         D4fA==
X-Forwarded-Encrypted: i=1; AJvYcCUc85NNqeVtq9+alOi5iHHhAHFa2AYgEweDkVNMzFJIwAxRzWI0tbCpMXdQE2oUTC2qXj4qccFvV0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAZfLsL19IdLWrt0keVfHujJEUYADLDUSScaU0AzFD/06aJQmA
	3sAZ4NgYCyV55PuKqI+AJXdFuzHy9vVMkH5PfH6YElRD+GnT+yAoKqbpEKfG02ltmfE=
X-Gm-Gg: AY/fxX5+HhzrG7rD907RrA9rM3lNQHJO/Hy9RaPA2hoRTLPTItErCjtd3RXv/FhFkwx
	d4LKb+rTC42HJTsdSlLEfXqvjuEn0C0WTXYWZsGs/ZACAxXLKHVWClHsfaB7n914jsf8X2+4nLJ
	4IxTXOuxRomqGRJKWvOqOSvLbZgYd56od7TRK060QEE0s7J2CT5ffrAc8MfsJaLMSWTJHnex7ph
	XknQvXWE+Q8Bwx7YhJoHvzXb9vxr5J65lGCoKXNiqj6JofPz8mbeIPuAYNAFu5yGAhy6pH5Pn3u
	RFdmof3smkxMB/8dv3Dxuxy1a9BXU9ixMSpCpkC35aHK1D1UYPtyXV1/eTSehQqgNFL9RcRjbOg
	l4wglKsx5NU9IGHoi9N8ke/Tg7uqSuZwdzqB2n1V/uYsU9Rj+/ybvpYCjQstH/B24PpS+HAsL8c
	/SlWqHa+DU4/1fadtIUWBtvsf1df2tedHQDhiiS1Cb+T4kwZQO
X-Google-Smtp-Source: AGHT+IGrtb2YvU4gbTIIh4y+GgCyDDmqLRtU5ABvYOIyzUGZoNtm0BpUSTYbGOO3t+Y5p0OtsIQ3LA==
X-Received: by 2002:a05:6102:549e:b0:5db:f34e:5fa1 with SMTP id ada2fe7eead31-5e8277e5e6bmr6527147137.33.1765959319807;
        Wed, 17 Dec 2025 00:15:19 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93f5aefd79csm6631835241.12.2025.12.17.00.15.18
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 00:15:19 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94121102a54so2953896241.1
        for <linux-can@vger.kernel.org>; Wed, 17 Dec 2025 00:15:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeEnnvXyp/LQ+C2K2bUBc7Qr9SFLK1kcoqQZV2VEVkRIhUaC4g5ED/EVJYgyzBYxWPE9S5L1MdKtw=@vger.kernel.org
X-Received: by 2002:a05:6102:1611:b0:5e1:866c:4f7c with SMTP id
 ada2fe7eead31-5e82781ea47mr5731108137.39.1765959318483; Wed, 17 Dec 2025
 00:15:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209162119.2038313-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251210-mauve-cow-of-hurricane-0f969d-mkl@pengutronix.de>
 <20251210-persuaded-rewire-8ac93b0cc039@spud> <20251211-wonderful-singing-eel-4e2293-mkl@pengutronix.de>
In-Reply-To: <20251211-wonderful-singing-eel-4e2293-mkl@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Dec 2025 09:15:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXW2iFQO3vTzMg_ydqZ5YC1EPqyNzkpLRfTAkLhmC+K5g@mail.gmail.com>
X-Gm-Features: AQt7F2oD50PxDosHDFQJjqw3YErV6WFAJtpUaCLTAZeWlqwHnCeiK6ic6sDkf3A
Message-ID: <CAMuHMdXW2iFQO3vTzMg_ydqZ5YC1EPqyNzkpLRfTAkLhmC+K5g@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: phy: ti,tcan104x-can: Document TI TCAN1046
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Conor Dooley <conor@kernel.org>, Prabhakar <prabhakar.csengg@gmail.com>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aswath Govindraju <a-govindraju@ti.com>, Frank Li <Frank.li@nxp.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Dec 2025 at 12:22, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 10.12.2025 18:21:34, Conor Dooley wrote:
> > On Wed, Dec 10, 2025 at 08:52:58AM +0100, Marc Kleine-Budde wrote:
> > > On 09.12.2025 16:21:19, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Document the TI TCAN1046 automotive CAN transceiver. The TCAN1046 is a
> > > > dual high-speed CAN transceiver with sleep-mode support and no EN pin,
> > > > mirroring the behaviour of the NXP TJA1048, which also provides dual
> > > > channels and STB1/2 sleep-control lines.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > > TCAN 1046, https://www.ti.com/lit/ds/symlink/tcan1046v-q1.pdf?ts=1765297159307&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FTCAN1046V-Q1
> > > > NXP TJA1048, https://www.nxp.com/docs/en/data-sheet/TJA1048.pdf
> > >
> > > The polarity of the standby line of the chips is different.
> > >
> > > You must set the correct active high/low property for the GPIO, as the
> > > driver uses logical levels.
> > >
> > > Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >
> > What you're saying seems to contradict the tag you've given, is a
> > fallback really suitable if the standby polarity is not the same?
>
> The driver uses _logical_ levels to switch the GPIOs. For example to
> power on the PHY, it disables the standby GPIO by setting the value to
> "0".
>
> | static int can_transceiver_phy_power_on(struct phy *phy)
> | {
> [...]
> |         gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
> [...]
> | }
>
> You have to use GPIO_ACTIVE_HIGH/GPIO_ACTIVE_LOW in the DT to configure
> the actual level of the GPIO.
>
> If you connect the PHY's standby input directly to the SoC's GPIO....
>
> | TJA1048: HIGH = Normal mode, LOW = Standby mode
> | TCAN1046: High = Standby mode, Low = Normal Mode
>
> ...for the TJA1048 you would use GPIO_ACTIVE_LOW, while for the
> TCAN1046 you would use GPIO_ACTIVE_HIGH.

Exactly.  For most of these CAN transceivers, there are typically two
almost identical parts (usually differing in the last digit of the part
number), one with active-high standby, another with active-low standby.
These differences can be handled perfectly fine using the GPIO_ACTIVE_*
lags.

Note that there can be other differences: the RZ/V2H board Prabhakar
works on actually has TCAN1046V.  The "V" variant differs from TCAN1046
(and TJA1048) in configuration of the two power supply pins:
  - TCAN1046 has independent supplies for the two channels,
  - TCAN1046V has separate logic and I/O supplies for the combined
    channels.
Since this difference can be handled through *-supply properties
(when the need arises, and the driver gains regulator support),
I don't think separate compatible values are needed for "V" variants.

BTW, how do I know? Because I had started working on adding support
for TCAN1046V myself, but Prabhakar beat me to sending out patches ;-)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

