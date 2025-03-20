Return-Path: <linux-can+bounces-3183-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E12A6A396
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 11:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54036188EC1C
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAB222423D;
	Thu, 20 Mar 2025 10:25:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86A6223324;
	Thu, 20 Mar 2025 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466347; cv=none; b=Ph9SS/WMawa593ym5tndbjS+ywwZEhKZLbgRc5/eOg9JKpaF9q3SHY7glZknZZIWruNRZT7ZRrATFtKQeIQGyBt//BMleqPeputS6Cb6AHpfn+qZmDSebVwpzZYheP1zOOYxxfRpEdIygPJsPAH3HOLsGxUYqI9uyAimvAnCo1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466347; c=relaxed/simple;
	bh=UiTlIWwnmkS8UNUn8U/axQWnOpvGTCPWWAjOMvnQnSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4rHUeehi5mOtAdktwa4ftQj3rIpCHLcjAG7my935waNrrrc/7NJiwmSx7TOHN49hKCsOFt/4myZ/5H3iGw0+xCyoCeg8HK8/BtMvWobX+9EAkYKF6+5vi30JzaQXNzBmYJOZEXoUWlQyZVaLuBLVBTCQ4bZ2mxbqIAO6kj+JE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-51eb1818d4fso789772e0c.1;
        Thu, 20 Mar 2025 03:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742466342; x=1743071142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9Vl8stWRp4XCmhjIQ4x29/EadE6k2Y0g/CcM3o/k34=;
        b=pUsXxm1OeUIBWclFYFlyP8gEjO6/s0MBFiErVBUnWtaHlZBSec8QR7YaYfmMa6zBtW
         vlDzvMRoBA5K1JQUApIV3DxrBlulZtOR7gUQ8p9qPI16pDfOxdExALuclsVD2jHFNuUS
         JPS6hMmcZ87UdDv8tLhNiOowVuOiWFoJ+5sY96WqToF9I5LpHQT2XfQjIlyf6Y3mRbYQ
         RC8vG8NyZvI6iGSptkEzgPn9pqwcgdQFDKq+W922+idTVDWus3i9RemQ2w4KHHqlwItR
         U1IzoLNLOV8i57V0LTQUbPLVMKmQLuMSucBAFBmp8NZhg7awM/LtSXcRILteZ76TyB+6
         1ayw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Fh6fi+aJ2hGI0gcwmlRNBTGfL+8DsktNJyj1HrbFC+PSct3zSal+V0ChyFrIq/BxexoRfPCaaZIanaA=@vger.kernel.org, AJvYcCWZJe4Xsg9LuAECwCqggTr9+lXPONr9Z+pSGHarXIwQkWL/TsmRYWLuRfDFP7M78ofe8Pt6i8QLHiPkd99Wp0Xj/NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyByJ+DJNgfOpIRXqsegxiXUx3u1gaM9LH+7baO2tHYRoGg29h
	qSAIaVYRRMjxMOVQKCRUsp9jb20MadKxoa76NSWTdqfFKPS6EyJvq0hpAz5/
X-Gm-Gg: ASbGncvr9N3nByqVZqHS3WK3h1j9NC9PSpoNfe2MI95azveS+wVJnkxc8nwWf13gUT0
	W3qhfYnQFWwmidFNH12TXBKilVEQ7CO7Yekh7A9owLdvF/DrO+Pq+TjPKnzVsG+adbTTdAJ+PDs
	3ygGZUzK3WqDU4VYiPonsRVspv5mmoPRkVqvbb08arO6lmCFzLQ35kQArUymsjEKXqmI95GcGzo
	/4qroWxQ/rcVLaVZRdJs+hYNGxaoJ2naFFAesLg8KYHsHR0xaN0+NuaGd8EIPRLVRJXeT89cZqg
	fueCcDYzBG1OXoQhAk2s/A66PHJzeldlgC0QbJE6AfrE72Uohu20X1WVeqIfzv7dbTvEUni7on8
	26/NDf9s=
