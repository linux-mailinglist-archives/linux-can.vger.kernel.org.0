Return-Path: <linux-can+bounces-6050-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BCED05D4D
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 20:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3259303FCF1
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 19:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65CF329C74;
	Thu,  8 Jan 2026 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JipJt2W+"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA82D131D
	for <linux-can@vger.kernel.org>; Thu,  8 Jan 2026 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767900349; cv=none; b=Kuf5U8MU2deqbxHhCE2tPEY3tPk2DKgUoo+A3NvuaxkUH9g6XfqXAlHgM2eRhBcVj9QIMvCjnkG5H0D5J8XAsIrMrZHOGTl1NwSxUBaSC2fd0yIw7imuwrGrTjTgOOkSSGHgzhSFGGVnxlg8VXo52zV3mXJGqkIL9TJ2Z3T7bGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767900349; c=relaxed/simple;
	bh=c5gOBQYPVn4tooM6tnnZA9Ows98FMtB9AhqimVB02AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iraoLCl02xsjqhxDRJnUrhtsGM/udJ5GM1+WonxqH86y3xw6Y9ekWkxPFTQ1UExjFZ3HLQ4oeUf9GjFvG75BdoZNM0jIZ9mp3N2bvQt5PfPGuHA7YJSI3Z/y81fX6lj9pVIX7ltMwBMeOUedqtjV2sV7Nka0VGlhe0u87YZ8Cyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JipJt2W+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso29416815e9.3
        for <linux-can@vger.kernel.org>; Thu, 08 Jan 2026 11:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767900345; x=1768505145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+weAIB5F3GzTAUKoqFrSQrQBjxwtKLdBlEZZpcTkEWM=;
        b=JipJt2W+bwoYgr1vjKGWpsACKo7nrVZ0Q7wqB/etwwc7QIGZiOLlHk3ZEAMoJpubSD
         c99FR/0Ma6v57nvAXNRCTVL4IhEE2EfC/N3vVzKTNggFKdltP52GSW/k9QKb6SJ4geXg
         takOUmQipt5K1ntgoELuafzO6D+RFGrt0J5iX7U4rJj0HLMCe4e6Jry7frYW1K9p5b3Q
         b4moM4cksN2tzQwZ7kYFH+WQ26Vrrt54bb/hKXXUF1+yuKoEglfCZx2CaDhqT4r0zRU3
         ZShSF5RMhpT3HhzvJwIHwxN+uAagZTcdAwI1L/d+0D5iQAPLbYmlhY5GkupMY5941p8U
         ge0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767900345; x=1768505145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+weAIB5F3GzTAUKoqFrSQrQBjxwtKLdBlEZZpcTkEWM=;
        b=iE3EWYxvseM6TPEgdj/R6a4hp5RqT/8Nad0DfaoIyHccYmUqfySamh0f2+V9kqalW4
         nHREDnAq2LoMDx+WkdJ5I/ZNdB28t13Zw844TmIXKjuWrtInqkAKsfLQrHnLxwjnNRkj
         lLWUCJUjdtjengPc1JZloP7cLscyBEDC4a0bWyIIWd7WjZhYrt+Sx1pKJX7WLWtHfAbf
         cJNiXsWNOChypJiLKfAkdWBMRfaej7QnGEbS7lGxVtfNVS/KudGswKvN0G5Y6J108YOm
         Z57JKPdk93vX7jeC7SW6cOBqG83jwNO3C1hSGIyMwJE8inBxL1EPkSG4KM5Y84wRH+NK
         HHIA==
X-Forwarded-Encrypted: i=1; AJvYcCUjUiP16dLDpzNYH0Ste5HgxBu8FWUYTKaRFfcm+2LcH0sFgcfM6MX+/rrWrKKlxFoonjKUKgOtkhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuSGboKTMFO0E9jszAAEj1EYmNE6SGtw3su8dfgglZDCs7smla
	hPalPmh4JVPPYijuuk4UvPrPG4a/hN5w48BQFI2nz3qZf9LxqtsjcI1W1vpowW96/id8kCEkr2r
	NEcKOWXXU+EoShTNmt+r3CgiTvPZJ3ls=
X-Gm-Gg: AY/fxX5tbGc/dsOgf+7zJpi68LnTqcGI4SEm3YFbfL1mX83QUjq5yfSsqmkxYni6Kky
	9oLtM6B3NjkOHoDngtONDthGJ//VEoYECUGuYRsP+pkc40K4jo10kON1QVeBZIild9seAU5MVBj
	DqMUmb7P3jo6tLyoA1bdVcsf4Fe87BanNtrBv1J75sYwViCdqll/VFcCqbISAuyK3S++2/luopA
	D8uUjmglifB6jCD86rkXuKf2rNeWA5AFjMM3+mzBKlEyllUfTEMde0MA+YnGgiHP7zJrfCrpIxh
	Gcov8TztxmeRdA/QtEQQAYr1ezIIYQTsKPBhGQ1Uk6PUXsbzrAwaEe3rsdvBrvRoW9aSxT6zmus
	qMEMJZ9Pk8gBOp+3gjnK1CFEV
