Return-Path: <linux-can+bounces-8278-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v5LeNp/IUGo35AIAu9opvQ
	(envelope-from <linux-can+bounces-8278-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 12:25:35 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 319D4739A80
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 12:25:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8278-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8278-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A59343035A84
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 10:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EA340682D;
	Fri, 10 Jul 2026 10:19:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4E3E0749
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 10:19:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678746; cv=none; b=WAYPF/0r+ruoFOl8LnJQ7AzB/Y5CXtHN7QiqV4+O3Cl9xdg9PL4KgK+ofTdxAp9lWy+pkA5tN9nFCgRTndNLnRqNFdD52xe+kzL9eIyJYX/s7Swjp3cW2usgA3bEM9WX8EteZrwh4V3nZxUU2lah8cd9PgVmwPbb+q/iSsjvEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678746; c=relaxed/simple;
	bh=+p5C07PlzwAnFV8W7DMxCM+4XlX762Bvt4U2R/azgio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nm66AWYsh7Dg0pMJ/aP8unPIWRhFpuTzjycxw7u0+K6K3J3cI5WCzvg0II6aYc6Dl4fymYEmyqPZdmsJbJxP4qoMUM0fQ9DDlMmmVQmT27oSjKQ3NUN4q7LfikXQwB1xCuhnQVrUw3NxOCsAB24yCQ9OTVVMDCIzW2xgCY+CVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5bdbd631a6aso577251e0c.1
        for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 03:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783678744; x=1784283544;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bwp9IGUDjgmX3mBabgZGirsEvY8TKRimZIn+QIFNSvc=;
        b=NwMPavDhruVvgRv2fdYEQHBKS13icLnR6B46ScPzoqiNvnuCMPo6gvxi3mV+DzDxN7
         6Cdvs1WJUzs+yvcrlZjq/V4kqLU01P+g22IFD9l5kDXq91knfWYrx22ndG9BWIw5hPAo
         anHKLsJ0wdxbJ8m91q8EfQFU14ga4vUnFDNqJbvvZVNOL7b2BACYMWMZTGqN9MQzbNIl
         DT5eyNuKiMqQVO99hSawSuBSdCmlT9DEBlEazUIz26CxrLaqbF0JcWxmySvjIMF5Ck/Z
         WblZS2N4ZbMWdplqOawDX/ixLVYLVl0WfemZ5qSHdbQaQdnl5hXmCTURHgm8+BM2WpIQ
         3k8g==
X-Forwarded-Encrypted: i=1; AHgh+RrXY0ARZoWD1VtckttPQe2I6W1sheRjDhsdorBpETWsEuUXEpBH84gMbjTFkiutIVqlR/Gcd5AtcKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3t/p4LdiKRoLcwKrE8aTvzcK30p6+FFI+3StSZNm0xHJRgteY
	JvtH0TSI0cIgkdY3kKjFauLTMH5YWeAG6PNTFKl/C7LKc60HC53hND0h+XaxjVrL9wM=
X-Gm-Gg: AfdE7cmrS63qX+Jncd0QGtENKeUXDLjmMAFkTBUYk4oMeITGN7ip6AOgsrey3Q7xEpX
	fVOXR15QWt+EEvKFAUwNBVdeg5fWOa3hrlbSYAguoxzwILIyEddN7MMcEzKToOFjybHLCoTlJED
	6V9ZdZRgE7eJjGTWSPPRV0FOGI14gHRT9HfFg7z0f4eGuTA0TqSj1aquOOJTLYL70X4HSlf8oAL
	m35G/l0nbHvcBlZ1V/iln+QJ07q2lNYfEq42b9tMIpnS0hhTGqFcaj7mjlC/jJFn/3dD+RGzD+y
	9vJlPC3wX62Di2gTiSZ0JqyVP4ALNghqH+Y1qmPk0Y5CoRRA9Qak/VaPDWdYkhZFrNxtUAWzjxH
	IrUHARBon+csst0rgknMRX7kQQ2sU/XgEwmN+s0oxIqDl+mfLUc0KfA2bSCdTScIX9m2iEGZi7q
	xkWekTv2kqRxTI/SX5NNduW9bf2J5ZT3B6sDQXx1X7DNa0dJ0iWvVrNw==
X-Received: by 2002:a05:6122:1d45:b0:575:f155:8cd4 with SMTP id 71dfb90a1353d-5bfa4dfe0bdmr1532934e0c.0.1783678743658;
        Fri, 10 Jul 2026 03:19:03 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bf6f8f4283sm4593018e0c.17.2026.07.10.03.19.03
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 03:19:03 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bd8efccd11so1490395e0c.1
        for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 03:19:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrSVB+oqRYYrRFV5JHwG48Jrb69EhR6Lv2O6Me3M4jEEo7YAkxAT/qZbQ9SlgEt/gbYldWO0DcxTeM=@vger.kernel.org
X-Received: by 2002:a05:6102:8516:20b0:6cc:e6b1:7f84 with SMTP id
 ada2fe7eead31-7450caa467fmr935740137.17.1783678743107; Fri, 10 Jul 2026
 03:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709182332.876408-1-claudiu.beznea+renesas@tuxon.dev> <20260709182332.876408-2-claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260709182332.876408-2-claudiu.beznea+renesas@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Jul 2026 12:18:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUGKQAuLJ-Vo7=O8E=kMCYiUZ2H=Be9T3PAkjHu+PRqhQ@mail.gmail.com>
X-Gm-Features: AUfX_mx3pB3dkKwbzFAKhxG_in4zcQzaeWH0J8kav2JP2BfBiNLW4WLUquaQ4F0
Message-ID: <CAMuHMdUGKQAuLJ-Vo7=O8E=kMCYiUZ2H=Be9T3PAkjHu+PRqhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] clk: r9a08g045-cpg: Add clocks and resets for CAN-FD
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: mkl@pengutronix.de, mailhol@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	mturquette@baylibre.com, sboyd@kernel.org, bmasney@redhat.com, 
	biju.das.jz@bp.renesas.com, claudiu.beznea.uj@bp.renesas.com, 
	fabrizio.castro.jz@renesas.com, claudiu.beznea@tuxon.dev, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8278-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:claudiu.beznea+renesas@tuxon.dev,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:magnus.damm@gmail.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:biju.das.jz@bp.renesas.com,m:claudiu.beznea.uj@bp.renesas.com,m:fabrizio.castro.jz@renesas.com,m:claudiu.beznea@tuxon.dev,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-clk@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,gmail.com,baylibre.com,redhat.com,bp.renesas.com,renesas.com,tuxon.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,tuxon.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email,linux-m68k.org:from_mime,linux-m68k.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 319D4739A80

Hi Claudiu,

On Thu, 9 Jul 2026 at 20:23, Claudiu Beznea
<claudiu.beznea+renesas@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Renesas RZ/G3S SoC has a CAN-FD IP. Add clocks and resets for it.
>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - used R9A08G045_CLK_P4 ID for P4 clock
> - still collected the tags; Biju, Geert, please let me know if you consider
>   otherwise

Thanks, will queue this one instead of v1 in renesas-clk for v7.3.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

