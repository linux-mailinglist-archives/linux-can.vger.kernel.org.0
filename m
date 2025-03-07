Return-Path: <linux-can+bounces-3019-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B224A56ABB
	for <lists+linux-can@lfdr.de>; Fri,  7 Mar 2025 15:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B6A188E70E
	for <lists+linux-can@lfdr.de>; Fri,  7 Mar 2025 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9257E21C182;
	Fri,  7 Mar 2025 14:45:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCD521ABB6;
	Fri,  7 Mar 2025 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358703; cv=none; b=paM90dV4QoohhIiPd/6b0HlqIAMMIBu4qG/ienIYWlz122Zg2ApwakTu28bRRZiQhChJ73HC/zidppcPAk05QtSG7PxednrUMSvmowlGOJi1wY/auRWQycTHw2zaw6UsP5mcLPiT+fILfrO3+IME9n2gF47dggtyIGD1wpTbFLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358703; c=relaxed/simple;
	bh=5Fj2kxXwd7A1cco/xLux0hGnwxuhcTGFlRgDQQxgadg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzmMmzkivN3UAlvcliQwexslkkRvn6tZRu39qfVQMitzRgy10n7rNiTjniB22zjH+tez/lsJP1d6SWywHlRYv62ohQn2bcacsaYLTyeuB2lg70sv2c3HJynCIVJdzajCfiZlAoud//hTeISMFGbds8NP14x3mhl27Wq6hZ+1las=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-523bf140eccso2213284e0c.0;
        Fri, 07 Mar 2025 06:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741358700; x=1741963500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGQhVNV18zxLq4hjM9PCow6L9wAKoP7Htc7goaZkuMI=;
        b=ZXomLDFfyicaPageXxGvcVetByWTC3pJvhwCeNx4VY7L4se6F3DkrqGPcTAMvCwLvY
         DWqa4Gmg210xgFlet9WIEKtlH9+6Kz8ARBg3PWW68eNXgkdILwyFfwgFm9gwdYDQz4cc
         GivM7AdzyI3O7MYP31Ke9EHJdscfc03fx9at+KRHMTCMofqzcgd9IDqjmMmeJA/wV5s0
         TBiPgsS22BqKyTO3glWPxCcWu2VKQZURF2PpZ1tQNBQU7pUAyfjPM08O3k07FANzYb16
         OoKQdCKqAJUuKdefcSVC6p4JASpptgpc+LIUwzqYC9PrnGWgHLpmIIlbhY4r7vjT/Jr+
         vYMA==
X-Forwarded-Encrypted: i=1; AJvYcCVBCv0PNOHhqNhB3d5TxozzIuhP03/ZiyXj2u5Sf5gqjHivgM+ocQ0Sze2yQIeCu3Bgm2F9UfieyP4=@vger.kernel.org, AJvYcCVjn+W1PRjD981tDPOR04MN3f4dTi7Ruh9aslYj9x2QtAA1s2jq7tkvP5lYw79HbDtkioD2SPeK@vger.kernel.org, AJvYcCXgb9o1F8rEHiWW85e8NxTKrtHuonzx7c/YS9P0/Zk8sAo19uSswqJt1v6kGdpV2YWMyH6GwnC9ywCe1W5aRKtz3kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCAoePgBgEprdcUVEmn4ahZym7RF/bOaPSKmkR5NqC2YP7wCl9
	N6Kw8mm7RaL39pb3xJ606jrZNlMjCGFJuHSPNuRSoznJyuk1LGyKURF9ok5uBlU=
X-Gm-Gg: ASbGncthEBi6LXz81fpT56wduk7QgKBuxDM7jXDs7ItwVSN4g6tunrSbHoP01NmQbYt
	k7sbbQ2FUXUnYkAg/x9GTwitKwLgNHDoSDrwl+1mJtsxwTd7jQw/Iihv/ByW22et8CFnyWTDjB4
	I4wOnFXcFCLciG2tTniVQjrt9k7atnw6L+t/mcTTIxVD825Uvp8tsjQKPuyJl8EJCL5tkiTNhyB
	uhcl5aeNvJkFlweW2NXoeI+tC9Qutw9oZhpUB9Ws7lFPaDHi/HXFIWNxZyu6BnSHntIdcOFl6e2
	gvS298D94HOOFSv08NUDAK+yvB8SJkT+xTFKdaoWHUQqB677Opx2fU8VEuVcMguvlH6x5o9Cgxm
	fUWkihLE=
X-Google-Smtp-Source: AGHT+IFVQW59ZwSUw0MaoiOSqp9x4yRlC8sdJOxtg+TYxicRSjXlEU2eHimh0I2ldma+KMvt0JiGdA==
X-Received: by 2002:a05:6122:50c:b0:520:56ee:78e2 with SMTP id 71dfb90a1353d-523e414eb5dmr2382248e0c.5.1741358700174;
        Fri, 07 Mar 2025 06:45:00 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523d8c81ce8sm541261e0c.33.2025.03.07.06.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 06:44:59 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86d30c329f2so1879513241.0;
        Fri, 07 Mar 2025 06:44:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5Qn214p3BN+eSaPz3JqbMO0YwQ02ztf6YwQn6MI98k8ZDjykPnvWgXBgYCGDJ3fshbohc82hwJA0=@vger.kernel.org, AJvYcCUKANOK29siHXOAwY/Keuo/kOGi8rXNbLLTUTsthGDQvXPS4lv3LAx6E5d+lhcUUJMF52K/LoVe7LLE5pZAQ6pa1kM=@vger.kernel.org, AJvYcCVhHhqQz8ellccsKlNjzS/ynNOAn24vBybKwage5Buf5lXQjRcTm4X7lNwztH7Xc9FmHkK+q/NO@vger.kernel.org
X-Received: by 2002:a05:6102:54a5:b0:4c1:8ded:2d66 with SMTP id
 ada2fe7eead31-4c2f67367d3mr5525232137.12.1741358699726; Fri, 07 Mar 2025
 06:44:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220094516.126598-1-biju.das.jz@bp.renesas.com>
 <20250220094516.126598-3-biju.das.jz@bp.renesas.com> <CAMuHMdUs=+niOyBW0us=UjZTnqeYjVsLWZSmROndCO8azER=3g@mail.gmail.com>
In-Reply-To: <CAMuHMdUs=+niOyBW0us=UjZTnqeYjVsLWZSmROndCO8azER=3g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 15:44:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUiu9KshTRGFgAmuiB2SQdb-X81ECW1RTgvFiPwDcmbRg@mail.gmail.com>
X-Gm-Features: AQ5f1JoWLtQCzNB0nwNk3JVa9qjH3RZYFXQytd6Xmm5mTDdWOU18etyf605f1es
Message-ID: <CAMuHMdUiu9KshTRGFgAmuiB2SQdb-X81ECW1RTgvFiPwDcmbRg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] can: rcar_canfd: Fix page entries in the AFL list
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, 
	linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Mar 2025 at 15:41, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> So the old code calculated the page number based on the pre-configured
> number of rules in the RCANFD_GAFLCFGw register, not taking into
> account ch > 2, and then reprogrammed the register with the new number

>= 2.

> of rules... Hmm...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

