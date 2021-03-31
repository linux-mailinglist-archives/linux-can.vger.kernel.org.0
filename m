Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0423510D0
	for <lists+linux-can@lfdr.de>; Thu,  1 Apr 2021 10:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhDAIZe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Apr 2021 04:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhDAIZ1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Apr 2021 04:25:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57E7C0613E6
        for <linux-can@vger.kernel.org>; Thu,  1 Apr 2021 01:25:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lRsdp-0005iA-Dx
        for linux-can@vger.kernel.org; Thu, 01 Apr 2021 10:25:25 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:3432:3a72:abbc:cd9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9CBD66058B1
        for <linux-can@vger.kernel.org>; Thu,  1 Apr 2021 08:25:24 +0000 (UTC)
Received: from bjornoya.blackshift.org
        by bjornoya with LMTP
        id aP1+DObwZGAlLAAAs6a69A
        (envelope-from <keescook@chromium.org>)
        for <mkl-all@blackshift.org>; Wed, 31 Mar 2021 22:00:06 +0000
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 25C6C60539C
        for <mkl-all@blackshift.org>; Wed, 31 Mar 2021 22:00:06 +0000 (UTC)
Received: from metis.ext.pengutronix.de (unknown [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 0D40660539B
        for <ptx@kleine-budde.de>; Wed, 31 Mar 2021 22:00:06 +0000 (UTC)
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <keescook@chromium.org>)
        id 1lRisd-0000EJ-ED
        for mkl@pengutronix.de; Thu, 01 Apr 2021 00:00:04 +0200
Received: by mail-pl1-x631.google.com with SMTP id w11so8620430ply.6
        for <mkl@pengutronix.de>; Wed, 31 Mar 2021 15:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=N4kurWnRUYXmR7z3KJBvyrU6Pp/Hk6bRXMnVv4qhpUw=;
        b=UysDK0tFln0ROMFobMSknIiOBcjN2FLMe1B5kPNlHcEJ4pLaoSNernczPzgy5Hy3oe
         /PSdtkEkNThR7t2At8UL0rasJyr8rkd/B0cCIWX/kOB5Ds6bQpQD97vfzxY5iM3DKfcK
         B6iYWAMPVx1skNQZQ3LRdc/wzUHra7q54y1Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=N4kurWnRUYXmR7z3KJBvyrU6Pp/Hk6bRXMnVv4qhpUw=;
        b=MLSAFWdkeW8paUvfeakYysfKreiwAVIBGU3N4Jl3eLt4h62oFkkgjk+8LKqyQiApHg
         soMJ7Qd4L5AqMXLH3KHzZYJfEfRNZfFvudg63B2Zy4dm07r3MB5QDNO2+t9XhU+uYB0k
         tRXVkbcGFYkto3X/7Bj7rNZs5NoOagwYwyWXQPi3G6OafMR5LWjFqAptRloBcZMuDAfe
         3DU9aT8ebNUJ4v4PQuBiKFPAjruNOywxGVCjr5v1K9NORAteA+2u5oEddiUZI+8CaA6O
         itZwx1uPuL1hKnrfeVPmsKlqRGTIZuc2R6oVlvhN1vHae+vxgUsCLWx1cjGMD7KBZkbj
         BI3A==
X-Gm-Message-State: AOAM5322VhTHC6p7uNV+zG3VJ36PJ5YZCKqmmjTBD6klXkMj9+L7DTM6
        3FqYHU2+2vs8l/nnH/pbfAWXdg==
X-Google-Smtp-Source: ABdhPJx+yVIizrn3TNkV0avPOzlugxQ8k0ukioAmiQ8vY0Mc4vNDxrGOASSexikBSeOz5hVkW3Tx+A==
X-Received: by 2002:a17:90a:fe05:: with SMTP id ck5mr5768761pjb.19.1617228001967;
        Wed, 31 Mar 2021 15:00:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i10sm12087380pjm.1.2021.03.31.15.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 15:00:01 -0700 (PDT)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Wed, 31 Mar 2021 15:00:00 -0700
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org
Message-ID: <202103311500.C1214192BE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        metis.ext.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=4.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.2
Subject: Coverity: m_can_receive_skb(): Error handling issues
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: ptx@kleine-budde.de
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20210331 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  None
    1be37d3b0414 ("can: m_can: fix periph RX path: use rx-offload to ensure skbs are sent from softirq context")

Coverity reported the following:

*** CID 1503583:  Error handling issues  (CHECKED_RETURN)
/drivers/net/can/m_can/m_can.c: 470 in m_can_receive_skb()
464     */
465     static void m_can_receive_skb(struct m_can_classdev *cdev,
466     			      struct sk_buff *skb,
467     			      u32 timestamp)
468     {
469     	if (cdev->is_peripheral)
vvv     CID 1503583:  Error handling issues  (CHECKED_RETURN)
vvv     Calling "can_rx_offload_queue_sorted" without checking return value (as is done elsewhere 7 out of 8 times).
470     		can_rx_offload_queue_sorted(&cdev->offload, skb, timestamp);
471     	else
472     		netif_receive_skb(skb);
473     }
474
475     static void m_can_read_fifo(struct net_device *dev, u32 rxfs)

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1503583 ("Error handling issues")
Fixes: 1be37d3b0414 ("can: m_can: fix periph RX path: use rx-offload to ensure skbs are sent from softirq context")

Thanks for your attention!

-- 
Coverity-bot

