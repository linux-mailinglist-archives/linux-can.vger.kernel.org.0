Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA5A5455F1
	for <lists+linux-can@lfdr.de>; Thu,  9 Jun 2022 22:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345255AbiFIUsH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 Jun 2022 16:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiFIUsG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Jun 2022 16:48:06 -0400
Received: from mx0a-0054a801.pphosted.com (mx0a-0054a801.pphosted.com [205.220.160.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AFD66224
        for <linux-can@vger.kernel.org>; Thu,  9 Jun 2022 13:48:04 -0700 (PDT)
Received: from pps.filterd (m0208803.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 259CPLmZ015082
        for <linux-can@vger.kernel.org>; Thu, 9 Jun 2022 13:48:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=samsaracom06092020;
 bh=fsize1LL6DRMFATJFP/MigYicgdzJfWPUSyxUH+2K98=;
 b=DnZi1tOpzbWjOhObvXhG+qZB3Bt9J0Kcf0m3vW+TMhg6xfXLgbHlRZXUgnjkdp+QFMJV
 nrngI4DrQ/j3MyMcx7/uYvucB7GdX3g3xyP4f2QcKu88DdDo/wEm8hCRF5U4qKj5Y1Vl
 EjU0SGQ9D9kRKXdXuPrjRBLsMP7ERGPT0F9vlxXRmYlcHidgsP9EhAphOyqE0Ln+Kdaf
 5z5T4Hztx531hAsEElpALR6yDeivZ0mOQ9v1H1JHYccib64ZWz/COjFfDbqcC0NIarK9
 XIAHqVcxElTSXuXNts4/6/6wGtxVs6O6LnM2gM1QAQO4XpfOPVpulHUPbhh4bdTzjZPy Vw== 
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3gg55dvjcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Thu, 09 Jun 2022 13:48:04 -0700
Received: by mail-qv1-f70.google.com with SMTP id eb5-20020ad44e45000000b0046447caa7a0so15788546qvb.16
        for <linux-can@vger.kernel.org>; Thu, 09 Jun 2022 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fsize1LL6DRMFATJFP/MigYicgdzJfWPUSyxUH+2K98=;
        b=fFeey2SOBlqmC/Q0z5OwTjAhXmN7RAWXgdaqgrSjDcKbHLPmMAGIpnG+xyd2eii51M
         mcMpZxAkNA7srCyIJambE3qCtMWCEUF5hben59GPzw4cLLakiOxpW/WWrLqeY+9hkV6y
         TeDLqSJd7iiVPp/jCs+UtYi8mW/O5Or7DLLhkF87rgGM6BtQYouW8kCFdSYqrqb2Y98z
         JFn30EqPFvPtwHZI6brPG0/VqdeJ3a4XJKdIIL8I+LDqNqtw8eOzoZF7w/4xbI/1f/GF
         YMoOzq0TjaGO/2eSIalZ/CjbX4OzuyDpEuxmoOruVQQfiGO6q67sRDl2KDLZ50S59PUJ
         I47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fsize1LL6DRMFATJFP/MigYicgdzJfWPUSyxUH+2K98=;
        b=0IKqtPMI15ZZfePyfbnnH/100UyDqDeADQGglP+UCWSo8DghtOuppk9bAt1ewrl7VS
         sW7vzbD3lZ1PLU6EDLxQrtLwSs4Sr1y7U3ZPxQg9yFezGczLXsFeVpnHo9mtDXruPbt+
         Zb1QnbkO9sK5thSSU0A1UlVwhEAHSmvJZPFgSigJnmNM/h8G024nW+HsIJUQGBF8+LDZ
         kk0YmHvCXfAKqaoZ5M4GVLWvwFKu6IMIfo9UwqP8UIBQ6rGPViXHQd234F97kDMGILbS
         ebGEwe7DyGwCfH6dXcpJm90dKLqtM3UBvAb7RGrgTXgJXGRJAqmNDH3bf8X4+GPZMwQ6
         qBMw==
X-Gm-Message-State: AOAM533njxHGu4I+6U4DmEIqkPesyefiQdli2C4XHfSwboepsqF8ipXL
        YQErWn10IBHuCcji4tOhLTAgiBX4G1TDaJyWkU0nU4Hxun79kjmreeh4ZnwAkV6hN/JApAyI7qP
        AUAxVukBesDO0IRiwXPYJ
X-Received: by 2002:a05:620a:2283:b0:6a6:b80b:816a with SMTP id o3-20020a05620a228300b006a6b80b816amr16713444qkh.68.1654807683351;
        Thu, 09 Jun 2022 13:48:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7/O6twSwh9yuivcEaZJc5OJTmJUEIS6JGVqtvw6SZg40zaQUoRJYCIKZzOcXGRio6XUOkRw==
X-Received: by 2002:a05:620a:2283:b0:6a6:b80b:816a with SMTP id o3-20020a05620a228300b006a6b80b816amr16713425qkh.68.1654807683066;
        Thu, 09 Jun 2022 13:48:03 -0700 (PDT)
Received: from downhome.. (ec2-3-215-55-7.compute-1.amazonaws.com. [3.215.55.7])
        by smtp.gmail.com with ESMTPSA id d5-20020a05620a240500b006a6b1630e95sm5428568qkn.45.2022.06.09.13.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:48:02 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
To:     linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc:     Oliver Neukum <oneukum@suse.org>,
        Alan Stern <stern@roland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rhett Aultman <rhett.aultman@samsara.com>
Subject: [PATCH v2 2/3] drivers: usb/core/urb: allow URB_FREE_COHERENT
Date:   Thu,  9 Jun 2022 16:47:13 -0400
Message-Id: <20220609204714.2715188-3-rhett.aultman@samsara.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220609204714.2715188-1-rhett.aultman@samsara.com>
References: <alpine.DEB.2.22.394.2206031547001.1630869@thelappy>
 <20220609204714.2715188-1-rhett.aultman@samsara.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NdmLIsltVlKOMlRcKMvowXTStkApdD3w
X-Proofpoint-GUID: NdmLIsltVlKOMlRcKMvowXTStkApdD3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_15,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=519 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206090077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The URB_FREE_COHERENT flag needs to be added to the allowed flags set in
order to prevent a "bogus flags" warning when it is used.

Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
---
 drivers/usb/core/urb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 1460fdac0b18..36c48fb196e0 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -507,7 +507,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 
 	/* Check against a simple/standard policy */
 	allowed = (URB_NO_TRANSFER_DMA_MAP | URB_NO_INTERRUPT | URB_DIR_MASK |
-			URB_FREE_BUFFER);
+			URB_FREE_BUFFER | URB_FREE_COHERENT);
 	switch (xfertype) {
 	case USB_ENDPOINT_XFER_BULK:
 	case USB_ENDPOINT_XFER_INT:
-- 
2.30.2

