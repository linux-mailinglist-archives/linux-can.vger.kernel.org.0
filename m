Return-Path: <linux-can+bounces-3370-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F7CA7FB90
	for <lists+linux-can@lfdr.de>; Tue,  8 Apr 2025 12:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4E33A2DAC
	for <lists+linux-can@lfdr.de>; Tue,  8 Apr 2025 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92CB267AE2;
	Tue,  8 Apr 2025 10:10:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9B267AE7;
	Tue,  8 Apr 2025 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107050; cv=none; b=Fx6E10asOc+ZrUXsB2viWtPxSTbFlWrzyijJKMC5+oH0qlvO5rDD3XhWsj7BBBgzdVN3MgR+udjxwU+8BY8SU9Go0579XKLLtunx1jnq178uSlH4OIkIdUwLzYYKqicKZO75QTG0e2rT8P4FCpG+SD4RRBV4MVJdEUQIQcUzhJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107050; c=relaxed/simple;
	bh=7u/xSUkUO9yn/yipKrfGD6s8VmTbpmnDhlrjOUEUufQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWtoaBUSeDSX6uXX0X0dUKtoEFg+BsO9517PUDm46owH9+mk0wYWl+Mbd8qcwtebZV/pO/7Axv1PMOoHjg6BvpPvp4h58SgtH4JHBSYEGv0LrbY28gQ+sZYwRTkmixLlGe5yUNG67SA3m8KDxID/ykE7Rjd8rgsTojAiXa9tmhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-523dc190f95so2627561e0c.1;
        Tue, 08 Apr 2025 03:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107047; x=1744711847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sn0dEIDKEarsIBX53h4F7dKWgVPs41TGZ/71AYv7Vuk=;
        b=C3RGo2qpNerlzuDgOjm8QMltwSDuh0pZJq50TC80arIQc984nS7eArIHZpKUKreSS1
         +3eh/oheTM656qss5iZgxBjqetTQjz+jb62Mzg4ZxgAIy/DeOuYb/rt1mP8VYzBPkLIT
         OSBvzY36XRYQGVnaN0x0b59LIYf8iGz6Uzxk2Tv7pPNUB5X7zwEs6Wuopf1evExubzR6
         wRjJjlZ0nJFj8XZ/jTW81WdSjxuCVC7x7+PoAdYO2Cd6we6F6mFa9ERStEO6X1GEipMZ
         hLBO1/pyen3gjRjJCmU4ST17+tQ0vDgNVgqNiJSkGTtR5q2tcqM2iDozE1UEgIohcT5b
         WOdA==
X-Forwarded-Encrypted: i=1; AJvYcCVEC2lENhRHt0HMX5cVYIVlVhkgNYYkpwgayv3AG0EfxOBSe1uij8iSaHrVjCwa0/niTeFsD+yu5Ws=@vger.kernel.org, AJvYcCXxElTONtEseMGIow97MaK827QsZ8P2hYcgyLXyCZOBsYQ6q9dpNf79Gmbp+NCcO0I9iOLGG/Z3/19i/8OZF5re7qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMb1c3b/rw0Ouhl9F/lcsGwnYM+NP3797j/TYtdgu8qd/7/eAp
	DAM3xBHfat90FQbB0DGsCzzy6ebuzozURtfsSycK17NbAEvtcIqfkVGm//gP
X-Gm-Gg: ASbGncvJqgSxhaxZOSTiw6MYW2WifzeoOTxbNwwxh4xBRr1PB1e5i+HLxREqJVe8b6S
	nyq/3Oa0/hxC61Iv/TQTm2If8J7CZ1NYuc83TZbABSpHDEeRgcSCamyRbT2ZLD1weh4Mlu+uK2f
	JQ66bDrRrfSZMQP9Gvb8FDBDruB3ZNMKdBdFSLmmo0qKvJddiEW52L/+a8fy8zPbLYd7MIyvPNV
	NSgK7dI7lsSVO2fbxfvBwe41h9mgOw/soV0U7Th9LofYHQCoguuSZzQjoTVtugftKXJp96Ppqdo
	IlaXM1FN5SCl9At4WnshMoISog/WEtT9wDRt3+SI/Y+Zw3vubCUQugutXyPIBqtY5ISaCFF3cVZ
	H117fPAQVezutzdLyPw==