X-Google-Smtp-Source: AGHT+IG9aCL3VMA1gQDfOUOzIBchboILAW5445ty0XjqfyxP2z1FY0Z6LuXzED9a3fq/fLU4RmJQ5Pzcxb6uHWUplVA=
X-Received: by 2002:a05:600c:1d14:b0:477:7b16:5fb1 with SMTP id
 5b1f17b1804b1-47d84b0a96emr83452675e9.7.1767900344555; Thu, 08 Jan 2026
 11:25:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251230115814.53536-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260102-petite-gentle-wasp-81bbb8@quoll> <CA+V-a8sryz1f_woi_r8jx_4x7TczrWPyjZoo+P9p=tG8KyK8YA@mail.gmail.com>
 <124bc6a4-05ee-4682-a0f8-148896eb3c95@kernel.org>
In-Reply-To: <124bc6a4-05ee-4682-a0f8-148896eb3c95@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 8 Jan 2026 19:25:18 +0000
X-Gm-Features: AQt7F2p5rmW7j0FdoOvEXJ_qBw4U8molRHd1kilHxVpDPpzkzw1Jj1KdICQmQbg
Message-ID: <CA+V-a8tbvJvqnrMaY9UA3tf2CcfcyiRFZLgdy7S411=ZUCcQww@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/T2H and RZ/N2H SoCs
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Wed, Jan 7, 2026 at 8:28=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 06/01/2026 18:26, Lad, Prabhakar wrote:
> > Hi Krzysztof,
> >
> > Thank you for the review.
> >
> > On Fri, Jan 2, 2026 at 11:20=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On Tue, Dec 30, 2025 at 11:58:13AM +0000, Prabhakar wrote:
> >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>
> >>> Document the CAN-FD controller used on the RZ/T2H and RZ/N2H SoCs. Th=
e
> >>> CAN-FD IP is largely compatible with the R-Car Gen4 block, but differ=
s
> >>> in that AFLPN and CFTML are different, there is no reset line for the=
 IP,
> >>> and it only supports two channels.
> >>>
> >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> >>> ---
> >>> v1->v2:
> >>> - No changes made.
> >>> ---
> >>>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 26 +++++++++++++++++=
+-
> >>>  1 file changed, 25 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-c=
anfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.ya=
ml
> >>> index fb709cfd26d7..4a83e9e34d67 100644
> >>> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.ya=
ml
> >>> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.ya=
ml
> >>> @@ -50,6 +50,12 @@ properties:
> >>>                - renesas,r9a09g057-canfd     # RZ/V2H(P)
> >>>            - const: renesas,r9a09g047-canfd
> >>>
> >>> +      - const: renesas,r9a09g077-canfd      # RZ/T2H
> >>
> >>
> >> That's part of other enum with single compatibles.
> >>
> > There is no enum with single compatibles as of in next [0], there is
> > only one compatible `renesas,r9a09g047-canfd`. I can club this with
> > RZ/T2H one.
>
> This is the one which is supposed to be enum.
>
Ok.

> >
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git=
/tree/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml?h=
=3Dnext-20260106
> >
> >>> +
> >>> +      - items:
> >>> +          - const: renesas,r9a09g087-canfd  # RZ/N2H
> >>> +          - const: renesas,r9a09g077-canfd
> >>> +
> >>>    reg:
> >>>      maxItems: 1
> >>>
> >>> @@ -179,7 +185,6 @@ required:
> >>>    - clocks
> >>>    - clock-names
> >>>    - power-domains
> >>> -  - resets
> >>>    - assigned-clocks
> >>>    - assigned-clock-rates
> >>>    - channel0
> >>> @@ -243,11 +248,30 @@ allOf:
> >>>            minItems: 2
> >>>            maxItems: 2
> >>>
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            const: renesas,r9a09g077-canfd
> >>> +    then:
> >>> +      properties:
> >>> +        interrupts:
> >>> +          maxItems: 8
> >>> +
> >>> +        interrupt-names:
> >>> +          maxItems: 8
> >>> +
> >>> +        resets: false
> >>> +    else:
> >>> +      required:
> >>> +        - resets
> >>
> >> Why is this de-synced with reset-names? Properties are supposed to
> >> behave the same way, not once requiring resets other time requiring
> >> reset-names.
> >>
> > There are SoCs that have a single reset and others that require two
> > resets. For SoCs that require two resets, the reset-names property is
> > marked as required, while for SoCs with a single reset it is not.
>
> Sure, but I asked why? We expect (and it is documented already in the
> docs) that xxx-names always follows xxx, so I really do not understand
> why reset-names are valid but resets are not.
>
Sorry for being clear earlier, it's already taken care in patch 1/4
[1] with the below hunk which will restrict RZ/T2H to not allow
reset-names.

+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a09g047-canfd
+              - renesas,rzg2l-canfd
+    then:
+      required:
+        - reset-names
+    else:
+      properties:
+        reset-names: false


[1] https://lore.kernel.org/all/20251230115814.53536-2-prabhakar.mahadev-la=
d.rj@bp.renesas.com/

Cheers,
Prabhakar

