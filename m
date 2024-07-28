Return-Path: <linux-can+bounces-1024-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AFF93E42F
	for <lists+linux-can@lfdr.de>; Sun, 28 Jul 2024 10:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37B01C20E68
	for <lists+linux-can@lfdr.de>; Sun, 28 Jul 2024 08:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDD912E75;
	Sun, 28 Jul 2024 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKrmcFQx"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BA3182B4;
	Sun, 28 Jul 2024 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722156766; cv=none; b=c0YYEKKe7O2KD7pEZBM0ruuYcOAidXKch+y9jopIlOQL6T6ddwYBjMQ18bYpoE2tzMtDkiuSK7kLNvIYuS4fOt8AcMQoTG1A0MWGFb8J3EEy95YnUriY6hmwThyAKKYJ+j1ir+vB1H72iZoPyF253t7HHJC6Zg9YpOmrD1puXro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722156766; c=relaxed/simple;
	bh=NlU2OuxD9BmWpHF9CFPJ/QLw6zy8dx7RCela9LKcZJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XL8KI+xBVnxbJrVF/B/33l9bjfuoJlnXCK4+oW66uij2vG0dFrzZNxSnYHiSJyma33E0CKKh++5LVPPLtH2cb9umWpqjcO4TJu5gYSl/Hhpq8wICCnDVmuEY0BovS+lqW6PjI/K77qCvTBOzSUfZCqcAE62QLvqSD4F3IKCe818=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKrmcFQx; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-67b709024bfso8767637b3.3;
        Sun, 28 Jul 2024 01:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722156763; x=1722761563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b50kQg9CcOfPljkM2el62+Gp/5HcSGg+41XNn2C/3x4=;
        b=EKrmcFQxwD85npuV8oMNEqGSXAzoKU9AwvsxtRG3RvQi07+780C+C4bwwuGa2iVq+A
         9tbUw//c86izq3hpvXTuksXVHwICqEjg/xEMom2b6eBttuxtWRTEWssuhC4UpT2UhaIR
         ACxXZCtosP3gZ5RRg1ckzpIwRhU+ECO0xlCDH1mR/tsHxnWCq/oiJI90nUFnfgsN9xka
         hAyn4+P15H+p3mmlsapP6obxWYiu/Fo2SK55j8blzxv8LlHfIRku6tdcQjoD2HuFHnVW
         tg8dkUwMtFs9jOIP/R2n7NXZdu+egBlauq8NdAAdBux0yubWtRg1n2KvHT4tjoKu5LdV
         TkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722156763; x=1722761563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b50kQg9CcOfPljkM2el62+Gp/5HcSGg+41XNn2C/3x4=;
        b=JgNyOBi5LH+V384h1cdoFreMzHVk/j6ixKITcv1gczgOUHscH8gzW2u9+UhGxbrNxf
         VMH3cpcfm1WNE7GoTNCPB1ShhKiRUWJNQnywFywtx6h6PZB1o9P11zQjaa//MmfPbqYW
         vHIQKXXkph13tMPe8Z2qiqaVPfCdj/o5betDQTniktZ6tbpAKA/YZmW2Z83JxGB3Wdk4
         aS0FPgXssPJa8xNtR6b3wxsRXF3+O11llJxTStfwPUvT1xaWSUGM8OrMaNGGGDsXwSFc
         1ZOeUHBHL+PxkUISDG1T9RDJSYfLTnUue/baTaT3RghkPcgjFt3BGZR4LDi7MgJS4pdS
         oHkA==
X-Forwarded-Encrypted: i=1; AJvYcCVmtLGZHJxT1+hu6aQosy8ujo/6SiABBhGwatCHom8RO2AQDqrjF/H/6oRAbOwvtuQyCG47Lew+FVDROOKV8PVp1f8AYLf+mIaKgrOc0tiCSbDw+jDd8fstLwVdcXM9qMY3kRV1jg==
X-Gm-Message-State: AOJu0YxDlFjFY4cjLWw4l6iT0bCOsvRX2/wlE2m/uMijJUjxJ+eBd0e8
	dHLA4teURvNGhLod5zOEL7AvWoKmrO0XjSXaS6GeNwrQwuY383eEHmxGOaiP1GIFXDu5xemUyUM
	E0k4QAiXXHn9fGAgNyaYTkSlNHYk=
