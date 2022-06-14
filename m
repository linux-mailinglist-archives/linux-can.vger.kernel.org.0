Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5D754B49B
	for <lists+linux-can@lfdr.de>; Tue, 14 Jun 2022 17:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbiFNP1p (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 14 Jun 2022 11:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356876AbiFNP13 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 14 Jun 2022 11:27:29 -0400
Received: from mx0b-0054a801.pphosted.com (mx0b-0054a801.pphosted.com [205.220.172.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DC545057
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2022 08:27:02 -0700 (PDT)
Received: from pps.filterd (m0208804.ppops.net [127.0.0.1])
        by mx0b-0054a801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ECgtS2016676
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2022 15:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsara.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=samsaracom06092020;
 bh=/aqPtmv6iSMPS7/+L+3IZl3bHaAOrQ0c5sRFaTsOanE=;
 b=h+q//88HwanbTfZXOXmp5uy2i7Qjkjdb9oPAIVsMq7cUYjx5aoya0wRdYb4DB29Bkm8k
 pCLpjgf4nKuXyolrEj19hi7dPAE7jZ/9OCIfnLOiVPxho3Dsxu/tptCWfe090uGC99Sa
 F3RgbOUm/n8RNR5roMA5RsFWoQ9aYr8Zxr77tiN4yZIaDLbihdQTWOsXQbXFkcJYPV4G
 xys82K/2TuIgg39+lWk1pzv+v+Z3+4y8RpfIfDrLy0hUCvwJIkI+6pYJSGZisAEhQAEF
 U/Ub8gNVaDyblz1ElLtU9FtqTZ7wleY6QjmnmUDChihJrORLoDK+iqrB5dx3cxwl+SWs +Q== 
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mx0b-0054a801.pphosted.com (PPS) with ESMTPS id 3gmhn5tcey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2022 15:27:01 +0000
Received: by mail-qk1-f200.google.com with SMTP id bm2-20020a05620a198200b006a5dac37fa2so7696948qkb.16
        for <linux-can@vger.kernel.org>; Tue, 14 Jun 2022 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/aqPtmv6iSMPS7/+L+3IZl3bHaAOrQ0c5sRFaTsOanE=;
        b=Q4wKkqxYygF8dh6r6vWd6toIh3CZKurVs+QoTkIzDPUiaA5szD4egBc+YNs3loTEWj
         l499TDfmFmjtT+m6u5cSbS1tL3Zaz/1/OB3fNWz721ymMqAcZKKt3dt+eUxKN87yI3Ke
         8DnQavN17IhcVPpO5kTo2wpSlzw4vGfTWMXb/59TCcPR6XpsqgMG9wq6bo6nChAJdHnG
         xWU7jS0f4tWVDM9b2obyIdm0Nfzf0aIOOAoSzAZWd2tfFLHHm1aXFsMEMMMGco79rtOW
         cCjSep16HtFP4Psn4l+xmOz1T1rwxb89s1FhErrM1YiJ9tjypZP8vHxIcyxSgym01rJB
         r+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/aqPtmv6iSMPS7/+L+3IZl3bHaAOrQ0c5sRFaTsOanE=;
        b=T8jBpUHGjDPKkJ/Iis6bBvc+Ts9BwMjQemwiN5w0+FATJAE1976fWlmNGgMN9jrbXQ
         YPtFEV0wk/YpfrKKQVzmbi1XneLOo8jdV/XXLawbcETDlj1sAKGOhtMnXhE0NlUGq8X+
         lcYNY2l6QsAqIlEvE2V+RuGN7mFTZv1bMnUIZ4WdI+U3Boifwtn1hj0blKYSRU0IL/V9
         +qmlKwBQntrANGY+GWZ2oF+GCT35ccBBlAbdW4LluKXEX0UGILe6OOjMK28NjlAXbJMq
         WWzhoa2zLaN69hkbwd39phKq6qEFUQ2vPimac4bnIr0GtjBFQd2LqHR2ek5OyeVt4GJI
         WVzw==
X-Gm-Message-State: AOAM533Vfdb++Rp61UMW8iEjBtMIVynPEmQt5zsiGAE8ueMqZOxhSJS+
        WpcpLe2RTv6rzisinZ80PQcsdF+IITldCXp+Vz5H3u8fkojTe08WXCvAvTzHj8cJ7i2/mCU+863
        FBCd0lcbMKA2u2ub5KWs3
X-Received: by 2002:ac8:5a10:0:b0:2f3:dd26:d138 with SMTP id n16-20020ac85a10000000b002f3dd26d138mr4688120qta.405.1655220419996;
        Tue, 14 Jun 2022 08:26:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyzmSC5oRUS1lpFt3Nk+2mdkuVVrsRrB8K6YTLxgQtPHXQw/JCfePmqyIcYR5t7+UX+Fwg2Q==
X-Received: by 2002:ac8:5a10:0:b0:2f3:dd26:d138 with SMTP id n16-20020ac85a10000000b002f3dd26d138mr4688084qta.405.1655220419575;
        Tue, 14 Jun 2022 08:26:59 -0700 (PDT)
Received: from downhome.. (ec2-3-215-55-7.compute-1.amazonaws.com. [3.215.55.7])
        by smtp.gmail.com with ESMTPSA id k4-20020a05620a414400b006a743b360bcsm10199259qko.136.2022.06.14.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:26:58 -0700 (PDT)
From:   Rhett Aultman <rhett.aultman@samsara.com>
To:     linux-can <linux-can@vger.kernel.org>
Cc:     --cc=Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Rhett Aultman <rhett.aultman@samsara.com>
Subject: [PATCH v4 1/1] can: gs_usb: fix DMA memory leak on close
Date:   Tue, 14 Jun 2022 11:26:31 -0400
Message-Id: <20220614152630.2255641-2-rhett.aultman@samsara.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614152630.2255641-1-rhett.aultman@samsara.com>
References: <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220614152630.2255641-1-rhett.aultman@samsara.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6FCS2EaUYpaWzhDpeyiVGxBYvn5UeTw7
X-Proofpoint-GUID: 6FCS2EaUYpaWzhDpeyiVGxBYvn5UeTw7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_05,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=579
 malwarescore=0 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140060
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The gs_usb driver allocates DMA memory with usb_alloc_coherent() in
gs_can_open() and then keeps this memory in an URB, with the expectation
that the memory will be freed when the URB is killed in gs_can_close().
Memory allocated with usb_alloc_coherent() cannot be freed in this way
and must be freed using usb_free_coherent() instead.  This means that
repeated cycles of calling gs_can_open() and gs_can_close() will lead to
a memory leak.

Historically, drivers have handled this by keeping an array of pointers
to their DMA rx buffers and explicitly freeing them.  For an example of
this technique used in the esd_usb2 driver, see here:
928150fad41b ("can: esd_usb2: fix memory leak")

While the above method works, the conditions that cause this leak are
not apparent to driver writers and the method for solving it at the
driver level has been piecemeal.  This patch makes use of a new
URB_FREE_COHERENT flag on the URB, reducing the solution of this memory
leak down to a single line of code.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index b29ba9138866..4e7e6a7b961a 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -768,7 +768,7 @@ static int gs_can_open(struct net_device *netdev)
 					  buf,
 					  dev->parent->hf_size_rx,
 					  gs_usb_receive_bulk_callback, parent);
-			urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+			urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP | URB_FREE_COHERENT;
 
 			usb_anchor_urb(urb, &parent->rx_submitted);
 
-- 
2.30.2

