Return-Path: <linux-can+bounces-8277-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tJgXMibGUGqL4wIAu9opvQ
	(envelope-from <linux-can+bounces-8277-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 12:15:02 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFA1739877
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 12:15:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8277-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8277-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29D54300C010
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 10:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD89404BC8;
	Fri, 10 Jul 2026 10:15:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C670403AF8
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 10:15:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678501; cv=none; b=lKdt8U/v25oWxYCJs7f+fvNSugbtTxdhu8E4goAJcBE2L7a9IPe+pbzW3R4JsJI/BZ6s3dtC8eGUgx7AWQWHBV8oGpQYGCV7dxf/4wGgO2GvDvwkue+ByK2fUSCoItX8Ag8dnjS4Nc8FRa6J981NCuIF7KZjYdoCuXvm61BT5YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678501; c=relaxed/simple;
	bh=jStoTu7RQA8BRTqGbaAV34VwUP2BPEMz29vPuO1fGCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDeKB4GTg3TotqKW5J9/wBY645SenSKe8hQQqx1pu8FfFypTqlSS2HQURhEYX/1rOoQsLcaAcjskyzj3q+m4B6fpBSi7dIS/16cMzBVJYlJXgiauyVuqS4h4QN6kWbUyRiZPb/48wUbXem90wPix7ajEnFxDND60Knx23/Wtm28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5bdbd631a6aso574805e0c.1
        for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 03:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783678499; x=1784283299;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GbEWAG6xIcV+3P2phIYnj4SrZfkvn8WstI+WFIFJ95k=;
        b=gOZT2v7iYVqL6zMSI0NVBAiF2OhXu+3CJx2SYGj8+DPEWq4f7ezvgvFhjfGkPwpP+M
         luho6CY9rF2iGvTdVxYxzu6L8LvE3Z8hG4gaKy+mliIcmzA3m6obT+keyBp53fubTCLA
         W4RS/Vdfx01buA0JOqw2ck9EcTOIdgN0e3rVJ4pF4oa+HtoySEk88uDMgFYvjmSStr8s
         MJuIX7iXlRKCqqk0VFyBgp6kdCxJ0OkuCbktZtarZy6Rn0lOXX5hTgkLgEKNDt6eqYnN
         t60Q1wJuYQQGraOtSneKSVnB3HQ/RXGqrNmuBc89mIbu5YsG1sUatmweqghbuGarPQOL
         o6xg==
X-Forwarded-Encrypted: i=1; AHgh+RrcRz+DMEMOyLsJWjUBkYNARFAcKjTdcWH5jeoul/ZzE5PPIr/Xn4y40aRqYjqb2Db7xzL7YCAl9Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHPztMoDT/iNkISRgdYlEM0NqgYFLTxvc9HAsFsMVOFQ/wBHfW
	W/n6jCazpvh8EbqYy9o4cLHj4rRJzvFt/C29sk/fbt9Z2eNrasOT148IPObFD4qHVSo=
X-Gm-Gg: AfdE7clbkfxs8wLx8Tj8AJ/xu3dTUFLjqLSsO6f4qDNynfD6NTS484ycbsxlZKnSCLX
	x3+JzE17WH68BHZAY/KMmeJu/d50d/HULUYfO2kAPgT9vZht8qp/SZSlekzqFn97g/V/KUgyGNZ
	eIP39msHeGDRk6h2BOVugT8sUPG5PD5VIVctwagoojCtRXsQNkJrArfB3eCFW2/LU0S41r2//i1
	RLYy8eS+7h9cq6/5dReKMwkSDpsm9Dj5vwOAu2jGc/xX6rRxFMaxTQTd3cC0ZgY7+r62F38VTw8
	KxyPAoeOd9iEu3RYERvuF6oPiJT3u8jG3RnfW2IEboz9+Yx0oMHS2m49Bkggzvf3u14rv2Ssy6N
	ADmWrmC0/pu413R1uNUkSwOMnbqTtlkI+sX3fcF36wCaoqBeRZMqOTc19JMbantxX0jmfuds3OH
	v/eSf/vjjb5M+17ihKWy8vHC0hHGmS/nDYR5kjTU62IXgHfy6rjw==
X-Received: by 2002:a05:6122:c9c:b0:5bd:b0a7:47e7 with SMTP id 71dfb90a1353d-5bfa544db9emr1679551e0c.3.1783678499116;
        Fri, 10 Jul 2026 03:14:59 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bf8bc8e082sm2345771e0c.1.2026.07.10.03.14.56
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 03:14:57 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-971de219a85so316657241.0
        for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 03:14:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrqJqY9YTXpiPq9xqa+DYf4OBYJITItYrBg4081UQS6HbQkrzwLPPvtgdujJRAiIyCOuC4OF7wHzYc=@vger.kernel.org
X-Received: by 2002:a05:6102:40cb:20b0:744:f2bf:44d2 with SMTP id
 ada2fe7eead31-7450c6bee09mr1278940137.3.1783678496645; Fri, 10 Jul 2026
 03:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709182332.876408-1-claudiu.beznea+renesas@tuxon.dev> <20260709182332.876408-3-claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260709182332.876408-3-claudiu.beznea+renesas@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Jul 2026 12:14:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWeCpR70fQ52NYsB_p+Feth0gewdfjSBCbpLWfUCCDvQw@mail.gmail.com>
X-Gm-Features: AUfX_mxSD2HzC_Ku4zRdh3S4Ewoz9pnRW_48syvAhXfLnIrebj7osOYA05aUezc
Message-ID: <CAMuHMdWeCpR70fQ52NYsB_p+Feth0gewdfjSBCbpLWfUCCDvQw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3S SoC
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8277-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:from_mime,linux-m68k.org:email,renesas.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAFA1739877

Hi Claudiu,

On Thu, 9 Jul 2026 at 20:23, Claudiu Beznea
<claudiu.beznea+renesas@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The CAN FD controller found on the Renesas RZ/G3S SoC is largely compatible
> with the variant present on the RZ/G3E SoC. The main differences are:
> - the RZ/G3S provides only two CAN FD channels
> - the RZ/G3S supports only CAN FD operation; the Channel n CAN FD
>   Configuration Register does not implement the bits used to select
>   classical CAN-only mode (bit 30) or CAN FD-only mode (bit 28);
>   consequently, bit 31 (CAN FD Frame Distinction Enable) of the same
>   register is also not implemented
> - some bits in several registers (mainly reserved or status bits) are
>   read-write on the RZ/G3S but read-only on the RZ/G3E; their behavior is
>   otherwise identical: the bits read back as 0 on both SoCs and software
>   is allowed to write only 0 to them on the RZ/G3S
> - the RZ/G3S provides 128 acceptance filters, compared to 64 on the
>   RZ/G3E
> - the RZ/G3S can use PCLK clock as the CAN FD clock source through an
>   internal clock divider, while also supporting an external CAN FD clock
>   source
>
> Since:
> - the SoC clock generator provides to the CAN IP only the peripheral and
>   the RAM clocks
> - when sourced from the peripheral clock, the CAN-FD clock is obtained
>   inside the IP itself by dividing the peripheral clock
> - the assigned-clocks and assigned-clock-rates properties are specific to
>   the CAN-FD clock
> the assigned-clocks and assigned-clock-rates properties were dropped from
> the required properties list of the Renesas RZ/G3S SoC.
>
> Add documentation for the Renesas RZ/G3S SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - forbid renesas,no-can-fd and renesas,fd-only since the IP supports
>   only CAN-FD; for this didn't collect Biju's tag

Thanks for the update!

> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> @@ -267,6 +267,7 @@ allOf:
>            contains:
>              enum:
>                - renesas,r9a09g077-canfd
> +              - renesas,r9a08g045-canfd

Please preserve sort order (alphabetical).

>                - renesas,rcar-gen3-canfd
>                - renesas,rzg2l-canfd
>      then:

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

