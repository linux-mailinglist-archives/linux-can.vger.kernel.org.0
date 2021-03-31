Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42826351057
	for <lists+linux-can@lfdr.de>; Thu,  1 Apr 2021 09:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhDAHtq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Apr 2021 03:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhDAHt1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Apr 2021 03:49:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E45C0613E6
        for <linux-can@vger.kernel.org>; Thu,  1 Apr 2021 00:49:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lRs4z-000216-Cf
        for linux-can@vger.kernel.org; Thu, 01 Apr 2021 09:49:25 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:3432:3a72:abbc:cd9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BC230605872
        for <linux-can@vger.kernel.org>; Thu,  1 Apr 2021 07:49:24 +0000 (UTC)
Received: from bjornoya.blackshift.org
        by bjornoya with LMTP
        id LtEOMtXwZGAlLAAAs6a69A
        (envelope-from <keescook@chromium.org>)
        for <mkl-all@blackshift.org>; Wed, 31 Mar 2021 21:59:49 +0000
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 9E727605398
        for <mkl-all@blackshift.org>; Wed, 31 Mar 2021 21:59:49 +0000 (UTC)
Received: from metis.ext.pengutronix.de (unknown [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 64C9B605397
        for <ptx@kleine-budde.de>; Wed, 31 Mar 2021 21:59:49 +0000 (UTC)
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <keescook@chromium.org>)
        id 1lRisN-0000Cp-0M
        for mkl@pengutronix.de; Wed, 31 Mar 2021 23:59:47 +0200
Received: by mail-pl1-x631.google.com with SMTP id f17so8612993plr.0
        for <mkl@pengutronix.de>; Wed, 31 Mar 2021 14:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=o6cVP/Hyd+IJoAbbWeUqu70F8kY7jqZxnvxhQO4a7+E=;
        b=J12K7YicqdLYYU1F6pb1bg/UgvJ7wVtUVaqnUZqNXzT3MDNvZFWYxPyUemdEjMP8TA
         37Eah0fGI9crTuDJcKy7d4P3t4tK3iWzt4N/ZyyEwBfCP3urj8Zbc3LgQMpox8SdqLqb
         FP6E1XWz+T84zJTnqc3APgoEcBgA4oSqjA+98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=o6cVP/Hyd+IJoAbbWeUqu70F8kY7jqZxnvxhQO4a7+E=;
        b=diUw2dTYxguvfgM7LxjIBsQ3eRcAU/+o1lU6kqbET+SN1wv3xeEGdJk4OrFd41D/HA
         XkRh1krpY8I+4TXI4TugNeW1/NY1zcbWYA0O2fBZgCxRmliJpgwDVATohE6IMMahSLdf
         2CrM2iBKWrqmswzkS/gjF9/gZoxfyGDY2IXLHHAj8NW6uSuz8kBwG7s/Scp+s0zsNOvW
         C+idK8cttUlg5ESlTkJfVukwT/44agBJMu477GDSosm7w3UwuAnKz9y8TkfHL6N+9cyo
         RNS6Zjb4EL52TbKzJ7uc6nVxoTTZIa4t26+E6OzpfssVpNZ3gj6NXw3QNbJNLptBBIVE
         4uzQ==
X-Gm-Message-State: AOAM533w/6urHEPIYsbErUlmr1B4tECvMtNUE31AkoBOzaRPJTbkpuQE
        kTS1ghD2c/AsnbtseoGV+UofRQ==
X-Google-Smtp-Source: ABdhPJw3IAweAz7FWYovvvotd5+zDf41UIjG/njGExPOfV4vCqAqmICRiktNQOJv4aLP+csI3Ckkxw==
X-Received: by 2002:a17:90a:d58a:: with SMTP id v10mr5613036pju.36.1617227985157;
        Wed, 31 Mar 2021 14:59:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 11sm3393600pfn.146.2021.03.31.14.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 14:59:44 -0700 (PDT)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Wed, 31 Mar 2021 14:59:44 -0700
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org
Message-ID: <202103311459.93EB7DEBDC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        metis.ext.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=4.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.2
Subject: Coverity: mcp251xfd_dump_rx_ring(): Memory - illegal accesses
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
    e0ab3dd5f98f ("can: mcp251xfd: add dev coredump support")

Coverity reported the following:

*** CID 1503585:  Memory - illegal accesses  (OVERRUN)
/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c: 190 in mcp251xfd_dump_rx_ring()
184     static void mcp251xfd_dump_rx_ring(const struct mcp251xfd_priv *priv,
185     				   struct mcp251xfd_dump_iter *iter)
186     {
187     	struct mcp251xfd_rx_ring *rx_ring;
188     	unsigned int i;
189
vvv     CID 1503585:  Memory - illegal accesses  (OVERRUN)
vvv     Overrunning array of 1 8-byte elements at element index 1 (byte offset 15) by dereferencing pointer "priv->rx + i".
190     	mcp251xfd_for_each_rx_ring(priv, rx_ring, i)
191     		mcp251xfd_dump_rx_ring_one(priv, iter, rx_ring);
192     }
193
194     static void mcp251xfd_dump_tx_ring(const struct mcp251xfd_priv *priv,
195     				   struct mcp251xfd_dump_iter *iter)

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1503585 ("Memory - illegal accesses")
Fixes: e0ab3dd5f98f ("can: mcp251xfd: add dev coredump support")

Thanks for your attention!

-- 
Coverity-bot

