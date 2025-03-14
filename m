Return-Path: <linux-can+bounces-3083-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AB6A612E6
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 547D47A4EBB
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 13:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C781FF7DB;
	Fri, 14 Mar 2025 13:40:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237051FECA2;
	Fri, 14 Mar 2025 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959647; cv=none; b=pL3so7OP7cgHU9ZsHYFEP9BL+6ukV3j8usylEHT8XAlrNuMnaOSpVL9Uu8o9yoQ5xAPaQrvKxBbZEa33EU7PdfD9Xmu3OBWAkTd4QE9+GK3FmdI81kGGt3cMYdgdys+j9nDFNj01S7DegNOTGKrg0V3e0mWtZmO7FaPy4uPffZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959647; c=relaxed/simple;
	bh=TmZHcQsdTfziEcqCytv29N3AT6yGkF3DY6qRuzvCfa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wk3AoiuycmSDIQsiOE8MQCn7IbNNq1QCMe7YpR/e9zdx8qABWTce9ZQHLpaA3+H7pqyvPjddOH7+bHB+yzVZEyis8uHjlcx+4wL+B99WnbCr065izvAWqUfdfQ0XylNm+th4/H+kKGnyXoSFK7HGgcmHl1h0lG7Tp7KHFF8YgQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-523efb24fb9so862056e0c.3;
        Fri, 14 Mar 2025 06:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741959642; x=1742564442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9t5Q/HGPBpyfp1O7v6BZAJI+km5Zc76VPzPDCYVhoV8=;
        b=oBPqn9BtAM4avzcvKhie85cJdxasK81galqsXZA8d0424aHOwjKHvWntY2Jde02EIN
         dGFxjfBgA7/yrIPnEooZ9KTQved1Enyyysr+577ppkiYIIy2F/JH0xVrPD5R2H/jOszw
         oM7mTW+zjHSTnd2i7zlnSxWx23I0qz8SQxXiZUtapYMhAF8WlkYiCMVGhzxm7+6P67Wm
         0mhmoQuppERpb3Nru/R5nJUMpEJmvR9B5krd3nsD9UTlqD/yY1IpyhO1tEUPsnH8ikzi
         8sgqYe158IF09oG5lqzHDiuBsymLkR8lmN3apnaL69U/yssT2bcWADmqjoviQAskxACt
         4sFA==
X-Forwarded-Encrypted: i=1; AJvYcCUdVWqdfSv8ytpafaneM7irryiWOoqR3wm9BREWsS0cr9qyzszseQ0yBF3OdN25jmp67sEvXgP1CMcc@vger.kernel.org, AJvYcCUmalv73jkqGtT4kmOeh/Je0hqGrP3RDK/XLB2nrgPAeeexPeQblIVGagOxcH+Ij+oRcjIyoSonoqhu@vger.kernel.org, AJvYcCVJea5OwiU0eVJidjQjIQvRqy6chdfu2mnfi6l27J7b6HauK9vjlNdaPkMVRWf1DRGGe7pwQRhdUIboJ+zgisaaVoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTWpRJKQteonBBVqfOmQbSSieAst+8Du71uzfL3qcecnubM1l2
	KAkKqdmksivGEn3K3s00zh4qpC2TwqgaEsmzotONGsSakvJQmqnkRsg905GQyRY=
X-Gm-Gg: ASbGncub7wgkqRBu0D1HCluUVC/l0gXVFCo8iif+ok8OE6px1ydT9R98AUjcXal2z2I
	tujaomZyHfsA03BG1yftLwFTPRHtYMczTkliym+jiAOxIHtHr0dNj6WrqaxTVcs3RMBWETsYjC5
	O6zt7wTCE7/OTzdUqmi4kiUg7wQ3ccouzs6lEZYKCZJ9VwwoIvwoSSL4HEfwM26PxMsvg7qMb0T
	TSBmYKGtx6nl/OBLh1IAduJxAcilp3O4lVeANNJPKiJ6nSsvFTMwRYV+b0duG/KxTJvgqxpakjM
	hzfGqMqXZFEh/3bKoNe33EQH7fW3niWAfOs5PwjVoF+t4Ioy4MZO+pF9mrqJJiJlE25ZqGr/81X
	XDt1XaM8=
X-Google-Smtp-Source: AGHT+IGIcNRxlajSPp09GwbxCKqqha6datABWauD5Pcru3LfpqmdkdzGXtESf01iFtbhnvlS/299iw==
X-Received: by 2002:a05:6122:430c:b0:50d:a31c:678c with SMTP id 71dfb90a1353d-524498b14c0mr1634164e0c.2.1741959642487;
        Fri, 14 Mar 2025 06:40:42 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a5c9085sm559010e0c.21.2025.03.14.06.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 06:40:41 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86d6976f768so877246241.1;
        Fri, 14 Mar 2025 06:40:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+bARJUV4yGA/Jl1XXd55+IYBt499/1K2UIS4ITyllasl+aLTXl6jNaBepMY07h7JaxfGtKt0nY0zI@vger.kernel.org, AJvYcCXn+tKL/7SkpYnTlPpenyIDpBvbEW4JaSsZhHxCPNiZWIxvcEcScT3pQySvntACo50YZPPUPMbUem70@vger.kernel.org, AJvYcCXyDGyRKDD02Hts4FWAIv9RmxHeKyjvEM/Fc6pYe9Gly6OVCWyEw+21I2GLFoAQHwbNI9AYRYSB59K5RE8PTcl0GSk=@vger.kernel.org
X-Received: by 2002:a05:6102:158b:b0:4bb:c24b:b644 with SMTP id
 ada2fe7eead31-4c3831f640dmr1431713137.20.1741959641212; Fri, 14 Mar 2025
 06:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com> <20250306124256.93033-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250306124256.93033-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Mar 2025 14:40:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWGzSAVBh=TW2Ym-oEg0Q8z1HfMDsRbw6kOf-oUtwYJ3A@mail.gmail.com>
X-Gm-Features: AQ5f1JoujKCCJ6T49mvKkS7GaDG3GMIaQDlFEfhvB4IRK_T16bWwOCOS1q86_wI
Message-ID: <CAMuHMdWGzSAVBh=TW2Ym-oEg0Q8z1HfMDsRbw6kOf-oUtwYJ3A@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3E support
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Simon Horman <horms@kernel.org>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 6 Mar 2025 at 13:43, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Document support for the CAN-FD Interface on the RZ/G3E (R9A09G047) SoC,
> which supports up to six channels.
>
> The CAN-FD module on RZ/G3E is very similar to the one on both R-Car V4H
> and RZ/G2L, but differs in some hardware parameters:
>  * No external clock, but instead has ram clock.
>  * Support up to 6 channels.
>  * 20 interrupts.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

> @@ -173,7 +204,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: renesas,rzg2l-canfd
> +            enum:
> +              - renesas,r9a09g047-canfd
> +              - renesas,rzg2l-canfd

Not having this common rule, and keeping interrupts and resets together
would allow you to keep a clear separation between RZ/G2L and RZ/G3E,
at the expense of only a single line.

>      then:
>        properties:
>          resets:
> @@ -187,6 +220,19 @@ allOf:
>        required:
>          - reset-names
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g047-canfd
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 20
> +
> +        interrupt-names:
> +          minItems: 20
> +
>    - if:
>        properties:
>          compatible:
> @@ -219,6 +265,15 @@ allOf:
>        patternProperties:
>          "^channel[4-7]$": false
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g047-canfd
> +    then:
> +      patternProperties:
> +        "^channel[6-7]$": false
> +
>  unevaluatedProperties: false

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

