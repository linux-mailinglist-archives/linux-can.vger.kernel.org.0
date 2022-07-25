Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA6F580011
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiGYNoO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiGYNoM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:44:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A2C15704
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:44:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l14-20020a17090a72ce00b001f20ed3c55dso10304171pjk.5
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cR/Cp2SmcTZRgqvd7FK08s53jA3xcb7We5IWZW44kWY=;
        b=CVwWSmycKcGUTIsiZn41or98ok8WT43akXIWwplSx6bdAxh14Q5kTxwl+Fm+/xYDC+
         NFkLIR5N1/n4+LAmfs5bl4ZjyOazcJgGdfJIP26bqvaX8143a6pVx4AlG8MevmEGTw3x
         TdrrWRHN+rCbqCYHktrdHRn9Mt83CdFkE4z3/rOYRy9hsTTwM6UlYIu6XC+Aq+507ds3
         1UeneLxWebZc/FtqQKNUKlLFz8nHNsOH4tyPjPeJyR4VL7HT4OImnA8Bof72xzpzaVss
         onc2fFdX1q1myIsvH85p9w07V1TrUAKBaBi2hGiMeOm7Y3mzPO+cs5oJuAplTkeql6bK
         5FQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cR/Cp2SmcTZRgqvd7FK08s53jA3xcb7We5IWZW44kWY=;
        b=WbLckw61j7WCnO8N9dI58mvuAzvNy9yoWJuFMUHTyQGWYxkN29JRxSXIzP7QaKBp6R
         yybfK8T0gdq86o+qmbOeGp1/CQ5Qy+JIfUeTjSsPX1C1J3gmeNNCkCT+8DDzZjwqFfj8
         4Mhgco064c+RYQufBwPY18Dnm6VQyFkQV8TV6twHqnDk86c15CPYu++NRqP3xriRCC2U
         6z3lFfDiPQHqtqvXbEhebWcy32tYq0Gx4PebYiouaAlpZ/pnSOb4ABKsxSrYPl2IOP0i
         fBmK4Swp1hiMd0S5XbnEf/jaTf3/c/VN5bp+Mhy+y5kC9cSV8t56WbqVYOwCgfTAvUXf
         AKFQ==
X-Gm-Message-State: AJIora+ZPGOCaeEHwFtyyKbjK5cegSpMEI0Wuwfe9WkMKhC1EZ7JoYQk
        i8iwVYYF/lLFcOFCf9msLkA8BT65PPc=
X-Google-Smtp-Source: AGRyM1ttU+a1kkXjfgC4BUyWrKPt5AY8FTcb9djQ+tDaeZtY7dDLCsJj7eRdEdcXQsz+GO+PD1qEFg==
X-Received: by 2002:a17:902:f548:b0:16d:83dd:9bc4 with SMTP id h8-20020a170902f54800b0016d83dd9bc4mr2809271plf.129.1658756647184;
        Mon, 25 Jul 2022 06:44:07 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id v12-20020aa799cc000000b00528c149fe97sm9579795pfi.89.2022.07.25.06.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:44:06 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 2/4] can-roundtrip-stats: remove needless else after continue
Date:   Mon, 25 Jul 2022 22:43:43 +0900
Message-Id: <20220725134345.432367-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725134345.432367-1-mailhol.vincent@wanadoo.fr>
References: <20220725134345.432367-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The "else" is not needed after the "continue" statements. Remove it.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 can-roundtrip-stats.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/can-roundtrip-stats.c b/can-roundtrip-stats.c
index 1eaed35..9d828d1 100644
--- a/can-roundtrip-stats.c
+++ b/can-roundtrip-stats.c
@@ -503,11 +503,10 @@ int main(int argc, char **argv)
 			if (get_tx_timestamp(soc, &msg, &kernel_tx) == 1) {
 				got_tx_timestamp = true;
 				continue;
-			} else {
-				usleep(100000);
-				clock_gettime(CLOCK_REALTIME, &user_tx);
-				send_canfd_frame_str(soc, can_id++, "", CANFD_BRS);
 			}
+			usleep(100000);
+			clock_gettime(CLOCK_REALTIME, &user_tx);
+			send_canfd_frame_str(soc, can_id++, "", CANFD_BRS);
 		} else if (get_rx_timestamp(soc, &msg, &kernel_rx) == 1) {
 			got_tx_timestamp = false;
 			clock_gettime(CLOCK_REALTIME, &user_rx);
-- 
2.35.1

