Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F44578064
	for <lists+linux-can@lfdr.de>; Mon, 18 Jul 2022 13:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbiGRLEF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Jul 2022 07:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiGRLEE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Jul 2022 07:04:04 -0400
Received: from mailgw.felk.cvut.cz (mailgw.felk.cvut.cz [147.32.82.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2318D65DA
        for <linux-can@vger.kernel.org>; Mon, 18 Jul 2022 04:04:02 -0700 (PDT)
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id 37FB930B294D;
        Mon, 18 Jul 2022 13:03:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        cmp.felk.cvut.cz; h=cc:cc:content-transfer-encoding:content-type
        :content-type:date:from:from:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to; s=felkmail; bh=XZ4fv
        IAd4110BNZh4fNTIuiftesp3qHh+CCLDdcP2bw=; b=E6W7JlM17a9JzkQsU30MY
        ObL6jSgxCw8vMSTMqdDOkStf4ilomLNzVPxuK7imD4WVeUht9OaxdK2XSLBKAN8L
        I3rzIt8lhV18LgG1RQ0l0Ca8ftB9odGTxCf2/mZEZXNlQ7iv2a8pMNONZj0ZmRWt
        lnMbXFu0yIkIwOZPzhq5hQPsZw2fbFAk2sxlInx+NU/7hGT+kJZdxrf3XKedFGS3
        9NBwLTircqLAl7Y/M4+T8PTU6u8gyqcTCxbl6s49DHkCtOnv0laL0JXWGUUQ9WQ1
        Nju1C7WKICGvgUUEwiZY08yLfihA8Ns7mfSzmL56DMg0RcDQ5FQVYUaJz1S95B2w
        g==
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id 531FC30B294A;
        Mon, 18 Jul 2022 13:03:44 +0200 (CEST)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 26IB3iGa031033;
        Mon, 18 Jul 2022 13:03:44 +0200
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 26IB3iDF031032;
        Mon, 18 Jul 2022 13:03:44 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH v3 0/5] can: support CAN XL
Date:   Mon, 18 Jul 2022 13:03:38 +0200
User-Agent: KMail/1.9.10
Cc:     linux-can@vger.kernel.org
References: <20220717132730.30295-1-socketcan@hartkopp.net>
In-Reply-To: <20220717132730.30295-1-socketcan@hartkopp.net>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202207181303.38060.pisa@cmp.felk.cvut.cz>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Oliver,

On Sunday 17 of July 2022 15:27:25 Oliver Hartkopp wrote:
> V2: Major rework after discussion and feedback on Linux-CAN ML
>
> - rework of struct canxl_frame
> - CANXL_XLF flag is now the switch between CAN XL and CAN/CANFD
> - variable length in r/w operations for CAN XL frames
> - write CAN XL frame to raw socket enforces size <-> canxl_frame.len sync

I generally like the idea but I would like even to extend it to process
all CAN messages types through same API.

+struct canxl_frame {
+       canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
+       __u8    flags; /* additional flags for CAN XL */
+       __u8    sdt;   /* SDU (service data unit) type */
+       __u16   len;   /* frame payload length in byte */
+       __u32   af;    /* acceptance field */
+       __u8    data[CANXL_MAX_DLEN];
+};

I would suggest to think about possibility to have single structure type
for processing of all CAN frames types in usersace. When you define field
prio as anonyous union of prio and can_id

  union {
    canid_t prio;
    canid_t can_id;
  }

then it is possible to define flags such way, that canxl_frame is alternative
for all other formats

+#define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
So CANXL_XLF will be changed to CANXLS_SELECT frame structure selected,
then rest of bits can be used for CANXLS_XLF, CANXLS_FD, in ideal case even
RTR, BRS etc.. or RTR can be left as part of ID if that is easier.
This way only single structure can be used to receive and send all
frames over single interface when XL option is selected
by software.

Yes, there would be redundancy in the kernel handling which has to accept
two types of encoding of CAN FD and standard messages but actual complexity
in usespace when you want to support all variants and for example
forward frames between interfaces or process them inside QEMU etc.
is really quite high.

Best wishes,

                Pavel
-- 
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home




