Return-Path: <linux-can+bounces-8210-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5yWZJZ7FT2qroAIAu9opvQ
	(envelope-from <linux-can+bounces-8210-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 18:00:30 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 425027333AD
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 18:00:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8210-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8210-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF07430661B0
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 15:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517BE426D18;
	Thu,  9 Jul 2026 15:52:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97042A149
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 15:52:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612373; cv=none; b=IopBv3qbpxyedcp96v+HV1khi0UmWwQeeV52oetjT9cw28uBrXJ3LbQWjbNCBXouUzaI7K0Q7Dl8JXeNgcPOO0AMlkxHdS7hXhWFY4ulSpVk3DLhC6FruSD8wdN/0eAbGqdI87FPUVfU6YIElND9UISVjfVJfXuoQqUnIMGtvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612373; c=relaxed/simple;
	bh=FK7tiZEI0WffDbTlu07kAZuJRwj0uLdhH15mcZOjFjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PV9R+V66Z4Zy1jU37AafXPhyl7zqxMhU9hS10w29w3aUie9tvtkPlLgQtwdUiJNDZGrSXwDD2OrjQQK9lba27/UJ86X2uXx97iOf8/bcyvmAtsFNJuUvjAURm4+C75If8zPAr6taPCuicCg2xnpJrS4TkkxrWnF4Lo04xx9ieXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7eb787dec99so23411a34.0
        for <linux-can@vger.kernel.org>; Thu, 09 Jul 2026 08:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612371; x=1784217171;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iqrcHFDoPWS2t5kW57shcQV+qLcmaCnZOWUcXcNxWfY=;
        b=QTmPnGKYyo6L94d/Sl+ztCb6+32b5GZwWkusqV0n327KSLSfI50rj/tVBDulguX60u
         MC2DZotR2Hw62XymIxPCrNyydHAfkK9PLXb2qUIBQdEqWTflLni2CkPm5LuUO3kUs3UA
         9O08YugQNi0+qMUepiQnVpxZ5NYW79nQWeEvZRk7+ia3qAqLnuDpVeBf1i+YmGmyWDhR
         bcMHDpr6dVPycJukeD8ukYF+5U97QK91fVD6I5y9ooEkhO0leQqj9X32u+oYDSj7mL3X
         WfRbAZNyKXMS3z+dJtMmfj2/siLzPjKhMn8yZilTJ4ylULj3ZZH75H97tnDvSfCiz5Ml
         FzaA==
X-Forwarded-Encrypted: i=1; AFNElJ+RWRW5qiMMrDZ9SlM6KTG1qvL+IwoIbBQJbMELn8h8FhyK957KRxNKidoPvP4xQX2d9O0SfE38M6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQWPsI1OxhHdqg5zKDforBhHKDC0qne2IDiiHyaJV5DSwWNLgy
	4VM5axwAL7MF43S7zuZ45e/SRO6Ym6yis8oWfxuzz6TXY0PALojfQN6GWyt2XaYR/7Q=
X-Gm-Gg: AfdE7ckrrth2MMQikvZhYKAqttUY2SSJwJpX04rSpsMeD4JtE5NX87hkg8zd6/B+k6c
	Oes+Tk3adSAK6RqpDCNP+dCFE0rphU/+Lbna7m1yWl7DqsTJK5zg0b+t6TtrCZKiLGho15WnTcq
	1VqodzOnXo1pSn9PYycSwCUzyR8ZmX4n7dMFzM+SDJMqCS/sHYYMdMrPLx+J8TdTi0BhGmP32Lc
	/63GXxWVCsZPhykwau4X9tkgb5X1WbaQFA4Qr1m4gM1TliXDdtEQDuQHoSW6dAGpwNFYpJUQkvF
	V3bgVX3md21WRCdk4ukuHMQwqzUFll2NqKP6IK43yFAG2wyYR5ER8h00gItmFebzyVnuhpXH+CC
	+Sp3GZGMBzyHni4JG2A3lxSscTDScWyNPsu38gliU9KfgtxOoHf6RLOAv+ZatYgo8y7zPlLAouC
	NDa2v0Oc7RH/k+4CyWctaTGDJOsO8HyubZQhT9tMZmStY8dUgjbg==
X-Received: by 2002:a05:6830:a8f:b0:7e7:aac:4cc9 with SMTP id 46e09a7af769-7ebcff35968mr6263555a34.3.1783612370719;
        Thu, 09 Jul 2026 08:52:50 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae1ddb8sm4489622a34.6.2026.07.09.08.52.50
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 08:52:50 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e6128bd9b3so14000a34.1
        for <linux-can@vger.kernel.org>; Thu, 09 Jul 2026 08:52:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9CWhTgh6jngwh3BOTsQOtyS3mkoTJtxwRhpB2ywxFTGjqTQAI6aJkRQdxRYBbIQwhNOE5Csc/LnrQ=@vger.kernel.org
X-Received: by 2002:a05:6102:f8b:b0:6c2:e290:cc69 with SMTP id
 ada2fe7eead31-744e01021e1mr4657081137.23.1783611946911; Thu, 09 Jul 2026
 08:45:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev> <20260707102418.1646159-2-claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260707102418.1646159-2-claudiu.beznea+renesas@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 17:45:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUEQVN7VqsmQ6EKWxazrFyQdY4edaHyt8pPFEaJfGgbpQ@mail.gmail.com>
X-Gm-Features: AUfX_mz8Do1OkGKS8SDkGEbLBy8tojYuESbee1M6XmgysSPwrDRBiIuowYvmngs
Message-ID: <CAMuHMdUEQVN7VqsmQ6EKWxazrFyQdY4edaHyt8pPFEaJfGgbpQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] clk: r9a08g045-cpg: Add clocks and resets for CAN-FD
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: mkl@pengutronix.de, mailhol@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	mturquette@baylibre.com, sboyd@kernel.org, bmasney@redhat.com, 
	biju.das.jz@bp.renesas.com, tu.nguyen.xg@renesas.com, 
	fabrizio.castro.jz@renesas.com, claudiu.beznea@tuxon.dev, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8210-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:claudiu.beznea+renesas@tuxon.dev,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:magnus.damm@gmail.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:biju.das.jz@bp.renesas.com,m:tu.nguyen.xg@renesas.com,m:fabrizio.castro.jz@renesas.com,m:claudiu.beznea@tuxon.dev,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-clk@vger.kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:krzk@kernel.org,m:conor@kernel.org,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,renesas.com:email,linux-m68k.org:from_mime,linux-m68k.org:email,tuxon.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,glider.be:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 425027333AD

On Tue, 7 Jul 2026 at 12:24, Claudiu Beznea
<claudiu.beznea+renesas@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Renesas RZ/G3S SoC has a CAN-FD IP. Add clocks and resets for it.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.3.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

