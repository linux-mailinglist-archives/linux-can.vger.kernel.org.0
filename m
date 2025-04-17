Return-Path: <linux-can+bounces-3437-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2B8A9162C
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 10:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD65E172E78
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 08:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5001822DF8D;
	Thu, 17 Apr 2025 08:08:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F522DF8E;
	Thu, 17 Apr 2025 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877332; cv=none; b=TVrT35xv1iHs29IdbaltR+SY3s4KZt7jITNwjUClbex2fHRPOQ1ZDqqNvOshYwHt/vyl7V3g6Du1qzU0CGSyA7dChNFHCAfDW1nXSsI1rtm0c5cPvaPTTMQpVGJuNUSGTwijgq/jMT5+YCGjF9h8FTrSZlYhZCsktKakX/opebA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877332; c=relaxed/simple;
	bh=WoqULKDdQaWy3miQ7iO0szYycC5LoDyqvTXTuhX3sL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwa9ZespuqyKMO+aXC5+8TRornNnHRz7KwbPnDOLqnkdjspBa9CAzqMae1q/0O6VxQRZVhnr0Gj8E8ssufyXaQOJJV/n+bcoumk+ccdW8YyhkSQkGNF1CuxEBFgsLZbFEBUTFhMKfz7whvww7JOYwisW+jWO2ILLyWtrClcyJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523dc190f95so222909e0c.1;
        Thu, 17 Apr 2025 01:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744877327; x=1745482127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3Xh33BRiUbSRT+JQZ7ejXYSdhDyQlm7mU6tXMQulXI=;
        b=K+KDcO75Ky0ubiLwx+Kd4+m7P6j/IZQQIzvsB5/dpZRvushzzv6UIV62i1z/60NQ76
         tcd6SeWsg8ZbTYAJQhhHF4z0aqPjTHO84m/d2G3wUN0jlrBkcqBEp5xkK8Y/O4KgHbSP
         mVh9YwUbIxzaBgGgtWZtZYBv3+cgyH9OBNmmUQtUqzxQOl+17nEf5hS1sLhJifOte+BU
         mF80KAPgUAWE+DiCXavXqQmM6sWSdm+AAk1eml4iM9eFlp3nzEBw3NCgxbuf4DLCz+/+
         3gaeF0GkGvKObmeBy20uN9BYeA8RYWtdU/Hk5BtaJKGK/ISl3Giy12qOnRCm/pkuGRVP
         +Kww==
X-Forwarded-Encrypted: i=1; AJvYcCWOzRwLUav1OijTokw5pKFmerPHusiwGKYCCSlV2knBQ8mAwwlHoFuPNBAm5CY0o1/bUYBAzKVg3Xvk@vger.kernel.org, AJvYcCWhFGdf6N1xKtJxw/zzc85g+U3Aoj0URyR7hAjm5Mc6zBial0UY/iQo3wh7pP+WEI3wWjndBQtTByTd@vger.kernel.org, AJvYcCWypRNh8iSgOUTpajkqQ+Yvq/aLvOrB9B1GC+LoVDx3pGJgCja42ZRcBWk7xYV22ouFpKHQ87qxCWf3nwVNZCxjhtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUHZhv35jeS7bFTMoBgGLlg9+MsyQJODx8QHPjKJuwiPvUbzon
	d7Lh25P5GADNWe+qP6DR4IMrBGP9hJL05PdWnZ43nsmllzZDncWL3JeAkRat
X-Gm-Gg: ASbGncs+v6BF10oomS0LEWGJcBLUvMScI1V6RRfZ9lh54yvrtDofxcTL2do+oTh8Y5N
	6eEUY+jLBOEeq6g0KkyzM/jB73D4TCxG+e++wH8MJiOkYjjkr3UG9uu7chm71x33aOWYbkF2mOv
	lNmfxZEBYQYZsrkRSQssWfo812+PDkC4J0CJ0zaiyikdJnYSV5nT4pnREgUYnJNAR2PaLAgCkf0
	vsxdTRVoDcYvNrhZrdH7EiE8IuNDZydro6TgC81Rab7BVZNcFJWnKRb7Wc2MUYnYwf8m+wHVgKf
	9aziyksrQTCr/O4X39yg1yhKffKoAhu/k160CpjDbDOAwLV1H8DsJ84wAg/CeTV0bKL/54GMdTe
	4mOSyHGA=
X-Google-Smtp-Source: AGHT+IF7yHWXjRlRjq8dWBz5ISpCJkmkOsQtuc/T5teCebAWQR/DZJxYOH+1bsa5adApTEa+s9j/rQ==
X-Received: by 2002:a05:6122:8c29:b0:527:67c6:faff with SMTP id 71dfb90a1353d-5290de99a49mr3712446e0c.4.1744877327643;
        Thu, 17 Apr 2025 01:08:47 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abe8e78bsm3480388e0c.32.2025.04.17.01.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 01:08:47 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-527a2b89a11so229855e0c.2;
        Thu, 17 Apr 2025 01:08:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVy2ic2S8y4220YQOFmviBLcjr3oWXGjVBAL40gpBUySIBln8QN8JezkStZ9oILcXFpx/6sUIUxXlIn@vger.kernel.org, AJvYcCWkf9y4ZmnkmyPkdjZCotzQC32p56mds6vakkXm9frMbnUL4Y9gMsxHaIpSDua93RkNYM+l9w20QIrYNmIOyOKR82Y=@vger.kernel.org, AJvYcCXky5+5B0+SgTj5bmsDbgttnxnVvECwqcz4Z1lGNR23XcD32vPtNVq9/xTr11hDixE6Svf0p8Jnvxt0@vger.kernel.org
X-Received: by 2002:a05:6122:3c8f:b0:523:e175:4af1 with SMTP id
 71dfb90a1353d-5290e18b406mr4186887e0c.6.1744877326589; Thu, 17 Apr 2025
 01:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417054320.14100-1-biju.das.jz@bp.renesas.com> <20250417054320.14100-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250417054320.14100-6-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Apr 2025 10:08:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW8n04tmahsVpZwNp_xc5i=P_fad-CQROXJBmDT3=vt3Q@mail.gmail.com>
X-Gm-Features: ATxdqUG74U_uISQ6QK0k2c6Ea3ZgjnCBo_dI_KqMsGmM5eDHbx9NCve-CJ3XEiA
Message-ID: <CAMuHMdW8n04tmahsVpZwNp_xc5i=P_fad-CQROXJBmDT3=vt3Q@mail.gmail.com>
Subject: Re: [PATCH v9 05/19] can: rcar_canfd: Update RCANFD_GERFL_ERR macro
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, u.kleine-koenig@baylibre.com, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Simon Horman <horms@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Apr 2025 at 07:44, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Replace the macro RCANFD_GERFL_EEF0_7->RCANFD_GERFL_EEF. The macros
> RCANFD_GERFL_EEF* in RCANFD_GERFL_ERR can be replaced by FIELD_PREP() and
> drop the redundant macro RCANFD_GERFL_EEF(ch).
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v8->v9:
>  * Added missing header bitfield.h.
>  * Fixed logical error ch->BIT(ch) in rcar_canfd_global_error().

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

