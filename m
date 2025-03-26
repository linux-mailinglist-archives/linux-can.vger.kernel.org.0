Return-Path: <linux-can+bounces-3211-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3694BA713E8
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 10:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0629E3AFD26
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 09:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B262815381A;
	Wed, 26 Mar 2025 09:40:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7BF2A1B2;
	Wed, 26 Mar 2025 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982041; cv=none; b=cfPcy+qaedz6xeSfDC7IBJq22Dsc2RZ8EgGZdkZ2CsN8uTUJOZ1PcMBkEKpsh3HK/cOnT2e50hBxZccnhlgj7mUmE7iy6kUwsmiv/djUzuJZ7/8BIjuQgNZBeBRsX0W7W6kSRSntVMWUDMsut9GS2MJVjA6cxp7sMHdxXRPZTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982041; c=relaxed/simple;
	bh=QdyqFy3DEvMsvBU17jzvoj9Vw1xK1m9CdhoW+hbUfkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFCYoChKxGSQwW5+Sc2OHaUfpagk9YpxBo6sOiSdX8tRP9v3KQw0VMEKNGIlh0Ksjgielifn4Dm4ACJxtdtT/OP2jc7qSyXG5h7SJrgu3za4kZkyj8ncWqSId9z/zP9XBjETQq+MswXz89D0lyBwqsvq0gish+r04rUjgcZPtpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5259331b31eso3013319e0c.0;
        Wed, 26 Mar 2025 02:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742982037; x=1743586837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6e/IUVbLKZBDaNXUvjvJWIciPMSTe+9z0wM1euWPxY=;
        b=I0bB5ham5OUXnP5/oRzF+fMieS5XLAvqs8QHTwshPwkFTultofPbCyySq+549Lw4En
         Ajif9fJ99wt5UzfHuag5G0Sh0cy3nBCHInVQlRhs4jRLR8vEP3sW92uLGqdno2f/Ofxl
         uisTcG36h/MXXFlI7xpUeDd/QCOJav9S9t54OoAlOCfLfrqWwE0ILuxlQRZjGmPqMqA1
         IdwkgPekHLUjU/mE7JgSQPvtjusDEu5psat1nskFiFQk0gWzhKzdPK67FpnHipX3LNXW
         SqvN0nXwFS1DJ2H8ou1BD0yn/ZZC0hC6nD+UGj8vcvfHP8t24q5WPKJWlmXVf9LE9IxN
         dPjA==
X-Forwarded-Encrypted: i=1; AJvYcCWiOp7ffRlqQCgOsxylnfOE/jsrgIiIPokH4t2H14RDywxgjiugmfg4zusUlqyLc2mJ3o7lC1viPrntWXMBwXjf3UE=@vger.kernel.org, AJvYcCX4hxHoXhyGjptjleSOoli1ARQ0zmgu5DgnqqpO9ypA1fKm3XDCNfNNDsUPSlEsJRZBO9bBEQ6rBq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytj1pdjvk8H3xtHwbFc28Enpu+ASIBemy0IxgWe0HAwGGrAhQ+
	Mbn+e/VYFdh1Ihb2iUXzwl9OxqNa3vuMiZSh6zNJPYjI2UQ7yBX4gHK+FM84e1o=
X-Gm-Gg: ASbGncuTBUMDQejiqlpcDM7aKhIgL4rL1pk7fyE2efRIz4qv1934jiBqUOuP/l7Ch5O
	YzRG4v4Cy3zr+R5K+WrQQeHIxezgLmg2BK3V4y298OfwPt0iPlxtczX9V/sD0bp4s6MKyspgZ9P
	3c4yUVGB2oh2rWWA2A1ILSu5+llBI0NIyywtWCEh9b+jtk431bfmgc0w9NutGr7gwoEkho7GbrX
	zSgd4ELDQ2YXqUL0O5CLz6z0sRGhPz6fM/Rh494B3vbaggAwlQLhCZHq+vO/1ofF9B9NnuxmZHE
	BkkptHgyPH6gAf/JwgyObcMLXP2CU0um9kD8ARc4xyZ6tt0YHQihRu79rypvQ+UZmXcU6Ew9k49
	t7j4gNE8=
X-Google-Smtp-Source: AGHT+IGnq9byCkUZp7brL3tzMJqDShkmmfTwSa04bZmBVvnuWiSXRLtVRBecVvQnkarSYtYWmgnnKQ==
X-Received: by 2002:a05:6122:88d:b0:520:5185:1c31 with SMTP id 71dfb90a1353d-525a850df05mr14055014e0c.9.1742982037414;
        Wed, 26 Mar 2025 02:40:37 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a766e5f2sm2163872e0c.40.2025.03.26.02.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 02:40:36 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86b31db3c3bso2607014241.3;
        Wed, 26 Mar 2025 02:40:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdhArpYZfGGllbJ1KJ2FxDD9F+zOElpzBJc6yj4GRmLK/AFAo7+SOSExvgUN3o50HyBcWEOZar0WnvOJeSImDYGIs=@vger.kernel.org, AJvYcCXTf8bZpoRXm89sraWO8a2ot0ipudHzdD8VVpJw5DG6GqDnLJz7BsLYajgTHJg8ph76+9qNVyEBewg=@vger.kernel.org
X-Received: by 2002:a05:6102:162b:b0:4c3:9b0:9e6b with SMTP id
 ada2fe7eead31-4c50d4ce4f4mr15374318137.10.1742982036183; Wed, 26 Mar 2025
 02:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320091101.33637-1-biju.das.jz@bp.renesas.com> <20250320091101.33637-12-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250320091101.33637-12-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Mar 2025 10:40:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVVtR8FiP3_k0zwqDpp_-pkm5J0Xh=KPedcf1-cRhBpwg@mail.gmail.com>
X-Gm-Features: AQ5f1JrYZUyFv92r2xE3Y2QMr9HAWoc9Dmob0OW2Lumsk3vBNIkAnE-3zELlIx0
Message-ID: <CAMuHMdVVtR8FiP3_k0zwqDpp_-pkm5J0Xh=KPedcf1-cRhBpwg@mail.gmail.com>
Subject: Re: [PATCH v6 11/18] can: rcar_canfd: Add {nom,data}_bittiming
 variables to struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 10:11, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Both R-Car Gen4 and R-Car Gen3 have different bit timing parameters
> Add {nom,data}_bittiming variables to struct rcar_canfd_hw_info to
> handle this difference.
>
> Since the mask used in the macros are max value - 1, replace that
> aswell.

as well

> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

