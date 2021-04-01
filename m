Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597BD3520A8
	for <lists+linux-can@lfdr.de>; Thu,  1 Apr 2021 22:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbhDAUhL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Apr 2021 16:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbhDAUhK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Apr 2021 16:37:10 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AB8C061788
        for <linux-can@vger.kernel.org>; Thu,  1 Apr 2021 13:37:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so5248925pjb.1
        for <linux-can@vger.kernel.org>; Thu, 01 Apr 2021 13:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=llbyPDMOLcpAdaBWgDvLePb1dxVV1/uSd2CRxF+s2EA=;
        b=G7Bo/0SA4R/Kd/GmM2tqrQdjYoJTM4UEY9Rm4wyH6fDYyekY/OczW+2jUiMgQYyg+C
         aLI3riIh8z6YGWNCF9DNMQn1gRS2+uSXSqYLDwE3pqgVcWEMAnN73G4aROIrCiovr0/z
         yEtu9zBx5EWqK48cbSx5fbFiVy/n+E9v/pRv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=llbyPDMOLcpAdaBWgDvLePb1dxVV1/uSd2CRxF+s2EA=;
        b=gH4vnK4dHocGrJ/yrE8cTMIQP31W2GVzfnX8EKx7ezaY34qntZvV3xr8zyuUQNTWLN
         Jiv1YopJ9p+ebxgSueLVHISd+7fpA3dyuAilklrk0Du7qTA4xYLHbZ21jdEGDAi5AB0t
         rx1UTjZr5MMdqA3dor9lhMMNwtORQ0yRsKzeYd6H4heRH+4aTg1emQVW23WzVemXx8Va
         FS0T929xP35mIBVemJWsEWz1xEEa3++G6Z5SBt7kMVV/uECej9VZMZdhYXUlo4mk+UBi
         UIlNPOLTLUS16aUA/2arRrGIhRDWqLnP7cwqjp/jnaifgFIkw3hid/vqLAKbf+rRjN9d
         k1sw==
X-Gm-Message-State: AOAM53024Rd0GyHvRZqgj/qKWAtKoHj6tM0WLt0b3am2S6PJ1lV8ZSMo
        NThaZnQEWbUUYRxf2giKWK+6Fg==
X-Google-Smtp-Source: ABdhPJweHyppnS+IAqA6l9+HfqC1tQJ9H9zvBhTN71+eHinNnkFYt7jCRHsTmg6SQvtLPmPg63RDZg==
X-Received: by 2002:a17:902:9a0c:b029:e5:fedb:92c6 with SMTP id v12-20020a1709029a0cb02900e5fedb92c6mr9550415plp.59.1617309429103;
        Thu, 01 Apr 2021 13:37:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u4sm5654113pfk.131.2021.04.01.13.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 13:37:08 -0700 (PDT)
Date:   Thu, 1 Apr 2021 13:37:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Subject: Re: Coverity: mcp251xfd_dump_rx_ring(): Memory - illegal accesses
Message-ID: <202104011336.56774C6480@keescook>
References: <202103311459.93EB7DEBDC@keescook>
 <20210401074904.ucgl4pictqaw6gew@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401074904.ucgl4pictqaw6gew@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Apr 01, 2021 at 09:49:04AM +0200, Marc Kleine-Budde wrote:
> On 31.03.2021 14:59:44, coverity-bot wrote:
> > This is an experimental semi-automated report about issues detected by
> > Coverity from a scan of next-20210331 as part of the linux-next scan project:
> > https://scan.coverity.com/projects/linux-next-weekly-scan
> > 
> > You're getting this email because you were associated with the identified
> > lines of code (noted below) that were touched by commits:
> > 
> >   None
> >     e0ab3dd5f98f ("can: mcp251xfd: add dev coredump support")
> > 
> > Coverity reported the following:
> > 
> > *** CID 1503585:  Memory - illegal accesses  (OVERRUN)
> > /drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c: 190 in mcp251xfd_dump_rx_ring()
> > 184     static void mcp251xfd_dump_rx_ring(const struct mcp251xfd_priv *priv,
> > 185     				   struct mcp251xfd_dump_iter *iter)
> > 186     {
> > 187     	struct mcp251xfd_rx_ring *rx_ring;
> > 188     	unsigned int i;
> > 189
> > vvv     CID 1503585:  Memory - illegal accesses  (OVERRUN)
> > vvv     Overrunning array of 1 8-byte elements at element index 1 (byte offset 15) by dereferencing pointer "priv->rx + i".
> > 190     	mcp251xfd_for_each_rx_ring(priv, rx_ring, i)
> > 191     		mcp251xfd_dump_rx_ring_one(priv, iter, rx_ring);
> 
> mcp251xfd_for_each_rx_ring is a macro that iterates over all RX rings in
> the struct mcp251xfd_priv. It's not pretty (as it uses its arguments
> more than once), but it works:

Ah yes; thanks! This is another "for each" macro that that confuses
Coverity. I'll try to silence these...

Thanks for the details and taking a look at it!

-Kees

> 
> | #define mcp251xfd_for_each_rx_ring(priv, ring, n) \
> | 	for ((n) = 0, (ring) = *((priv)->rx + (n)); \
> | 	     (n) < (priv)->rx_ring_num; \
> | 	     (n)++, (ring) = *((priv)->rx + (n)))
> 
> For now there is only one rx ring...
> 
> | struct mcp251xfd_priv {
> |       [...]
> | 	struct mcp251xfd_rx_ring *rx[1];
> | 	u8 rx_ring_num;
> |       [...]
> | }
> 
> ...and rx_ring_num is initialized as "1".
> 
> | 	for (i = 0;
> | 	     i < ARRAY_SIZE(priv->rx) && ram_free >= rx_obj_size;
> | 	     i++) {
> |               [...]
> | 	}
> | 	priv->rx_ring_num = i;
> 
> 
> > 192     }
> > 193
> > 194     static void mcp251xfd_dump_tx_ring(const struct mcp251xfd_priv *priv,
> > 195     				   struct mcp251xfd_dump_iter *iter)
> > 
> > If this is a false positive, please let us know so we can mark it as
> > such, or teach the Coverity rules to be smarter. If not, please make
> > sure fixes get into linux-next. :) For patches fixing this, please
> > include these lines (but double-check the "Fixes" first):
> 
> This looks indeed like a false positive to me.
> 
> > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > Addresses-Coverity-ID: 1503585 ("Memory - illegal accesses")
> > Fixes: e0ab3dd5f98f ("can: mcp251xfd: add dev coredump support")
> 
> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |



-- 
Kees Cook
