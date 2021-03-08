Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D02330B2F
	for <lists+linux-can@lfdr.de>; Mon,  8 Mar 2021 11:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhCHKbg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 Mar 2021 05:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhCHKbV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 Mar 2021 05:31:21 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A80C06174A
        for <linux-can@vger.kernel.org>; Mon,  8 Mar 2021 02:31:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e10so10814735wro.12
        for <linux-can@vger.kernel.org>; Mon, 08 Mar 2021 02:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HeiC0u+oHGk7+j7YzqY/+nK1dESKhewuHI5UlAMFP1M=;
        b=ljEKjnktq8RsuMl4UeLeJyI8GXv7xqRrU5YCaH3a6UFaBcZyOWGGM5GJqKZePSqgLO
         wZaAYFvNtjQdpTskJ8uw7nQ1yuHRXGnVeitavgyGpbgibcNP57ZmxK6JL3vo58gmWIX9
         l1kvccPbbUa9lvY+phC7WklhmxZ4SLVh0O0EA/qcQasg28J/x3YkYwQdRqIud3sBm0G/
         rHMCjNL1e0MxnWWg5q2T3mq6Tfvjc5LB7CvY+k7Wggo+DEw2aZiqA4PDlBfREM/m5kEZ
         uVBzWanAchMmv7sEkUmUmXVkPZHt+8y7rcIfyKKyOx5HyxkKS2Kw5eDr0m45a60PalIp
         xZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HeiC0u+oHGk7+j7YzqY/+nK1dESKhewuHI5UlAMFP1M=;
        b=HUFhXk5f53p/cBa6NyZ65s9bqNUX133PVyZa60uNaHWyCjPBgph2bgyC4wO0zXoaxL
         59bCYfMzsnT8eHwtJxfvyaB6thQ8AFhazbjkCfTauIfegnLrxNjMIqhMC13gglE6w1Pj
         XazuM2v3qLjS2CxaMu1p0YJpW6segjyS/7HAB7uT6+67Czl8tWq9yRGaGTccTPpg7WBm
         6Frf5iC+y8v6zXvvPL/+CYwfdH/ldW/n9xz6qKyXo0d386OkG5KCVikUvKg/eK+7jbSZ
         qtt27OLau2LOML/qGZAmeE0tWSVeqjjjApiiDawYmHWg3QhZ0bI+plrlqaV+w1ExXsdm
         iGqw==
X-Gm-Message-State: AOAM530w/dTjWJXEhJZR5kk8tm+h7hWKyG5YYWjxShoCDvgDJ+BuxyCX
        A6xVweW8lal2iUq4AqqdBdy7pw==
X-Google-Smtp-Source: ABdhPJxZCySMkoWke7056dZIsu0/ycg1pkP3ei/PDqZt+SlN2K7ALmWKu2hxqIUNyKkYJ5fWSZbK8A==
X-Received: by 2002:a5d:6945:: with SMTP id r5mr21632658wrw.367.1615199479582;
        Mon, 08 Mar 2021 02:31:19 -0800 (PST)
Received: from bigthink (92.41.6.207.threembb.co.uk. [92.41.6.207])
        by smtp.gmail.com with ESMTPSA id z3sm17635588wrw.96.2021.03.08.02.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 02:31:19 -0800 (PST)
Date:   Mon, 8 Mar 2021 10:31:17 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Pankaj Sharma <pankj.sharma@samsung.com>
Subject: Re: [PATCH 3/3] can: m_can: fix RX path: use rx-offload to ensure
 skbs are sent from softirq context
Message-ID: <20210308103117.o772ve7gjfrpalaq@bigthink>
References: <20210305172015.1506525-1-torin@maxiluxsystems.com>
 <20210305172015.1506525-4-torin@maxiluxsystems.com>
 <20210305222957.elzieau5s6kbdpus@pengutronix.de>
 <20210308091130.23736cyh7euvwxse@bigthink>
 <59ad45a4-1404-4622-5f75-3ea08aa15287@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59ad45a4-1404-4622-5f75-3ea08aa15287@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Mar 08, 2021 at 10:16:54AM +0100, Marc Kleine-Budde wrote:
> On 3/8/21 10:11 AM, Torin Cooper-Bennun wrote:
> > On Fri, Mar 05, 2021 at 11:29:57PM +0100, Marc Kleine-Budde wrote:
> >> On 05.03.2021 17:20:15, Torin Cooper-Bennun wrote:
> >>> For peripheral devices, m_can sent skbs directly from a threaded irq
> >>> instead of from a softirq context. This patch transitions the driver to
> >>> use the rx-offload helper, ensuring the skbs are sent from the correct
> >>> context, with h/w timestamping to ensure correct ordering.
> >>
> >> I think you beak the non-peripheral drivers here. They already have a
> >> NAPI function m_can_poll(). It makes no sense and doesn't work, if you
> >> do the RX in NAPI and then queue to rx-offload, which then needs to run
> >> from NAPI again. But it cannot as m_can_poll is the NAPI function.
> >>
> >> For peripherals it works, as you do the RX in the threaded IRQ, queue to
> >> rx-offload, which then schedules a NAPI, to push the CAN frames into the
> >> networking stack.
> > 
> > Understood, I will make the skb handling conditional on
> > cdev->is_peripheral and retain netif_receive_skb and can_get_echo_skb
> > usage for non-peripherals as before.
> 
> Not beautify, but should make the tcan driver work at least.

Submitted v2 of patches, hopefully hit a good compromise :)

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

