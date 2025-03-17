Return-Path: <linux-can+bounces-3140-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC50AA65237
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 15:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D986172864
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 14:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3FE1474D3;
	Mon, 17 Mar 2025 14:03:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875ED20322;
	Mon, 17 Mar 2025 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220232; cv=none; b=PLzKf0V5jdB1DHlAQKz35S3zjQ6mwqNNHQURSj5hQVGy6FJ/U+Gb8jqDxILZdkeXm5+eshT+CjVekLgeyLyQfp+jR5w9gJgYxFrIzwgRkC/xCgxd/XB1anQ1V95Qh37NMy//stLc3+0hvpwgmdjlNs40CIN6/5f4c1U8rgJz3Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220232; c=relaxed/simple;
	bh=rv+cqhkNmaYwY2RibLKB60LGT3vhgCnK7tnLm7TxXB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYd2A0wqAcoPs4ylrhk5VOaETsqVRrQ7K5lN1jvZdk5JvJiZkpCLQQuCZ3L3pbZiwNNrta+xtiNDCr0tZ2fvrg1kpvrgWpnyKSeK2mA1L+GfefdHg4Mpmt0/+qijvqxrPwVY6fQECLdhUv/JJ/zEa7uDTKP9x3iwcJhInA91rCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c0a159ded2so593184185a.0;
        Mon, 17 Mar 2025 07:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742220228; x=1742825028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84vV1JCz+LQzh7tMd1uB0s2VWEBMo5DVMU7V9Q/LUrE=;
        b=kBL18XZAVRVEHclhWDaCD1Trlzvh/yE/7F09DlZT7kkhoc/VZD2zPjgvpNgcukxw0t
         S2K50eJzcS9b9w7E3ox95DvqUcSA1oZPAtbKqoJiAhIQNlxsSz2Cst0XpshJhPJ4lBxT
         IO52E1eNaoK6uAB9kj0MAkR3bTvKYTIqggFPzTX1OBKTgrHa9o7m4L6isS5OhhQ5Z6BU
         oTizSRgb3rmX4PIddwKSVpPZj5rGvIMFqH6FmK4i+4daRVm7df/12v2FbPp1yZ5bvnod
         osgXwQa2InuReEfr4G+1mr+hq3YvkjghHfJr5PBmepU2rgYgpgboYPyAhUpn986ROBQn
         Kdag==
X-Forwarded-Encrypted: i=1; AJvYcCUCTJX3/tJ30UE7sbcHfDVOb32tAeg/zMFv/q5QgGnIxJ8xET8gidSBImXehOVSXkPdVss++vLHsHI=@vger.kernel.org, AJvYcCUF/PkvZQcq76+0UtPneR5XekkOLv/yeerYZgvDeIPc4AwIXLWsYZ5pUP9nQEeSQj3O0KAXgmMdyCAPLBI4ZGnwhJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Lkv2OJ1AIyWVWTCdE2VNg+kv5VmvNI3KVLM1avpG9rEYrSKu
	pyFqn837LhPIxEVSef0yPfcw1BWDoR6lSToYV+K6GqMuN0QdY1W9a7F9+nnt
X-Gm-Gg: ASbGnctN1biABhHnG92VolQJqvH+zBBhpm4y8a1pBXs3UiJ3fs6xwjQYWkiE0Aqjupq
	CTDDwBgqotoDp2nQ3JGE/7+fdmhmN7hXVz2FMfDIQR8Bzu8BxeivYtqj+lrFjr5DDdPhQtRsm7b
	Z/rKypc/0IFX489kiBu8o/WN5anNEfWZq6tvFh3AYG0CxtU1M3ug9jSwo7ge1W5RXc5kQaq9NMD
	pQuUXifdD/t3TqKnUkb4KnRVe3ixOt6k/waEIPq0ke1MpnsG6WzUXDRBUI1mHRHf92io2PYJMg+
	9NnOqsOLmGskZFLLocex9dIaskvDOS9GYAjfrfaomCymn9SGo+7k6emSBqjZtlNGLs/nmE5pbBG
	ssQM7O9gFkaE=
X-Google-Smtp-Source: AGHT+IGKxiBhfCL9t0LfzeTDHp998NUyEQiZTOo/IQ7BR1x3p2XI5lQJCpRi9jdIDuIo5/S2YDVrsw==
X-Received: by 2002:a05:620a:4550:b0:7c5:49b7:237a with SMTP id af79cd13be357-7c57c7e22d5mr1540077285a.19.1742220227994;
        Mon, 17 Mar 2025 07:03:47 -0700 (PDT)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d8a06esm588404385a.93.2025.03.17.07.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 07:03:47 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c55b53a459so434298685a.3;
        Mon, 17 Mar 2025 07:03:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUBpTd0T612CjLft8ul0veWPJ5DgkygteJEP3yOqWid+TDJ4UYTwF0/yrlO7x+KkKRTFJo1ONvs1E=@vger.kernel.org, AJvYcCWuFO16U0K3QsgV5c1mYsuM6WLBx0eOeddt3EXSRi/pE6KmbMKCNyaH3WMybk5P4M17SRFURnL+9GMZRG7wYGw6IH4=@vger.kernel.org
X-Received: by 2002:a05:620a:4387:b0:7c0:a0ba:2029 with SMTP id
 af79cd13be357-7c57c908d06mr2066008185a.40.1742220226836; Mon, 17 Mar 2025
 07:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com> <20250317123619.70988-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250317123619.70988-6-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2025 15:03:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVdc8sD4n2buYyKw44UR=a6eG3VeMf8Zo8EhSdM2v5=6Q@mail.gmail.com>
X-Gm-Features: AQ5f1Jp9sBNJknbdPP29Bxfpc-x8Q6eAI8x6dac2pmySco5C8fVZTIDnp70GVVM
Message-ID: <CAMuHMdVdc8sD4n2buYyKw44UR=a6eG3VeMf8Zo8EhSdM2v5=6Q@mail.gmail.com>
Subject: Re: [PATCH v5 05/16] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros
 in RCANFD_GERFL_ERR
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Mar 2025 at 13:36, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The macros RCANFD_GERFL_EEF* in RCANFD_GERFL_ERR can be replaced by
> gpriv->channels_mask << 16.
>
> After this drop the macro RCANFD_GERFL_EEF0_7 as it is unused.
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

