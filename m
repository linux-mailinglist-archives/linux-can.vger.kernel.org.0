Return-Path: <linux-can+bounces-995-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2863393A4E1
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2024 19:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB963284139
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2024 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F9F1581E9;
	Tue, 23 Jul 2024 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knafn8at"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F4A14C5A1;
	Tue, 23 Jul 2024 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755218; cv=none; b=oZPvGQkuBWRSM/UuPAATbTLuj/pps+Q5iXTb/3mnIi3iQp9DV/KdKC9F2IU75s45RsZGuv+xMmJ3Lbhep6wIBfJuwox0JxZgJ/HoYS3fytRrh6JpQkko2TJtbKSzFmMbbxtuzXwGcNv/wK/GeftGP7nC0MKxAZZVmq3CmJebs64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755218; c=relaxed/simple;
	bh=s+FbsBLL1jMHQREVmDymAVoIY7/hFnWDNk5fvkWdR6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIRdbw5+3u/Rnsfjw9Y4OFDI3EIivd0hy12z1NDJM9N030gKFKuHNrKZyrbXC/jn4xxqn5nNdig/8OeQvtg3nY/wxYt5BEQCeth8ixgBjGCs9RHm+OmHzof59zPvpAWB7VNuVnYq8B4hVJ0x3NeC+ggY+q41tFdclRScYfa1Nqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knafn8at; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-66c7aeac627so27859937b3.1;
        Tue, 23 Jul 2024 10:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721755215; x=1722360015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XOe0MLUMVLOrVxxv/ePfl9ff0aPXG4+Z35ycnARxiY8=;
        b=knafn8at5vWjCFysx45qN1U/85CKT9teiAP+x1bOJa6ad4kL5MNeHMlq0jebMLQ1Q5
         nj8BkwkcCb6jWBu1GIaSw0xQu/rIlhTSpWcxaNqDQ3mt0SmNubc68UApdBX30+RFo7lh
         dtwF7QBfG0NpujzVng93Z0W4qTRrXJSa2NhE3RQi16i41p5fQ75osiRHOvdo7JnLVwVc
         uFWeeBRxLUSg9cpC1xvqrPoO5IVbL6uTxoKj9LYJ1VkZ+B5ygLP+ld9FvSyNrKDpGblL
         Mjyujl3B/5hcIE70/8BqEpQ1VqlwLV9KpZWka820uUDBhafBh3FJbV7Pf8WeLc9KRoLC
         kwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721755215; x=1722360015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOe0MLUMVLOrVxxv/ePfl9ff0aPXG4+Z35ycnARxiY8=;
        b=MmBf7QMEAzzbkXI7wfrV2WB6weOAVNsveofKxrhKYIXUrYCZ9CtHV4Xn2HNxC90Xe2
         WoVXrKbWfnyuf1MKqz73H8iayLFMWW5TXbAnO7+NSV33xYkbqL7Os1v1bOJMmtAi1Gcd
         vpFH7ym89YdXogQJi2zY8WcVQiJq6fkjfjda1u+ikqRlzpuKr7SqSf2OZhtSMtuR66DU
         mvgtxDJvfIyx7bZhstgEElKCikvsLUPUHpgTRzuaRS2ue2h9RZXPrYe5suAD/UfdMog3
         wV6uCrSheqC5lSOFvkCQTA/qqjwvS51hNumu0lWrfO2LZRwVxVOvqpAFuMjnoMJrD+Wd
         nNqA==
X-Forwarded-Encrypted: i=1; AJvYcCVTKQVgOK+qbTjEEUI4eY37zb3tGX2t7yiiJdNJvDxaHaJskc8UDJtKEWGeq4bCYeobtR0NDoUqPMb4/EqG3VsscGB81AsksXSlNMkrHHFcHxkGqjDNJjuDvz3PAtakvBxMPDdewg==
X-Gm-Message-State: AOJu0YwAsMPCT589xAByC0mbVclDHEaUasFGrl3/1JDKn/efG2p9G8oe
	CMU8xMNpbbNBSYG7K6XAg72HmoPDnVATyl1hc+Fn1BYQ9U2NTNaQf0iOdsezJPFrrjS5Odf122K
	hObRNlI66nPohy4vUHtRYk2akQdI=
X-Google-Smtp-Source: AGHT+IFcHozHZx+cILlSEO6Gl2LmXfljpvHEyEVdBwuFcMIZtVfKaO43sgcYRG67ZYw8sJ27fCMFQ9KO8R/WVwG8mzo=
X-Received: by 2002:a05:690c:10d:b0:64b:7e17:b339 with SMTP id
 00721157ae682-66a68b87fe5mr136874317b3.15.1721755215500; Tue, 23 Jul 2024
 10:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718210322.37492-1-ilordash02@gmail.com> <20240718210322.37492-2-ilordash02@gmail.com>
 <20240719-ahead-kiwi-995e52bf3e74@spud>
In-Reply-To: <20240719-ahead-kiwi-995e52bf3e74@spud>
From: IlorDash <ilordash02@gmail.com>
Date: Tue, 23 Jul 2024 20:20:04 +0300
Message-ID: <CAGCz5HkF_WNZBVpY2SWVf071Pi896BvKFk0jnfNAYX5AKx2Zcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561
To: Conor Dooley <conor@kernel.org>, geert+renesas@glider.be
Cc: mkl@pengutronix.de, mailhol.vincent@wanadoo.fr, vkoul@kernel.org, 
	kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, a-govindraju@ti.com, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jul 2024 at 18:07, Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Jul 19, 2024 at 12:03:21AM +0300, Ilya Orazov wrote:
> > Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
> > It is pin-compatible with TI TCAN1042.
> >
> > Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > index 79dad3e89aa6..03de361849d2 100644
> > --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > @@ -18,6 +18,7 @@ properties:
> >        - nxp,tjr1443
> >        - ti,tcan1042
> >        - ti,tcan1043
> > +      - microchip,ata6561
>
> Given that your driver patch has
> | diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> | index ee4ce4249698..dbcd99213ba1 100644
> | --- a/drivers/phy/phy-can-transceiver.c
> | +++ b/drivers/phy/phy-can-transceiver.c
> | @@ -89,6 +89,10 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
> |                 .compatible = "nxp,tjr1443",
> |                 .data = &tcan1043_drvdata
> |         },
> | +       {
> | +               .compatible = "microchip,ata6561",
> | +               .data = &tcan1042_drvdata
> | +       },
> |         { }
> |  };
>
> the driver patch is actually not needed at all, and you just need to
> allow ti,tcan1042 as fallback compatible in the binding, so something
> like:
>
>   compatible:
>     oneOf:
>       - enum:
>           - nxp,tjr1443
>           - ti,tcan1042
>           - ti,tcan1043
>       - items:
>           - const: microchip,ata6561
>           - const: ti,tcan1042
>
>    '#phy-cells':
>      const: 0
>
> Cheers,
> Conor.
>
> >
> >    '#phy-cells':
> >      const: 0
> > --
> > 2.34.1
> >
> >

I tested the build with fallback compatible:

compatible:
  oneOf:
    - items:
      - enum:
        - microchip,ata6561
      - const: ti,tcan1042
    - items:
      - enum:
        - nxp,tjr1443
      - const: ti,tcan1043

and modified compatible property in DTS:

compatible = "microchip,ata6561", "ti,tcan1042";

Build succeeded, phy-can-transceiver driver was used. So I would like
to add a fallback compatible for both "microchip,ata6561" and
"nxp,tjr1443" in this binding and modify other DTS files with
compatible = "nxp,tjr1443". What do you think?

-- 
Best regards,
Ilya Orazov

