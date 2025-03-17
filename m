Return-Path: <linux-can+bounces-3141-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A851A65240
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 15:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32ED41893BE7
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 14:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AED22CBFC;
	Mon, 17 Mar 2025 14:04:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E4E22759C;
	Mon, 17 Mar 2025 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220268; cv=none; b=MK8Z8lBX0Y6U/KFKGgJSkz21qqBwN4hSawutmyDnqoeh/krqSHiQuSNXqqER3fi5B88Am47oqBxhQ5GbeTzmVIAoOmBB9TKsn9DXIC29dVpGZgKIliO6r2pLxry4gQC8n2S2RypaR5oQqHoao3jP0mw7qnW5gQNFGNb4M3AvNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220268; c=relaxed/simple;
	bh=sv/PR9zeoKrPLkOMNq+FT1itkjc85VGltMyZoPohhxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAbK43JpyLShh/wm4ocsxLz0DoiYtHHFmS49ZV9TvnnvNNxHEg0OlzO1mktrVd9YvYDeDueNNsMx+vQqy6e5LWMlJNd6HeS5f7vHX8NxYTv/Qsp4q28Tvq/1w/qAs+0N/bvADEg2uTa6B/I7JYb0f5nlYjKDUuvCTsa6Wm1qzPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46fcbb96ba9so21487321cf.0;
        Mon, 17 Mar 2025 07:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742220265; x=1742825065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlZ/4oY0joNX9n8pbVpQQVC73NA3cRT9OVRKHzalhiI=;
        b=j+P0bz3qoJXifQaHNCzBRSvNPRiF0ZxeCo+6JJP1EP15dLGmRtI44SIDZfuyJTWoFh
         Y4KU8Gon3qcPtD1GUVA+rT3YJO/4oJvInY4BA+OLy7HYWDbdaoILM0eCTuvDA2qkYjA4
         US+BEQOUBfWzJvaKd+i8gtRfbHvebdgwSL16r30P7XysAeSsLRPTkLXPmyJzAEbU8iQ3
         g/tQIm/cjDGK7mVUzofEbyH3NbDZiUdiCw4VQiD29qAdYd5yuKrbpONSMpfEz6x8ORVv
         sRDOd33u3Rq9ODgwOpn+8NOsAYbxD5nBsACcrkkyU3I0F8z+hl7vkKNWL+7fnlc0rAr1
         dATA==
X-Forwarded-Encrypted: i=1; AJvYcCU25/rdpf+6tPanQBwIyBidjFKYv+QOc9pS4szFhk04NqFDmYJJ50P4J4ktO7ue0v8dbvhuRSuFyO4=@vger.kernel.org, AJvYcCVyP0nbJovs02iKUEekmB1kjbuq2CjSuellv2XdSMrKeB1TVjo15/yZFfE3C/BellNCyrpcjBJ/O6NKEkW8Dzq6PX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGjItGptvySQRvwq2emsO+xPNFlghvMidh4m4fny1v89qvdnKc
	oXEIop1JeOA2ZSJPZ0x93+64KOafZlK7sHpfo28CtAJpKuNc1B/VUl2WlrSI
X-Gm-Gg: ASbGncts6DF0PmMWVGFaUdeNNc9hxQ3Wie3V83BNd34KLremBxjk5x7JWmTrg7tTc8J
	RzEuctrCyeeOpA2RQEt8BOstgoJzAJYoRbk811Ft/AxLs8V9d38jh/T7AkM4tsIlq2BHKaOgar3
	AsSiNc4TF0T6n//lSwvE9mWDe581QT9kTEg8wG+lsNsKnKwWDQ2q3VTZNGpuPjBXB5AYKqRnoB5
	2lJv9t9uhPMrl93xeUSi0w6kKPg24p/H8soN3ZXrjWW3yTcd45bK8qE6CjqmOIJg/3jD5JQbPgt
	Rq63h4bijTFvoC+gdA+F5qJpnG9EK8XlKxmIn2+lauef2fchMoM6KMKwL46tv1LszLolbuFr6gC
	e8DGLFi8=
X-Google-Smtp-Source: AGHT+IEQy4h6zH1zD+oYy/1e2BnPWlgH7CW+HZ3BTDo5+L9QcB96lqu3mD2v3Qw2WckuUrW6gzOZbQ==
X-Received: by 2002:a05:622a:5b0b:b0:476:95dd:521c with SMTP id d75a77b69052e-476c81dcaddmr160766231cf.45.1742220264418;
        Mon, 17 Mar 2025 07:04:24 -0700 (PDT)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb608448sm54280641cf.14.2025.03.17.07.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 07:04:24 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f05acc13so50862856d6.2;
        Mon, 17 Mar 2025 07:04:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKs9UxTZ7Zvg6q8v7NHSX74t943MDSyfOXSU/V7wJ2ex31XXeOD8XEVtpna9bMaal3aJz3tnOqwE8=@vger.kernel.org, AJvYcCUTJfdNeUiN9Xs0hL4xWrIuUhQQ7GJ+/fMqRQ6TmomSpYbfVrdfHjyau/j0Lrc6Bz+EZVNySPVt0IScQQuw3V/W13k=@vger.kernel.org
X-Received: by 2002:a05:6214:194c:b0:6e8:9957:e705 with SMTP id
 6a1803df08f44-6eaeaa9f95dmr212008396d6.34.1742220264019; Mon, 17 Mar 2025
 07:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com> <20250317123619.70988-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250317123619.70988-7-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2025 15:04:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWheuUpBBOqMuiMmGc=6Pc5VMZ5bqthfKjLnvZnBwrSYA@mail.gmail.com>
X-Gm-Features: AQ5f1JrXxTwR1DSicQSaWM-7W4F-Jlqw_0qgfzIg9dQjYdrHrFeEaH4E3cba_D4
Message-ID: <CAMuHMdWheuUpBBOqMuiMmGc=6Pc5VMZ5bqthfKjLnvZnBwrSYA@mail.gmail.com>
Subject: Re: [PATCH v5 06/16] can: rcar_canfd: Add num_supported_rules
 variable to struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Mar 2025 at 13:36, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The RNC mask is the number of supported rules - 1. Add num_supported_rules
> variable to struct rcar_canfd_hw_info to replace RNC mask in
> RCANFD_GAFLCFG_SETRNC macro.
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

