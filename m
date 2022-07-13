Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259045739EE
	for <lists+linux-can@lfdr.de>; Wed, 13 Jul 2022 17:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbiGMPUS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Jul 2022 11:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbiGMPUP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Jul 2022 11:20:15 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4004504B
        for <linux-can@vger.kernel.org>; Wed, 13 Jul 2022 08:20:14 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-f2a4c51c45so14409182fac.9
        for <linux-can@vger.kernel.org>; Wed, 13 Jul 2022 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKNJ81XHX1rVWPGtQSPsv7xkRycDjY6KgGLmlaN+gNY=;
        b=UGv5W4X0AgNs0e90Jxbuk8yoqkf1YIvPuG32cxJaOFdhOKMYtLT3UzjNMyJo3NmCSB
         h/K0iglgBA1TRNjZsaY3WPDnmRX23YpSMViygd9NRIhPlSo9yiPb+fbPadGOwbmeYz9x
         0j6tumQO78ZJbjdyG1XX+ZjluB6BIV4JYujzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKNJ81XHX1rVWPGtQSPsv7xkRycDjY6KgGLmlaN+gNY=;
        b=kBuu7UpSBd0BHEzIIpe3TvZpcy0QAkl9/GEihuEe1/j/xoPK3AxHEJipzcJVCmVFI5
         w7aAo9NDnjoSWMQJOBNeRPMJj1WjKL68zRQLcCjMTMGDpB2vuvcknpseU7tp2i3jVejl
         czcFsTs9MVE+1VdVIeMTJcPSM2AqQnUZRh72qsCiFiSKLBHB4IzAgianTCBSouX+bi/N
         j97YGv+ZabW3SBRNmjQpiV9gh1GNW0oQZ4RfBvLFg8MyVoMzZuT92WIcsNDqCtL1oTCO
         hwh6Jg+uJ7vOCxwuAP1jOLeLNhNFti+xMp8NvTJXaNNdVuS01OemQ/vJObPeJ5NPdBT4
         86BQ==
X-Gm-Message-State: AJIora+sUt9szQ0WS4/0SVqJN62aN6f6fP9/n5/oTNtLmlyqyBC5LMVA
        l44tHVSITBpRkvged/CqJPFvIA==
X-Google-Smtp-Source: AGRyM1usHml13CDD+aHqFlxY8s5H+Eng7j9UX5kgdAqCwghIPyT60PRhwo1GRoZ8vA6nrb+/q/6Bdg==
X-Received: by 2002:a05:6871:60c:b0:10b:ee7c:2e28 with SMTP id w12-20020a056871060c00b0010bee7c2e28mr4774059oan.21.1657725613728;
        Wed, 13 Jul 2022 08:20:13 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-80-182-13-224.pool80182.interbusiness.it. [80.182.13.224])
        by smtp.gmail.com with ESMTPSA id x24-20020a4a3f58000000b00432ac97ad09sm4895477ooe.26.2022.07.13.08.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 08:20:12 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Richard Palethorpe <rpalethorpe@suse.de>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <oliver.sang@intel.com>, lkp@intel.com,
        lkp@lists.01.org, ltp@lists.linux.it,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] can: slcan: do not sleep with a spin lock held
Date:   Wed, 13 Jul 2022 17:19:47 +0200
Message-Id: <20220713151947.56379-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

We can't call close_candev() with a spin lock held, so release the lock
before calling it.

Fixes: c4e54b063f42f ("can: slcan: use CAN network device driver API")
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/linux-kernel/Ysrf1Yc5DaRGN1WE@xsang-OptiPlex-9020/
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/net/can/slcan/slcan-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 54d29a410ad5..6aaf2986effc 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -688,6 +688,7 @@ static int slc_close(struct net_device *dev)
 		/* TTY discipline is running. */
 		clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
 	}
+	spin_unlock_bh(&sl->lock);
 	netif_stop_queue(dev);
 	close_candev(dev);
 	sl->can.state = CAN_STATE_STOPPED;
@@ -696,7 +697,6 @@ static int slc_close(struct net_device *dev)
 
 	sl->rcount   = 0;
 	sl->xleft    = 0;
-	spin_unlock_bh(&sl->lock);
 
 	return 0;
 }
-- 
2.32.0

