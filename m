Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB86329396
	for <lists+linux-can@lfdr.de>; Mon,  1 Mar 2021 22:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbhCAV2s (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Mar 2021 16:28:48 -0500
Received: from mxcwn13.webd.pl ([194.181.228.69]:40747 "EHLO mxcwn13.webd.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237988AbhCAVWU (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 1 Mar 2021 16:22:20 -0500
Received: from wn13.int.webd ([192.168.101.113] helo=wn13.webd.pl)
        by mta01.webd.pl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <mariusz.madej@xtrack.com>)
        id 1lGpyq-0004ge-Pz; Mon, 01 Mar 2021 22:21:28 +0100
Received: from [192.168.101.231] (port=48996 helo=mta01.int.webd)
        by wn13.webd.pl with esmtp (Exim 4.93)
        (envelope-from <mariusz.madej@xtrack.com>)
        id 1lGpyq-0005Oc-ND; Mon, 01 Mar 2021 22:21:28 +0100
X-Quarantine-ID: <KaS4Ai1MsV3c>
X-Virus-Scanned: amavisd-new at mxwn13.webd.pl
Received: from wn13.webd.pl ([192.168.101.113])
        by mta01.int.webd (mxwn13.webd.pl [192.168.101.200]) (amavisd-new, port 10134)
        with ESMTP id KaS4Ai1MsV3c; Mon,  1 Mar 2021 22:21:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xtrack.com;
         s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=kNwkNwrTdW8LBBMrLUj7w33sDYzP3G1CVSqOQcpn/d0=; b=W6OaWbGlRNg7frJcvnd5x9ppR+
        ZlqTdDVJipqAh61hTrjdGamK8g2jalgu99ygsrLcMaazwu2iYW6vq/MywOw5q8I62zNYI/Qwlgoz6
        J1kEOEVcZYWuUZbYdGqm4Aa/EJ0Ylbj+6HtbB484t0OY1q1nZrOyP8Lw+O3vSMH4+5t85qtsHlXIj
        mvE2vZzOX0pItBLC6aSrXnwj2lJTPl/uFtAsXWnpGaq8Je3PJ9yXAsoVCTdX7yRTGOKLGuqjb1/GQ
        K/7fFgXhYYYmNVT0jXxT0mp10QfopsriKiLbOdgnRE/LvkVynqks4BQ/FxuAZNziPai+s/PzRHRmx
        sxUKiQjQ==;
Received: from [185.241.198.130] (port=51794 helo=[192.168.32.4])
        by wn13.webd.pl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mariusz.madej@xtrack.com>)
        id 1lGpyq-0005OR-3X; Mon, 01 Mar 2021 22:21:28 +0100
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
From:   Mariusz Madej <mariusz.madej@xtrack.com>
Subject: [PATCH] can: m_can: reset IR_RF0L in message reception loop
Message-ID: <0710fbd2-4b88-21bf-88f7-0b97d7e7dc0b@xtrack.com>
Date:   Mon, 1 Mar 2021 22:21:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Message lost warning is reported in loop without interrupt reset. Besides
redundant log messages it may lead to serious performance problem, where
fifo gets full faster than next reception is scheduled by NAPI. This
patch fixes it.

Signed-off-by: Mariusz Madej <mariusz.madej@xtrack.com>
---
  drivers/net/can/m_can/m_can.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 3752520a7..bd5539435 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -501,8 +501,10 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
  	}
  
  	while ((rxfs & RXFS_FFL_MASK) && (quota > 0)) {
-		if (rxfs & RXFS_RFL)
+		if (rxfs & RXFS_RFL) {
  			netdev_warn(dev, "Rx FIFO 0 Message Lost\n");
+			m_can_write(cdev, M_CAN_IR, IR_RF0L);	
+		}
  
  		m_can_read_fifo(dev, rxfs);
  
-- 
2.20.1

