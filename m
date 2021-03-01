Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6079C328078
	for <lists+linux-can@lfdr.de>; Mon,  1 Mar 2021 15:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbhCAOOz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Mar 2021 09:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbhCAOOt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Mar 2021 09:14:49 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4BFC06178C
        for <linux-can@vger.kernel.org>; Mon,  1 Mar 2021 06:14:09 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l22so4035253wme.1
        for <linux-can@vger.kernel.org>; Mon, 01 Mar 2021 06:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T/Bv6TUwFAxbQNlFxlmz30xGEXRhFQq2TXCX65gXhRg=;
        b=LeJJodEDPZBSv8CYyWHnBR18KTdXzdNaF637Wwk7Xw6nK5rOGnhYvfXyjAp1xvTQfa
         kZWTqmj2spHXbPRvJ3U2LhUlCKoimah2EcG/XATEu4Ac1Q6G/UzSpCF6glfXcrhJ0Z4M
         nNSK+Y494e8uJ8/DWnjtITCDMl5Jr+KdRv1yDVDd1qc/pieAywgzPpn3p4F6/6ySJqic
         Kv95DU33SNq5+TpIIGtepcHag1ggkMbEscJpdybAsn+RDlPScG1pA8iKLs6upPUDMeBD
         RTA0e7wVLKb7WwxdRPcyQAYVr6f/AO3yOAVPnSechwPJ9Jja0tNr5CGnXwC3khM5x8uz
         CyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T/Bv6TUwFAxbQNlFxlmz30xGEXRhFQq2TXCX65gXhRg=;
        b=oGzD2hTYxzezGB/0y9FZt5wpZgHBuhWQPE9TfxrvGxIfLV/+GHx6FWjTmlO1ZsgUch
         F0myCDIoEY6TRhJYZ38bIsi/qx3C7/aZDAAr/AlTo7MWIz0rApNrdT3Q3przvc/NPbvg
         OOVYHCGkcBBTEiksxr/BwHn3jtcXZXD+2i3xp47tJ3wTY0pZKo/k78LAifqM5NMCzwv/
         7xW6ylgrhHOibNZyOB8L+VZDar5KBGtZ0dZtc/LMw/fs9Mn5aUEBmq5G6PHWJlO/AcGp
         GU5v2U2JFCnsLw7h5uSHIb8vU1Bf8foWqV2OPVeWwf6WcKzPpgoFUgG8r3zcSJeGeBJo
         PuYw==
X-Gm-Message-State: AOAM533ok7GllqrTVeJGOCMzPQb9izgtLoWAsFQzmrrAbTjEEoLjihUb
        2LUUdRKpb/kVU/A+7WSqvvJ4nAAiikrssA==
X-Google-Smtp-Source: ABdhPJxGDmO4y05i7VTsmv9o8WFCiVkbi1XZKRcps56fX2sIrNddvOe7DaTEJviOOpao4m9rxYIvIg==
X-Received: by 2002:a05:600c:d1:: with SMTP id u17mr8447827wmm.64.1614608047827;
        Mon, 01 Mar 2021 06:14:07 -0800 (PST)
Received: from bigthink (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id g11sm22760888wmk.32.2021.03.01.06.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:14:07 -0800 (PST)
Date:   Mon, 1 Mar 2021 14:14:06 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Mariusz Madej <mariusz.madej@xtrack.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: m_can: a lot of 'Rx FIFO 0 Message Lost' in dmesg
Message-ID: <20210301141406.bnrqqkbfnq523ofb@bigthink>
References: <PR3PR05MB7212376CDA795770B7E625E6809F9@PR3PR05MB7212.eurprd05.prod.outlook.com>
 <20210226133702.echxlob5z4pj5ptc@bigthink>
 <d0ebed81-3f7a-1e82-e16b-85e242d1ddca@xtrack.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0ebed81-3f7a-1e82-e16b-85e242d1ddca@xtrack.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thank you Mariusz, you've helped me understand this driver better - I
had missed some of the logic. I agree that this is a bug.

On Sat, Feb 27, 2021 at 05:03:14AM +0100, Mariusz Madej wrote:
> I changed m_can_do_rx_poll:
> 
> static int m_can_do_rx_poll(struct net_device *dev, int quota)
> {
>         struct m_can_classdev *cdev = netdev_priv(dev);
>         u32 pkts = 0;
>         u32 rxfs;
> 
>         rxfs = m_can_read(cdev, M_CAN_RXF0S);
>         if (!(rxfs & RXFS_FFL_MASK)) {
>                 netdev_dbg(dev, "no messages in fifo0\n");
>                 return 0;
>         }
> 
>         while ((rxfs & RXFS_FFL_MASK) && (quota > 0)) {
>                 if (rxfs & RXFS_RFL) {
>                         netdev_warn(dev, "Rx FIFO 0 Message Lost\n");
>                         m_can_write(cdev, M_CAN_IR, IR_RF0L);
>                 }
> 
>                 m_can_read_fifo(dev, rxfs);
> 
>                 quota--;
>                 pkts++;
>                 rxfs = m_can_read(cdev, M_CAN_RXF0S);
>         }
> 
>         if (pkts)
>                 can_led_event(dev, CAN_LED_EVENT_RX);
> 
>         return pkts;
> }

Your fix makes sense to me. If you submit a patch to the linux-can list,
it will probably be reviewed quickly. (Don't bother to CC Dan Murphy
though, as his address listed in MAINTAINERS bounces mail.)

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

