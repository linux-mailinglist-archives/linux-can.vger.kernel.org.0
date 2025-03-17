Return-Path: <linux-can+bounces-3144-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC2EA65287
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 15:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9592D3BA7FE
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 14:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7A224169A;
	Mon, 17 Mar 2025 14:13:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054CB241685;
	Mon, 17 Mar 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220804; cv=none; b=O9wPVzAPnSvNQ5H3Mh10K38PyA2ubufKPzfjfwW4j+HE2scFtBeVUieOigXjqo1U7nr3QrJheILzkX+kVrOTmAUcMwB6Kx5OfLCJY/mKJ9u15sPdGhb+KQw824YEAf5cppv80LXB9xhO2/SU5eFJGakTHdUlv3sbcOdPwQWC2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220804; c=relaxed/simple;
	bh=fIKOoMEacn2dZZaWZ3sSMbZe6ugxY0qtLt/W+YbjbaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Imzf4yR1NK0pZnHuaK0SVT/VZqSQL1h+F/JQ22rTt2zSeadJE+SHqoGcVPPxJilJ5LHGpz7M/rRKVCyaIs06gg38wVy0YSZCmKpRn8kRbMBFDa7vgHjfs+4C5M2AIuzmJrnIoIEL02ppcS1XRTJY+6ZrsZQszMkQn3RX7XlxvnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c54b651310so597997085a.0;
        Mon, 17 Mar 2025 07:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742220800; x=1742825600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tcz6qqF+bqcYZZTfOTR5lGqIp9dHgRyrX2HtWQnVAp0=;
        b=BB52PeQcj9ZkoHfMycZDmybWRq9BJfAIm6EOjkZoH+iCxwCE5QrgkyUYFFMSJ1e567
         ZSbZorX9pkj97pcAmVLv1LDOMGXmvPnw2VHAQdOVZNzYjWQhE+QHR60xUTgcS8f44s6i
         4N81koWY89J4FlyIuXiTTdpWj+58WGXdxTpBx9qoJBvtqRwVvT2W34ld0nKPLBDXM/7V
         ATvA3xuvVBdOMnJUPsIY4pHMkvRar0B5xYPiTfZtmOsBJVe30dJAHtsu58VLHWPoI9jj
         0Bw0IEbDwrrBfbvREpFL+oAD+w3TepfhzsMjBr/QtFhZgPaPhB3a32Yhuhr6+GF3ck/W
         bSOA==
X-Forwarded-Encrypted: i=1; AJvYcCVD2/FSE4XPHcwmuqPQRKmDE+x2QYPXJRvwnmlkBYifHNdALrXHlK2wpLEhWsV67iNdclq13mR5qoA=@vger.kernel.org, AJvYcCW0t9P/vdbqdSuuKoWHtaCV+szV4xfRnmuOjWh8FgGO0lGgf9QqqFbo2Wy9S9rj5Fafa/3WSFG1vY6gOv2QiB8/5rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUNafd42MuLyLp+LOauhhK8SlQzi2+28rfIEv0tKIZPL4Ck5oG
	YjWkkGWDU2yae8N8u9s/Gm/DDbpT8dMujpYtrWSxXhfdmdZdwIwQuCSWTYGK
X-Gm-Gg: ASbGncut9Ndm14nTQ4hDn5dY0aQjwtkVtQDmluVWVjhysY3P0U3m8waTBgEGJN26VJm
	un0WOZGiSKFzMNUpJDBEgm01mgRuyIomma9EanKDA3Jjs2mzukkbkEBVjNXqmbkrg06k/W8SlEa
	3MLMBo6Nifj4IJauZaPxjjQXNSLktjG+vnbg7T5zqsqCC1N8SXowt2pbszT58mfRbKl7+vx2UKB
	gTSou2emPtbQ59PfJ2sOR8eC9DIjWn0y9ZtKvhL5n+ZdeTEuI+2gsCIVNSDZlmfqAmmYJdl1jVN
	U2zuWWdAigurvRXl6ATk4zau6qMGJFqFr5XJfMbOC13Xw1YuBX/i7cNawHo1Vovk3NeRVxKXfFx
	GtLOyY1WUH6I=
X-Google-Smtp-Source: AGHT+IG637qT5jGFFfM7H1iG2pN3XY/pAOWWdscnHrDEgl3H/CmJY7xTjfOpsVGtIyOCb+OIe2Lzmw==
X-Received: by 2002:a05:620a:2a07:b0:7c5:4cb7:ac97 with SMTP id af79cd13be357-7c57c79bbeamr1629574585a.1.1742220800458;
        Mon, 17 Mar 2025 07:13:20 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d89448sm587042585a.90.2025.03.17.07.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 07:13:20 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c554d7dc2aso739952585a.3;
        Mon, 17 Mar 2025 07:13:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbK8Y7ZQO11IIOb6YY2iZqEV8ozKX0jBM0GdvxXTC8sqObC1trelwoCPAWSO90/wPzUgCuhwsU4Z2mNLDm5Hj4VGU=@vger.kernel.org, AJvYcCXroY+1mpBIgrlJn0Wh1xP/ll6e3bH+l9o8XrKViKxU0AJxR8jpGt38sevUH2UVA0SHMmDsx7Npigc=@vger.kernel.org
X-Received: by 2002:a05:620a:2491:b0:7c3:c869:1aff with SMTP id
 af79cd13be357-7c57c7d258amr1477782685a.16.1742220799565; Mon, 17 Mar 2025
 07:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com> <20250317123619.70988-13-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250317123619.70988-13-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2025 15:13:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVbcNqeNXnLRAhS-1g+VrTEwzfLiyNt+WCfuJDuF-Hacg@mail.gmail.com>
X-Gm-Features: AQ5f1JrB34Bm-uhv-spdtQfdxNsEqmw1rQKaN5e4AMBjAHj2jdthIV3TXd0TQh8
Message-ID: <CAMuHMdVbcNqeNXnLRAhS-1g+VrTEwzfLiyNt+WCfuJDuF-Hacg@mail.gmail.com>
Subject: Re: [PATCH v5 12/16] can: rcar_canfd: Add mask table to struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Mon, 17 Mar 2025 at 13:37, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> R-Car Gen3 and Gen4 have some differences in the mask bits. Add a
> mask table to handle these differences.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v4->v5:
>  * Improved commit description by replacing has->have.
>  * Collected tag.
>  * Dropped RCANFD_EEF_MASK and RCANFD_RNC_MASK as it is taken
>    care by gpriv->channels_mask and info->num_supported_rules.

Thanks for the update!

All mask values are just the maximum values of various parameters.
Hence they could be replaced by the latter, like you already did for
the RNC mask.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

