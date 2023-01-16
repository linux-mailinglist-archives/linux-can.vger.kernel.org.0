Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB12266CFE9
	for <lists+linux-can@lfdr.de>; Mon, 16 Jan 2023 21:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjAPUMF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Jan 2023 15:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjAPUMC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Jan 2023 15:12:02 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703DA2411D
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2023 12:12:01 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 294EE240240
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2023 21:12:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1673899920; bh=p16IEsCAxBqDSoQrOUzfDo5DWwkPuXoVAHxrztwGuQA=;
        h=From:To:Cc:Subject:Date:From;
        b=kjFClva9hs96+xzTdeIgOEphuioSUcy7oGUE1o6gP8UCstMf9rhBGD3PJoTQ0gQaz
         zvVs6uO1OZa5QhOt2uwUzYxxnXfYwMCDelOCtetRCptPEdBqRlWDViaxhSond6Zino
         y9ujr+JssIJS+kmM0ZSozecKrb89YWWfaEcCMNqbtCbro1BA7mdqAWifj0OcwsdKTi
         hdIzQMEPAIVGchpnwitxb5Zh9GEgCZCeyXPqLyBJxygEztwBymOuqh53qCzSdd1ucl
         GSHYkciN+37PSRoVnWlQq+im6NxKfQxS3dfveSrADAKAi1Vq+UMS7FfalEZjHWS0Sj
         qjNkVwz54zmnw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Nwjq34Z7Sz9rxG;
        Mon, 16 Jan 2023 21:11:59 +0100 (CET)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH v3 7/8] can: peak_usb: align CAN channel ID format in log with sysfs attribute
Date:   Mon, 16 Jan 2023 20:09:31 +0000
Message-Id: <20230116200932.157769-8-lukas.magel@posteo.net>
In-Reply-To: <20230116200932.157769-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
 <20230116200932.157769-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Previously, the CAN channel ID was printed to the kernel log in decimal
upon connecting a new PEAK device. This behavior is inconsistent with
the hexadecimal format of the CAN channel ID sysfs attribute. This patch
updates the log message to output the id in hexadecimal.

Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 89ad5fda19c6..926d1359f433 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -1029,8 +1029,8 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	/* get CAN channel id early */
 	dev->adapter->dev_get_can_channel_id(dev, &dev->can_channel_id);
 
-	netdev_info(netdev, "attached to %s channel %u (device %u)\n",
-			peak_usb_adapter->name, ctrl_idx, dev->can_channel_id);
+	netdev_info(netdev, "attached to %s channel %u (device 0x%08X)\n",
+		    peak_usb_adapter->name, ctrl_idx, dev->can_channel_id);
 
 	return 0;
 
-- 
2.38.1

