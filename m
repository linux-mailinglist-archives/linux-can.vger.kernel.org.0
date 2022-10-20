Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D21605B7E
	for <lists+linux-can@lfdr.de>; Thu, 20 Oct 2022 11:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJTJtj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 20 Oct 2022 05:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJTJte (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 20 Oct 2022 05:49:34 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E94B25D9
        for <linux-can@vger.kernel.org>; Thu, 20 Oct 2022 02:49:22 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221020094917epoutp038606e3e054f5aa64bd101a287d6c160d~fvg6n-eb81262112621epoutp03E
        for <linux-can@vger.kernel.org>; Thu, 20 Oct 2022 09:49:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221020094917epoutp038606e3e054f5aa64bd101a287d6c160d~fvg6n-eb81262112621epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666259357;
        bh=mXpXXW7FDJVzh5xT3qEufr5C3NDZDUXmvQJfo/Dd6+Y=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=oIniUXTYql7vghh05IN+TyDwnqrA9QyU+C/8riwdqKxmUyRvx1LqJKCZkVUCIey/g
         rf4LGvJg1FYvD0iuNZLe569fiksPTb8EM9jMvir8LlgGvqJLB81/EyBESdNzbbPQt9
         ENZqBaNU3v9cReA4/t6xRYiBBKiwJDH6j7Vkq+XI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221020094916epcas5p2d3e5fbd6ea853d3ac047e18752263d2a~fvg5spzy62159021590epcas5p2u;
        Thu, 20 Oct 2022 09:49:16 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MtN955G6mz4x9Q4; Thu, 20 Oct
        2022 09:49:13 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.11.56352.99911536; Thu, 20 Oct 2022 18:49:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221020094824epcas5p1c069f11b37d07d0c88d3c95eed314878~fvgJg7S0V2517325173epcas5p1U;
        Thu, 20 Oct 2022 09:48:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221020094824epsmtrp2a7091bef8d3e887dac69fd4be3b1d314~fvgJd2fPH1004110041epsmtrp2K;
        Thu, 20 Oct 2022 09:48:24 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-27-63511999063a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.5E.14392.86911536; Thu, 20 Oct 2022 18:48:24 +0900 (KST)
Received: from FDSFTE343 (unknown [107.122.81.111]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221020094823epsmtip2b41f5fe83350d1c6c07895db18f7b608~fvgIzfnXb2338023380epsmtip25;
        Thu, 20 Oct 2022 09:48:23 +0000 (GMT)
From:   "Chandrasekar R" <rcsekar@samsung.com>
To:     "'Marc Kleine-Budde'" <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
Cc:     "'Vivek Yadav'" <vivek.2311@samsung.com>
In-Reply-To: <20221018081934.1336690-1-mkl@pengutronix.de>
Subject: RE: [PATCH v5] can: mcan: m_can_handle_bus_errors(): add support
 for handling DLEC error on CAN-FD frames
Date:   Thu, 20 Oct 2022 15:18:22 +0530
Message-ID: <005301d8e469$189b2770$49d17650$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHOGH3zLVrDc3MKTS6n20XEz2tJjwGe84MVrh+pZWA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmuu5MycBkg+snxS1WfZ/KbLF+0RQW
        i18LD7M4MHv0/zXw6NuyitHj8ya5AOaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11D
        SwtzJYW8xNxUWyUXnwBdt8wcoD1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKT
        Ar3ixNzi0rx0vbzUEitDAwMjU6DChOyMe+f/MRc8FqrYe2Q2UwPjVP4uRk4OCQETiQtPbjB1
        MXJxCAnsZpR4dqiJFcL5xCjRP+EqlPONUWL3z3vMMC0HlrWyQST2AlXdfgrlvGCU6Pn1mw2k
        ik1AR+J93zcgm4NDRMBbovmPOkiYGSi8ftYbJhCbU8BKYtPZVrByYYESiWvT1zGC2CwCqhI3
        P70FW8YrYCmxvWsNlC0ocXLmExaIOfIS29/OgTpIQeLn02WsILYI0Mw7B5ewQdSISxz92cMM
        cpuEwCN2iROHdzNBNLhI3L7RyQphC0u8Or6FHcKWkvj8bi8bhF0s8er7ZCi7RmLf5tVQy+wl
        DlyZwwLyF7OApsT6XfoQYVmJqafWMUHs5ZPo/f0EahWvxI55MLaixLStM8FaJYBuOzIvZAKj
        0iwkn81C8tksJB/MQli2gJFlFaNkakFxbnpqsWmBcV5qOTy+k/NzNzGCU6GW9w7GRw8+6B1i
        ZOJgPMQowcGsJMJb8C4gWYg3JbGyKrUoP76oNCe1+BCjKTC4JzJLiSbnA5NxXkm8oYmlgYmZ
        mZmJpbGZoZI47+IZWslCAumJJanZqakFqUUwfUwcnFINTExNn61PxLv3nDpT9KD5w5Gvx06d
        y3C5uejB0X0mhTy1N7cw6l5gUN47dbbXs5877zIdnPlwRcPNtJ47efuveX98z745UnXW++SL
        UtNbmrKX+fL9PnKuWW5OyvQWl57zNpF8mcnFM9mWeoq8NwjcNH2CSMAeBost/llnuKvUzZP4
        /2VE8HyTPLspTM9V+krRYW5rjq2u4T0i7677n9ctW9G2LfHcepP54UVvXWZ4GJ4vK721Ljek
        eucNBcdbL1fkXlx4lvPb/Ijv3+1nJMbduTT5s9h27U2b9SO+yMzwzv/CsumUjNDj1VtezVcX
        Wd/KKzvrafZEdv16lQXPl/p6hfbWKGu6rXd638p1MX/a6kNKLMUZiYZazEXFiQCn7J0wDgQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvG6GZGCywdb9sharvk9ltli/aAqL
        xa+Fh1kcmD36/xp49G1ZxejxeZNcAHMUl01Kak5mWWqRvl0CV8a98/+YCx4LVew9MpupgXEq
        fxcjJ4eEgInEgWWtbF2MXBxCArsZJS5de84OkRCXWPvhChuELSyx8h9IHKToGaPE1++rmUAS
        bAI6Eu/7voEViQj4Spzv6WEGsZmB4utnvWGCaOhmlOhY/YcVJMEpYCWx6WwrWIOwQJHE8TOH
        wLaxCKhK3Pz0FqyZV8BSYnvXGihbUOLkzCcsXYwcQEP1JNo2MkLMl5fY/nYOM8RxChI/ny5j
        hbjBSuLOwSVsEDXiEkd/9jBPYBSehWTSLIRJs5BMmoWkYwEjyypGydSC4tz03GLDAsO81HK9
        4sTc4tK8dL3k/NxNjOB40NLcwbh91Qe9Q4xMHIyHGCU4mJVEeAveBSQL8aYkVlalFuXHF5Xm
        pBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwLRj1ZX/MSHvnhuZhknlnY9osFn/
        X2Qpx4ql/gwHs0xyrTynJkVv9g5lrfxS9+fx36LkOa5Nc6SuRP458btpu9ftzEvtZT0/ZllP
        NS9I/stvYvDCOFTU6Gv/tnt/g38tqd6u9c6TS4k1+n4fw/errX/Wqr8p+uT1w9lFUHTfcubm
        Kr2wucs7Vq/TX5nIauVwq0K4PPWPqG9XRvj0qv/ZC7WPPJx3nrP07YfKf7KBqyX38zVHZvD0
        +Ugxrv0SvmK5cWisU73+Tek45v9Mf+S++Wqqfj0cYH+lXdOcffvFsN/a7Qa1Ih7O1axna/Yf
        kmXx1ZOeyr3XTEGuZtrp0yImXCy3DxU9jsup1xIMTmZTYinOSDTUYi4qTgQA5Tsf6fYCAAA=
X-CMS-MailID: 20221020094824epcas5p1c069f11b37d07d0c88d3c95eed314878
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221018081944epcas5p4c87af0a214b02e7c062eca86a3d1f029
References: <CGME20221018081944epcas5p4c87af0a214b02e7c062eca86a3d1f029@epcas5p4.samsung.com>
        <20221018081934.1336690-1-mkl@pengutronix.de>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



> -----Original Message-----
> From: Marc Kleine-Budde [mailto:mkl@pengutronix.de]
> Sent: 18 October 2022 13:50
> To: linux-can@vger.kernel.org
> Cc: Vivek Yadav <vivek.2311@samsung.com>; Chandrasekar Ramakrishnan
> <rcsekar@samsung.com>; Marc Kleine-Budde <mkl@pengutronix.de>
> Subject: [PATCH v5] can: mcan: m_can_handle_bus_errors(): add support for
> handling DLEC error on CAN-FD frames
> 
> From: Vivek Yadav <vivek.2311@samsung.com>
> 
> When a frame in CAN FD format has reached the data phase, the next CAN
> event (error or valid frame) will be shown in DLEC.
> 
> Utilize the dedicated flag (Data Phase Last Error Code: DLEC flag) to
> determine the type of last error that occurred in the data phase of a
CAN-FD
> frame and handle the bus errors.
> 
Looks good to me,
Reviewed-by: Chandrasekar Ramakrishnan <rcsekar@samsung.com>

> Signed-off-by: Vivek Yadav <vivek.2311@samsung.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Changes since v4:
> - fix indention for GENMASK
> - fix GENMASK
> - reduce scope of dlec
> - add netdev_dbg() for arbitration phase
> 
>  drivers/net/can/m_can/m_can.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c
> b/drivers/net/can/m_can/m_can.c index ebdd3c164d7b..34c76ee87c6e
> 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -156,6 +156,7 @@ enum m_can_reg {
>  #define PSR_EW		BIT(6)
>  #define PSR_EP		BIT(5)
>  #define PSR_LEC_MASK	GENMASK(2, 0)
> +#define PSR_DLEC_MASK	GENMASK(10, 8)
> 
>  /* Interrupt Register (IR) */
>  #define IR_ALL_INT	0xffffffff
> @@ -875,9 +876,17 @@ static int m_can_handle_bus_errors(struct
> net_device *dev, u32 irqstatus,
>  	/* handle lec errors on the bus */
>  	if (cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
>  		u8 lec = FIELD_GET(PSR_LEC_MASK, psr);
> +		u8 dlec = FIELD_GET(PSR_DLEC_MASK, psr);
> 
> -		if (is_lec_err(lec))
> +		if (is_lec_err(lec)) {
> +			netdev_dbg(dev, "Arbitration phase error
> detected\n");
>  			work_done += m_can_handle_lec_err(dev, lec);
> +		}
> +
> +		if (is_lec_err(dlec)) {
> +			netdev_dbg(dev, "Data phase error detected\n");
> +			work_done += m_can_handle_lec_err(dev, dlec);
> +		}
>  	}
> 
>  	/* handle protocol errors in arbitration phase */
> --
> 2.35.1
> 


