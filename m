Return-Path: <linux-can+bounces-6555-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPHaMBTrkmlSzwEAu9opvQ
	(envelope-from <linux-can+bounces-6555-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 11:01:56 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F15A81422E3
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 11:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA3353001A45
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 10:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44F927B4E8;
	Mon, 16 Feb 2026 10:01:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521381D618E
	for <linux-can@vger.kernel.org>; Mon, 16 Feb 2026 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771236105; cv=none; b=F3KHmOyzDSNfG9TFyc5Evdlww/6HTN1lGLni/dXZV+Cxk9xue3lHJJepMgy0lT/A66Ao3tNbw4vnU8jaQDicvloNWGRb5NaXK4Cj4VEqhoM/h+s93LYSCGd/tGvLki6XisxYqy3MJR2fQMahfMK8NRFSuf/KRTnhci5WSYPmXIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771236105; c=relaxed/simple;
	bh=qIHY7cCiEnGtwkY7aFFwE/mZ8uiiY18ecDxBJTYhSwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkkIE0JfUh11qQafdpDaCz8/VbywMBkXU5YVk7KxMHkQm194crV/BaGvuNQRhu5JhR72slrl8T0fUK+jNzBb8naDzijemp5tLc6vzFZyi2qZo3guGl/Uh/hO20TQPaC+28mY3z+T232b1WRxvUfwz1pS7Lxtt+m4Lhck0Mxlklg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-566390e7db3so2245455e0c.1
        for <linux-can@vger.kernel.org>; Mon, 16 Feb 2026 02:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771236103; x=1771840903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QwpdPffhWm62Ds9NyNo/SaQsJWiUgFomKDnAW7WiSg=;
        b=POayVyzm+y4e08MSWaGixeoB2W5DKO7uWgfXKJ6wNug17/As17DmnDtxXk0PFkITh/
         K6+1xdSuAY6cynNXHPB3AO4PugqFeRLhKqnMYng9RLeGz3zvARdG7AXZS0XEzSP/2mmj
         t3STKsHlIYL6l/Iz7itqt15KEEC9zwvHbt6rRyG5GJ8Nnxet4W953tw7tCdF1I7Z6iuc
         t0sbSHgDXRm1f6aZGLLeaGgJ4O2VQNNB7rrhz9v9wnfXrYq1Cc9Ilu1YyUgH4v18LXB2
         riz5c8boJdfKte501w9gqXZgOoJSS79EWUhCyvnqdNEoqf+nDyECKxdsMzO72llJuxeY
         MDhw==
X-Forwarded-Encrypted: i=1; AJvYcCWgj7dfP6XBeFy3AUNBBiF2MqEN0u8M1Z3W+WGm1FEI5FpYgherd1DfKBDeg2Du+K4oaHzfFq7huAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVD0OWbE0BifRRLWn1OrcyzLO1VH4tz9Y/uaGFwhAIQmp6PSUs
	3NKiglbBtIguy5d2ZbtW/n+4PhPnDSKgrh5E77aoqcMjNuftZwWlDZzf0NhgkHjv
X-Gm-Gg: AZuq6aKbcsf+DVMVNOkYFbgDD8W9Zj/nGTjcvCcY+Ac/sridDMPla+6Dj6lwQRLNpEv
	ZOr/6YYeCM58uWZQSM+eY/+HpIxKoX4kmyV3e7QWmwK/5GqJ2IxSm3FJziOhry1XPzhQP2QJxq9
	0z78Moi4E2QNKsoZ5gFzEZn5X8OAIzqZT8mOHBLfBzVmVKInYhX0HHOVhLYGPw0tcAXQPG67By9
	eZHfgUEVHmm3NdvIxn5db36pJnC+GtDlvbgEaf4noWNSICGGKclUL8rP4wEFdEd/Tku/+3vhbFU
	cXp+dSntI2zSejcDldapDimKIAaVbymnfqOyarOU1WOZnQHGlpJnOwtUkaB6uq3dni0OZBBfvBP
	6NA8GHx+0OjfQReeyqyss9X+dZ1hryKOlBDHpoPAf91N3Wi/fG3lYjvtg/a29ieXxHSgU9JozhP
	oHjmb4s0eD14kuuFqvIDEA0aE5opNZdcdqqaqYvJjj52K3cvxWSRQQt8+hfSL/
X-Received: by 2002:a05:6122:178a:b0:566:3685:6ed0 with SMTP id 71dfb90a1353d-5676aa6e180mr3596936e0c.19.1771236103346;
        Mon, 16 Feb 2026 02:01:43 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afd1ab720sm6899434241.4.2026.02.16.02.01.40
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 02:01:41 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9489d087bcfso1711947241.0
        for <linux-can@vger.kernel.org>; Mon, 16 Feb 2026 02:01:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWWwtlo5BBcgxTR9VN8GCuVwX7y0Qsrxoam+BHIC62jXLr/fiDBBMcxMYM646zgU49PnF2ETliLJY=@vger.kernel.org
X-Received: by 2002:a05:6102:cd1:b0:5fd:f145:b88a with SMTP id
 ada2fe7eead31-5fe1afcd3b7mr3584435137.40.1771236100546; Mon, 16 Feb 2026
 02:01:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com> <20260212164823.mbeycqwzsy2dfq6e@skbuf>
 <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
 <f9ede0d3-6a37-449c-b62b-a5c761ece097@solid-run.com> <20260216092914.kmvl7aep7dantcsd@skbuf>
In-Reply-To: <20260216092914.kmvl7aep7dantcsd@skbuf>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Feb 2026 11:01:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUH4W9W2uNknr41AgVQfO7inwZP6BfuMatyEUvJtf+Ueg@mail.gmail.com>
X-Gm-Features: AaiRm50a7dRj7dLKtMGILEQb14-VkaVzM5nFFHi-S8Lj08OYuJXTfF9bVPV6HRk
Message-ID: <CAMuHMdUH4W9W2uNknr41AgVQfO7inwZP6BfuMatyEUvJtf+Ueg@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6555-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[solid-run.com,pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F15A81422E3
X-Rspamd-Action: no action

Hi Vladimir,

On Mon, 16 Feb 2026 at 10:29, Vladimir Oltean <olteanv@gmail.com> wrote:
> Then there is the fact that local definitions of devm_mux_state_get_optional()
> keep popping up, possibly in unrelated trees (not the case here). This seems
> to be a bad practice which should be discouraged during review if caught.

This was done on purpose, to (1) avoid having to make too many changes
to the file when a common helper would be introduced later, and (2) make
it easy to find all locations where a future common helper could be used.

The alternative is to use a completely different name (which is thus harder
to find), and having to fix up all the users of that name too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

