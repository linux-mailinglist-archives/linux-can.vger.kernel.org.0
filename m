Return-Path: <linux-can+bounces-8457-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VtRbMK1OV2r5IwEAu9opvQ
	(envelope-from <linux-can+bounces-8457-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 15 Jul 2026 11:11:09 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D16D75C45D
	for <lists+linux-can@lfdr.de>; Wed, 15 Jul 2026 11:11:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8457-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8457-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1331230BB0A1
	for <lists+linux-can@lfdr.de>; Wed, 15 Jul 2026 09:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D3F3ED5B8;
	Wed, 15 Jul 2026 09:04:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA9E3EB0F6
	for <linux-can@vger.kernel.org>; Wed, 15 Jul 2026 09:04:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106267; cv=none; b=kSMCfq+UjnpNOp1miBUoGasz2ODkw+OOR7fIXeF7lSnjyu1RklsBUH1MMpjkeAGXtraHiKeGy3h1zCxfpkRCmOV2H/EgJauUXfM4VwAsLb8I/QcnMgy4dxwz8AbbTEukoiMpHrqUnVddNnedHyNnPhwART0xqr0DLRo4EIka3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106267; c=relaxed/simple;
	bh=cd7DBG096VF7/MN3QhC9fHqLP5wSJXhCQl8cwkt8dzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZ0oNhotcLreICrEeDvpb1dRbJLCXyYxwqWIc/IOXZugQLk7mZxtP5ImPYMv4j/bOQascCTawiwWUjilCaS1gUyKlmXoOOfIl54ValfmKNLAvoUY/qcmMOTTW2J3qk++ZbEzpb56VmSIO62zktUQOEhyWG1ERtdcFWe+8kxHbN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so5889039b3a.2
        for <linux-can@vger.kernel.org>; Wed, 15 Jul 2026 02:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784106265; x=1784711065;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Em+8fgb0ygi1i2LhSV0Cm1ShdIUU1QDIn9O8w7QaQ/k=;
        b=sR+mxjrJZk14nUnjnu6olZqKaxafOi/bUXkTvnCzq1kaVpfwgqHMHT0RqpccVXR0wN
         yeX/v+t1RWy73+UbSgAJSXKe9gqdiW6hKod+DHpw2zg88k7qqVDzjZS+NPQ4syEoD5Pf
         6gjGwNcMnIduIaqZwRcBrCcAe7kUNp7KCZJE66J0aOmx/RbCR6Fh3GRjvTgi1QDpqQ+r
         IyjQF1PvVhmH+Ethj6JAT1pwrEp3pq4B65lT5jL/FL48ykefZh2OFg4kIxyYYHiZjmVH
         pF03tbsVixk9+4nafn8VhzVyj6DJYdslBHgtLKq7xWznb4pxlRZuYTczNUH5C/qG+6d5
         +C8g==
X-Forwarded-Encrypted: i=1; AHgh+RphNdp1TjFBFNeunw9rAzLNBN/coCL0mmO+Z9EZ9umxzMoGuLW+2wUfpQja1nMteCKw69eb5Q9gyEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX4iBD9tk0SLOx96ieWTAbsPcznvZMXrPAaKLSE+9JI7gbvsI2
	fivrYLzZbUxtORsCTHgc4weIig6Nem8eFZuHCtPPv4FyBxjTJ2BChQKN+spwjwFkZoI=
X-Gm-Gg: AfdE7cm0L5yDwi9r1huMckL1scY3R2qPzG4Iy3/QjaGP93Cnvltlqh9D550EAmzb7Wa
	qIc7cWEQqy/XFgeBXtt6AaThZmYMlUH7OdfThQ76wT8bj55cpfIMWhOIF2EKNhiKCQq8WHr3E4l
	z1HHqaHyCcbDWEjN8acZt3M+3ug8wGmYH7bsABh6aWpjcq6Ud/1AD8o+EfyCeQCLYylBppBC+tO
	yOnjf0Sk+l20a78P3sXyhS1FjZQCxf82Vo0WGitbHx3OXoLho/xUUM1kCl4gglvTpXyTLj7rxY0
	fqKZttKQzudw7wsd2pTkVlfKN2z3/an78suDQL5z9Ro/3ilHXubLtBEOnQl5Yj9pK1E5tLJ+NOX
	04VSmn46C0nTtRMzH58X0Jj1pViUkvOgyBAOAlYO0WzqJIkNsqVw09D373+blr8HJuNXVNd75HC
	ktC82PZU9iCjwina4YHHASROshEpw0o0FTDReQMGiA6s4JUH6lgVk3nA==
X-Received: by 2002:a05:6a20:a10e:b0:3a2:dbaa:82ee with SMTP id adf61e73a8af0-3c34d5297f9mr7940972637.9.1784106264717;
        Wed, 15 Jul 2026 02:04:24 -0700 (PDT)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com. [209.85.210.175])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3162a49sm10843098a12.15.2026.07.15.02.04.24
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 02:04:24 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so5889022b3a.2
        for <linux-can@vger.kernel.org>; Wed, 15 Jul 2026 02:04:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp0UKhMQZVj8HAAZ1ffmWb0bZdM1vmMHwI7sP5s8wmeYeIq4pVPs5SxBtJgAUlcgEsd/VXkGVB8Viw=@vger.kernel.org
X-Received: by 2002:a05:6122:82a9:b0:576:c4b:460a with SMTP id
 71dfb90a1353d-5c10ed0389fmr3961224e0c.8.1784105930097; Wed, 15 Jul 2026
 01:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev> <20260714173315.1981708-2-claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260714173315.1981708-2-claudiu.beznea+renesas@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jul 2026 10:58:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUgvwjb7zNnsRXX9AzaUVAhVmks4yU5P+pJ0in6NyA+ww@mail.gmail.com>
X-Gm-Features: AUfX_myYPtAhsLzqsMqdAVX_MCR49rN5A1iR-oDlp3d9aq2XNRWC9ufPlL95oJQ
Message-ID: <CAMuHMdUgvwjb7zNnsRXX9AzaUVAhVmks4yU5P+pJ0in6NyA+ww@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] clk: r9a08g045-cpg: Add clocks and resets for CAN-FD
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: mkl@pengutronix.de, mailhol@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	bmasney@redhat.com, biju.das.jz@bp.renesas.com, 
	fabrizio.castro.jz@renesas.com, claudiu.beznea@tuxon.dev, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8457-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS(0.00)[m:claudiu.beznea+renesas@tuxon.dev,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:biju.das.jz@bp.renesas.com,m:fabrizio.castro.jz@renesas.com,m:claudiu.beznea@tuxon.dev,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-clk@vger.kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:krzk@kernel.org,m:conor@kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,glider.be,gmail.com,baylibre.com,redhat.com,bp.renesas.com,renesas.com,tuxon.dev,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas,dt];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D16D75C45D

Hi Claudiu,

On Tue, 14 Jul 2026 at 19:33, Claudiu Beznea
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
> Changes in v3:
> - none

No need to resend applied patches.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

