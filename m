Return-Path: <linux-can+bounces-2904-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB346A3DB16
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 14:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDC7189B6E4
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 13:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1791A8F6D;
	Thu, 20 Feb 2025 13:17:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EB71F4262;
	Thu, 20 Feb 2025 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057465; cv=none; b=WrPAbHVEw8VKxHBz/oEintKV038myk7Q0K2rupJgN+i5z9+00OQnylYBcrBz9Ed4cfg6mirEpicX0rVnaWtVio0RWfbXKmjI1EiyW/2IScFmeBxb+Dmn2amSKUeKcoC3d7P8mLnrIEIqpwpIYfZSPqb4p39oPh6l/ym/ARDzUkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057465; c=relaxed/simple;
	bh=OS3z7ALxQoHDxz9A3w1QKV5MAs2PgxcM+RGJ8dziU/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjWFrcJqDlchNyVMb5mYh5MX/8ODtD0Rq9d2YSvOFOEwfR+GPxEk14elEcaV7J5+94/7lK95KNmdQdiRbUnBGzqo/QLtuC4xZn6vKX/6DevBshcnC2BjV6w6mDkzrigFcF54Ibe139+uSvfgh6+MZsK5M0ShRRV0nN4+pFPUgEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-868e5684712so229093241.3;
        Thu, 20 Feb 2025 05:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740057460; x=1740662260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTEqKWnqcKbGV39w4JvnHryZ4PrkgUOhPB4n5Z8x7hk=;
        b=aPm2qTZu+XoG6mRZpE8a9vz5V6CPmGMsujEoORLDyh0pPUjkRdVFBgcgrLsMJsl+Jm
         GR9WrWzaF0BpiYzXTicgHyIgxF8SX2EppgUXyuBn8kvNde4FsLLcdESEGiMjEN0QKUVA
         Y2F7hXifKl8rw5/JwyyXVAfodmHzKz/2gbJLq8cVQj9LbOWxCjF8YwZxfjhVu1vPBo1J
         zswACxiQLmUjvE1ajEnOVlgJA4F9DBktPO+ZHq2qpdrhYO7CkXOE1rQa8AGcdErXCfR5
         VB42GcpVIwV2vrw6fkk96hpWef/RYRu2M3ZJN7TV6oG51IhUPwgeUJmH2DuHayLrJdH1
         c4bg==
X-Forwarded-Encrypted: i=1; AJvYcCVsBWHKp2hMVQOZThTR96Dz4ZMzikrB+ybv3jsm1hZeIv1x5yJMx27o7ZimcHFY8hWBY173ibDTr88nNrDy54LDM6w=@vger.kernel.org, AJvYcCWnD1kIvo5bVYnefO7GK+RTRQdAvQ2S+heM5xvVnnuog9ntZkXP8qgBUF/ey50zkfD8pMQt7QgJdGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzonxdRKmBjrjHGv1/oT4MdvGs2DZPLg+uy399zAoeaWLCrvaww
	POwIMiDDMp+qf4YH8wyqnm5LSEoADaFe66sGAWcMJIavg8OD4XQzN4ZWagGO
X-Gm-Gg: ASbGncuURP9zGTv/WDDxFRT1QvtMuJ33gGY9qQld65ga1GKUm1lNQB6EQgDT4igLjRD
	A3hYYVbg08jFjuEyN30m1tPUwiyPodS3Pw5SlCGqsx4t8LPyob8ls7/aItkdZUFwXJTuaAEaimk
	OLxIbel3gravMCfYUQDCzjNJBNAOwFIiB2NRHtlJ93rxQjtWvLK2nFKZ/ap3sMQWSCDtGaV5NkS
	v3tj1CiG3KKoC++oCS3lXlaNouC2uziEGx/73EmPGxBtaiNnKbZtanbg6vn1BZvZ8Jz0d4BwjPH
	KNDcdQb9lF8SE6nfvDEn+vGCJZXYf29JraBB5w9M8lgid6grKrRo7A==
X-Google-Smtp-Source: AGHT+IEx6vhhbEeToZvHi/bYBGBzZAszDFqphIkbpJa5ZjRlhKgAQNxsnpxjSCrxt99tTRZMcu+UaA==
X-Received: by 2002:a05:6122:3d10:b0:51f:4154:c1b2 with SMTP id 71dfb90a1353d-5209da3cd8fmr12194773e0c.2.1740057460074;
        Thu, 20 Feb 2025 05:17:40 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52098c98d26sm3121371e0c.8.2025.02.20.05.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 05:17:39 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8694ffca83eso147131241.1;
        Thu, 20 Feb 2025 05:17:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAB2pgs57ZtSZZRDwjcWW+NvHCpDCs/ENPOz11NktyrG6dYc5BOG7lgl/6mQkg0JvIbD526abK+9w=@vger.kernel.org, AJvYcCVZRztIN0zhNWq8iPtetCigu9F0kgqi8ylyDVvXpvCpsb9AjrxM3ibBg0G29JS38Wy9lwG/zLfzW3vqyvum790brpY=@vger.kernel.org
X-Received: by 2002:a05:6122:658b:b0:520:420a:a07a with SMTP id
 71dfb90a1353d-5209dde2362mr10745473e0c.8.1740057458950; Thu, 20 Feb 2025
 05:17:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220130427.217342-1-biju.das.jz@bp.renesas.com> <20250220130427.217342-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250220130427.217342-4-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Feb 2025 14:17:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXWfszP40uT-RxLzDMFY7O=Crm0O0b+kT9xADpJC_2LRw@mail.gmail.com>
X-Gm-Features: AWEUYZn4GideiSNlnQthZAAA8c7UEy81sj5Um119YC_tj9IGa-qzxtReamtZ2FY
Message-ID: <CAMuHMdXWfszP40uT-RxLzDMFY7O=Crm0O0b+kT9xADpJC_2LRw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] can: rcar_canfd: Use of_get_available_child_by_name()
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 14:04, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Simplify rcar_canfd_probe() using of_get_available_child_by_name().
>
> While at it, move of_node_put(child) inside the if block to avoid
> additional check if of_child is NULL.
>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2:
>  * Added to this series as dependency patch hit on can-next.
>  * Added Rb tag from Vincent Mailhol
>  * Dropped redundant comment from commit description.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

