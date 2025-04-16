Return-Path: <linux-can+bounces-3409-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E386A90476
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 15:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B553D17C3DD
	for <lists+linux-can@lfdr.de>; Wed, 16 Apr 2025 13:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84C4158538;
	Wed, 16 Apr 2025 13:37:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F29179A7;
	Wed, 16 Apr 2025 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744810679; cv=none; b=J4fJtnUzCYckQCqo6kjaLUY7MvaPo0Cr60SgDhqg4pM1rKvkDNEbbt4oirvP7U/bhbgeK8a5tN/FyjV1ocrLecvZEytBSUIdyH4N6Js1Dg+VgH36slKZ+s69AfLFQchYKovgQQcHdb5HsC/SQCcE0K857K5Bc0n6QnuGY7BQFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744810679; c=relaxed/simple;
	bh=bv8qxXuI62o8GRr4+jZIQcSM4GNBFSifb252dD4myTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSrDtEGc4xD/oUGGhSjfBZrsSRFZbJllTHlOLV3zEL08C+SY13SBU4ctdLgMNccNWazb/rLkMzale1DHwmO3X+sgh8T0DTCZTKGPtxr7Q0/WjGXV75GBSeD7JPbulCS+iXW9lnM4PfiWSYdfZMhG/0QIN50+MkjZkPOMHm07ih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f0c30a1cf8so77630406d6.2;
        Wed, 16 Apr 2025 06:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744810676; x=1745415476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ile9GcDBP/sdlUIAbBIn3uqVE+tc5CKk2ygGHbbtcdE=;
        b=kAhedWg287Z9b8RaET1qICu/isMbOmPHDKzbh2JU2eg6ef2ZmMCkR7kFwJaYPQb8VK
         GkWemnpwBcNJevpRxzqUhjnWSQTG//nSDFijZC380uiCLw93ntSwSneCbFayWrlC+XBS
         mPolrXlb0ZBFCAZ+LpOa/4nzqMAl9UZHPgCO8kDFQNiJbJToBL1Qw/3FsnRP7KPT1qEJ
         gYFiNaUOhhXpCeUQtJ41HEKhBM552w2ZxqhdOnpb/z2ohBpECUnSXdw+Zo70d3+loA2Q
         Vfa/KpNWA17tGCPdFLdvoPqKzt2iUKZQD5R+WisEmoUOnGhxuJbVkbGGZ+4leWQyHhGz
         m+hA==
X-Forwarded-Encrypted: i=1; AJvYcCXhRfv+rzwoErn85KcAHKZIXtKDdY1noYKy373dELsZJ2pII/OJL2lWUFg1xfXE5Xt9rAb8toSoaJQhUJ7CFvyoVF4=@vger.kernel.org, AJvYcCXjDIGPG5x8ThRDVfJHvIgoUB30DMryG7kjGgu+XWIBGQcRfBFJPNiRNMl3c/ABQEw+px7AC1Cq7WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZBdNHrsU8B93RjN4ERQPafo8TALMgeTh+GOoZaXr4j8OajpgT
	lCi3CoGl93g0FNyGqX2IzFIuit65CY0J1Z67iK3D+W0Q7t287qMvcufXrcpI
X-Gm-Gg: ASbGncssEQmjgcrlO7WqJeqkQt4Rz57gtWzjsLL3dglrfHF2My+LOo0pGqLHpBnS8Up
	jq1Ut5fe74gNWDtCRzAGPrXcu2Y52fUYIDvCvLmFLLCj1oNSy82WsvJuP5ZhHid2MllOtNczmHw
	ivfOlB3iVv3ZaSYteJGN2j9QJxHe+QlqfDAXgINJfZoAfpkLsl97Jwb2lmhNSEYT9Dw42eWMIgf
	qTr39yuxUTjHGEox5LSp0qX3dpJBfthUBJin/VVeKcoh0VinIGjGz9FasvyFPwnq3mGggdc5nu0
	kaeOmHqsDLUyosA8xmEPmDnLOG8OhIVSAkJJ3Nm4+8662DXJEoBwmssGBWZojqTzlOfcM0iaSUT
	9Wx4=
X-Google-Smtp-Source: AGHT+IFwPh2Oaw07CM6xnUVIR7zFf4eBYH9T47Mq5ZM4XrwrvM0j2rQkuXFwKt+0vB6so8t90CAXXg==
X-Received: by 2002:a05:6214:d07:b0:6e5:a0fc:f663 with SMTP id 6a1803df08f44-6f2b2ded737mr27522846d6.0.1744810675681;
        Wed, 16 Apr 2025 06:37:55 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de95f774sm115627246d6.16.2025.04.16.06.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 06:37:55 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ecfc2cb1aaso69139476d6.3;
        Wed, 16 Apr 2025 06:37:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbhwXHora74JASBwWTV5709PNq6Waoe3IkXzGHJvBqTp1fPEg5v4tn311fR0YQ/+JZB/+1695zowM/ezGovQcfvlI=@vger.kernel.org, AJvYcCVw19i8gWMzVsNMunIo4MRariLx8ipbZXM5wOIn44A+E9Z0r5YQ3ZJBVQnjeyv2d8ie4+De8WWsBcA=@vger.kernel.org
X-Received: by 2002:a05:6214:f0a:b0:6ea:d393:962c with SMTP id
 6a1803df08f44-6f2b304c47amr23174826d6.30.1744810674950; Wed, 16 Apr 2025
 06:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402102226.28032-1-biju.das.jz@bp.renesas.com> <20250402102226.28032-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250402102226.28032-7-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Apr 2025 15:37:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUMzWo93COEDPF2Ve=RwkZ_5Ur5V=pTgyTrVEjag6LTkA@mail.gmail.com>
X-Gm-Features: ATxdqUEZGRDeajlOfKEJlnM6hzrT54ZTNrvrUP4ds5ixZapsAXtBSG8DeZnCFYs
Message-ID: <CAMuHMdUMzWo93COEDPF2Ve=RwkZ_5Ur5V=pTgyTrVEjag6LTkA@mail.gmail.com>
Subject: Re: [PATCH v8 06/19] can: rcar_canfd: Drop the mask operation in
 RCANFD_GAFLCFG_SETRNC macro
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 12:23, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Drop the mask operation in RCANFD_GAFLCFG_SETRNC macro as the num_rules
> can never be larger than number of supported rules.
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

