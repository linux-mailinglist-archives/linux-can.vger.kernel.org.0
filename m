Return-Path: <linux-can+bounces-5897-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C95A8CD5B8C
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 12:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B37B4300BEC4
	for <lists+linux-can@lfdr.de>; Mon, 22 Dec 2025 11:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EF31FC0EA;
	Mon, 22 Dec 2025 11:06:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC210295DB8
	for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401568; cv=none; b=ER0VpYNWJTcJuloBLZejsExpgYNbTAa6rj4auj1TeZp2sZaX4lmWBZztEZsLKNfnUIjc3M1BwfQp/30EnMk7JuFCpEYAo2FCPV2hOuGhVc7AIgrka9veMs3ifRRVbofdWZS4fIlp9ydzjHcPEe8sieLHRPihsVN+sg1kUODf1Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401568; c=relaxed/simple;
	bh=Sa6vRFp+J8CzdQeFDX4yWNCdRt01fLLpAObxTP7lVIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQ65rGBYcK+XD/JjSlLXSMnZHc27kOlTGChfDkC1ODBtO0waglN1AApqEBEzX0RSph7NTFeaJx6sbSCqaJ/jiiQ6fIpjcs89byL6Ms5A9DX4hy/LQAMVjD0090NjsT2Vi41HoVWrY5LkB747xKeYcNJ91lHT3LRyWlODVz6e2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-65cfbc56a29so2277096eaf.3
        for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 03:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766401566; x=1767006366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Er9fT5sSTO9v6Ol7FhPUI+D4OHHff+0Re947MEjlztA=;
        b=Qv6ON0dlUcno0zp/4HhNqhQqHIdrglyYI3Xhy5ZxFg/Me0k+CRtDJf7HmKxJZ2/c2P
         rMB9gHxwjYucsklyOaYEGt5oVC7tWc9ex/55R/RYkwILoDPsxcUgXL80gqtpdccu9u7N
         UDWcfvnm+1nYZV3DCG9aA3OnVaKY0vjrdwbz15HtX6WRrqkruvzqV4EE9pBUDN9GdmmB
         CGibUjquQ4Z9PIsPrTdFTFgMjiuMKoqlpXhPXfhmbAmES4tbpz81TZ88eMRz8QC+/meg
         HbcZEob1T10H9W2JUppe4doYtwevlHGMdrTFWoDBvbPCvLaHK0bccc4a2t7qy0yjsvhg
         mJZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGf9QnP6WiTWcr2YwyizFfmjwffwf2/8+QxURUhhcXoXmjQo7SdR6JHWXY3N6lPnatijUMuX5QMFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIN53lOWy2PudwZqG1auBxqWrBswvsUUUYJ/wx8rTJrdSeui3S
	ANahm9wbIIfH1HMzU66HIlXLhLEncAbfYrL9LiqI6n3fp0e2Bm5VJUJReUdtDbNr
X-Gm-Gg: AY/fxX5KCmAJWIFVlnKOVWsG/uNsZhN563MiJ+9IE3CaezU0tOchyW75iL4fK6HSW5Y
	08+nQ3/M3HkIWP3LLT7nuX7ACv37dmDP6saSdYYMBKsI9/RSjdHmRdH5FRO6XHOYmUxmyP8aaLX
	3eJkCSlzSgiZQaDhdvUrYnOTiDg7Nlm8WVdUw8ybR1qObXWDfV/8sKOQz8Dh2POY1r7TTIj3FE7
	4GHW5o0VClh5i9s4mf4HJTB+4sLiKl3z06v5a42MLtZnMCvUxUo0b7lNtuJjswy+KuL7F6trBVB
	cB6Cn/n5gnDD/3Djs/SDWKpDPc0zb3vCIgDbIYEtmI9b53s8hEgYSrhGP9FJuDnrEWURiqekK9a
	ZOzSjof1eONJkyNB9r62uFsLDX5PtQVF27ui6WWiQtPij8ldrV3C9txKDMZnSxBo1wGQh0mhH96
	T3UNQ8l/24o3OiC7abPB+aM2phaF7ZzGlm99r6orX7dkrMeHQU
X-Google-Smtp-Source: AGHT+IGfgqoqfsiOAcYBu9mBHfnMucsgEje7NsYzJROZvhYDOMoAW+5OHhTW8nxEfqYxAf4A1UsFog==
X-Received: by 2002:a05:6820:f029:b0:65d:c57:70b3 with SMTP id 006d021491bc7-65d0e94d36bmr5579140eaf.12.1766401565739;
        Mon, 22 Dec 2025 03:06:05 -0800 (PST)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f710763sm6824518eaf.16.2025.12.22.03.06.05
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 03:06:05 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3ec4d494383so2705549fac.3
        for <linux-can@vger.kernel.org>; Mon, 22 Dec 2025 03:06:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLHDydCU0KGHPSBjhEig4S2lJIbJgnLdot/aybeWooOQc67tvmdF8Duzd/ebpVO0ZLSx6F2QIGkXg=@vger.kernel.org
X-Received: by 2002:a05:6102:e0e:b0:5e5:5ed7:60ae with SMTP id
 ada2fe7eead31-5eb1a817635mr3544923137.31.1766401227460; Mon, 22 Dec 2025
 03:00:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com> <20251210-rz-sdio-mux-v3-3-ca628db56d60@solid-run.com>
In-Reply-To: <20251210-rz-sdio-mux-v3-3-ca628db56d60@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Dec 2025 12:00:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXmKPe6AyfAeD9nObqVhofZ4a5559_=DbDZzJ57A7=k9g@mail.gmail.com>
X-Gm-Features: AQt7F2qYMU-2Y0vKWd5gUo3SltdOK-02OVX3vIl9B9fuc7xPsFnO8gx3yQGyGmE
Message-ID: <CAMuHMdXmKPe6AyfAeD9nObqVhofZ4a5559_=DbDZzJ57A7=k9g@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] phy: can-transceiver: drop temporary helper
 getting optional mux-state
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
> Multiplexer subsystem has now added helpers for getting managed optional
> mux-state.
>
> Switch to the new devm_mux_state_get_optional helper.
>
> This change is only compile-tested.
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

