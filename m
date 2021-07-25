Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE493D4CA3
	for <lists+linux-can@lfdr.de>; Sun, 25 Jul 2021 10:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhGYHcW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Jul 2021 03:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhGYHcV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Jul 2021 03:32:21 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74174C061757
        for <linux-can@vger.kernel.org>; Sun, 25 Jul 2021 01:12:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d17so9726102lfv.0
        for <linux-can@vger.kernel.org>; Sun, 25 Jul 2021 01:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tH99Ez9eAiFU1yHfRGwUBaxm4TN4vru/kkAPpoP8a8U=;
        b=MRSpcKQq4PBJM228K+mzWZrk1P/t+THwWmn+TATNtYhy4fY/RSq6Mo0Pj1zjvj8fQv
         UDbT+53SXdF7efWiA81G3h2dvJzJ/7E/KiRxefXVODUVsJI2uvzheW+3+DGZ7gUsXfqq
         WmuWoYeVMjiCw05ZzmvcdUjBr4LCuQ8obgdnkhI5BjFHi3yC45lXrSwPLn3X8jhiZQKa
         l648CNpVswvLXK99wznKguLvD12PjY5wSbqMNt0El3f1saWg+dx34aTKUYihQl4ruX+u
         kaFj98kH7YbBd0PRodX/YVIJlHmHYqvAI0WgeAPMDCXSAwfy2qoVOuZ72h9pvCXXRqlt
         OWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tH99Ez9eAiFU1yHfRGwUBaxm4TN4vru/kkAPpoP8a8U=;
        b=h6s6wT4mbzkzdEyFQG77YxtPLL9t5+OIJVFgONheTQU+m//XIhIj3UiPbUeMuGsIHY
         yTqvV1ffxTC9BxXBNEFkybBS7oxETono22G7Y9NLJ5HJVWtVDCLwSXmxGblqAOMKSQ/n
         tQk44oLHzLZERpO52nZ9ApY0tBxkkzk/PY019Nq0VgdaYG16TQlVoJU+2VmFwpODrMKq
         EEfitEBVspWQvb/0DCLEkVpmhnnKp9bXmpNiWW1cPTOTuW7rPwNtpeCakGQBJttocRlw
         0yIYuTIrv4A58j+PCVvFhAoI51kBs0TO5rPUO+D682HPDAW1NWo8Gb8YiieLfMkSYWlu
         pDCA==
X-Gm-Message-State: AOAM532CeZgTUbV46bDm5Z+uz2q/C5e4VW4Wm3I9Bat5fooKR+74gJR+
        LrV1dm3m29EDsgK4KVKX0I0=
X-Google-Smtp-Source: ABdhPJzir7U+U9B4SAzmu0okfnDHtIiJCZzy2vVaa4G7zOL70d5Yqfai+jxwCxassaG9zfmYJLl/PQ==
X-Received: by 2002:ac2:5b03:: with SMTP id v3mr8831713lfn.188.1627200769737;
        Sun, 25 Jul 2021 01:12:49 -0700 (PDT)
Received: from localhost.localdomain ([94.103.227.213])
        by smtp.gmail.com with ESMTPSA id p21sm2695394lfo.199.2021.07.25.01.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 01:12:49 -0700 (PDT)
Date:   Sun, 25 Jul 2021 11:12:42 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Yasushi SHOJI <yasushi.shoji@gmail.com>
Cc:     linux-can@vger.kernel.org, mkl@pengutronix.de
Subject: Re: [PATCH] can: mcba_usb: fix memory leak in mcba_usb
Message-ID: <20210725111242.2d9a819f@gmail.com>
In-Reply-To: <CAELBRW+6BGDPaUGrTDJtv020zF1AvtBAy2Jb1+i=uDbcH+0SzA@mail.gmail.com>
References: <CAELBRW+6BGDPaUGrTDJtv020zF1AvtBAy2Jb1+i=uDbcH+0SzA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun, 25 Jul 2021 16:42:49 +0900
Yasushi SHOJI <yasushi.shoji@gmail.com> wrote:

> Hi Pavel,
> 

Hi, Yasushi!

> Apologize for the late reply.
> 
> Since 6bd3d80d1f019cef, my Microchip CAN Analyzer stopped working,
> more precisely I can't capture any data with it and repeated messages
> from the driver flod the syslog. I usually use the Debian kernel image
> and linux 5.10.46-2 migrated to unstable on July 20th.  I noticed my
> device stopped working a few days later but didn't have time to
> bisect.
> 
> Does your device work with the patch?
> Does the patch work on the main line?
>

I don't have this device, I just fixed this syzbot bug report:
https://syzkaller.appspot.com/bug?id=c94c1c23e829d5ac97995d51219f0c5a0cd1fa54.

I think, I found the root case. In this patch I saved dma_buff to local
variable and then to array, but forgot to assign it to
urb->transfer_buf. This log

[   33.862175] DMAR: [DMA Write] Request device [00:14.0] PASID ffffffff fault addr 0 [fault reason 05] PTE Write access is not set

points exactly to this problem.


Can You try the following patch?

diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index a45865bd7254..a1a154c08b7f 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -653,6 +653,8 @@ static int mcba_usb_start(struct mcba_priv *priv)
 			break;
 		}
 
+		urb->transfer_dma = buf_dma;
+
 		usb_fill_bulk_urb(urb, priv->udev,
 				  usb_rcvbulkpipe(priv->udev, MCBA_USB_EP_IN),
 				  buf, MCBA_USB_RX_BUFF_SIZE,



I've added Marc to this discussion, I believe, he can help us, since he
is CAN maintainer.


I am sorry for breaking your device :(

> I've posted some report with my hardware configuration at debian
> mailing list: https://bugs.debian.org/990850
> 
> Please let me know if you need any more information.
> 
> Best,
> --
>                yashi





With regards,
Pavel Skripkin


