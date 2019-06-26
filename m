Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D936256A07
	for <lists+linux-can@lfdr.de>; Wed, 26 Jun 2019 15:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfFZNJA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jun 2019 09:09:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53078 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfFZNI7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Jun 2019 09:08:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so2043950wms.2
        for <linux-can@vger.kernel.org>; Wed, 26 Jun 2019 06:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=UlAyafwoDWOEZg6jMds0rhcbFjBfyg8hnA1+xEC/Yao=;
        b=D9jj2u8GMuzxKU98G6kRXnbV9c+RQt++kXvN4FEFtgycPae8cdS/Aq6nD+2tCgJ6Sz
         o42/OZOTQwjC+l7lSrgOJhdXQSQQzfMcEeCtJzNRik/ohayCwPAInW9bH/yq1KFnnNj8
         JHOT/9wbnneNrrt67ZxJho/0B6j/eW1ng2C6MzdOTX+jGRVYoNKUSlsK7onoPoT1FH2N
         lw1wqztnx5cWqz2pl1ReVLa7b6vnHVO7zH8c27WNUzw4pribsjpFa53DFIQ8Ri2/CAp/
         C91LYRzikIJlV+WC4SyaHKNhya/JXfsRH1sq+uNVUhPCfQiyAacRTPrFaDD+uNm7dt6y
         tZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UlAyafwoDWOEZg6jMds0rhcbFjBfyg8hnA1+xEC/Yao=;
        b=HJ6qIGss+cQEaMu/3ryfNC8ydXLlzUx2/5NPxJhMgDIMlakZgm8IK2/1CMaq2DwGrv
         bo+mWBYugTSeRMTQ/+2YbtkLRt335d71migAN6Wpqus+8YucXLylRMeIq5GLJDofniR1
         XGgo5fwq+1lLxgrS2VbzYESBfSNxm3XGkmaVkPoRSUE/4wRA6GmLdTNB2KutPmutzG7J
         iZEFop35mFl7PJSmCnvBetrcvsgQoc9IWb4ECEFVB3uPCPXYJ/Z63in1o7Aw3kZpjyWl
         B8PH/Vt3rGiHCRLQLRKhEpRblmB693WABar/ZOqL4vpB2QlV/0bUc0Q9B2Rb9mjlXqbW
         zsLw==
X-Gm-Message-State: APjAAAVMTG3HHwr9pLODLRRacX50bPjNMBXrxdMm3aYoIPXk6nQew12e
        FMB6M0ZsIE9jSJS4QDzul7w2vA==
X-Google-Smtp-Source: APXvYqwKysgktY1GpqtaQ+PYDOj5SUC1kpqiac/ggfHtzlyx9cDcNQ/sdW+AT8RFtOuz94FidUEZgg==
X-Received: by 2002:a1c:b706:: with SMTP id h6mr2640507wmf.119.1561554537502;
        Wed, 26 Jun 2019 06:08:57 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id n5sm1832855wmi.21.2019.06.26.06.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 06:08:56 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Artemi Ivanov <artemi.ivanov@cogentembedded.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH resend] can: rcar_canfd: fix possible IRQ storm on high load
Date:   Wed, 26 Jun 2019 16:08:48 +0300
Message-Id: <20190626130848.6671-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

We have observed rcar_canfd driver entering IRQ storm under high load,
with following scenario:
- rcar_canfd_global_interrupt() in entered due to Rx available,
- napi_schedule_prep() is called, and sets NAPIF_STATE_SCHED in state
- Rx fifo interrupts are masked,
- rcar_canfd_global_interrupt() is entered again, this time due to
  error interrupt (e.g. due to overflow),
- since scheduled napi poller has not yet executed, condition for calling
  napi_schedule_prep() from rcar_canfd_global_interrupt() remains true,
  thus napi_schedule_prep() gets called and sets NAPIF_STATE_MISSED flag
  in state,
- later, napi poller function rcar_canfd_rx_poll() gets executed, and
  calls napi_complete_done(),
- due to NAPIF_STATE_MISSED flag in state, this call does not clear
  NAPIF_STATE_SCHED flag from state,
- on return from napi_complete_done(), rcar_canfd_rx_poll() unmasks Rx
  interrutps,
- Rx interrupt happens, rcar_canfd_global_interrupt() gets called
  and calls napi_schedule_prep(),
- since NAPIF_STATE_SCHED is set in state at this time, this call
  returns false,
- due to that false return, rcar_canfd_global_interrupt() returns
  without masking Rx interrupt
- and this results into IRQ storm: unmasked Rx interrupt happens again
  and again is misprocessed in the same way.

This patch fixes that scenario by unmasking Rx interrupts only when
napi_complete_done() returns true, which means it has cleared
NAPIF_STATE_SCHED in state.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 05410008aa6b..de34a4b82d4a 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1508,10 +1508,11 @@ static int rcar_canfd_rx_poll(struct napi_struct *napi, int quota)
 
 	/* All packets processed */
 	if (num_pkts < quota) {
-		napi_complete_done(napi, num_pkts);
-		/* Enable Rx FIFO interrupts */
-		rcar_canfd_set_bit(priv->base, RCANFD_RFCC(ridx),
-				   RCANFD_RFCC_RFIE);
+		if (napi_complete_done(napi, num_pkts)) {
+			/* Enable Rx FIFO interrupts */
+			rcar_canfd_set_bit(priv->base, RCANFD_RFCC(ridx),
+					   RCANFD_RFCC_RFIE);
+		}
 	}
 	return num_pkts;
 }
-- 
2.11.0

