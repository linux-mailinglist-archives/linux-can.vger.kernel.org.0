Return-Path: <linux-can+bounces-998-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254AE93A7D6
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2024 21:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CC91F231AE
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2024 19:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883821419A9;
	Tue, 23 Jul 2024 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxT6fMS0"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDCC13D62B;
	Tue, 23 Jul 2024 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764531; cv=none; b=oqWyKkxK4IyiUAQVzx+qxawUHSEYwcoryt5Ek76ZtXbPK2NFUeGXQMicC9tb6jk3RpbwAkgMnMk2pIzKAqmLFvY9ofexzJKj/AtPF/5nMZhJX1bKHC+qkDnvsISrwk/KD3YYyr3v7cw94ASYmsTuTM5iZ0gkRGud20oyb3LvUuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764531; c=relaxed/simple;
	bh=QXrSGb32IAkRFiwh0qFRLKbFsw45qMUC7GOfMNbEyJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSow/9uE3gTH0SL6Inwi0vDQB29CBGR8RBJHTs7n6gLWrqmnX8ewAIGTNEdxFWnGHjuGbr2q9e6ajZ9io034JSp3tKgjnUzY/9eDeR5j9+ckuBGL4u3Irgw/Z0p2s5t1T9mf65SVVucJk/EJrPxNiYb6ERfCPEbwyugAyCi9+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxT6fMS0; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6659e81bc68so61123287b3.0;
        Tue, 23 Jul 2024 12:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721764529; x=1722369329; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=etaAck1fX9Dd1SjvfDtSdQJAv2GP2QxAbK5wmmmFTuQ=;
        b=QxT6fMS0Pz9t0wmMbbEYO0roDm5iJdIfcWZmWzIyCJIo7xodniR4ZnfuVHMWU29FoS
         xD7cpJ4bQ73Z/qcbOLM5bMQkWtla3oEdGRTT0oTLv9sJwAEFcgo3NPTU+gubE6AdKnia
         MCZFy1NkZ86Zwy9Crojh6wCt59JNs1q+2otVwvi7a5nNJuvjgk8sV8HwULLEaDy7uwJB
         Fb/YRw+QmeNEOULUswMsfJKfHSpaSdPt88fIky5PGccP2V10Kb8Mdw1IYglFYQGHoC66
         3gnrkx4xfbUpPbjnDJVw5SJ0QhbCUo2fhLhN+r9meDJuK9S4EDlpmYi0xrJpIZ545Wgi
         gThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721764529; x=1722369329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etaAck1fX9Dd1SjvfDtSdQJAv2GP2QxAbK5wmmmFTuQ=;
        b=ATl2XslT+40im+mY0x15G70bJYM6NtZ3ui5G2+qfmh3Z8REJmn2x6W8LLBq59JnB1f
         d3SdYdzaI4A4PGJ8k8RUWcB/pnqLlNe4jsdpnIAN49IuJYppbX87p2yBtgoCH9iSfxk0
         avDdJlnwA8RU035gdxHwQmPHpk0drEFAcVnM4DQmeAprnlgI+ffHLz94BdnBTq0PkmTE
         dqjKopTGBcPR9O/OsJS9xQdMM1l7Q/nFzZPVxiO3OICVUlebgh0ZGIBXGU7iaZrFlvTE
         Jd49yxLHq5fcu7/ZAmDAp+EF4zV78fnvtPOHPCqBDvVLXzRHxAkNNEmzfm+OvCI4/8+O
         tvjg==
X-Forwarded-Encrypted: i=1; AJvYcCUWsPrmZKtJI0Ti8RvlBDKm1ZGDDAyuY0w0vivZslDyDiHp1vsmpX9og9HcSwCkT7Lmv2GpMS09/7Jurq4DlcuV8qAcPn7inXcwnIiJ7Zqfr7RZ00hyHWLE/Ax3Js6t7t8uQbzxcw==
X-Gm-Message-State: AOJu0YymL5KXljHqBl0mCRcFMZ5/6+O9az1NetdaBtiQtt/RQgWNL+TL
	IVELu/JntErc1qOROTXxVaRRGQ1WBsC5yvIiotpgiquey7DlIfnoevZ8T2DBMrWy0T346E8hR+E
	U1TbEgo8i2HuS9ekvpygWU0kwT2y2SUj+WjU=
X-Google-Smtp-Source: AGHT+IFXvl3OlgZ1GZmz0h0FPNpsPWMbHtygJfT9wCAu2tZOOz5UEQgu6RPgr0wwBKIqLTB+vdVKhSAS7wRFrH0i9mA=
X-Received: by 2002:a05:690c:4505:b0:649:4256:9d49 with SMTP id
 00721157ae682-6727e151e2amr13147b3.42.1721764528911; Tue, 23 Jul 2024
 12:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718210322.37492-1-ilordash02@gmail.com> <20240718210322.37492-2-ilordash02@gmail.com>
 <20240719-ahead-kiwi-995e52bf3e74@spud> <CAGCz5HkF_WNZBVpY2SWVf071Pi896BvKFk0jnfNAYX5AKx2Zcw@mail.gmail.com>
 <20240723-dinginess-john-608d0b28293b@spud>
