Return-Path: <linux-can+bounces-3143-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99485A6524B
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 15:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F003AD487
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 14:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150F222759C;
	Mon, 17 Mar 2025 14:06:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9EB23E35D;
	Mon, 17 Mar 2025 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220392; cv=none; b=J06ZAxFrcO91DMAco3rM1cb7cbDzNRK944BJfwW7Dp+IhmfYenwdKTSjvL1HeNREwwy4dy/6Wdsw3OHB3Jkk7hPZma+8RSdoa75X3fpjB6cQygoSbYimg39PhGRb2bbxsMY9UaEZIF38zR7cNSgBYNjpSeXdJwMIZq6xXBllcpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220392; c=relaxed/simple;
	bh=gmbCSR2y+3QOH45t87tpwhcq/aXoSl5xsSHRBF3eRJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oD8ZzgSn3sew3NLUHwqr8lQ5xbAT2MAeK7z6Ij5M4TtIMmT3I+1PtXMJfSyrm1EIpOKBD708Nk0B6goaJSdUdXMuR9nZwNBQdq/GTn2sUpFOJm4eevQJA0vi0KiVEMy2VI3LbYg3K/2ktdELiMumd06hCwc9lmXOZVjVybBU2B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47688ae873fso42981291cf.0;
        Mon, 17 Mar 2025 07:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742220388; x=1742825188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kc4N5iU6icpZ9GRMpT2zHqWO/CzFUF/EGCyH0dSNU+M=;
        b=kkV7+Lkp5cnIcLunjt1L6iMbqryMdpwnjnMKG1GI8dUnfMdUsdiXbBBwLtcS++l8AC
         ZP5uaPo9Oq7xq9WyCA2l12npXKQLdUL2hp97u6oCxQwePzkxd7eNhKISeQYSe4YeuVFV
         mO33XStals2YS9qmjYqA0ezUNiUU/alZFPmba7pVE2jOn44YpctRFYL05Car/9ER9HuL
         gvYcoAfNrKi3mf+abqHSBC5zULQZahBOwkbiMH4ZgMtmhXucEsb3VY/4qyRZ8HDn6HL7
         b+7huxVi1Qjn8s6kNIzT7PNG9TAi6NKPlD2ObVWfo6JdBbtrsOFQOfdK2WZez1hLzehS
         cpYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmKUo11t6BiMUSiSWPKZNBp0iLXSQU+vgmI5uAE6pkWxv36NsvI+gEn6LAOQLzJY8I5BqCEc4Lmwk=@vger.kernel.org, AJvYcCXmkt9XQuf232HhLd7OtsEzTm4FxRBHyedjp5bt1pgZ1ueayEDXcOZ0AUdQmLr8ipQ++Ur42jqqIUWOslEfM1y8Wyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+HNLKH+n0AaKnF9olEVXMBoAuik/UILuv3sQxp9jXxHFXTjme
	23LudVfb4LAuLJ+VXKCx+mB5ewuVMR//hZyT/3MWRwRLdaZ4dcVVHuFPm4RP
X-Gm-Gg: ASbGncvdYm4+LdPtCZ8g5+Olc8p3Jkz1U1NoTuipn7i2BYLNi2+ReluwQJ/ZMGOuHMP
	iz1iIUw3Lo1RqsC6kaaY3pSAX12sS8zkFTP5UYbuD0GYE9tKySnWi+TyHCAfP7E3i4m0OngVqy1
	LqvoReq8/MjgGolcFJGSDBf5+B7zWrvafzF3jSxbrH4foVc21D2u+vcSl+OvxAZEolbNKKDsa5S
	keYUb9G1qy0i7IZTTaGg1DyI54B8vZUKxT0SwOVBRgZl6oM6Bw2xL1PSOUrZPx9tvf/WgdBpJeR
	2Qtv2bhyWNDL6iT991UtyxQaKmHV89hTykKTCetypxavUfFzIPLHPJbLaY9TtXCEPC3lrxbfjyz
	vUnLAKk5iqnY=
X-Google-Smtp-Source: AGHT+IHaIH28NxtRXm7ANEA1VL3gV9FwOTxyK3CjIgORBPPyr/U6VIbrQHCqafI+n7pL1FHNDgLdLw==
X-Received: by 2002:a05:622a:41ca:b0:476:8825:99c2 with SMTP id d75a77b69052e-476c810f8a6mr126095031cf.10.1742220388423;
        Mon, 17 Mar 2025 07:06:28 -0700 (PDT)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb82bc80sm54266391cf.76.2025.03.17.07.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 07:06:27 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7be49f6b331so450504585a.1;
        Mon, 17 Mar 2025 07:06:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/+6t0xEtPZg/0pz18jYQ34iayrSH/n6b+7giSxByUQb4bHLsF4zgxiTJSEvCAx/X2/3l8jYT8UfVGMOR+FoEmj14=@vger.kernel.org, AJvYcCXuy9CRb/2QjLksL2CHbw/CYBIwRzyftfuWF6rfADUzWkDBoLcvW/mUU6yTw4u6ZISR8r/BWtc3iKA=@vger.kernel.org
X-Received: by 2002:a05:620a:26a9:b0:7c0:a70e:b934 with SMTP id
 af79cd13be357-7c57c736d09mr1873799885a.7.1742220387511; Mon, 17 Mar 2025
 07:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com> <20250317123619.70988-9-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250317123619.70988-9-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2025 15:06:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXaneixw3t8M5jCcTuEhO9HDfXdsr6J76inr7SP8RZ7tA@mail.gmail.com>
X-Gm-Features: AQ5f1JqaX-bMePu_MaH-ym52rwcI9WR1mKKl3SiAvNOiSsp0v47ZvWrDROQ72V4
Message-ID: <CAMuHMdXaneixw3t8M5jCcTuEhO9HDfXdsr6J76inr7SP8RZ7tA@mail.gmail.com>
Subject: Re: [PATCH v5 08/16] can: rcar_canfd: Simplify RCANFD_GAFLCFG_SETRNC macro
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Mar 2025 at 13:37, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The shift values in RCANFD_GAFLCFG_SETRNC are dictated by the field width:
>   - R-Car Gen4 packs 2 values in a 32-bit word, using a field width
>     of 16 bits,
>   - R-Car Gen3 packs up to 4 values in a 32-bit word, using a field
>     width of 8 bits.
>
> By using a formula (32 - (n % rnc_per_reg + 1) * field_width) we can
> simplify the shift value in RCANFD_GAFLCFG_SETRNC macro.
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

