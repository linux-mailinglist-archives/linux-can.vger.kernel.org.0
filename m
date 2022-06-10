Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F939546779
	for <lists+linux-can@lfdr.de>; Fri, 10 Jun 2022 15:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiFJNlf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 Jun 2022 09:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiFJNlf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Jun 2022 09:41:35 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5C7A1BF
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2022 06:41:32 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220610134130epoutp0257422df9742c2ce9e6718a9c8b97ccf7~3Rh__mqld1642616426epoutp02_
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2022 13:41:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220610134130epoutp0257422df9742c2ce9e6718a9c8b97ccf7~3Rh__mqld1642616426epoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654868490;
        bh=S4pQpSBiQ9JZ7ZM6nDhTseZIUEdkz4bMZ5E9UXfJQV4=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=DhTgFOGRS+V5KIcwmN47F8nY0pl4z2lFj5z0TpbFNR0KU7IQP76qM4mHBwmTD0If9
         m+A+cMFqlDcAE8zzFL4FT2bsvpJt5CPUAWAPq5kCLly6ff074gEJlV0qDbYHQSGlD8
         6ra35SZk/vX2GsWuhS32fBpS2IPiYmboahxJkrTo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220610134129epcas5p484fbf789bf475222da688fe7b1e52588~3Rh_V9ynY1361013610epcas5p4N;
        Fri, 10 Jun 2022 13:41:29 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LKMYz26Fvz4x9Pv; Fri, 10 Jun
        2022 13:41:27 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.28.10063.70A43A26; Fri, 10 Jun 2022 22:41:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220610115053epcas5p1b2609c019f6a7fb245346c1725459597~3QBZ4m8pD0278502785epcas5p1c;
        Fri, 10 Jun 2022 11:50:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220610115053epsmtrp1128e136ffd9b33d2e82e42773ad70f03~3QBZ3_5rS1864118641epsmtrp1Q;
        Fri, 10 Jun 2022 11:50:53 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-f9-62a34a074229
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.34.11276.D1033A26; Fri, 10 Jun 2022 20:50:53 +0900 (KST)
Received: from rcsekar06 (unknown [107.111.84.29]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220610115052epsmtip2e83ec7cdbedc2ebe9db59a4976a7f6a4~3QBZW9jcz2012820128epsmtip2g;
        Fri, 10 Jun 2022 11:50:52 +0000 (GMT)
From:   "Chandrasekar R" <rcsekar@samsung.com>
To:     "'Marc Kleine-Budde'" <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
In-Reply-To: <20220610112037.3857192-1-mkl@pengutronix.de>
Subject: RE: [PATCH] can: m_can: fix typo prescalar -> prescaler
Date:   Fri, 10 Jun 2022 17:20:51 +0530
Message-ID: <005301d87cc0$564a8900$02df9b00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKWDwwugrMQPcWRuG7O5s14kk8f4gIlrWfHq7w0xWA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmhi671+Ikgzc/eSxWfZ/KbLF+0RQW
        ByaP/r8GHp83yQUwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
        ufgE6Lpl5gBNV1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevl
        pZZYGRoYGJkCFSZkZ9xo/MVUcJuronnfApYGxg8cXYycHBICJhLvF/5i6mLk4hAS2M0osWDu
        GSjnE6PEpNYmVpAqIYFvjBLnbunDdKx6vJQVomgvo0TLrQ4o5zmjxLPNB8A62AR0JN73fWPr
        YuTgEBHwlmj+ow4S5hSwklj4cwEziC0s4CBxvvM+C4jNIqAq8XjnTTYQm1fAUuLnwT+sELag
        xMmZT8BqmAXkJba/ncMMcYSCxM+ny8BqRIBm/u79xQ5RIy7x8ugRdpB7JAROsUs8vnecEeQG
        CQEXiSm/YyF6hSVeHd/CDmFLSbzsb4OyiyVefZ/MBmHXSOzbvBpql73EgStzWEDGMAtoSqzf
        BQ0HWYmpp9YxQazlk+j9/YQJIs4rsWMejK0oMW3rTBaIC8QljswLgQh7SMxf/55pAqPiLCRP
        zkLy5Cwkz8xCWLyAkWUVo2RqQXFuemqxaYFhXmo5PLaT83M3MYJTnpbnDsa7Dz7oHWJk4mA8
        xCjBwawkwhtwe1GSEG9KYmVValF+fFFpTmrxIUZTYMhPZJYSTc4HJt28knhDE0sDEzMzMxNL
        YzNDJXFegf+NSUIC6YklqdmpqQWpRTB9TBycUg1M0ur9Endfbrv4IO2xXs6UK3vfvz2o5rE9
        i00n8WO/eWn1udc6Qexe+5yXrEroeRPoc/murET9e2eHqcf+sgUpr9P975TTf9A53nfNS1fv
        OoMPLitq8pi/ZHd8C69WMtMIFu5+7e5xUf53kYjTlTc93Yf+7xKQXC7eUHjFWr37y3PnaO7+
        j9yO+5cwHHYN+up/h3X/Lz+g4IrzbtufFdksuXDl5Ln7lxXNLDgCL6aaPC42cGr7/I9h/da6
        95/cy22luL1qd/GvWfdJRnX+7+qzzEeEc+cmcBnWv1m3IeWLz50A6z08sXvV5TQM0tfwReVa
        VbUG8djHmn+7nHL6Xb2t9C53Zad35vdOsQd4KrEUZyQaajEXFScCAOW+bP0CBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSvK6sweIkgw/LeS1WfZ/KbLF+0RQW
        ByaP/r8GHp83yQUwRXHZpKTmZJalFunbJXBl3Gj8xVRwm6uied8ClgbGDxxdjJwcEgImEqse
        L2XtYuTiEBLYzSjR03SVCSIhLrH2wxU2CFtYYuW/5+wQRU8ZJTr+rGcFSbAJ6Ei87/sGViQi
        4CtxvqeHGaKom1Hi3PlGsASngJXEwp8LmEFsYQEHifOd91lAbBYBVYnHO2+C1fAKWEr8PPiH
        FcIWlDg58wlQDQcHs4CeRNtGRpAws4C8xPa3c5ghDlKQ+Pl0GSvEXiuJ372/2CFqxCVeHj3C
        PoFRaBaSSbMQJs1CMmkWko4FjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCQ1xL
        cwfj9lUf9A4xMnEwHmKU4GBWEuENuL0oSYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC
        6YklqdmpqQWpRTBZJg5OqQamRUbXPth66+UySTmr7lTdmK4bs1t5la3MO1d+ex1xIw87rdKp
        Ox0utzvM+SifZ8IwN+f9jugN/tMbq041P/vcLKe8drd/U23qIcs9wXKMG4L1p+wyXdEg35/N
        yp1yPl4iRmvy1obtyxT3XJxTHuOdKlPQVfgg+OD9pzt5alpbep7qn2ESveWrWnwrpoLJj4FP
        3dOrwf9GxMoY2VX6i44V9gczCmy1PfBUVDdW5dgu/dWS6efLv7746pL/d63pdtUHz923F/tl
        TZ43L0vWQCfJ1XnzVscC1rWCZ6/cD7v3sEZ9dtDhOcVrJG8lsP7n0Q43a4vJlf8gqL6a5Ydl
        Sj7HA7nAWIFZxRKL4/ldlFiKMxINtZiLihMB+Arz0OACAAA=
X-CMS-MailID: 20220610115053epcas5p1b2609c019f6a7fb245346c1725459597
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220610112048epcas5p1f7bf95a5f29d7c81a1c96829a96ded35
References: <CGME20220610112048epcas5p1f7bf95a5f29d7c81a1c96829a96ded35@epcas5p1.samsung.com>
        <20220610112037.3857192-1-mkl@pengutronix.de>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



> -----Original Message-----
> From: Marc Kleine-Budde [mailto:mkl@pengutronix.de]
> Sent: Friday, June 10, 2022 4:51 PM
> To: linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>; Chandrasekar Ramakrishnan
> <rcsekar@samsung.com>
> Subject: [PATCH] can: m_can: fix typo prescalar -> prescaler
> 
> This patch fixes the typo prescalar -> prescaler.
> 
> Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Reviewed-by: Chandrasekar Ramakrishnan <rcsekar@samsung.com>

> ---
>  drivers/net/can/m_can/m_can.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 5d0c82d8b9a9..4f90e17354f2 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1348,8 +1348,8 @@ static void m_can_chip_config(struct net_device
*dev)
>  	/* set bittiming params */
>  	m_can_set_bittiming(dev);
> 
> -	/* enable internal timestamp generation, with a prescalar of 16. The
> -	 * prescalar is applied to the nominal bit timing
> +	/* enable internal timestamp generation, with a prescaler of 16. The
> +	 * prescaler is applied to the nominal bit timing
>  	 */
>  	m_can_write(cdev, M_CAN_TSCC, FIELD_PREP(TSCC_TCP_MASK, 0xf));
> 
> --
> 2.35.1
> 


