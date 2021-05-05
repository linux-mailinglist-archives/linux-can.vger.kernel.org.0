Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F86373A42
	for <lists+linux-can@lfdr.de>; Wed,  5 May 2021 14:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhEEMJl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 May 2021 08:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhEEMIe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 May 2021 08:08:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F184AC06138D
        for <linux-can@vger.kernel.org>; Wed,  5 May 2021 05:07:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 4-20020a05600c26c4b0290146e1feccd8so990749wmv.1
        for <linux-can@vger.kernel.org>; Wed, 05 May 2021 05:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uVQeqJ4Dnpl8/4KjeQnAtiL2Oi64xbGdF5JY8DeQ4wE=;
        b=L5AsDkmfrC6tkCQOVS4x42xzXqdXBmsf6Q1ZFG3+aD8nVeUu0PpJlZA6123evoCtsI
         ZSYpttb04Cnj8hZSQzc9YFgghjvQqZICsF7QDXNgnXHxL+HeYGE+41GCBdmoQAeSxEmd
         QS8tqHoyxwhNS/erbKv7+85vKCxCC6iMTjdjIVNG5+dWvuyXjIDe01M5FbOC7jmONDwR
         bw5QwRIa43Rbk6Hyv1EA9jKPnIevt0KSVnk87Uz8eSfvxn6atzFBqf5zg47OIQPYxy3c
         vQ63qfuvqYK1x2uFsq3CrqgGDTWQM8OmXA+Mc7b6PvCHr+Qx2i7QgfgFZS1sAaszbGDN
         5iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uVQeqJ4Dnpl8/4KjeQnAtiL2Oi64xbGdF5JY8DeQ4wE=;
        b=rIarKwZMElXMZyIyCyCBAEXbktE0rDCtXXHnuL5L8Md4sKy7h3YcR1WQmSYKTcX3Td
         G2ZLe24SZRuzPeEU004E8bs/pfScSbI4q0U9cYF4ts6laDgKgPRVrJqR2k+2P2cxf/aJ
         Ldr0527OS0erccD/wyJexHY5ZJ5C4RHivRMqqR91RcCVH36ia9AgfMTNPRROWh52Zk+Y
         qJlrblVy2Gk5Wdc+rvymlnxdjEh/3wQmoiS3JNbSoPvz0MWUfY2mlSGYc/36t2JcTqKY
         PFOS4HP9o3e54l/cEqAmXyw/mo5jyl+Qhy16FS2N481eBXLDAw0G7yi8hDRzVvMnLgg6
         eIcQ==
X-Gm-Message-State: AOAM533ZiUB18Xa5wqKMfBHubiTPzU8/xcqpqSRPGElDnigMAjSuf/p6
        kLGw/4Odl6CS7RlQtxPQ0RD43LDEIL9nKdp0
X-Google-Smtp-Source: ABdhPJz9HdGVKNN07mjNvQN4a6NNU8m9e79ca29VNcFLwbUCJuk1G7F08KxZTFQsCgy/I45nmbSeMA==
X-Received: by 2002:a05:600c:2d42:: with SMTP id a2mr9673815wmg.99.1620216421756;
        Wed, 05 May 2021 05:07:01 -0700 (PDT)
Received: from bigthink (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id n6sm15287852wro.23.2021.05.05.05.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:07:01 -0700 (PDT)
Date:   Wed, 5 May 2021 13:06:59 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC] can: m_can: m_can_tx_work_queue(): fix tx_skb race
 condition
Message-ID: <20210505120659.bconnblkp5lhd52t@bigthink>
References: <20210505114302.1241971-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505114302.1241971-1-mkl@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, May 05, 2021 at 01:43:02PM +0200, Marc Kleine-Budde wrote:
> The m_can_start_xmit() function checks if the cdev->tx_skb is NULL and
> returns with NETDEV_TX_BUSY in case tx_sbk is not NULL.
> 
> There is a race condition in the m_can_tx_work_queue(), where first
> the skb is send to the driver and then the case tx_sbk is set to NULL.
> A TX complete IRQ might come in between and wake the queue, which
> results in tx_skb not being cleared yet.
> 
> Fixes: f524f829b75a ("can: m_can: Create a m_can platform framework")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello,
> 
> compile time tested only.
> 
> Marc

Thanks a lot for spotting this Marc, after initial testing this is
working very well. I don't see that error message at all now, even at
very high transmit rates, and dropped frames are reduced considerably.

(Test setup: RPi CM4, TCAN4550, 500 kbit/s CAN-FD.)

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

