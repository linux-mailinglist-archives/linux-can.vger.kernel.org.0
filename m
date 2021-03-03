Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9608832C5A8
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 02:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377829AbhCDAYA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383522AbhCCOjP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 09:39:15 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B9C061A32
        for <linux-can@vger.kernel.org>; Wed,  3 Mar 2021 06:36:10 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h98so23910662wrh.11
        for <linux-can@vger.kernel.org>; Wed, 03 Mar 2021 06:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kznca3zEmMinTq28ma7OpIR5yo6A50Qa42241Bk+eug=;
        b=VkD9zoZ7Em96cDUoODqEjHGsmtGjCX2p3Y1lh8tu7jMB6qjkXsTl1Rfr4aNxcjMX54
         ezrsyFX4y4V1FYXpm6NnxFyHCPTo1Yz6CVJ813eRulg6CFe1F78lhKZOb3vF9YQ9GuiV
         CdlaGO1OuXVufDGua8aat0wxbBglaLWB89tIV+uEPiOzR2QukdWvVt+CSaVcRV+kC5nl
         cxBsdjPtSEPGpeIlvIxg554oRHX3kbhfZfO+4xmvg+a1BhpYpnvUtTnFRBkz4UNKuNg4
         D8tKIOT6IGMZDkzGS0884/VHFcJBOQEtX4WuBvJH85NBsBDgTITfBQcAFw4h/upCRdPe
         MFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kznca3zEmMinTq28ma7OpIR5yo6A50Qa42241Bk+eug=;
        b=JSDQSs+KGY7J6TWs8OB8UuZ4NxcJwAh5fI4A7B7kg724A4PYhYHtE1v/GDj2yjj14N
         augkTlNLeIKzTqA3T5hT/Uwd0ZxKOVVv1EC4FvrHnrj2rP1xmogY8P8X4bbZ3btC3qPv
         IEhFWPjPdv8NDXN01NaAH6szOkOEEriCkahzvQm2A8qLVXnLCCMKqsEtAPj7PwfyJjhE
         s7Igqg4ajVh+S2iWNcXIK/MsrTENe532rhzxFbcydBmIBugU/xC4YHTVx6ITMQ6YwUam
         tPZ/IyVRDpumTUaxjqxu6rvh+rJ6vnv1t66mmndnu3O1qwaXxclD9p98UYSYp0IEejNT
         lDow==
X-Gm-Message-State: AOAM532HM76BiQoWeoxPm5/bUGZ0FK+Nx3f3bF5dy3WernmIdBs/gnpH
        4vrR8kk7D6TvotYWYqYYcGR5Jw==
X-Google-Smtp-Source: ABdhPJw1DZSuuU9pBiiTlo+1uJdghGIJg1sPsxVkh0DIQYmQBDomiPUZ4lyZ/tx+Ljsx9Kx9EkF6ew==
X-Received: by 2002:a5d:698e:: with SMTP id g14mr9659980wru.127.1614782169166;
        Wed, 03 Mar 2021 06:36:09 -0800 (PST)
Received: from bigthink (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id l22sm33393481wrb.4.2021.03.03.06.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:36:08 -0800 (PST)
Date:   Wed, 3 Mar 2021 14:36:06 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: m_can: m_can_rx_handler(): fix RX in periphs being
 blocked by error handling
Message-ID: <20210303143606.hlvqoqwljuzxcuc6@bigthink>
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
> To be precise, it's a threaded Interrupt. Why not call the rx_handler
> with a reasonable quota instead?

After some testing, I've found that this solution works best. I'll send
another patch.

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

