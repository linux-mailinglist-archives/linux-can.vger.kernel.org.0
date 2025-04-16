Return-Path: <linux-can+bounces-3411-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39135A9055A
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 16:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794FB462EFB
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06A21B0414;
	Wed, 16 Apr 2025 13:47:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7E81AA1FE;
	Wed, 16 Apr 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811250; cv=none; b=VeC4ae2QlFu0pJd6Gh7Ss6lEDXViS/GwDxQjiRCtgJasH+0/W3y0w1LDxDmA6Jeh5tzy2Gnz/zc8uBFeDh3eYWTN2s1rBh6pe0FMi8+0dkAL+sZDBybEHpoy2xfShBnTvUVBs8lnB8nRw+YN5DTUKduD1/8hCRmi6S5xncJa1Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811250; c=relaxed/simple;
	bh=sdoEB53mz0KYQKVfN6rHI9ZKmoGwsVg4m39GnhuoYs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICAveEDMAxtwFLD6QnnL/nZMNXOYdp4jKjtH1kjHyctfHtyme+cKIXl1h+fcg1JQrc1infbw0aPfne9dl0wDPmdP2++4zrSb+BSy4ekrYYv4NuPpOLVT6br3fALhPGrXcyPGyMIoxQojE3D+qTMd4qrsKzdoFi87HDoh05TRWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8fce04655so58777616d6.3;
        Wed, 16 Apr 2025 06:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744811247; x=1745416047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqqbu0WkIihSw83vf7N7K9GU9PWHkoY2ZyYza6PUSoY=;
        b=R/8Krf1Tlf3bRk/ZrNybZHOqupAuiiMLEZDgEldqxi39803t3jaT5pGFnFp665uE2I
         SSrRRp47gptDEM000j4r3W5LZ4lmUGmqhIkglU5aYYS26aRK7LKN9mgLka1GybrUjvK9
         SXISE1QxW2xYfj8X4PHTmaLyta/gKWwiIZrPWFNzX9Tl0GhJrdTvj49D+lrJn2axG1Tu
         rgVOUAsBJt6sgZ7SOUUM1THp+Zm0GZYTmR5oHCnm/7L0ig40l9fJoy4fDuKztxgZbpjp
         pBhtednVe3mq1suTjtSS9OwzOsGXfwYtNmFiBU/0ARZv8gx4EvHoY0H78Ewb6iXHK1QK
         ZDIA==
X-Forwarded-Encrypted: i=1; AJvYcCW7+bWgyJ3NpuVTSkF8oI7sUffC4uHFm+9MWDZ+wclGa2sPL6MKoqNh2e4HAv/G/AZMMfpLxCcxuNPiYE2XPahPPHw=@vger.kernel.org, AJvYcCXJS6LswkuPdTsdtiUcTPs6BUsSm1h7g4AChz29XSB2Bn+IzbOv7sxJG81DE1aYkZX4Z/131a6phCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb7iCXi8CF0k0eC8/QfvXPZj09Z+KC1C89gR7txxFW9infXCVn
	RDa1hfoGcTQnUy3Wl5xJGnPOEnvN4zBbQcM6m5Fgn8ZbfJU+AzYnhu1a17nj
X-Gm-Gg: ASbGncuB7ESYb8d6ZIXBMP4sWdZqILTa2++VLhZJKmqZKFyZLtVcJib//r+ck0l/ltt
	3hcIAr8m/SaEpG9NtR9/wI64jk6uZ8tIaf7+6bkyweR+X8jsagi/TThq3YYI6HgAO5IQo0zneBT
	gNCaJTRSSYeeaetnT2Z+HVsrq9TG0b1E8163mYb8FGM/pRWDxQIcXTFm9U+6nztDMen1B31xfJT
	YzEF6V4x+MMcvg/F3O+DqqPD3yfRbJkJFmvXoxRzmbGG0eSHTzsBd7DaWL12FbOSNhwp+sk7GjJ
	vbeJzTEnUmL82Cgzz8V9mmvNCpsufMuPGEflxgkPAxdcjqOKuH6LVgYSWjwdGYqYNuxy1o3VPiE
	it3NHE8uE1/ewaq7/ww==
X-Google-Smtp-Source: AGHT+IHRCr95uAwJP3pkbLTPKlkRBZ7XtVynzvdctHTE88R9jSWtq6e+y/sCPleqJDqp90rRo+Qp6w==
X-Received: by 2002:a05:6214:762:b0:6e8:fbb7:6764 with SMTP id 6a1803df08f44-6f2b3057483mr24995006d6.45.1744811246889;
        Wed, 16 Apr 2025 06:47:26 -0700 (PDT)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de95f801sm117340406d6.5.2025.04.16.06.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 06:47:26 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c542ffec37so678653485a.2;
        Wed, 16 Apr 2025 06:47:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWhH9aAVcpXT8Dqt5DOtOAPy+iixuvesOWk/EG98s3Um//H2Bt+jzrEJWv0nqb7SkVuWuPuo1zLHWaslcjmZCzJRA=@vger.kernel.org, AJvYcCVKQRJrCElZloLmNXGH81o0f6HPl+HlpYulP9obFNzkP8ARtpgqiUu14t/l+gK9Na7Jv04mXalfQmw=@vger.kernel.org
X-Received: by 2002:a05:620a:44ce:b0:7c5:5296:55ba with SMTP id
 af79cd13be357-7c918feabfamr250866485a.13.1744811245835; Wed, 16 Apr 2025
 06:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402102226.28032-1-biju.das.jz@bp.renesas.com> <20250402102226.28032-9-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250402102226.28032-9-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Apr 2025 15:47:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUGWzdds+Fq+dR6xvjS+n8+hOK_VG93TLbzvmGJ9=LOHQ@mail.gmail.com>
X-Gm-Features: ATxdqUFvc8lxIIn8uJQcWoq5RSZRxDmgAxtNH9_afju2wSBE2UFGE6_u8rjz1XM
Message-ID: <CAMuHMdUGWzdds+Fq+dR6xvjS+n8+hOK_VG93TLbzvmGJ9=LOHQ@mail.gmail.com>
Subject: Re: [PATCH v8 08/19] can: rcar_canfd: Update RCANFD_GAFLCFG macro
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 12:23, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Update RCANFD_GAFLCFG macro by replacing the parameter ch->w, where w is
> the GAFLCFG index used in the hardware manual.
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