In-Reply-To: <20240723-dinginess-john-608d0b28293b@spud>
From: Ilya Orazov <ilordash02@gmail.com>
Date: Tue, 23 Jul 2024 22:55:17 +0300
Message-ID: <CAGCz5H=Gncw+Tr0XaQQhhGWQER5Rs1BcxbkPaJwx9jJ-8j7LGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561
To: Conor Dooley <conor@kernel.org>
Cc: geert+renesas@glider.be, mkl@pengutronix.de, mailhol.vincent@wanadoo.fr, 
	vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	a-govindraju@ti.com, linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 21:50, Conor Dooley <conor@kernel.org> wrote:
>
> On Tue, Jul 23, 2024 at 08:20:04PM +0300, IlorDash wrote:
> > On Fri, 19 Jul 2024 at 18:07, Conor Dooley <conor@kernel.org> wrote:
> > >
> > > On Fri, Jul 19, 2024 at 12:03:21AM +0300, Ilya Orazov wrote:
> > > > Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
> > > > It is pin-compatible with TI TCAN1042.
> > > >
> > > > Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > > index 79dad3e89aa6..03de361849d2 100644
> > > > --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > > +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > > > @@ -18,6 +18,7 @@ properties:
> > > >        - nxp,tjr1443
> > > >        - ti,tcan1042
> > > >        - ti,tcan1043
> > > > +      - microchip,ata6561
> > >
> > > Given that your driver patch has
> > > | diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> > > | index ee4ce4249698..dbcd99213ba1 100644
> > > | --- a/drivers/phy/phy-can-transceiver.c
> > > | +++ b/drivers/phy/phy-can-transceiver.c
> > > | @@ -89,6 +89,10 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
> > > |                 .compatible = "nxp,tjr1443",
> > > |                 .data = &tcan1043_drvdata
> > > |         },
> > > | +       {
> > > | +               .compatible = "microchip,ata6561",
> > > | +               .data = &tcan1042_drvdata
> > > | +       },
> > > |         { }
> > > |  };
> > >
> > > the driver patch is actually not needed at all, and you just need to
> > > allow ti,tcan1042 as fallback compatible in the binding, so something
> > > like:
> > >
> > >   compatible:
> > >     oneOf:
> > >       - enum:
> > >           - nxp,tjr1443
> > >           - ti,tcan1042
> > >           - ti,tcan1043
> > >       - items:
> > >           - const: microchip,ata6561
> > >           - const: ti,tcan1042
> > >
> > >    '#phy-cells':
> > >      const: 0
> >
> > I tested the build with fallback compatible:
> >
> > compatible:
> >   oneOf:
> >     - items:
> >       - enum:
> >         - microchip,ata6561
> >       - const: ti,tcan1042
> >     - items:
> >       - enum:
> >         - nxp,tjr1443
> >       - const: ti,tcan1043
> >
> > and modified compatible property in DTS:
> >
> > compatible = "microchip,ata6561", "ti,tcan1042";
> >
> > Build succeeded, phy-can-transceiver driver was used. So I would like
> > to add a fallback compatible for both "microchip,ata6561" and
> > "nxp,tjr1443" in this binding and modify other DTS files with
> > compatible = "nxp,tjr1443". What do you think?
>
> This is wrong on two counts. Firstly, were what you have correct, you
> should
> squash the two:
>      - items:
>          - enum:
>            - nxp,tjr1443
>            - microchip,ata6561
>          - const: ti,tcan1042
>
> However, that does not allow the TI compatibles in isolation, so you
> still need to allow that for the actual TI devices, so you need:
>
>    oneOf:
>      - items:
>          - enum:
>            - microchip,ata6561
>            - nxp,tjr1443
>            - ti,tcan1043
>          - const: ti,tcan1042
>      - const: ti,tcan1042
>
> There's probably some devicetrees that would need to be fixed up. I'm
> just not convinced that this is worth retrofitting however.

But nxp,tjr1443 is pin compatible with ti,tcan1043, so it should
fallback only to ti,tcan1043 and not ti,tcan1042. That's why I decided
to split them into different enums.

I made my patch according to a similar one that adds support for
nxp,tjr1443. You can find it's conversation on
https://lore.kernel.org/all/6ee5e2ce00019bd3f77d6a702b38bab1a45f3bb0.1674037830.git.geert+renesas@glider.be/t/#u.
I thought we want to hold all PHY chip names in one compatible enum
and each in its own of_device_id struct in driver and extend them
where appropriate.

-- 
Best regards,
Ilya Orazov

