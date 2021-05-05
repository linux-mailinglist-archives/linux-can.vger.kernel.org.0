Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983B2373893
	for <lists+linux-can@lfdr.de>; Wed,  5 May 2021 12:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhEEKbv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 May 2021 06:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbhEEKbu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 May 2021 06:31:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9A4C061574
        for <linux-can@vger.kernel.org>; Wed,  5 May 2021 03:30:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d4so1250185wru.7
        for <linux-can@vger.kernel.org>; Wed, 05 May 2021 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=s23TUMcvZKOURbW8KYelmMo8xqTGbqHyeioo6aiGSUI=;
        b=pEcuqtk1Rs0bMmIHQv29ANC6p75/gWXec3nH/DPbaJJXLnAGvPcc5znU8fIV7l2xuC
         219DeIGf/C5lc1O/YR+MKelYojSY+IJb+kX5TBvCYbaSFJwYfr/QtnCCFk/Uv9YmD4vb
         RWpOFzg3xgc02CUKBeQ4DdRFEkWfrQNKzRcRTsr1gXQGL13NuFTRMOiHo0K+PErDLzo8
         vJcvqp2CCboEp9sRjlTfEOqUs8/slEtPDHsBsFO9wnRo/StVq2OmqGF0qJAa4r5/ERsa
         PvLZahVEhWYplahJ8obRS4I4f3xqphORgpMKAdZmmUmmC6XpdA/wiHNAEMC98MWWimh1
         LwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=s23TUMcvZKOURbW8KYelmMo8xqTGbqHyeioo6aiGSUI=;
        b=lLT96SBMXjnI226BsfIhvgDMbXZSH17jn00IDtcBkBrtYuTtEzSbqfYv6iifc7MSjT
         v++gZ21cBzI8blwn7tgwhCf2kbV9YSXuN0Q70dB4kg10T7vAHnquwkGnKMc0rkmUWX4V
         56QHSJ8B1luUTXf5i0lGBOeIz19zzOm1T5+5AjypOzUB+MzFrW5HV/2TgG42Oatpfa9g
         6ulhy4qVmO+EuojM6GnX/9PqZFPO0yS6ahiv2U3+utHtOqQOv5v24yhs8DAw0076cha3
         NZp+/V0tJBchOL8+VO07lR3mH6VjuyA4t8tuTaH+92wx/cO/08/J3SltTNwOhoeP4fY1
         /HeQ==
X-Gm-Message-State: AOAM531fkp5WgF4TmCpJ3BZUyK3+KNKRkwhgU+RwBla8tsJK/rC4QWix
        Ajihqdjw+x249+q9cxUO6UGb5CsGFB+T9Xwv
X-Google-Smtp-Source: ABdhPJwQIQAgfD3zJS8mTYz9dkcp8MGnG0Eq1Hb5mJQUwdnVdXKEBNzYAus+NCFn5/yBSVY9OLLjEg==
X-Received: by 2002:adf:f3c1:: with SMTP id g1mr29405700wrp.242.1620210652091;
        Wed, 05 May 2021 03:30:52 -0700 (PDT)
Received: from bigthink (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id z14sm22446588wrt.54.2021.05.05.03.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 03:30:51 -0700 (PDT)
Date:   Wed, 5 May 2021 11:30:49 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Improving TX for m_can peripherals
Message-ID: <20210505103049.gboat4dr3zvdm4s6@bigthink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Good morning candevs,

I've been testing the TCAN4550 recently with proper kit (no more jumper
wires, hooray!) and I'm happy to say the RX path is fixed in v5.12 with
the latest patches, and even with heavy load I see no missed frames or
errors.

However, TX still needs work. It's easy to break the driver due to the
following logic in m_can_start_xmit():

| 	if (cdev->tx_skb) {
| 		netdev_err(dev, "hard_xmit called while tx busy\n");
| 		return NETDEV_TX_BUSY;
| 	}

Regardless of your netif TX queue length or the number of TX buffers
allocated in the M_CAN core, if you try to transmit too quickly, you
will hit this. For the application I'm working on, I run into this very
quickly with real-world scenarios.

Also, the queue is always stopped before the tx work is queued in
m_can_start_xmit(), which seems wrong and clearly doesn't solve the
problem:

| 	/* Need to stop the queue to avoid numerous requests
| 	 * from being sent.  Suggested improvement is to create
| 	 * a queueing mechanism that will queue the skbs and
| 	 * process them in order.
| 	 */
| 	cdev->tx_skb = skb;
| 	netif_stop_queue(cdev->net);
| 	queue_work(cdev->tx_wq, &cdev->tx_work);


So - I'd like to fix this. The comment in the snippet above suggests a
queueing mechanism. It would be good to hear your take on this, Marc -
AFAIU you have written a similar mechanism for mcp251xfd. :)

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