X-Google-Smtp-Source: AGHT+IFxPxC4Ng6BBPJ48T04Y3ihU8aK+aGafUQKzzm/XI0/Mws3uR/xLo9Uwm/f7iZEJNeBJn29rXvYEXrH93XwLTE=
X-Received: by 2002:a0d:ea0e:0:b0:67a:f3d4:d9d2 with SMTP id
 00721157ae682-67af3d4e244mr38363277b3.39.1722156762788; Sun, 28 Jul 2024
 01:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718210322.37492-1-ilordash02@gmail.com> <20240718210322.37492-2-ilordash02@gmail.com>
 <20240719-ahead-kiwi-995e52bf3e74@spud> <CAGCz5HkF_WNZBVpY2SWVf071Pi896BvKFk0jnfNAYX5AKx2Zcw@mail.gmail.com>
 <20240723-dinginess-john-608d0b28293b@spud> <CAGCz5H=Gncw+Tr0XaQQhhGWQER5Rs1BcxbkPaJwx9jJ-8j7LGQ@mail.gmail.com>
 <20240723-municipal-snowy-136b08b6db90@spud>
In-Reply-To: <20240723-municipal-snowy-136b08b6db90@spud>
From: Ilya Orazov <ilordash02@gmail.com>
Date: Sun, 28 Jul 2024 11:52:31 +0300
Message-ID: <CAGCz5HnJKjNj7A0YD2fw20m-NrEs3MoCLwox86mC11Kudq8xbg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561
To: Conor Dooley <conor@kernel.org>, geert+renesas@glider.be
Cc: mkl@pengutronix.de, mailhol.vincent@wanadoo.fr, vkoul@kernel.org, 
	kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, a-govindraju@ti.com, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for your detailed explanation. I support the decision to use
fallback compatible.

However, I am curious as to why the NXP CAN PHY transceiver was not
included as fallback compatible. Geert, could you please share your
thoughts on this matter?

