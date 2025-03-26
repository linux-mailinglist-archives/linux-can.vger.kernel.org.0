Return-Path: <linux-can+bounces-3210-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C06A713E7
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 10:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAAA3BBAB7
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 09:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3EA185920;
	Wed, 26 Mar 2025 09:39:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87CC1A3A80;
	Wed, 26 Mar 2025 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981973; cv=none; b=ThBQJEe1G/46QVWRnVNdvif7eyEseIkWfn2uiKf17CJVVAn2ieV2asmCHBaPHMiowjNdfUcttCA6cMZ9jsAaTWRQ15z2AHpPDlSjbrDFvTIhkHHDGqZpI3AYKcAQFp1KmjMbIimVICg3pi3NlGitlxdRBwIQCK3GdmDgbOfXOeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981973; c=relaxed/simple;
	bh=zw/xrKhc+MHVHo3Pa9SHpHrS8+vVAiADBHc5Gu21toc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLC6hlXME0d4w4hNR/7iUFHPjjvBgxYPmihFFhPVL2Qfk6LLnCBwOMC1ZuxS6+RYxowyefmvBuMy9n1rx9urjP1eHyseYiHrBTpHbt5kgwL/Dx43FsEt0RPD5YsUWMRFIwnEIwUMYOhey7rtiILAqz4vbqbVqXT2gacjskTLbuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86d2fba8647so6296901241.0;
        Wed, 26 Mar 2025 02:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742981969; x=1743586769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3yP7fk0CipVt2LVgS7AnFph7AVutPzETlsy/zCNiq4=;
        b=I0QUF91RXzNtfl01hcdEPtuejKjEybnfKCZ0qtFa6nIggBJ5G9I6eL+Q8E4+FMnS6n
         6zKJla6KHtMFosvB5UCEYLpNv5yWfYVVghIANx/DT9Gc1zpI9uuonsWsUfCH0XHtCdoW
         DvQqNxXjqXffHIiYNBRhP/JhHaDugcm13kXoSB06h1lL8gRV1phxTC1CCjkRCGvLSt80
         jMIs/iBLjZcnswrhmuw8LXTL27yifBlzsTKfWLuM4ENqybVZrf2tcP0gA8HvJuSvUohJ
         09VljR9aJ2Mg0xGFcHso4uf9Hoor+yqnc569omjjLjpefRt4cgwI84qACG/zQv+es/tu
         YDSg==
X-Forwarded-Encrypted: i=1; AJvYcCXioLpp8fku7fvKsQY8DCqLjsK9TnkAL8CVTEqHGeJiZQyuAAl0ZSkkF/k0ONM0PHsNIqiIpkx9XFg=@vger.kernel.org, AJvYcCXnVVm9J1ipxaPAb6zPpBSWcvGgYeiixTL7qxTPpMRQZOX4cJXwNwS1MBmwhWxYEyT6zLa12uZLiIjp7X3b8uT5TB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyylJ9FSXQRQEtR3wZCysbIdKkjfDRJoaW+yxNW8p30Jr6nS/m4
	wWnznj2sa/0pcsi2q+VPuZaamhMkqvuzJnfZb42n02dgu5SIhSEGG/ycluBZEds=
X-Gm-Gg: ASbGnctSr49SG5WCXstugzH7sn0KUGBHpsCOC/SxTmwbtt57LwqYFM3hJ8DLpu6+yEL
	V9mL2IlxlcUWNRv6u8ngItIbEEhezGihPUBQEGTsOoNYt7nPsm0DBN1UQg/vzwLrRw2iuMwMPPW
	1fORL6XFNhMX/lKF17yH7+6vnvbC559lQZaLkUMtXMBMk8KWW/CU/jb25lFTnkH9Z9YU3MX4yXL
	EENK/JWBuII6KeswyfdWdHftnzEV27INY1TIAVa/x3GePTO1BsolN35+7MiHpEQOoGuY93mz9UP
	MdOR2rCE5IBmoc9BdNkM49mIMaJPEuViUBa5RRTbNa3H4QKlXUqdpmXBVz9TIL3/GxUnOUmKCPY
	vNgzBlEjW2/R9Vh9A0DgHZQ==
X-Google-Smtp-Source: AGHT+IFr0T4U2G3vzJVbaig55JCGq0ZkDULLqrbuTBwMG6eyBGoly2uzxvjNUA8FINzCsXN7w4EjbQ==
X-Received: by 2002:a05:6102:800d:b0:4bb:623:e1f7 with SMTP id ada2fe7eead31-4c50d5e3d7amr15283775137.16.1742981969404;
        Wed, 26 Mar 2025 02:39:29 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86f9f3c4828sm2393060241.18.2025.03.26.02.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 02:39:29 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-520847ad493so6348369e0c.1;
        Wed, 26 Mar 2025 02:39:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2ht/lGrVXItsxWM5jFB8iyuvaW61NczZJjj9kmtotgMrxMM5ar577NHNs86fxkII0QGCiKIovXeWkVRUXlUBoO4s=@vger.kernel.org, AJvYcCVx9EfrZFgjCccGWI5Ul6aLtcBmI8hRoot5imgpB7/3t8IW5jov+ZCCJDgi3NMXsAxgUkDFGxKwcic=@vger.kernel.org
X-Received: by 2002:a05:6122:469f:b0:520:9688:d1bb with SMTP id
 71dfb90a1353d-525a82f1da9mr17156569e0c.2.1742981968577; Wed, 26 Mar 2025
 02:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320091101.33637-1-biju.das.jz@bp.renesas.com> <20250320091101.33637-11-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250320091101.33637-11-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Mar 2025 10:39:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWqfE+ijJC1rwkEu=iypZmdnRc3=-6oBKVTQiDC9vyY9Q@mail.gmail.com>
X-Gm-Features: AQ5f1JqyGLUYvGRK0b0xXFU5tH7LVabBicjgC-F4wUT8pSqSsKVJcRX4PKJDm7Q
Message-ID: <CAMuHMdWqfE+ijJC1rwkEu=iypZmdnRc3=-6oBKVTQiDC9vyY9Q@mail.gmail.com>
Subject: Re: [PATCH v6 10/18] can: rcar_canfd: Add max_cftml variable to
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
> R-Car Gen3 has CFTML max positional value is 15 whereas on R-Car Gen4 it
> is 31. Add a max_cftml variable to struct rcar_canfd_hw_info to handle
> this difference.
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

