Return-Path: <linux-can+bounces-3082-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CFAA612B2
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C477B3AFC8B
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 13:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3E51FFC6C;
	Fri, 14 Mar 2025 13:31:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE7E1FF1DA;
	Fri, 14 Mar 2025 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959114; cv=none; b=qrzO35479o6kX9LOVE1ipwfLmW/ww8nkLgVvEnO/2aAZf0a0Hsw1/GVL1nsJmyJayzmz5/IymJc+VKYGB4+YL6jEO+u1cVmrxiBRlTnErpdIkO37ntnVQovmuK5vPRsJB7xtF5fmtx1urolYTaQTeG+Lzu7eks/LU1JdeOyvFZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959114; c=relaxed/simple;
	bh=/1OyBHCSUGEHUQF+hraCaikN7Atdl5ChyYCCJK/MRwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEWoX+lIlKu/jmLREh58d/xBffmqXBzMH9qZXOrCpIILwgh7Vw/ZvM5wABfUlUHEqY4sCUdZD+/INw47/LoHQDKSXVS83Hl6Vne7xYjfVBbRYnsAzpyYyKaMpn3diBkGaULcrLuM2OhITRjrTMLzVgKcAVUvPi7tuK7Xi/qAvPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86d3ac0fec0so2017703241.1;
        Fri, 14 Mar 2025 06:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741959111; x=1742563911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdsP/C7vJvwzf5r3hUg1C5beEovb2PN7Hr+v7lfHHzM=;
        b=Tu2cn0fPaFg0LO3uQHQOEpdHG7b4lCF4XEchh4wKct+1MYNrdbex/j6vg1taKxW9VU
         MfvSoIQBY/1/NcjczkVtDGODZzaZbQ5hU6Xsipl2Gqo4Xgx27ztF6cFs3kET5mo87bn3
         5ND/QpxOqBrtdi2lfmwkXXFYkLe/pCowlVujrF0sBU5oqJVis7PMxiX7RKWACqirsx0V
         eUYCTHyKHBFdhImUKE/FY0svihBpH8y/LvrL8Ddm877pwKifoHrplFCPMZLqRRISSwdP
         s0ygKpS9hsWrQZhT0+fnT0pCLjdbdaM4dmQu31kBh6+n6l7/Won9bUsQoeRRrUARztU9
         iw+g==
X-Forwarded-Encrypted: i=1; AJvYcCUXVSmRZlQrlpmOuDAymJH+Q12dgGUlbFGBhTcGsbJS8ve+jxXO2swnRVG0OVURAZT/qGvo8M5832zL@vger.kernel.org, AJvYcCW46WsnIM8Imy1830NAUMx030p9pzenvmsH5QTUObvMdBuOx1+fNWu30IA9kO3OxQvVkOu2PV+m+gN01mQEWHmrwJ0=@vger.kernel.org, AJvYcCWPCsv1uqAXxsoUO35T8fBtrv3HGRjBKU6FcA/987tHcbnet9X0eG/ZYWALdajZjelvIh3fG3U0qah4@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZM2UKjKd6xFA52mjWJWcPh2tPv1xAf3dirfXAlcEMZ63jnWb
	f5Wsf9Q7fmsavTwFQvonJ3QLLE/5AcEVLwmMPLZtB4BP03Y/sIWUchTofb4KUKk=
X-Gm-Gg: ASbGncskUkq3YbSG0Z6w520qGgYPxFqpM6Kb+xLNAo+ijuyvlVRXKLRXT+4MPNcRbMC
	V9Ha2RBsMtJwjBNjwb/DBN5u7yP0v6Yv6bd36pkyvWIxBsPPGAOhp+KxiCupu5doVUFB/vYt7IP
	nW2QNcelOY+GZlUZLxuN4uecnmIUerK6NDYH2PsEAvXfjtERBe7LD8FiAnKrd9leHh4iJp4vboP
	7x3HmMKakV0J66QLdxrD+fCuDXLIi1A4F71WviwUHGn2raR5Ujvi35oepl6iIE1L2x86Mru5P6z
	f3uawV+GbZK7vLHS3zGbuluqvo/rHaqZYfp1BbW/v5sWeiKdCPxUcBG4iDgdisbw+aAa8QUo+OA
	sS6axkBw=
