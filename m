Return-Path: <linux-can+bounces-6546-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLs4KhAHjmkT+wAAu9opvQ
	(envelope-from <linux-can+bounces-6546-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 12 Feb 2026 18:00:00 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4711612FBE5
	for <lists+linux-can@lfdr.de>; Thu, 12 Feb 2026 18:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4ACC300F110
	for <lists+linux-can@lfdr.de>; Thu, 12 Feb 2026 16:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113AB35DD13;
	Thu, 12 Feb 2026 16:59:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97EE35CBD4
	for <linux-can@vger.kernel.org>; Thu, 12 Feb 2026 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770915598; cv=none; b=NLr9TJsdCj6Sqkg25SdCfHfLoX02bm+UbyqhXG1C0xAbhbIUjgwRTt4YYzYIHPbHgvwfc3XMicHJ/dR0my7uEM03GjjHCFHvH3UVHPX/Xf066sYz/RARSoUnosIPuhVqFla0fomR8H0SvTd0VKLywE1MSusa3udUjr2k0KzuPOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770915598; c=relaxed/simple;
	bh=FavnLYuCSZbZEB88+6M4JKOu7/zHNtiz8QGLBab5uI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6PVwUS18kUT2VR2uhFWEHqdzVFDZnsBCU6A1IqErWxXZYcHdh3NDEhWFznqFGP356v0HUEU71AoUpbqzZHSzRCDiGvQhH4cUCkB5NsOB/2n7YgjyAUc4YOt3e+rOqPL4rhE94CdJKGY3V3t5fT9QvijmG4E0T3gkbU5GZ6ESTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5fdf3735e14so30222137.2
        for <linux-can@vger.kernel.org>; Thu, 12 Feb 2026 08:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770915596; x=1771520396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om3cuNbQzAgOvOQckRciuNr9O8eg7IAaHrWKXJVxB8U=;
        b=oXR0JBZ8SfQXTdJTPKq+wyVR8PMBn0lks3+YF4GwIrm8/HAiFrlzuYVcfzLWA+t75p
         G5feh8XTwgXKksuL1tmvyTimaaw+uQb/JgXyYHnV4RgeBQuJ5avbpsicJEYMsNayYIbB
         NR9rEhdVnFHoH//Qz9GzDG/af9r/7W7pd8KEBmmisShkkQ+O2W3z79AsE+A9yH4mb/3F
         ywJ1nHK5Y4adKNm9hi4LIUpIRHjRJfLWEj+NTew1iA0GOOrsLFlMw+zvbGFejF/K61jH
         TymVkiawYmYBsmvEnq4javmPatR0zoWyZvSTweDIDumvCES6s0Ktb0dx/X5s9hKZ9DyS
         Y0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3fpMiOpW/sGs8EKR6eeezjD3c+FDYokPHKSIWbmg1RLqAqa7U6vEewh7nLaiMtwUfJPqCyua9d+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBhA2K7T36ujgWhQljdU46wnKOPRZ8+P038evGxQaJvGQ8Vl70
	og0jT+TMN/x0A8VouJXjyDnN4+UnRfXBn9rtendh2r0+loaPxZpBC7CYGmDo9qlM
X-Gm-Gg: AZuq6aIVBBfmHkqFDhs04EIudQ9E2igRkrvUty1z+gExThMujf0tvbcFrhfMFbtHHzb
	jMCKnK4soJ1SqeVhpEmDyzMuCPZAx/Xnbg+peNStfJW48KC7J/O0OxyO7g4/BWcViFy6s2dHjbE
	dCSobuVL/+Devatai8sCdZa8YpZKOrWGPPW8yCuQl+CArGPTqq+PH36aeURBT8WkhaM0bU3CCLQ
	2tzFdHKXOyTtHIW+gX2FinwdgKPsAeKExHhHeGXcjhztQyoGKV32asCQI4BgAcWwmPvIVEQNsMK
	fROHJIXLqKNkmlZx73rq3tpuPa4171jmgrTROqMRNH5oxXVLUm8ScbkHCfxl5EDA7toG1ycmrnj
	Vxkw7oNcv8FpFwRoXt8qJB7f0iH0TQOObAlx30jr65utWEewsbLxH1957cCZ7CGnDwn2z5DXnmz
	ZftYqoF5X70Rp7RjrMrG7Fttr5gVnQvTendWZcN+u7+aNPEbU2IslQawEFRhTs
X-Received: by 2002:a05:6102:dcc:b0:5f7:2568:abb2 with SMTP id ada2fe7eead31-5fe003a63b8mr909759137.6.1770915595819;
        Thu, 12 Feb 2026 08:59:55 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afd343306sm1927488241.9.2026.02.12.08.59.55
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 08:59:55 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5fe086fb0baso30839137.3
        for <linux-can@vger.kernel.org>; Thu, 12 Feb 2026 08:59:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHB/J24qHLUctfi0HelDYsmhdXVsnDN+GMzDstoNAnJa1KqGOYIgYkOOWdyMvQNQLDd3W1YzQLSNo=@vger.kernel.org
X-Received: by 2002:a05:6102:3051:b0:5fd:f8d6:e5d7 with SMTP id
 ada2fe7eead31-5fe003fb1fcmr1021759137.11.1770915199593; Thu, 12 Feb 2026
 08:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com> <20260212164823.mbeycqwzsy2dfq6e@skbuf>
In-Reply-To: <20260212164823.mbeycqwzsy2dfq6e@skbuf>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Feb 2026 17:53:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
X-Gm-Features: AZwV_Qjd18dp3H6_yOLJUoqzfa3vu8ojTLTUkfH0N1bdOdZMnHdC-jkEvP2Togs
Message-ID: <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
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
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6546-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[solid-run.com,pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,vger.kernel.org,lists.infradead.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,solid-run.com:email,linux-m68k.org:email,sang-engineering.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,glider.be:email]
X-Rspamd-Queue-Id: 4711612FBE5
X-Rspamd-Action: no action

Hi Vladimir,

On Thu, 12 Feb 2026 at 17:48, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Sun, Feb 08, 2026 at 05:38:56PM +0200, Josua Mayer wrote:
> > Rename the temporary devm_mux_state_get_optional function to avoid
> > conflict with upcoming implementation in multiplexer subsystem.
> >
> > Acked-by: Vinod Koul <vkoul@kernel.org>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
>
> In the future, when you have a series with cross-tree dependencies,
> please try to think of it as individual mini-series for each tree's
> 'next' branch, and specify clearly that you need stable tags (to be
> pulled into other trees). Telling maintainers what is your expected
> merge strategy helps avoid making mistakes.
>
> For example, if you did that in this set, you wouldn't have missed the
> fact that in linux-phy/next, phy-can-transceiver is _not_ the only
> occurrence of devm_mux_state_get_optional(). There's another one in
> drivers/phy/renesas/phy-rcar-gen3-usb2.c, and that should be also
> handled in order for trees to not enter inconsistent states.

To his defense, the one in drivers/phy/renesas/phy-rcar-gen3-usb2.c
is a recent addition.

So this is yet another case of "convert all current users" (i.e. those
present in the typical subsystem base, typically *-rc1), with new
users popping up in -next in parallel, which happens all the time...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

