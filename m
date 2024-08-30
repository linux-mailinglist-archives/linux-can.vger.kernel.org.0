Return-Path: <linux-can+bounces-1234-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555C7965A81
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 10:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883F81C22024
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 08:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001B416DC23;
	Fri, 30 Aug 2024 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCjjKoNm"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7072D16D31C;
	Fri, 30 Aug 2024 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007030; cv=none; b=KMjgABFECdqD+9n2CE5pL2tJKyN+16qX7FeIMSyzleEVSgJRwRRdT0CISVwqokcsQWZw93J8C+ZDqabqXfodBB+6ZJtUN1V+klvr4zOeT4nPIM1zRy9ZnWmDtTkJrT5equFhNy8J0DZKr38kPljzsUaKEEHS/XVqDFPUPTsxdKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007030; c=relaxed/simple;
	bh=9shBE0H2zwNmx3u97BgFCqYlaYKFOAo34QjRe1zHXUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeFMn/+M0QSXRjlVzTtZ8g/KAhLRCh3kp/lQKkdWmf+sxgpDFrat2cETQ8NYGra8kDU9t4eLwl9j0J57FcLxwpxMrWW/CDPsNf+lcCVMuqaOasB/7O71mRlTbIVcCanqS6RxHupgpaIIQ9iyp8gvOdRp/oAIfS3JvsSB6fXACBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCjjKoNm; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-690ad83d4d7so13478447b3.3;
        Fri, 30 Aug 2024 01:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725007028; x=1725611828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=31d7hZq/3IptMCIezPTJphlV/fOaIPteID4cgke+Fm0=;
        b=aCjjKoNmZFlVfIST8VnKPDclOt2s5aXnFr5TYTOWceAQ3Ni4oJJMKRcTPQ59vy4ir1
         npSn9uEmV6BlQPw9tWIDKfOM7axpFxxkAHVsDdY8+PX8Nqyu5xFp0404cyHUqxvRNhdR
         UNhxPSN2N3cmzGyfX6HKQngtSjLNLty4ByWk/xsKbZnoTR5UAK6cpwCghzqOB/QaS+GP
         +TIh+9QzTRDPAyDWFExmIjSORoz32qOh+HQ+xdKRB/Z7VMxg7sJsFnf5Le3prOGFTmEa
         RrSw6E+7aewBdwKQ236Mpev8TfP2RJL+F3bty97OTPeIQ6OXEyExJmxNxs5MCYuONI7m
         uPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725007028; x=1725611828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31d7hZq/3IptMCIezPTJphlV/fOaIPteID4cgke+Fm0=;
        b=Z1xY8ixN502A/y8tTIh9FvxqhlefFCqqIOoGHFCTqjk5WOPWqjSaW4Ta/sS3A9/NOL
         oBRXAkbS5RDqhRX69hmxSz7VWgSeuKUKnmgRotmEyaFWHn6UAVe/fX0kCtXKc2+htQ1Z
         gUvm3xBfJH3JFunodSMdVQmg/ZQBbCh8mZQVIEn28eiHSEqSpcLV7LyPuh7X4kMoZO6n
         EHjZ98AoYHQnxsB94fewBVRs1wx4iG6eHFUI9wh3l753PPp4AtFy22KUDNVzmtib7TRt
         ZlWr9ciRgVg3OyuAIQhKfvXRfaYmaPn/uxKRctUAqqdbFGXdvDXs6DMohP+3f4hUkYk4
         STdw==
X-Forwarded-Encrypted: i=1; AJvYcCVG1/2aK3VactHt9ndMe6bBfIJ44Tyngx02qCSFPUxoUShnPuXGlfMj0lT8wHpDwLL9kma8kvCHsEm7@vger.kernel.org, AJvYcCVG7nNREcWsXKtZW6kH4lDN5IIT26uVGGW76iEVPX8cSrtazPFV4ZNR+HRLVWFn1IpNaHVuPIo4QtQf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+WeGbPxzVjnqibrzaSVzhqFS91XOkckeHMhcKzMnE6Ntmm4up
	K4H3ADftbuvfmcs3xuD5OP3OYfBwnQADSfPRobn2kBbPrF4ARys89mUzQZi5+LHyVKQrkP+O6kU
	rxTHFrIHPm1mqIw2b1QkrVNy4th6wGmCi
X-Google-Smtp-Source: AGHT+IGv646FbyuGE3nSt1USD81qaCTmkIsKuR1GVErqyBk4BGsOTCdJ41R5AwVCpk1z3YAtl3HfPbWoPoCieHUNZYk=
X-Received: by 2002:a05:690c:10c:b0:6b5:5042:2c9d with SMTP id
 00721157ae682-6d40e77fd6emr11447737b3.24.1725007028363; Fri, 30 Aug 2024
 01:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822105238.213019-1-ilordash02@gmail.com> <20240822105238.213019-2-ilordash02@gmail.com>
 <ZtC6S6I/QKihcsyu@vaman>
In-Reply-To: <ZtC6S6I/QKihcsyu@vaman>
From: Ilya Orazov <ilordash02@gmail.com>
Date: Fri, 30 Aug 2024 11:36:56 +0300
Message-ID: <CAGCz5HmTNtGJHoXmuFhC_43jTObDN+Bxn0rLK3OfH-DBhacomA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6561
To: Vinod Koul <vkoul@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aswath Govindraju <a-govindraju@ti.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 21:13, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 22-08-24, 13:52, Ilya Orazov wrote:
> > Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
> > It is pin-compatible with TI TCAN1042 and has a compatible programming
> > model, therefore use ti,tcan1042 as fallback compatible.
> >
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
> > ---
> >  .../devicetree/bindings/phy/ti,tcan104x-can.yaml    | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > index 79dad3e89aa6..4a8c3829d85d 100644
> > --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > @@ -14,10 +14,15 @@ properties:
> >      pattern: "^can-phy"
> >
> >    compatible:
> > -    enum:
> > -      - nxp,tjr1443
> > -      - ti,tcan1042
> > -      - ti,tcan1043
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - microchip,ata6561
> > +          - const: ti,tcan1042
> > +      - enum:
> > +          - ti,tcan1042
> > +          - ti,tcan1043
> > +          - nxp,tjr1443
>
> No driver/dt for new compatibles?

There is phy-can-transceiver.c driver that can be used also for
ata6561. I used this PHY in my own DTS. It is a popular chip, so I
decided to add ATA6561 to the kernel, as I believe it would be
beneficial.


>
> >
> >    '#phy-cells':
> >      const: 0
> > --
> > 2.34.1
>
> --
> ~Vinod



--
Best regards,
Ilya Orazov

