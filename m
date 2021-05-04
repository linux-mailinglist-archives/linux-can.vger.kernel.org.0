Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCC1372A50
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 14:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhEDMtk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 08:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhEDMtk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 08:49:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7092FC061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 05:48:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h4so9244039wrt.12
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 05:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=R4dszX90OyJmbK90GMk8ueJ6efAQzYB3mx+np55J/Lc=;
        b=g6aFn8bAGDqVJ7SP2EXRV9bKrp9iHuPlNdHVu0EKKm88X58xtksd/3D+YAbXfNl3hx
         8PE1xJ8Cj2LtYRWCTVmkW1Wju9dZht8Ds607Jei1x53ZWh9PbQcleKhjelxQ664jqwrX
         Sv05I/7nXwnpt8d92/+5tDdZr9Yh9eKd3T00glQJoayFnHdcq+bUrdWajWP8FYKBpegu
         c+FLFkxfQ5w2TGlrugj8QeN61NsmnrZvYw52UC+KrncVOG6IkunOx/TVKOmzFyXGzvuB
         zeUHdVPnipE6Zli7XC4aypFJsVvexfsGUfIJZczerefuo5odQH1VESlV7T8pdCaOkpE/
         lvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R4dszX90OyJmbK90GMk8ueJ6efAQzYB3mx+np55J/Lc=;
        b=T4XxHiRoeNOXUcXO2QJOiOUsF6IHNg5UOuOyt5UB9sbjD2LgUIP8TkeTXjmYAelj20
         7gWMmy901DPRfcx8vbTh7lmXC1fqw2AHDCUTDuuwJHBfqViaSkHNuWq7tRiaH8Gs19TJ
         Pg4D4fFAR7py7fwRZ11OWrm95WvteedQTg57flu5aL7N982lno7B9Q3ztoEIiHpMMx7n
         R+vDZuihpVqB6aFYSM7TsvbCqJuSPQyQo9OEZz6LnGR6l/NQYOILIj4j5kukFQx3QEb8
         r9T7wQX98DPNeCWSGNLSVXx6gKNjrmua7FVOz6QBWxa7Eptqlkj3MXR8WydTrufAFNR0
         /Qvw==
X-Gm-Message-State: AOAM533uQJ+zXYMCrrIuIXKMNB50NrzzK95qzgaY5p/7MyLLZje1oK13
        HofuTmTbOH6doll+H3azF7srcVlVfMFB+/L2
X-Google-Smtp-Source: ABdhPJwl/V/MBFxc7ydGtgOw48TCtqQPS9cfpBxoao4JL0rFO1861OjdLY/PW6pxY3EHawg7ufnsvg==
X-Received: by 2002:adf:d0cd:: with SMTP id z13mr16689689wrh.373.1620132523998;
        Tue, 04 May 2021 05:48:43 -0700 (PDT)
Received: from bigthink (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id p17sm15773876wru.1.2021.05.04.05.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 05:48:43 -0700 (PDT)
Date:   Tue, 4 May 2021 13:48:41 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [REPOST PATCH 0/4] can: m_can: various regmask-related cleanup
Message-ID: <20210504124841.rcdy5lmls3y6hubw@bigthink>
References: <20210504114900.351170-1-torin@maxiluxsystems.com>
 <20210504115433.nz3q4fbr62hecnmj@pengutronix.de>
 <20210504115847.b3t6zbgxxd5gntct@bigthink>
 <20210504122017.suk5coyk6nmc54y7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210504122017.suk5coyk6nmc54y7@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, May 04, 2021 at 02:20:17PM +0200, Marc Kleine-Budde wrote:
> Hmmm...not here:
> 
> | ➜ (pts/13) frogger@hardanger:socketcan/linux (next✗) git lg -1                                                                        
> | 644022b1de9e (HEAD -> next) can: m_can: m_can_receive_skb(): add missing error handling to can_rx_offload_queue_sorted() call
> | 
> | ➜ (pts/13) frogger@hardanger:socketcan/linux (next) git am -s --reject ./20210504_torin_can_m_can_various_regmask_related_cleanup.mbx
> | Applying: can: m_can: use bits.h macros for all regmasks
> | Checking patch drivers/net/can/m_can/m_can.c...
> | error: while searching for:
> | 
> |                 net->stats.tx_errors++;
> |                 if (cdev->version > 30)
> |                         putidx = ((m_can_read(cdev, M_CAN_TXFQS) &
> |                                    TXFQS_TFQPI_MASK) >> TXFQS_TFQPI_SHIFT);
> | 
> |                 can_free_echo_skb(cdev->net, putidx);
> |                 cdev->tx_skb = NULL;
> | 

Yup, found my mistake, my tree is not consistent with can-next. Let me
submit a v2. They'll be based directly on can-next/testing.

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

