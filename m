Return-Path: <linux-can+bounces-5896-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B581BCD5B8B
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 12:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED0B030124ED
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 11:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9757E295DB8;
	Mon, 22 Dec 2025 11:05:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7931F936
	for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401502; cv=none; b=MLu/HXG4QjztXyN9aap1jUFnnoFJdpqoUgON4nrvA5fKj/86xdry/7q9EJ5UYtDNN/9BasD3HupRSrA0qiUKtU9i5Qg/3hn1w5Pl692eHCuq+1m6whTDHlRakW+UlX7JfW7HD0yY3WDNWguERSdYQsyoFkWoxbIgM4110I9jStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401502; c=relaxed/simple;
	bh=hQz8inePYy4z7kE2ZTh8btcX7ZL/LHM5S3zx3idHlV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/4w9BPfdOYooXXAkRKMxQzH/JdeUj/86tH9dhYxtfPkx3QKGMGABGKOmV2XhA7zjRDvLWG7htAC7+K2AP5s4NOnlUDoCuyP9xXOCImBmX2LlnQIA/c4JngoLR1lUpbLqURnAoCENG2xfpFgvWxLGgw26TsAf60wYBziStR7okM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5deb0b2f685so3265712137.0
        for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 03:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766401500; x=1767006300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVlS5J1HzuVScBDeCBX0VxoypelfY5sXHRtDOTQInFQ=;
        b=kJIKhyfbXqk6N3V/fuXoQToBT8Mf9LM2sBvZ/94rKTe+/Us3x3UoEGlCvFCKIo0D3L
         CXVgBn4EOL4iODOXMje60rYVR0gx0QNMQqo8tnlqZRrUOhvtqIdk2dTyVXRe+MloM4hi
         mrfn3wyHGXUgUI5x2HlDnDO/T7UDyVHAhLIwlEc1SllmKDWcT1ZPYLDzQUCNH/1JxbX+
         WF+2VZONXdu2x69XFUwstspR0XXeGG7Dal7FQ4MtMBKuZ3fhg+X3WnrKlnJZaNvQQFXz
         8d/9cfLnPgfEQLH8NhESXzpv6WFlnVs9mvfbjwjCYho9PfFSvkT3tiSy7dx+5jCgZQ7f
         bxCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk95ryou/nKkQx/LmaHIRJUvzfCWnTcsMj9341gJbNeSH5ngPTEpQPemZCDJd3iwcPv+2GsVt6Byg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjh50jZ3ketiy+8W3buoptWQn1gRehtDrWxIm/IQJnbGmO68gD
	2RrXuUbpbP/rdcUsgiz55hdk6YccbsDZVS+XuwIdSKfaOpyOpalD9wznU9n4LiWV
X-Gm-Gg: AY/fxX5TAGar5Oe2N4wePC+b7WJCdC34p/Poo2KCfW3K8yT5Xms6fO9QtvDxnoBUkym
	0EJ4c0flaDDv5KHKdbGIzIWQXOzCoHi6yRRjM/z1jQdcPyrLp38ZRkQkgn4us3J7fkvXeUgK3p1
	OATa8Bg0+CFfy81/wyupylfFCbD/6OuV+HjAenB73DUXjBXTUL/oRj+Y7DJeTpJJjZDQn9Ba/O3
	U+5qBYukYFgS4fDKuHk9Wtz/xONIXtIVd1NQA82ppa3jvzp0NbuUAAWyIVSGElSll9+JSZoBCvy
	KRQhThOJMM+44SaYyFiaMexXP2TJKZxYR8NwPYh0tX0Y2E9NiNCwK3YqQNR0N4GeUAehCVjx5w6
	w5P8ceiejZBr6ddaGmBnqUuCmBvx4BIcIyuPpCE+mgxQ1k/UhAKogPww4B7KE7UMhLHUhHdAVcp
	7+IQXGVK59C05sEyxinhfDxhpuefghMvINau3MUN/igQfzFVh8kdsxUurVCRxxZ8M=
X-Google-Smtp-Source: AGHT+IEsskSe0VSjvrASoBLnQKodEK6zvVbHpJ31TTDTGGc9JouYSXFXH5Rw5t7np/iVcllfl9UmVA==
X-Received: by 2002:a05:6102:5241:b0:5db:e93b:692c with SMTP id ada2fe7eead31-5eb186a59e2mr3763710137.12.1766401500005;
        Mon, 22 Dec 2025 03:05:00 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5eb1ac67e41sm3347464137.11.2025.12.22.03.04.59
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 03:04:59 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55b0d4b560aso3191118e0c.0
        for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 03:04:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXgrgheSfoJW7UVivMqO4WiJTDzaV8SLuL+VrJ5ySPzlYVUZkDP9DmypFJA5aow1FpnUiaHPYEOQg=@vger.kernel.org
X-Received: by 2002:a05:6122:6790:b0:559:7faf:a276 with SMTP id
 71dfb90a1353d-5614f7ae2d0mr3069797e0c.7.1766401194470; Mon, 22 Dec 2025
 02:59:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com> <20251210-rz-sdio-mux-v3-1-ca628db56d60@solid-run.com>
In-Reply-To: <20251210-rz-sdio-mux-v3-1-ca628db56d60@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Dec 2025 11:59:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVqSPQ_rCY1mPxyAw1=WwK2VX9bxMKQQuVEe75u5hTvsg@mail.gmail.com>
X-Gm-Features: AQt7F2qvtAFJTZWBdh_71wFZZJPHL2v6ti7TTVpa1qQd7XzzszUS-LtvxMifYms
Message-ID: <CAMuHMdVqSPQ_rCY1mPxyAw1=WwK2VX9bxMKQQuVEe75u5hTvsg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] phy: can-transceiver: rename temporary helper
 function to avoid conflict
To: Josua Mayer <josua@solid-run.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>, 
	Jon Nettleton <jon@solid-run.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Dec 2025 at 18:39, Josua Mayer <josua@solid-run.com> wrote:
> Rename the temporary devm_mux_state_get_optional function to avoid
> conflict with upcoming implementation in multiplexer subsystem.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

