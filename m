Return-Path: <linux-can+bounces-3207-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F99A713D0
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 10:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F431895308
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 09:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573561624DF;
	Wed, 26 Mar 2025 09:36:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3690F15381A;
	Wed, 26 Mar 2025 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981760; cv=none; b=mlpwUs8u378R3idpcxqXwL9efe0HxoSyFNNVTR0YipyYF5fPbhS40dNnxbsG2uFtGbZTjm9fpVx29d8A0tY2DU/z/2qEclnrEej90nP+oVB+PoVUoT/ae3ou97NojO7RjJ6OFtpofCRy8Wl5hEORVSNKacJMlG4fCDdwNcZI1B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981760; c=relaxed/simple;
	bh=1lET1WBXlbfygSS7ys/4Ss5cvlFBlp6i4eGQwRF40vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+FQzL9eMngjpm+IQ5cxGaSZ5iwwtJetZhyK/7NalEhsQw9miQxiMmlOMvzCCRHJih/Q3Q1KOV7wlY2cAyFAcQjekU1G+CsrzqDOaZGBMPAKQ9smuS8kT5vuTAVCiyUrqSezoO/wxKM8yWgBHTl5ms3479Qwt3HrpuPy6Aa1GFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-52403e39a23so6115159e0c.2;
        Wed, 26 Mar 2025 02:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742981757; x=1743586557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+T9mKGmJnOxJt4RVj15BVMXT3ERgk+llKtZMhedaFI=;
        b=Qa96FKNWgKGXWhN3fal3yYN+0A74uaZaZ1QxbFDA+/Ralse6n1G5ovpPuwC0VWYJ9w
         V0VgYRRh2AQo6lb6N2WfKZcQt/C8S+CPOWyhXgjILiXX7gtzv3WbF0BoAJ4uZpusm+iz
         fjjPkIjYInW5uoPxeA2PFSvMEecJuetZ6o4urth/HmovZi3MqCzYs+1UJZSGV6Vue7Q0
         SnAQAaMKBUWfZmeXFZ7XkgySLn3wOS7kRyAXA+dVzBg2YmXNBsfvoOQRdbdfJftE4P34
         8pu0kfgwYqLJXOEOZUfzqe5p9vtmRal6ikQ9V2yd+cY19T3zAwUvJzY19pEIA2fIhxJH
         QrLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqKmZiLMEZwNTxg9JAnpOGvZYGQqbFr1o1Ams5Uj5q3BiXy6DzdhDyT5VZ4J6DPThkcXNxiWLsmig=@vger.kernel.org, AJvYcCX28HiYfCdery1709PPWbb5SssboP2WTDxBI9P/EsYAJ91cZc35+otU4p8fsv5vQmoyIsUnhWWKYH3bQNOVVQCqNb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylEvDw96+9O0QS/gV/NGMBxbY3yOzAdvZeNVHyaoLcb4u3SCeZ
	RwE+aKZt/JvfSitLa6/cGP2b/Vyc1ZWTIHEFEcO6N9E9b0Gz+2/clNZPM+I0XV0=
X-Gm-Gg: ASbGncuhzgw30HWn9N11ddyq9ev6t30/3noVtwsBD8nVNadiGY1KVoj07PmxxLdesTA
	NrRwj0PKnjg21IWYLjiko9LMmBRuWvkYF+lRq3ikMST7827XCIfhkqjOcQ5N79kctJ9jt5GiArn
	pCIBDjAqHU7QpBJd3gPbMo1dXsgZAkJzXjGyAutJ8RzXZmaqGMwBmRtr2HvOPEiyABRhBW1YYPt
	4qbe24xQW++P6Fi7rRSUdrOhwVwBObvSvzZJYTPBNO5U3/lcOpQuxordYa8ieWZWmxFz6KYxkPz
	unMO/KWuy+UPAt4uDWM5SDe6TPDfwZkBgqloQyVOkHCwyZ5qRCmCW6qmGPeZvtuI7VbsZevwVtx
	hZ39PBi6y5sA=
X-Google-Smtp-Source: AGHT+IFT778gVwFXEr6HE9VO38dRkHbTylIww2hx792Y90drOXXJssYf2mE3KN8GOKsUmH+znYgfvw==
X-Received: by 2002:a05:6102:358e:b0:4bb:e511:15a6 with SMTP id ada2fe7eead31-4c50d4f8acemr16077804137.11.1742981756501;
        Wed, 26 Mar 2025 02:35:56 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bdb5c18sm2333662137.27.2025.03.26.02.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 02:35:56 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-520847ad493so6345841e0c.1;
        Wed, 26 Mar 2025 02:35:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkQuK6c+cJVnFLsvk09fXKeqd22/JcQ22owBi7QXJqncv7TJ5mEzI5BHHkhi/HOEP/qDWS+iJCrhg=@vger.kernel.org, AJvYcCV4NkwYiJrFdefdTKOjQpRfuypkcOJA65brrECTk6TGInSn5pvRkjapfaI0eZASSF065GmqSNoh9OLviYJzZi9Ybnw=@vger.kernel.org
X-Received: by 2002:a05:6102:3a14:b0:4c1:869b:7db4 with SMTP id
 ada2fe7eead31-4c50d4b52eamr14680055137.9.1742981756071; Wed, 26 Mar 2025
 02:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320091101.33637-1-biju.das.jz@bp.renesas.com> <20250320091101.33637-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250320091101.33637-8-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Mar 2025 10:35:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWtLuYzsPEQpJAruwOePSRzxiWODk0UzMGc9-CcHEHNbg@mail.gmail.com>
X-Gm-Features: AQ5f1Jrs3fiTpEd-EPF_o8Np1srKI8RrQ0_UDSPj824LkY0Te3KcaNoDu6o7c_4
Message-ID: <CAMuHMdWtLuYzsPEQpJAruwOePSRzxiWODk0UzMGc9-CcHEHNbg@mail.gmail.com>
Subject: Re: [PATCH v6 07/18] can: rcar_canfd: Add rnc_stride variable to
 struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 10:11, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> R-Car Gen4 packs 2 RNC values in a 32-bit word, whereas R-Car Gen3 packs
> up to 4 values in a 32-bit word. Handle this difference by adding
> rnc_stride variable to struct rcar_canfd_hw_info and update the macro
> RCANFD_GAFLCFG.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v5->v6:
>  * Replaced RCANFD_RNC_PER_REG macro with rnc_stride variable.
>  * Updated commit description
>  * Dropped Rb tag.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