On Tue, 23 Jul 2024 at 23:14, Conor Dooley <conor@kernel.org> wrote:
>
> On Tue, Jul 23, 2024 at 10:55:17PM +0300, Ilya Orazov wrote:
> > On Tue, 23 Jul 2024 at 21:50, Conor Dooley <conor@kernel.org> wrote:
> > >
> > > On Tue, Jul 23, 2024 at 08:20:04PM +0300, IlorDash wrote:
> > > > On Fri, 19 Jul 2024 at 18:07, Conor Dooley <conor@kernel.org> wrote:
> > > > >
> > > > > On Fri, Jul 19, 2024 at 12:03:21AM +0300, Ilya Orazov wrote:
> > > > > > Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
> > > > > > It is pin-compatible with TI TCAN1042.
> > > > > >
> > > > > > Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > > > > index 79dad3e89aa6..03de361849d2 100644
> > > > > > --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > > > > @@ -18,6 +18,7 @@ properties:
> > > > > >        - nxp,tjr1443
> > > > > >        - ti,tcan1042
> > > > > >        - ti,tcan1043
> > > > > > +      - microchip,ata6561
> > > > >
> > > > > Given that your driver patch has
> > > > > | diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> > > > > | index ee4ce4249698..dbcd99213ba1 100644
> > > > > | --- a/drivers/phy/phy-can-transceiver.c
> > > > > | +++ b/drivers/phy/phy-can-transceiver.c
> > > > > | @@ -89,6 +89,10 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
> > > > > |                 .compatible = "nxp,tjr1443",
> > > > > |                 .data = &tcan1043_drvdata
> > > > > |         },
> > > > > | +       {
> > > > > | +               .compatible = "microchip,ata6561",
> > > > > | +               .data = &tcan1042_drvdata
> > > > > | +       },
> > > > > |         { }
> > > > > |  };
> > > > >
> > > > > the driver patch is actually not needed at all, and you just need to
> > > > > allow ti,tcan1042 as fallback compatible in the binding, so something
> > > > > like:
> > > > >
> > > > >   compatible:
> > > > >     oneOf:
> > > > >       - enum:
> > > > >           - nxp,tjr1443
> > > > >           - ti,tcan1042
> > > > >           - ti,tcan1043
> > > > >       - items:
> > > > >           - const: microchip,ata6561
> > > > >           - const: ti,tcan1042
> > > > >
> > > > >    '#phy-cells':
> > > > >      const: 0
> > > >
> > > > I tested the build with fallback compatible:
> > > >
> > > > compatible:
> > > >   oneOf:
> > > >     - items:
> > > >       - enum:
> > > >         - microchip,ata6561
> > > >       - const: ti,tcan1042
> > > >     - items:
> > > >       - enum:
> > > >         - nxp,tjr1443
> > > >       - const: ti,tcan1043
> > > >
> > > > and modified compatible property in DTS:
> > > >
> > > > compatible = "microchip,ata6561", "ti,tcan1042";
> > > >
> > > > Build succeeded, phy-can-transceiver driver was used. So I would like
> > > > to add a fallback compatible for both "microchip,ata6561" and
> > > > "nxp,tjr1443" in this binding and modify other DTS files with
> > > > compatible = "nxp,tjr1443". What do you think?
> > >
> > > This is wrong on two counts. Firstly, were what you have correct, you
> > > should
> > > squash the two:
> > >      - items:
> > >          - enum:
> > >            - nxp,tjr1443
> > >            - microchip,ata6561
> > >          - const: ti,tcan1042
> > >
> > > However, that does not allow the TI compatibles in isolation, so you
> > > still need to allow that for the actual TI devices, so you need:
> > >
> > >    oneOf:
> > >      - items:
> > >          - enum:
> > >            - microchip,ata6561
> > >            - nxp,tjr1443
> > >            - ti,tcan1043
> > >          - const: ti,tcan1042
> > >      - const: ti,tcan1042
> > >
> > > There's probably some devicetrees that would need to be fixed up. I'm
> > > just not convinced that this is worth retrofitting however.
> >
> > But nxp,tjr1443 is pin compatible with ti,tcan1043, so it should
> > fallback only to ti,tcan1043 and not ti,tcan1042. That's why I decided
> > to split them into different enums.
>
> Ah, sorry I missed that. I misread the match data. Then you need:
>   compatible:
>     oneOf:
>       - items:
>         - enum:
>           - microchip,ata6561
>         - const: ti,tcan1042
>       - items:
>         - enum:
>           - nxp,tjr1443
>         - const: ti,tcan1043
>       - enum:
>           const: ti,tcan1042
>           const: ti,tcan1043
>
> because the TI devices exist and we still need to be able to
> differentiate the TI and NXP devices. If you have
>   compatible = "nxp,tjr1443", "ti,tcan1042";
> that means the device is an nxp,tjr1443. If you have
>   compatible = "ti,tcan1042";
> then that's a tcan1042.
>
> > I made my patch according to a similar one that adds support for
> > nxp,tjr1443. You can find it's conversation on
> > https://lore.kernel.org/all/6ee5e2ce00019bd3f77d6a702b38bab1a45f3bb0.1674037830.git.geert+renesas@glider.be/t/#u.
>
> > I thought we want to hold all PHY chip names in one compatible enum
> > and each in its own of_device_id struct in driver and extend them
> > where appropriate.
>
> Nah, fallbacks are preferred when the programming model is either
> identical or a "compatible superset" of an existing device. New
> of_device_id structs should only be used where we need to account for
> differences in the programming model.
>
> Cheers,
> Conor.



-- 
Best regards,
Ilya Orazov

