Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B5C32C599
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 01:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355377AbhCDAXq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843045AbhCCKYy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 05:24:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B25C08EDBE
        for <linux-can@vger.kernel.org>; Wed,  3 Mar 2021 02:20:18 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 7so23054837wrz.0
        for <linux-can@vger.kernel.org>; Wed, 03 Mar 2021 02:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oJadlViRhHHTP8OkBMDOWwUEXALsISsGUTDXRJKkqoM=;
        b=NHggoNOvzF4CEYx61GeB8kjuJiKcZEysbSfjhkha3kw4b4A4nOGVlsw+e+D5FzGyuG
         ECSxuSphtEY4mQOp3gxppSJQSFulIaNcEvlreJ3hjdDL4gk/9o91onwzEN/Y/A4OF+U6
         U249LcZSYJAyQqPqpJHojMJv4zQLQlpwpvSCoKOCMB5dfuISi3wgHAA1SuPfp/3ub8Md
         aPGDNjD4dXgQAPHqiC+sdUG44mdGeX+/t5jhxdTVooJLGA3edJWZgwdJEulAUO0V7JRA
         h4FDvAJOdLkb3N+h9Zvh9GSYfKztiElDN5MvpC4IP9hg1wPif0ei4ZVSvJVV4x2kIrET
         yEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oJadlViRhHHTP8OkBMDOWwUEXALsISsGUTDXRJKkqoM=;
        b=ZqDGNLzbAhcmNyWR0qVnzrT8a81m80cyHpmFACDlGt28eL5q/Nic0AdBeOG4XEsRJ9
         CoyB0Ko4Q8tbKs3NBo80hYM5GJSlYEB6qCjLRJQb+dWn5aTXztJJYWdVYwhlYrzlEyHs
         WITswya/XTt8Hs4fksxaC9ySwTbU31WqTE1F25ULaqIt5mebx+A2NIzUSpX/ioNHEwcq
         NfpLEgoEahjN93koYS6q9vbw6yLyz+htN9Nf0E/BDCYNrVDX3dSCSHdD6l4pQvg4FsVO
         jUZLSVIRAxbWZpXi2l4GzZqz3+ylIh0uVqVKWVUTxDa5v2V0sBvc2Pd/4qtkPFmWj5nD
         Sn4A==
X-Gm-Message-State: AOAM533zcyY/NPut2ZIfxdUvbX1WpVnr+uYy2tGnX4uAqHobr1G43qGu
        F+OqAWoVw+EwrDhC+4tXX4RW3w==
X-Google-Smtp-Source: ABdhPJzUhP2Ssx7P59Qw3EVkXOKhcrPhqmB9p78vYoyhRdWjrLcBfOc+kXDfULvLp5/EeGvxiFYuGQ==
X-Received: by 2002:a5d:6945:: with SMTP id r5mr26175192wrw.367.1614766817377;
        Wed, 03 Mar 2021 02:20:17 -0800 (PST)
Received: from bigthink (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id v6sm32171984wrx.32.2021.03.03.02.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 02:20:16 -0800 (PST)
Date:   Wed, 3 Mar 2021 10:20:10 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Mariusz Madej <mariusz.madej@xtrack.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] can: m_can: reset IR_RF0L in message reception loop
Message-ID: <20210303102010.gjkvr35n7gc5uf2f@bigthink>
References: <0710fbd2-4b88-21bf-88f7-0b97d7e7dc0b@xtrack.com>
 <20210303080809.zfjh6oolqxcv4pir@bigthink>
 <20210303083136.72bwnozqhzznvanu@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303083136.72bwnozqhzznvanu@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Mar 03, 2021 at 09:31:36AM +0100, Marc Kleine-Budde wrote:
> > Looking at the flow in m_can_rx_handler, it looks as though
> > m_can_handle_bus_errors -> m_can_handle_lost_msg already handles message
> > loss properly, and issues a netdev_err. I wonder whether we can remove
> > the warning from m_can_do_rx_poll entirely:
> > 
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> > index 3752520a7d4b..d783c46cac16 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -501,9 +501,6 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
> >  	}
> >  
> >  	while ((rxfs & RXFS_FFL_MASK) && (quota > 0)) {
> > -		if (rxfs & RXFS_RFL)
> > -			netdev_warn(dev, "Rx FIFO 0 Message Lost\n");
> > -
> >  		m_can_read_fifo(dev, rxfs);
> >  
> >  		quota--;
> > 
> 
> Looks good to me. Can you send a proper patch?

Of course, will do shortly.

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

