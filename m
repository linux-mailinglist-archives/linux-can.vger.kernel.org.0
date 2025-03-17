Return-Path: <linux-can+bounces-3139-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7B8A65238
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 15:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C713A7565
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDE420322;
	Mon, 17 Mar 2025 14:02:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9655A2940D;
	Mon, 17 Mar 2025 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220150; cv=none; b=t0I5EZ7+LpOaDU4Qi/yoHu4t/q3NcteUD9xSW3sNFKXxUSyHc9sCBhReElnnwkPQ49xnOL9DmIgmOxSvmfQDXvTHz+idxlOiNUrdiwwtkQu0fLBgLXjG5Q3JM6pTULrKVh/xmI/Tct8nWjXc6bkKfZKX2Uv6TuDbNmaUt16HBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220150; c=relaxed/simple;
	bh=qKyPGTKwcDFsppRt9LNo21sP1+oAs3r3EqzeAdQGgDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJ41js7tlA6EoK07s3vlFfDJnY/tt75AwHtqHWWB8jroKXyHjkKhckKIHV/+400Xfi6o1jv4TogcdNxwNEfAdTO5VjcjMY81MD19jGUDEmNWq5e9JP7HMFj9qIl17vdbSycRjHuYgR3Oxk7IVc4AtLWCdfBsdQn93Y2IZxwRsjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f8df49e75fso848253b6e.1;
        Mon, 17 Mar 2025 07:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742220146; x=1742824946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OB69WHpxbbPik5US431qDVDh+pGWVQeQ/s5tJbhophc=;
        b=MsteJo9POxf7P8i6eaczITIcOcFsb2hFBte/UZ4c4jU3SxkoWw6iwBh2Wq5m12y2AO
         hgWGWcfuLbvRk3eFfB1fq5s0zNBNLFi1SFD313e55JANMUC5QcF+yxMVxMpeU9K5FsKX
         WzkzZ3GJCSQhu0YIROTCG8N3UgVTEriSz83OtsqdKN41XIYpCf8/bPtXY0lsJhWm+aHj
         /QvxIRoi7NpVpBaRziUSz/p7CjU01DEHsrM+O15EG+22YpFq7e2R+dDUQrwkeZHtyZju
         5DeaUsM3A94SA6jcOsCdB2jfPACArReJyxxkyS7YdtptUJVVfVdpTLpEf7C6hn/QPgXd
         rIPA==
X-Forwarded-Encrypted: i=1; AJvYcCUZEi2EVrMo9Ek3MXYSxdu2gANyVtXyqmB63VXwsPCZpEUV9NVbAfOt587Hb+r0gzcn79fasqOhTpkleP7HoNTyurk=@vger.kernel.org, AJvYcCVArGn3q4eb1ToeiQzGuA/72xn5KSzGKrvf93DPtyVEOlzDUbWLZ4ZdMLxBjyH4LwZu227xEZDCHFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7g+nwoLEG680d3QubIdHBGbOHy6y6vHQ8CcHZHzZcNq253dc8
	j+j3k/DeMeSDLFeK6/4NQOj/QtrhHP43E7sIhrP2RJnJeIqIk0hAF66Sf5UM
X-Gm-Gg: ASbGncvg128LxkxX6wybWDSeq2Ayv1dg0yPthQanJMz5syhUFzWUPoqmTEwLsnQ/QeW
	10b9y2JsFLYPlSAQy8iFuxEhz4jBLng50avZHTjmD7qPVnwFD8eaeJBBNEycl2T1oAJgdeOrYm2
	dJLwJ6XS9TEQGkJa1iqeMc7qivt7RX04JuraiDSt5qxS9o2UoKLiZGt9jhLBKoxVoMYwrj6XWJ1
	NWmkqLur+HGROgndzlr5EL470p+8XTJX2+yC5lI7CNBn/WMZe8qdM1Rf2PrS1D6mpZTQGtduGir
	kCafWw5BtOVrd92zqPl99d3D4gTIMu+sej54qs3UF9NGD1DBobRzvpapq3fGFgoN4Zs23jdEaS4
	bWO+EXr7N9DyO6qNTBw==
X-Google-Smtp-Source: AGHT+IHGy/JinwIhI0GcG87BSMiP69k3sTeW0hCo2dHsv4aVenvFlG7KrErS9aUddhcLrG/Y0OyxLw==
X-Received: by 2002:a05:6808:23c3:b0:3fa:25c8:a037 with SMTP id 5614622812f47-3fdf0082dc3mr5660698b6e.29.1742220146127;
        Mon, 17 Mar 2025 07:02:26 -0700 (PDT)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db659ae3sm1619208eaf.2.2025.03.17.07.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 07:02:25 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5fc447b03f2so851447eaf.0;
        Mon, 17 Mar 2025 07:02:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCoUXuPswIMmZpwniw0d29DgCBZcZ/MrQS9WaWzjDXhFJKU0ueNd35yE7rt/wBiRg/cUIePuE6u5U=@vger.kernel.org, AJvYcCWRLFkXVVdQUfjDOwHrK53+UHjq9FH7TsGUy2McBNDelXgvj2XmiyCyldfQfEQLeX+CxqL2ywLp24HPn5eAJMa4VzU=@vger.kernel.org
X-Received: by 2002:a05:6358:5295:b0:1de:fac3:19c2 with SMTP id
 e5c5f4694b2df-1df36b0503emr4261455d.16.1742220140969; Mon, 17 Mar 2025
 07:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com> <20250317123619.70988-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250317123619.70988-5-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2025 15:02:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVwt4h8jCdyK2eFchojLmcfnVFNfw=UwOZEf4fOUCMLzA@mail.gmail.com>
X-Gm-Features: AQ5f1JpiFjJgOQfwLlLU3q2hWUJ7jbJS_rc_vXKqULuBWZ7X4ZqnnBq0kqXxvo8
Message-ID: <CAMuHMdVwt4h8jCdyK2eFchojLmcfnVFNfw=UwOZEf4fOUCMLzA@mail.gmail.com>
Subject: Re: [PATCH v5 04/16] can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC macro
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Mar 2025 at 13:36, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Drop the unused macro RCANFD_GAFLCFG_GETRNC.
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

