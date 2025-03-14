Return-Path: <linux-can+bounces-3086-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C84ACA613EF
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 15:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1864016FF86
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F451990BA;
	Fri, 14 Mar 2025 14:46:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E21A83F2;
	Fri, 14 Mar 2025 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963568; cv=none; b=mmyHbxvUlFUlYrFItVwjiV5gEkjnqYH60Ufw3ya0YHd6MH8VKUZOXNEuf5IafH5DF/cZh4JnctFo60pJ6rG98EvxhiEj4esngErnQLLMQBc+XZErAomApzt8pk8ikIRkHoB/t0+OrpVSsOjIh40OJEGFX4Awhk2IXRy3sOB6R8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963568; c=relaxed/simple;
	bh=DU7c0xNgpn8VO3JOAQhnBvqT4Y4y7S5SIfuOMJVWGX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGs5KehJDoXdrId9EubJ9Yb3Lo7CSnazLBWK4/8wekWYe6+1EEh3wvWaoOkxQmLKYxCJikNcivcRL6U00as4mLO85l0bVRzF0CzbsfrtDkD+7YUBvDQpQ1EVIhAYHsgHlWdC3e3sulvl0n5KWL/MIXe01zkmBexUXieUkrDFGHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-520847ad493so1773780e0c.1;
        Fri, 14 Mar 2025 07:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963564; x=1742568364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifdxR7trOQf1kajicfBPx4dMU3nASEFJyuuSU5FARkY=;
        b=qFi9fI2S8k4K/4DEU0DyT6nUVna5vPyZP6qBRyrOUo1IeEb+tJSc3FTuQIuyGtrF85
         gysw9nH1VtX+73CrJCBNpZTSjVFPY6vbrZKjDI7NJNEMykvJfgyOtIKPwOokWneY94ZH
         GfjA1cyE5VUNCwxu9omcRdgiRRo32/xjDJxLQV5Og8gt1b1T4JBFijUPrmfIs9iLgcnB
         wedb56GOMUS4zo2aaBCv3CI+jlU175vfKMOZaR2RE88IwJlfy04j6lf5cNi88LS+RdAD
         OR1qKhDR9QNF8x+cG4pdCYrXIkDAGvUZeo1wqjuD3fgtPe6qrRf5kHVMJjePnGMRRt+T
         i6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWjo/1NATGaCh8T7bLQicg36J/6bNtyj9p6O9kqFygD6L5V23m7ZsoJpz8ibEXmGm1uIXkCT8q3M0A=@vger.kernel.org, AJvYcCWoPGuQ0cc24JfFElV/BiMr6NqRrR9vllfB+iYrAuG+qQ/Fppbn0FHWipo6JsHqcPvxGo1J5ZCZbMuWbPkbK3VmY+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ag+Hy3iGMyv+Fgnsa15VZN3kLHAvdhI9rHwm2LKg17RzFkT8
	5Q/+uYwE9aFJoeOb+rDi/AIAIc58bINd6tnrbOQES5Ibh6cTukFJ3b0tU6R5Vak=
X-Gm-Gg: ASbGnct0SOosS8eN/a/5IBdkLthNC88rwE7j34p0YPu0LuNkQSy9KJlX1c41oFAWlMY
	12BCdXKDxiAzdxBrWycq+QsVAHtrQp6ZF80KYFHcX0a7WFZYBQqSnc8JBA7mditvg7O+acN/pNY
	X0C10+IBuy+UCfDUlxubjM+fZ8/l0hEjNIO4b9Od2CwV+Hgbxw7HRlOnDu8zF0WOxhvQAJXdO4/
	rRlCEYDnPnNIX6mTFJEaCRQFaOanR+zAHx0j2GOBW2Pghs3s8Z9AzM2OJUAftQ0JS99MUErRE3F
	3rWnkBuDeXdZT0vNQ+boDK83s3tM+SMLy28ki2Vq4NI/nD3hWviSjl6cYtV86Wi5FtyFYztVuB0
	0vZTcsL8=
X-Google-Smtp-Source: AGHT+IEpWLhULwDxBBJpOxjMR1xq4YwVUQG6h7zq36W1w63H2hknd7fOC2Uj06SBwYvac7cMcySn5g==
X-Received: by 2002:a05:6122:8d6:b0:523:e2bd:b937 with SMTP id 71dfb90a1353d-5244989f8c3mr1915783e0c.3.1741963564418;
        Fri, 14 Mar 2025 07:46:04 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a5cc4f3sm584367e0c.23.2025.03.14.07.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 07:46:04 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86b9d1f7249so1872263241.2;
        Fri, 14 Mar 2025 07:46:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+CBgwlB4AxpFpNWv0bv8qyn8fMagCVdRgOvl14NlcWY0fPihyYMSDsYBGExo37w9vMGcB4/YI4B0FgSMqX9ace2g=@vger.kernel.org, AJvYcCXuKVtLBaDsLPDMcpgeDAuyBgoueTcBVBUTQzq3mpp885TCI+UIriqEyewYTFgg6KjcJ3BzEUNxDM8=@vger.kernel.org
X-Received: by 2002:a05:6102:d89:b0:4bb:e5bf:9c79 with SMTP id
 ada2fe7eead31-4c38322951dmr1695698137.22.1741963563841; Fri, 14 Mar 2025
 07:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com> <20250306124256.93033-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250306124256.93033-5-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Mar 2025 15:45:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWE4-2UT1hjs0rrnmaRnxuQz_LA-c9xWLphrwBTXRV2yg@mail.gmail.com>
X-Gm-Features: AQ5f1JpkQSJ0_LKVf5KNjX0SmUevwwXqz2u63Xt06WYskuuSxaFaaq64chKQEfE
Message-ID: <CAMuHMdWE4-2UT1hjs0rrnmaRnxuQz_LA-c9xWLphrwBTXRV2yg@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] can: rcar_canfd: Add ch_interface_mode variable
 to struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 13:43, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> R-Car Gen4 has channel specific interface mode bit for setting CAN-FD or
> Classical CAN mode whereas on R-Car Gen3 it is global. Add a
> ch_interface_mode variable to struct rcar_canfd_hw_info to handle this
> difference.
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