X-Google-Smtp-Source: AGHT+IGagaV/gR8xBYykgGLsduR2pMAiQ6AYjhlgdUr+2X2KnYDde4Zs/D7ln0SLPbeiKbFb2pTLvA==
X-Received: by 2002:a05:6122:8d2:b0:523:e175:4af1 with SMTP id 71dfb90a1353d-5277308100emr7753865e0c.6.1744107046947;
        Tue, 08 Apr 2025 03:10:46 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5279b55a2c7sm311228e0c.5.2025.04.08.03.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 03:10:46 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86d377306ddso2318674241.2;
        Tue, 08 Apr 2025 03:10:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFc6rkNU79NxiEVuc7GQ3ds9eFQ4LMfu8BTaHHsEvhSTUv3tCiOmkudjnVUlZVdSellLVNl0oSTbxF5jqGl7y4OEM=@vger.kernel.org, AJvYcCXzEGiXCnJswDdVc/Xr9DdlAyZbVn6IxFO7Qc/foJyfZ7gIWcL6oKZOpp03MnZb14qr2nDMUi6kCqM=@vger.kernel.org
X-Received: by 2002:a05:6102:3c8d:b0:4bb:e2a1:183e with SMTP id
 ada2fe7eead31-4c86374a466mr9364968137.18.1744107046285; Tue, 08 Apr 2025
 03:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402102226.28032-1-biju.das.jz@bp.renesas.com> <20250402102226.28032-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250402102226.28032-6-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Apr 2025 12:10:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDrbAAwBz80ve6UbH8m4uCNe3gqoF6H0A1Sn9hUbw+FQ@mail.gmail.com>
X-Gm-Features: ATxdqUFC43TJTsokU2r1u_JcihKvFsaDXQx3XWImF67c1WmQlJNrfU_QrZhj9HM
Message-ID: <CAMuHMdWDrbAAwBz80ve6UbH8m4uCNe3gqoF6H0A1Sn9hUbw+FQ@mail.gmail.com>
Subject: Re: [PATCH v8 05/19] can: rcar_canfd: Update RCANFD_GERFL_ERR macro
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

On Wed, 2 Apr 2025 at 12:22, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Replace the macro RCANFD_GERFL_EEF0_7->RCANFD_GERFL_EEF. The macros
> RCANFD_GERFL_EEF* in RCANFD_GERFL_ERR can be replaced by FIELD_PREP() and
> drop the redundant macro RCANFD_GERFL_EEF(ch).
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v7->v8:
>  * Updated commit description.
>  * Replaced the macro RCANFD_GERFL_EEF0_7->RCANFD_GERFL_EEF.
>  * Dropped the redundant macro RCANFD_GERFL_EEF(ch).
>  * Dropped the tag.

Thanks for the update!

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -938,7 +938,7 @@ static void rcar_canfd_global_error(struct net_device=
 *ndev)
>         u32 ridx =3D ch + RCANFD_RFFIFO_IDX;
>
>         gerfl =3D rcar_canfd_read(priv->base, RCANFD_GERFL);
> -       if (gerfl & RCANFD_GERFL_EEF(ch)) {
> +       if (gerfl & FIELD_PREP(RCANFD_GERFL_EEF, ch)) {

On RZ/Five: error: implicit declaration of function =E2=80=98FIELD_PREP=E2=
=80=99,
i.e. missing #include <linux/bitfield.h>.

I will do more review later...

>                 netdev_dbg(ndev, "Ch%u: ECC Error flag\n", ch);
>                 stats->tx_dropped++;
>         }

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