X-Google-Smtp-Source: AGHT+IFOGr9YoJOoW3vf8W+00ednyoOhlfJzjaDhfIzxDOBx5guCg0oovUHeIQg/ykmahoIcmEBEgw==
X-Received: by 2002:a05:6102:579b:b0:4c3:6544:c250 with SMTP id ada2fe7eead31-4c38322a7bbmr1415548137.23.1741959111192;
        Fri, 14 Mar 2025 06:31:51 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c3759dd36bsm477976137.18.2025.03.14.06.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 06:31:50 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86d5e42c924so2024225241.3;
        Fri, 14 Mar 2025 06:31:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUR2ddbfQUKrAy5HgPOCc6o0614UDmuUBoC1urRuiOdEpaypLi3h/0gcPVrtDFhnt3BYk7GU6FNFWJ5@vger.kernel.org, AJvYcCVLb2SrttCNGW699jNYvXAlhVZAwhCvdvyfSE5cvKOMAL6SI0oflLnxHhB++3rRq2oXQ3vxwJpX0h0c@vger.kernel.org, AJvYcCXAKvFX3D9/pPtRb094IBWMrDJYOUWTtELz5MidaleCU7NtyWPB7CdRl6x5wWTCaVMVmQQCYv1bWXYLCkKUgj+SYcI=@vger.kernel.org
X-Received: by 2002:a05:6102:579b:b0:4c3:6544:c250 with SMTP id
 ada2fe7eead31-4c38322a7bbmr1415474137.23.1741959110736; Fri, 14 Mar 2025
 06:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com> <20250306124256.93033-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250306124256.93033-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Mar 2025 14:31:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU0X=4KNXhh98igqmnwHuv20jxQe73hd=Gy7cALrHBFPw@mail.gmail.com>
X-Gm-Features: AQ5f1Jpi-XUERR2icvC7fNOdIA4hq_UVesFXSE3aaSFd1c0D_mXqh7qc21TWCkw
Message-ID: <CAMuHMdU0X=4KNXhh98igqmnwHuv20jxQe73hd=Gy7cALrHBFPw@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] dt-bindings: can: renesas,rcar-canfd: Simplify
 the conditional schema
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Simon Horman <horms@kernel.org>, Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 6 Mar 2025 at 13:43, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> RZ/G3E SoC has 20 interrupts, 2 resets and 6 channels that need more
> branching with conditional schema. Simplify the conditional schema with
> if statements rather than the complex if-else statements to prepare for
> supporting RZ/G3E SoC.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

> @@ -117,52 +145,71 @@ allOf:
>      then:
>        properties:
>          interrupts:
> -          items:
> -            - description: CAN global error interrupt
> -            - description: CAN receive FIFO interrupt
> -            - description: CAN0 error interrupt
> -            - description: CAN0 transmit interrupt
> -            - description: CAN0 transmit/receive FIFO receive completion interrupt
> -            - description: CAN1 error interrupt
> -            - description: CAN1 transmit interrupt
> -            - description: CAN1 transmit/receive FIFO receive completion interrupt
> +          minItems: 8
> +          maxItems: 8
>
>          interrupt-names:
> -          items:
> -            - const: g_err
> -            - const: g_recc
> -            - const: ch0_err
> -            - const: ch0_rec
> -            - const: ch0_trx
> -            - const: ch1_err
> -            - const: ch1_rec
> -            - const: ch1_trx
> +          minItems: 8
> +          maxItems: 8
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,rcar-gen3-canfd
> +              - renesas,rcar-gen4-canfd
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 2
> +          maxItems: 2
> +
> +        interrupt-names:
> +          minItems: 2
> +          maxItems: 2
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,rzg2l-canfd
> +    then:
> +      properties:
>          resets:
> +          minItems: 2
>            maxItems: 2
>
>          reset-names:
> -          items:
> -            - const: rstp_n
> -            - const: rstc_n
> +          minItems: 2
> +          maxItems: 2
>
>        required:
>          - reset-names
> -    else:
> -      properties:
> -        interrupts:
> -          items:
> -            - description: Channel interrupt
> -            - description: Global interrupt
> -
> -        interrupt-names:
> -          items:
> -            - const: ch_int
> -            - const: g_int
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,rcar-gen3-canfd
> +              - renesas,rcar-gen4-canfd
> +    then:
> +      properties:
>          resets:
>            maxItems: 1

I understand you introduced separate if-blocks for interrupts and
resets because RZ/G3E can reuse only a part of the RZ/G2L rules.
However, at least the rules for R-Car Gen3/4 could be kept together,
reducing the number of lines.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

