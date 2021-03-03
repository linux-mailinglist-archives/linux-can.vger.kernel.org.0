Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B0432C594
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 01:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355366AbhCDAXm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842623AbhCCIIx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 03:08:53 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C205C061793
        for <linux-can@vger.kernel.org>; Wed,  3 Mar 2021 00:08:12 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n4so5316006wmq.3
        for <linux-can@vger.kernel.org>; Wed, 03 Mar 2021 00:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VFRRoGfckXg7HGIHciNO0j64FnqzsFblrRwXjjxT5aQ=;
        b=zTNcj+w6s3QVfZnUWrYAMq3n3VsKwVdUj8ssQwMhaTr8oBshIbSZs7mdA/oXjmqQ//
         g4b6vNLRv+pIQJSiG59qcGArFiz29J59mqL7iFUzEg2ijU5r9WK6rGNU0Lk5QI+2QJfC
         OzOhF0pMquICtpp4QYCYX4SxfgY/56zKLWGcXJcUS0hjMKPRDRXOQW0eNdMfszaPtptR
         QBifXuStuRl03ff+A2Btp39bHwgKlOSB+wyz3YZUB+A4H4NWl9mfndtIh/2TEGJkq/5y
         lLR1IBkSvvpkuDf3hyXCOnWsmUJLlmIEbNKbsG8RVConCc/69XCoOzf8Giclwi9M2m/p
         sLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VFRRoGfckXg7HGIHciNO0j64FnqzsFblrRwXjjxT5aQ=;
        b=Hsi5PasBF3SB4BLzid1ICbdR10bq51pMuFde2xcb461G/hUD/2ZJ3WRP1AQ1WU9QRH
         XPe6D2+GHLCwRRMI6zftDMc41hwLcYHW6Si4qiA4PhSLANjXE0BpdoPVPf9UTfT05N3B
         7mZf4yYLHK0XcFdmDBshY07hi1ZEZKMateFx1VnajJU/ymwMqMxpI4ZNNPI07nPVMseI
         cBiZZldfGb9Iw1MeZEyUmQHB5+77ujBbeTM2PAuZCf2xdOKSDnooSKtoFE25Uz6XhkuZ
         o8rjFzzrp8gkkXVw4N4C5owg0ruq1gLVgh4YxhbVeo7P5uG0GYI/4A+SacMhNct00zbu
         FogA==
X-Gm-Message-State: AOAM530vQ82i92+z3kSUmn/FvJMI5fz6IA6aSEKWIVCDct1CzqZQWX/8
        mTw0+tLUAVv8x5gJAjWRu7e5HvVqF3LucQ==
X-Google-Smtp-Source: ABdhPJyW5r4wKfWXy2ptJTfwpcf0kaJhu7DHOcOExroDX7tKWu0htHyirwIGzDdi7qPaGYQMT14lyA==
X-Received: by 2002:a05:600c:4c11:: with SMTP id d17mr8064464wmp.86.1614758890936;
        Wed, 03 Mar 2021 00:08:10 -0800 (PST)
Received: from bigthink (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id g9sm32360806wrp.14.2021.03.03.00.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 00:08:10 -0800 (PST)
Date:   Wed, 3 Mar 2021 08:08:09 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Mariusz Madej <mariusz.madej@xtrack.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: m_can: reset IR_RF0L in message reception loop
Message-ID: <20210303080809.zfjh6oolqxcv4pir@bigthink>
References: <0710fbd2-4b88-21bf-88f7-0b97d7e7dc0b@xtrack.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0710fbd2-4b88-21bf-88f7-0b97d7e7dc0b@xtrack.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Mar 01, 2021 at 10:21:27PM +0100, Mariusz Madej wrote:
> Message lost warning is reported in loop without interrupt reset. Besides
> redundant log messages it may lead to serious performance problem, where
> fifo gets full faster than next reception is scheduled by NAPI. This
> patch fixes it.

Looking at the flow in m_can_rx_handler, it looks as though
m_can_handle_bus_errors -> m_can_handle_lost_msg already handles message
loss properly, and issues a netdev_err. I wonder whether we can remove
the warning from m_can_do_rx_poll entirely:

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 3752520a7d4b..d783c46cac16 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -501,9 +501,6 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
 	}
 
 	while ((rxfs & RXFS_FFL_MASK) && (quota > 0)) {
-		if (rxfs & RXFS_RFL)
-			netdev_warn(dev, "Rx FIFO 0 Message Lost\n");
-
 		m_can_read_fifo(dev, rxfs);
 
 		quota--;

---
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

