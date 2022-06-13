Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD808547F81
	for <lists+linux-can@lfdr.de>; Mon, 13 Jun 2022 08:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiFMGaL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Jun 2022 02:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiFMGaK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Jun 2022 02:30:10 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1157B1C927
        for <linux-can@vger.kernel.org>; Sun, 12 Jun 2022 23:30:07 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220613063001epoutp03b8ebbfd0d4ecb16e46a63313ce0acde2~4GlHNPoNJ0850508505epoutp03u
        for <linux-can@vger.kernel.org>; Mon, 13 Jun 2022 06:30:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220613063001epoutp03b8ebbfd0d4ecb16e46a63313ce0acde2~4GlHNPoNJ0850508505epoutp03u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655101801;
        bh=9A0q+65QUMed70KtkXKJBeCMfe1sgYp/0N6iGK6breA=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ubOSGN+7Sn2LaO/oDg8MEHPJtajy+ESzKLlB27RoHTiVZrdnKJs/dIbkDx66o0vVu
         zAytE/blIq4eOn7dLhi71SHBKe12y5Ex4TzXA8S4N8KfqkZcoMmfpNqynb7DXZzXYc
         X1cvQHg5b++gXX81zNPc3rkrmMUO0Qmy+/uuRBsY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220613063001epcas5p3ddb6c5a804a70b7011b57df3df4d9cd9~4GlG9Yi3d1993119931epcas5p3E;
        Mon, 13 Jun 2022 06:30:01 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LM1rk4GCVz4x9QF; Mon, 13 Jun
        2022 06:29:58 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.FA.10063.569D6A26; Mon, 13 Jun 2022 15:29:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220613062907epcas5p141171adf6b4dca82f088befb58440265~4GkUmedbN2963429634epcas5p13;
        Mon, 13 Jun 2022 06:29:07 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220613062907epsmtrp15c52c9e1540e2cf3623f9f60226c950f~4GkUlsoEd0595505955epsmtrp17;
        Mon, 13 Jun 2022 06:29:07 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-e9-62a6d9656328
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.0D.08924.339D6A26; Mon, 13 Jun 2022 15:29:07 +0900 (KST)
Received: from rcsekar06 (unknown [107.122.12.252]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220613062906epsmtip2d92a48b618f1ac5c02ef7111bd738791~4GkTop3ru0252802528epsmtip2I;
        Mon, 13 Jun 2022 06:29:05 +0000 (GMT)
From:   "Chandrasekar R" <rcsekar@samsung.com>
To:     "'Marc Kleine-Budde'" <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
Cc:     <kernel@pengutronix.de>,
        "'Torin Cooper-Bennun'" <torin@maxiluxsystems.com>
In-Reply-To: <20220612211410.4081390-1-mkl@pengutronix.de>
Subject: RE: [PATCH] can: m_can: m_can_{read_fifo,echo_tx_event}(): shift
 timestamp to full 32 bits
Date:   Mon, 13 Jun 2022 11:59:04 +0530
Message-ID: <001001d87eee$e23f8700$a6be9500$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHogD7T53zNgkiiEh2LOszoJO4ZBgHrYh1urR2Bq2A=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmhm7qzWVJBoteCFqsmrqTxWLV96nM
        FusXTWGxmPM9xoHFY/6X72we/X8NPD5vkgtgjsq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1
        MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHapaRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUot
        SMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzrjzo4Wt4IRQRffnX4wNjBv5uxg5OSQETCR2
        77nC1MXIxSEksJtRovXLcRaQhJDAJ0aJ87PYIBKfGSUmr7rN3sXIAdbxeG41RHwXo8SW/XvZ
        IZwXjBL9Dw8zgnSzCehIvO/7xgbSICLgLdH8Rx0kzCwQKLHteQMTiM0pYCWxY8M3VhBbWCBV
        4smTTmYQm0VAVeL+6ptsIDavgKXE4iuXGSFsQYmTM5+wQMyRl9j+dg4zxAcKEj+fLgObIwI0
        88eeb1A14hIvjx4Bu01C4CO7xJGlzSwQDS4SnVcfMkLYwhKvjm9hh7ClJF72t0HZxRKvvk9m
        g7BrJPZtXg21zF7iwJU5LCB/MQtoSqzfpQ8RlpWYemodE8RePone30+YIOK8EjvmwdiKEtO2
        zmSBhKG4xJF5IRMYlWYh+WwWks9mIflgFsKyBYwsqxglUwuKc9NTi00LDPNSy+GxnZyfu4kR
        nA61PHcw3n3wQe8QIxMH4yFGCQ5mJRHeyReXJQnxpiRWVqUW5ccXleakFh9iNAUG90RmKdHk
        fGBCziuJNzSxNDAxMzMzsTQ2M1QS5xX435gkJJCeWJKanZpakFoE08fEwSnVwLQtzn7KpNzw
        pbuO6YXf1/2m2PfE5Lpg9m6R0m8eW7dzGug/M/5661+t1Wnv65vXOO2T4+rMrf3C8MrAIfPV
        5Ic+Xv//R5RXF9+/pGvuKyrjuziIu+XZVMsZC55+7Nknt97wXUW2i3nL5T1GcipFrxoUrNYv
        zllU3hVT+bHyklq66EWZedE5SwS/5PMm71/DFR33pXXOnIyr9juW3vcUL+QNLOpdLi6qUuOe
        2da/IdzlVaC8aW3anSm8B7inP234U3Gf496s5dbHfx1/Lf3l9Pqseb+tpp62cJv+TWHXTdtn
        GY+Ddv99v+jHS4mCrLQ4v3ORM1Tdv+2OK2E3WbT67pPnf+Xjji15bKmReMbq6k0lluKMREMt
        5qLiRACo3IMmEAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvK7xzWVJBldX8lqsmrqTxWLV96nM
        FusXTWGxmPM9xoHFY/6X72we/X8NPD5vkgtgjuKySUnNySxLLdK3S+DKuPOjha3ghFBF9+df
        jA2MG/m7GDk4JARMJB7Pre5i5OIQEtjBKPF7VjNjFyMnUFxcYu2HK2wQtrDEyn/P2SGKnjFK
        9F17xwqSYBPQkXjf9w2sSETAV+J8Tw8ziM0sEChxdsZHNoiGbkaJ42+2giU4Bawkdmz4BtYs
        LJAssXTjJDCbRUBV4v7qm2CDeAUsJRZfucwIYQtKnJz5hAXkUmYBPYm2jYwQ8+Ultr+dwwxx
        nILEz6fLWCFusJL4secbC0SNuMTLo0fYJzAKz0IyaRbCpFlIJs1C0rGAkWUVo2RqQXFuem6x
        YYFRXmq5XnFibnFpXrpecn7uJkZwVGhp7WDcs+qD3iFGJg7GQ4wSHMxKIryTLy5LEuJNSays
        Si3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoHJk7c471vBpEWme29f
        WFt7YaajS8AJucTmbW+vaByeGfVrXnDWk/ZF7itY2Sesm3r+juHBqyJh5ZIB/gzPZNQ5vrz9
        LHbRbvFV25OXU8WP2M9tkTc9eljWWehjzI6rG2f/ub1aq1Uxrd/NwaU2JOiBgH/w+dqShU/0
        /dw/b70cXa8+fcZCIR2h1ZayrHMsOuazRl/f3zFtQXcXy/63amo3Xhud5y3ecy/1yXPR7Y5X
        D6lUT+ncL8IQYHt34bHUjLdeUpE1LD5i/fqs0fcm9Ur1TX57bvrHNc49HiKPpCPjmLyzv6h0
        NZR6h+13EuTjf8r7wXmVip/P0sPVOrM+TVvP5GFntflSyZ7TR/21ps9XYinOSDTUYi4qTgQA
        E1ynMPkCAAA=
X-CMS-MailID: 20220613062907epcas5p141171adf6b4dca82f088befb58440265
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220612211422epcas5p2d7e6e78a0ef6b61bf7871a90e5b7ffb1
References: <CGME20220612211422epcas5p2d7e6e78a0ef6b61bf7871a90e5b7ffb1@epcas5p2.samsung.com>
        <20220612211410.4081390-1-mkl@pengutronix.de>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



> -----Original Message-----
> From: Marc Kleine-Budde [mailto:mkl@pengutronix.de]
> Sent: Monday, June 13, 2022 2:44 AM
> To: linux-can@vger.kernel.org
> Cc: kernel@pengutronix.de; Marc Kleine-Budde <mkl@pengutronix.de>;
> Torin Cooper-Bennun <torin@maxiluxsystems.com>; Chandrasekar
> Ramakrishnan <rcsekar@samsung.com>
> Subject: [PATCH] can: m_can: m_can_{read_fifo,echo_tx_event}(): shift
> timestamp to full 32 bits
> 
> In commit 1be37d3b0414 ("can: m_can: fix periph RX path: use rx-offload to
> ensure skbs are sent from softirq context") the RX path for peripheral
> devices was switched to RX-offload.
> 
> Received CAN frames are pushed to RX-offload together with a timestamp.
> RX-offload is designed to handle overflows of the timestamp correctly, if
32
> bit timestamps are provided.
> 
> The timestamps of m_can core are only 16 bits wide. So this patch shifts
> them to full 32 bit before passing them to RX-offload.
> 
> Fixes: 1be37d3b0414 ("can: m_can: fix periph RX path: use rx-offload to
> ensure skbs are sent from softirq context")
> Cc: Torin Cooper-Bennun <torin@maxiluxsystems.com>
> Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Changes looks fine, 
Reviewed-by: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
> ---
>  drivers/net/can/m_can/m_can.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c
> b/drivers/net/can/m_can/m_can.c index 03a22d493cf6..7931f9c71ef3 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -529,7 +529,7 @@ static int m_can_read_fifo(struct net_device *dev,
> u32 rxfs)
>  	/* acknowledge rx fifo 0 */
>  	m_can_write(cdev, M_CAN_RXF0A, fgi);
> 
> -	timestamp = FIELD_GET(RX_BUF_RXTS_MASK, fifo_header.dlc);
> +	timestamp = FIELD_GET(RX_BUF_RXTS_MASK, fifo_header.dlc) <<
> 16;
> 
>  	m_can_receive_skb(cdev, skb, timestamp);
> 
> @@ -1030,7 +1030,7 @@ static int m_can_echo_tx_event(struct net_device
> *dev)
>  		}
> 
>  		msg_mark = FIELD_GET(TX_EVENT_MM_MASK, txe);
> -		timestamp = FIELD_GET(TX_EVENT_TXTS_MASK, txe);
> +		timestamp = FIELD_GET(TX_EVENT_TXTS_MASK, txe) << 16;
> 
>  		/* ack txe element */
>  		m_can_write(cdev, M_CAN_TXEFA,
> FIELD_PREP(TXEFA_EFAI_MASK,
> --
> 2.35.1
> 