X-Google-Smtp-Source: AGHT+IFy7Zhn68cvWA99JWFfpq886W8gABfyhO9r2skkuBqc+KXl3gL5kos/bRPaW1Ml4crPx/CPxQ==
X-Received: by 2002:a05:6122:400d:b0:520:4996:7cf2 with SMTP id 71dfb90a1353d-525963ba3f1mr1730742e0c.10.1742466342602;
        Thu, 20 Mar 2025 03:25:42 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5258b0a93d8sm639072e0c.14.2025.03.20.03.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 03:25:41 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86d5e42c924so599557241.3;
        Thu, 20 Mar 2025 03:25:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDntN0pigaW3fLPfvYONAahtnS24EO1oVktrmDJ7wQSMVSXexaP0b170WRZ8Hz1u36RK7RxoQSJ9SMISDY4zqoBIw=@vger.kernel.org, AJvYcCXyozqZ8a+sYUh4fEEhFS+urit/4FCCEp8mEzSzU0uOFsG4lRghuNXgNUQaGMqO+Vb9shDms4lXJitUJ2Y=@vger.kernel.org
X-Received: by 2002:a05:6102:5e8b:b0:4c4:e451:6f24 with SMTP id
 ada2fe7eead31-4c4fce5a0b8mr1981078137.22.1742466340794; Thu, 20 Mar 2025
 03:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6bcfde63b3a6b25640a56be2e24a357e41f8400f.1742390569.git.geert+renesas@glider.be>
 <9875d99a-4e16-4f0e-9249-69f0acc4c890@wanadoo.fr>
In-Reply-To: <9875d99a-4e16-4f0e-9249-69f0acc4c890@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Mar 2025 11:25:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVCmchuN1LyHGoE6A0TEpc9R1unXi2KNYO94cmT1WwOHA@mail.gmail.com>
X-Gm-Features: AQ5f1JoPHL7qu1sdjzScQ0pkORkgvrvYYtjHhU4AbcOVfFrVPVM4tJGLITEYQz0
Message-ID: <CAMuHMdVCmchuN1LyHGoE6A0TEpc9R1unXi2KNYO94cmT1WwOHA@mail.gmail.com>
Subject: Re: [PATCH] phy: can-transceiver: Re-instate "mux-states" property
 presence check
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Peter Rosin <peda@axentia.se>, 
	Aswath Govindraju <a-govindraju@ti.com>
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Wed, 19 Mar 2025 at 15:07, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> For some reasons, I received your message twice (with a two minutes
> interval between both messages). These look identical. I am answering

My scripting didn't handle the comment in Rob's address correctly,
so I resent the patch with the fixed address.

> the most recent. :)

Good ;-)

> On 19/03/2025 at 22:27, Geert Uytterhoeven wrote:
> > On the Renesas Gray Hawk Single development board:
> >
> >     can-transceiver-phy can-phy0: /can-phy0: failed to get mux-state (0)
> >
> > "mux-states" is an optional property for CAN transceivers.  However,
> > mux_get() always prints an error message in case of an error, including
> > when the property is not present, confusing the user.
>
> Hmmm, I understand why you are doing this patch. But on the long term,
> wouldn't it make more sense to have a devm_mux_state_get_optional()? Or
> maybe add a property somewhere to inform devm_mux_state_get() that this
> is optional?
>
> Regardless, just see this as an open question. I am OK with the approach
> of your patch.

Alternatively, we can be proactive and add a temporary local wrapper:

    /* Dummy wrapper until optional muxes are supported */
    static inline struct mux_state *
    devm_mux_state_get_optional(struct device *dev, const char *mux_name)
    {
            if (!of_property_present(dev->of_node, "mux-states"))
                    return NULL;

            return devm_mux_state_get(dev, mux_name);
    }

and call that instead?  Then the probe function needs no future changes
when the real devm_mux_state_get_optional() arrives.

> > Fix this by re-instating the property presence check.
> >
> > This is bascially a revert of commit d02dfd4ceb2e9f34 ("phy:
> > can-transceiver: Drop unnecessary "mux-states" property presence
> > check"), with two changes:
> >   1. Use the proper API for checking whether a property is present,
> >   2. Do not print an error message, as the mux core already takes care
> >      of that.
> >
> > Fixes: d02dfd4ceb2e9f34 ("phy: can-transceiver: Drop unnecessary "mux-states" property presence check")> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Notwithstanding of above comment:
>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

