Return-Path: <linux-can+bounces-3088-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65203A613F8
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 15:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A391893B96
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77CF200112;
	Fri, 14 Mar 2025 14:47:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84641990BA;
	Fri, 14 Mar 2025 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963626; cv=none; b=HsvVxQQWvb4SqvHfnnaND/b/GEDHQvxOjfttZxdxrD/C9Z2pqMBfCaKZWvfZS197NVSCFHBuVq07mLPuXNyPXNYswdtktMMLvyGNCwzZme87uPGWuLAK5581AGeZgzuCwKM9dMSBOh4j0Zrx3mcDeYMLLT5nC7/iZw+UAZ+x/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963626; c=relaxed/simple;
	bh=Wr60PM+qvHPDx36H4hxrhljHgznDt22LJ4ImKZ+bF8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPXgfgDuFZPYVGfFj6KtK7AjLCqOmwb3nNW1tJbwEHyaf8glXRonpA5QcOysNsTsXukVvSdIxJPHjloUnI4/YWFgoacUyvso5XfMW5110QkF4GD1PmGs0i90tTxx8Qy1nFSD9X+pSpnsut2mRdI5T9USYdDMRbEOzEDJXvooEEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-52403e39a23so1805548e0c.2;
        Fri, 14 Mar 2025 07:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963623; x=1742568423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6IBOXpPJJk/JaV0L9IS1ugMwz03f/5nbFfAAVDyU5Xs=;
        b=fkorEvk6/a0AQf7k0gQBB+jkZFgkUYH38jaI4I9DBxFP37PAElo1ih2HMehC5t2nL9
         PHGh5YnYqWLpQeSSR7IWedWjcPKa2eGUkmueXbdMaaf0134opHs9n04AotB/sREs8lGh
         5eYxBYfcGKb6bjfrTtsN9OM/VfHxiPLb3iPF8WBhokd1YcJFjcxG5/TOzfVVxhaBz65p
         3dY1WPQ3PQsoCziWKPdgwYYu8YBTimBy1jGxyspVFkqXkGvra5nh0zORVSdfUFLv0a+U
         aZoEFMoEqZdpentYQ9d0m7AN4MQXJlIC2eRyIx1qyutqkZqzAncR6koRsLLk/N1ICcVG
         Vh9w==
X-Forwarded-Encrypted: i=1; AJvYcCVLwI4NZQFxsOAOt5mc/388E9TzfGfKWDyXk8pSSFlZdN2oUSginNOhfFFRRbR6gc8d7HCj0wQAExA=@vger.kernel.org, AJvYcCXmL4Kvns3NKXklrYDuned9VHMO5MfREd9y3aHPiYjYhQ8ZfaBaoCu5jmUieer8Bc1mBS6APQ+wqd65XJ0GEhLlsqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOWWCLje0dv5mZm7jMs0/7il/ulTP5P8xF4WD+p8TGVVowXfv
	SeVbLPfkIoRGu9NHg9jj6cKvS6YKwsFA1BtHgMJ5LKi68XsofOfUNTfUqpCW2yM=
X-Gm-Gg: ASbGncvDT/8b5Y6XKO19akSBYbAtWoSrJwbZlkGVS0qDyJmJAel2w3f+zlqFEQnhpbW
	dx0a57Rgj8m6hFUqA4iASMP0vuepCnL8RcPEgpuBMjaT8zdZJ4YhNtlTlTXPV0fAcS5ajpwxux2
	GlIxlf1ZKwgkEIobr4x/ls1Ujecg8B9vcxWaYs+gPLD+hoc4+iJdMGSG7OL6zUkLCABJzxoGzAz
	Rd33BrUWBeNREy3XY5Y85IEWXXn5AD9sKV3QshHi+jtRbFe/bBEEQWLsfIVYllGZJ3oy4/sh4SJ
	mZfp5HzhFR1U/498KajOPf1OxDPOSwszC1oEgQ2jdH4XCjZkKbH8s66qggTUIWdtbtOAmLxrrE5
	xrUlkH+g=
X-Google-Smtp-Source: AGHT+IEiz0nCmaeUEFvipg1Yv2ULVgCmEl6mueJ+Ufx1B3AmmcmEtYmBU7x1dJzQe1u5F2BAAskbpA==
X-Received: by 2002:a05:6102:3a0a:b0:4bb:cbbc:38 with SMTP id ada2fe7eead31-4c383110403mr1652538137.5.1741963622733;
        Fri, 14 Mar 2025 07:47:02 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d90d939b1sm554894241.13.2025.03.14.07.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 07:47:02 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86d2fba8647so1913825241.0;
        Fri, 14 Mar 2025 07:47:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZuJPvZ0oCsgCo/erbr8I08KTAl5JGdbBl/VaexJ79NLuiHanN6+6sfUY4g+dw0PPcSMZzqAkX2uc=@vger.kernel.org, AJvYcCXzA3njRLiMp0RhRfsq1J6Srd5gRnmiq7Dea7NTJGun+qMOAw+diu2CEUwrB6txoniLeBzEcZVikJ8xL3i7voYLZZs=@vger.kernel.org
X-Received: by 2002:a05:6102:41a9:b0:4bb:cbbc:4c with SMTP id
 ada2fe7eead31-4c383112348mr2009369137.2.1741963622137; Fri, 14 Mar 2025
 07:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com> <20250306124256.93033-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250306124256.93033-7-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Mar 2025 15:46:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVP6H3VkZN3ZbxK=HiGi544nzujVs6sKnUX585r6kScEw@mail.gmail.com>
X-Gm-Features: AQ5f1JrdT2EV2kyHlNTROC5i7a4ebdYmYBklBAIn_nOF8u72-wibAQy8QNKAK2A
Message-ID: <CAMuHMdVP6H3VkZN3ZbxK=HiGi544nzujVs6sKnUX585r6kScEw@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] can: rcar_canfd: Add register mapping table to
 struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

Thanks for your patch!

On Thu, 6 Mar 2025 at 13:43, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> R-Car Gen3 and Gen4 has some differences in the register offsets. Add a

have

> mapping table to handle these differences.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

