Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0889A32C5A3
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 02:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbhCDAX5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240990AbhCCNIo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 08:08:44 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0203C06178B
        for <linux-can@vger.kernel.org>; Wed,  3 Mar 2021 05:07:53 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e10so23368741wro.12
        for <linux-can@vger.kernel.org>; Wed, 03 Mar 2021 05:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gT3e+ll57UiNKMckiUfYzGEhCLqAbjuKvFeG+pjUby8=;
        b=eK4xGGiyKLCiFI//fmkOKaxdnFBPvyJBm3lfFnoZd3gHCBZhsjnzimTwoZYbyX7mTz
         jICc04c/Lr4adtDYDHroV+0bkPEmcsmmjjIb0l0HTtP3pqwus0u/QPulgKxJopclWRq9
         573AiszUAH0QXC940jn4KFHEdFQ5o4Q9KBiPTWis7S8Y6uEoMC65CtZ53PwTB3e0d8Ci
         JivRQooLpGJ9XkQfe5o8ehUqAuNkQNFgoUADuBoEOfcD4bnWigNtmIyQF5exBkKpMAbN
         IZLZ9V85YTrI/7WJak0hWpTHKZmSHXjvP1eyGuGq1ra7PM+xXhXSAPHWsOASd8TFBi4q
         InAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gT3e+ll57UiNKMckiUfYzGEhCLqAbjuKvFeG+pjUby8=;
        b=Ct8ps/ul25C5lizfESHTr9nF4s6s7Q0cCNVMneLq88HfeDyWWsL+gSQN4077OoEz95
         07DFN+IamGE5E2HAGXn0r8Nn6+KPI099LN99GQHYoc5RawxUPIVMJmlat/I+7WofS0dM
         gPrdtxlaBB4sCOuS70UJxEHvs15t/kZ+5vMMCXgCWoHYi4eN5tCmyIJx1GfWZwUVkIjp
         COpOf8n7SpcpCpHZP6jBTimwSIOKgPTt2i3LXaEhazFtgKtl2lb84YAbUlCQoALT0vHR
         kPJsz0Tz53gmgBOlWzPmMAfogyTtcIan1wd/U6r3/uK74xT3EQlXzC3KiHwoTwvdj2S9
         Ncng==
X-Gm-Message-State: AOAM533RZOVbqjBa6SIMjgch2TpR8ygt9VMfGKGFHZxkQ6bmPFq1gZ/I
        IUUBd5ZMlD4xHTbUknUw/83Kiw==
X-Google-Smtp-Source: ABdhPJwy4AoNuTElpza13/9UgNsdQSNzz7q3CFFZI+6tkmJRqe4DxJkG/GE4DO5uYniD4Zse9L/G7w==
X-Received: by 2002:a5d:4445:: with SMTP id x5mr25927885wrr.30.1614776872479;
        Wed, 03 Mar 2021 05:07:52 -0800 (PST)
Received: from bigthink (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id w16sm18973710wrk.41.2021.03.03.05.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:07:52 -0800 (PST)
Date:   Wed, 3 Mar 2021 13:07:50 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: m_can: m_can_rx_handler(): fix RX in periphs being
 blocked by error handling
Message-ID: <20210303130750.y2leqimmthzn2liy@bigthink>
References: <20210303124950.3917746-1-torin@maxiluxsystems.com>
 <20210303125523.4tfd6ifwyugoygzh@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303125523.4tfd6ifwyugoygzh@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Mar 03, 2021 at 01:55:23PM +0100, Marc Kleine-Budde wrote:
> > In peripherals, m_can_rx_handler is called with quota = 1 from an ISR
> > context.
> 
> To be precise, it's a threaded Interrupt. Why not call the rx_handler
> with a reasonable quota instead?

I see, thanks. Forgive my ignorance, but how long should a threaded ISR
reasonably block for? Was there ever a good reason for the quota to be 1
here?

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

