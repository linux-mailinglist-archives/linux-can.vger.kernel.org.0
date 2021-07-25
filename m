Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1E13D4D13
	for <lists+linux-can@lfdr.de>; Sun, 25 Jul 2021 12:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhGYJiI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Jul 2021 05:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhGYJiI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Jul 2021 05:38:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C450CC061757
        for <linux-can@vger.kernel.org>; Sun, 25 Jul 2021 03:18:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z2so9949665lft.1
        for <linux-can@vger.kernel.org>; Sun, 25 Jul 2021 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dNncCSgvuua/3a+rQFsr5KCKOyeFRymNB2VRkTmkRXc=;
        b=dL/z9gL6sH3EXdkxLmNyk1isest5F8wXYSLXVuP4Vaq8vfuY1UwSaKfSNFrtSMNbaB
         aizMsQvcq66SG/CqPeYnWFLqbKVoaPBL6pMAUjAp01pY07twS+HJ5vbEfV3avwHv9Ia5
         0qNdXPBPw4fi0IWd8tETTf6kF7mFy78EcyCyJ0+7d6jbVAxnUFc3iByZQq/bswYRNvCm
         dlIQOG/q9GjXM+ieGyMeY5T/XgxXmuqnRCspvehUTzmBpnZLlYa6yqM244hTeu4yTCFI
         Qvmn8hyUqwQAur60K0WZy4RSmwiGpAQ8A6eDrxF/UeAqXTDG3cmI4rPdWW0LTgncmi2b
         UttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dNncCSgvuua/3a+rQFsr5KCKOyeFRymNB2VRkTmkRXc=;
        b=jjPSSoRzChgQSZtdoEaqlHZXK0YUet66Ne95TfmEQ8LiE3b+zyucNTLPGgDt16DjLH
         sKOs3RKtOoT7YxWvgd/MgZTrIKtDJv4T3t4WKKmHw1CG/Um2MvUqM73Ty1f5d39Tpn8T
         PjVwHB60bXkxw4QX5hXGxj/PwmqP37RONso7LaM9qUIerj4VrRscUc1LhjZ2nC3QrAI6
         eCc2rR0XZHTRi8mlWr2Tkq9bUW7ckCw+UCR1dIof4Cxf7FCqjK/IWa9MNVqI5esNivYX
         xw34fT0JVpHZfguwqKfk8ueH9h79C6MLSHCBrcgeVirEd3FYEnIBeP8AC6y3lORVPaji
         4fPQ==
X-Gm-Message-State: AOAM530EOgT9WmBCtdOsIxaaSF2hknkkg9d3kH9Z/MA8HkxlFujq53n8
        6gZa55SjJvl7Me2wRaG/Ij8=
X-Google-Smtp-Source: ABdhPJxdxzAMynMcwjOhaKXu3r7+eZ27ZYBoK5ia9jVjKLRYv94o/bGEyD210U+oERRLNX+hkXFOOA==
X-Received: by 2002:ac2:47eb:: with SMTP id b11mr9531137lfp.544.1627208316123;
        Sun, 25 Jul 2021 03:18:36 -0700 (PDT)
Received: from localhost.localdomain ([2a00:1fa0:81a:8fc0:522:ed96:7da0:a814])
        by smtp.gmail.com with ESMTPSA id n12sm2687525ljq.35.2021.07.25.03.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 03:18:35 -0700 (PDT)
Date:   Sun, 25 Jul 2021 13:18:12 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Yasushi SHOJI <yasushi.shoji@gmail.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcba_usb: fix memory leak in mcba_usb
Message-ID: <20210725131812.7a6f8f4e@gmail.com>
In-Reply-To: <20210725094246.pkdpvl5aaaftur3a@pengutronix.de>
References: <CAELBRW+6BGDPaUGrTDJtv020zF1AvtBAy2Jb1+i=uDbcH+0SzA@mail.gmail.com>
        <20210725111242.2d9a819f@gmail.com>
        <20210725094246.pkdpvl5aaaftur3a@pengutronix.de>
X-Mailer: Claws Mail 3.17.8git77 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun, 25 Jul 2021 11:42:46 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 25.07.2021 11:12:42, Pavel Skripkin wrote:
> > Can You try the following patch?
> 
> Can you create a proper patch with you S-o-b?
> 
Hi, Marc.

Sure! I thought about a bit diffrent fix path like:
diff -> Yasushi's test -> patch with Tested-by tag. I guess, your
approach is more standard, so, I will send pacth as reply to your email.

Thanks!

> > diff --git a/drivers/net/can/usb/mcba_usb.c
> > b/drivers/net/can/usb/mcba_usb.c index a45865bd7254..a1a154c08b7f
> > 100644 --- a/drivers/net/can/usb/mcba_usb.c
> > +++ b/drivers/net/can/usb/mcba_usb.c
> > @@ -653,6 +653,8 @@ static int mcba_usb_start(struct mcba_priv
> > *priv) break;
> >  		}
> >  
> > +		urb->transfer_dma = buf_dma;
> > +
> >  		usb_fill_bulk_urb(urb, priv->udev,
> >  				  usb_rcvbulkpipe(priv->udev,
> > MCBA_USB_EP_IN), buf, MCBA_USB_RX_BUFF_SIZE,
> > 
> > 
> > 
> > I've added Marc to this discussion, I believe, he can help us,
> > since he is CAN maintainer.
> 
> Yasushi, please test and post your Tested-by here. After Pavel posts a
> proper patch and you tested it, I'll forward it to net/master, then it
> will be applied to the stable kernels. Debian can even pick up the
> patch earlier.
> 
> regards,
> Marc
> 



With regards,
Pavel Skripkin
