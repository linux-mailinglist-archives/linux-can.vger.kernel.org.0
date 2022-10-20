Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A76B605B79
	for <lists+linux-can@lfdr.de>; Thu, 20 Oct 2022 11:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJTJtI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 20 Oct 2022 05:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiJTJtE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 20 Oct 2022 05:49:04 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27091C906D
        for <linux-can@vger.kernel.org>; Thu, 20 Oct 2022 02:48:59 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221020094854epoutp04090e8270cb1c42a6aba8b867c4d11424~fvglcO7Yx3182131821epoutp04M
        for <linux-can@vger.kernel.org>; Thu, 20 Oct 2022 09:48:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221020094854epoutp04090e8270cb1c42a6aba8b867c4d11424~fvglcO7Yx3182131821epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666259334;
        bh=uzqEkS3AsLeq/bVuAwqx41AXSTCfDbNjTFMpIIH4hY4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=cUOFBlZRMfJcB4uP5jYDunzRcUSGyEIzdAlCM+YTy+462Y09JHnUs9M3ivV14fovb
         UK69TSlsjv62ubhbHBgaq9pLWzavopi2vk3ZjZcQPfTiPLZTFXiC3uhpWsGRZh3tMB
         +NgI3ayM7V1xAzvbBVTRcw0UnExxZQbZt7iSly80=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221020094854epcas5p4c67bd3cddef9a227716a0ec22cd493e0~fvglAWV9g1312613126epcas5p4F;
        Thu, 20 Oct 2022 09:48:54 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MtN8g3kVDz4x9Pw; Thu, 20 Oct
        2022 09:48:51 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.AD.39477.F7911536; Thu, 20 Oct 2022 18:48:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221020094130epcas5p4e96f28710db539f50eae8869acef100a~fvaIAp60O2723027230epcas5p4U;
        Thu, 20 Oct 2022 09:41:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221020094130epsmtrp1ed90fefc5868f7262de6d251479feae6~fvaH--KeD0951709517epsmtrp1w;
        Thu, 20 Oct 2022 09:41:30 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-b4-6351197fefc6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.ED.14392.AC711536; Thu, 20 Oct 2022 18:41:30 +0900 (KST)
Received: from FDSFTE343 (unknown [107.122.81.111]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221020094129epsmtip126214b2ff1b9d6e4e96672882af20894~fvaHBng7c0299602996epsmtip14;
        Thu, 20 Oct 2022 09:41:29 +0000 (GMT)
From:   "Chandrasekar R" <rcsekar@samsung.com>
To:     "'Marc Kleine-Budde'" <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
Cc:     "'Vivek Yadav'" <vivek.2311@samsung.com>
In-Reply-To: <20221019211611.1605764-1-mkl@pengutronix.de>
Subject: RE: [PATCH v2] can: m_can: is_lec_err(): clean up LEC error
 handling
Date:   Thu, 20 Oct 2022 15:11:26 +0530
Message-ID: <004b01d8e468$21e16160$65a42420$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLEguLVrP6XG6+h37puLd5Zq27r3QElmQi4rDac7XA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7bCmlm69ZGCywawuTotV36cyW6xfNIXF
        4tfCwywOzB79fw08+rasYvT4vEkugDkq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ
        0sJcSSEvMTfVVsnFJ0DXLTMHaI+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8Ck
        QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvjzdEjTAVbxSpW9zewNjDuEOpi5OSQEDCRWHdpN3MX
        IxeHkMBuRokFhxrZIJxPjBInnyyCynxjlJh2+QJrFyMHWMvvY/UQ8b2MEu9nzWcCGSUk8IJR
        Yu5BARCbTUBH4n3fNzaQehEBb4nmP+ogYWag8PpZb8DKOQWsJD4dfsgGYgsL+EssW72OHcRm
        EVCV6O64ANbKK2ApMWOHG0iYV0BQ4uTMJywQY+Qltr+dwwzxgILEz6fLWEFsEaCR5zbPYIeo
        EZc4+rMHquYtu8SxFnEI20Vi5u+nTBC2sMSr41vYIWwpiZf9bVB2scSr75PZIOwaiX2bV0PN
        sZc4cGUOC8hpzAKaEut36UOEZSWmnlrHBLGWT6L39xOo8bwSO+bB2IoS07bOZIEEoLjEkXkh
        ExiVZiF5bBaSx2YheWAWwrIFjCyrGCVTC4pz01OLTQuM8lLL4XGdnJ+7iRGcArW8djA+fPBB
        7xAjEwfjIUYJDmYlEd6CdwHJQrwpiZVVqUX58UWlOanFhxhNgYE9kVlKNDkfmITzSuINTSwN
        TMzMzEwsjc0MlcR5F8/QShYSSE8sSc1OTS1ILYLpY+LglGpgmvfmXLLdP/71y7KYZ0av5vRX
        ue11Y6Wm3KrJf7JKgl7N6nLi+5P15ZLrWbsXu00i7RTennr1/D/X9n13euqmu1oZc0d8trid
        Wdn55VZ8Tp5ubqR/1Dsr/pV3PzXuZDqT2OsX/2Z9yO+FeVtd9N4u/8p2O3jP/XsfTB7d3XSz
        YM7L3p86jy6IVVYWThW5urlqUUL8B63JUjsFD77t1FcLe6RQHeL7LkpTQfXxki0JPk6BDyQY
        12dFnFL6ylTqcSdh267IbQXnPiXHvTwRLv3ttpany4J7rClXxZTcr2n0ZTR3Rs/zdT+wdirv
        OfFal3OTvVq2XZHl+hh44mLurOY59yd43NskKeLu0lF0rizTSYmlOCPRUIu5qDgRAAxJ9RYK
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSnO4p8cBkg/ZvCharvk9ltli/aAqL
        xa+Fh1kcmD36/xp49G1ZxejxeZNcAHMUl01Kak5mWWqRvl0CV8abo0eYCraKVazub2BtYNwh
        1MXIwSEhYCLx+1h9FyMXh5DAbkaJxc397F2MnEBxcYm1H66wQdjCEiv/PWeHKHrGKHH+5GxW
        kASbgI7E+75vYEUiAr4S53t6mEFsZqD4+llvmCAauhklpt2fCtbAKWAl8enwQ7AGYaCGLYf2
        gcVZBFQlujsusIFcxCtgKTFjhxtImFdAUOLkzCcsIGFmAT2Jto2MEOPlJba/ncMMcZuCxM+n
        y1ghTrCSOLd5BjtEjbjE0Z89zBMYhWchmTQLYdIsJJNmIelYwMiyilEytaA4Nz232LDAMC+1
        XK84Mbe4NC9dLzk/dxMjOBa0NHcwbl/1Qe8QIxMH4yFGCQ5mJRHegncByUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwbX/Imrz3cljtYbv5h3evb7y6
        8I9gzQ+ZHweXpG9KbKzq1FbJnvLE6iBjTMas9vDvNRLaPWse9+/b6Tt3Q8+v0Iyu272nApgm
        cX9k2Nnss75W7Kfjilblfevt5BIF528VXcF6pkyvUvG0sP6O61NDZK2bzvud6tireO03z/Sl
        6gtKV9Rtm6VxmbPcTIHv3Vc9H739WRudDsf0MUz4+/V7fvz2tTcP5DuYx9u9vLqjpWmSxg4T
        t5Pyq4JbXEVCfq4xZl2QGLG098Ee17MTHa9cMzTe5/GrXaPiipKUqtD5ix5zXsib/5f+dmrf
        P7V5SqJ8UxZtux0Wde7Y9/a5c/K/7Vxx1+nZ5f3x32P7vOpeHlFiKc5INNRiLipOBACmWAw/
        9AIAAA==
X-CMS-MailID: 20221020094130epcas5p4e96f28710db539f50eae8869acef100a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221019211623epcas5p4202f80061238508c48fae82a40d079e0
References: <CGME20221019211623epcas5p4202f80061238508c48fae82a40d079e0@epcas5p4.samsung.com>
        <20221019211611.1605764-1-mkl@pengutronix.de>
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
> Sent: 20 October 2022 02:46
> To: linux-can@vger.kernel.org
> Cc: Vivek Yadav <vivek.2311@samsung.com>; Chandrasekar Ramakrishnan
> <rcsekar@samsung.com>; Marc Kleine-Budde <mkl@pengutronix.de>
> Subject: [PATCH v2] can: m_can: is_lec_err(): clean up LEC error handling
> 
> The PSR register contains among other the error for the CAN arbitration
> phase (LEC bits) and CAN data phase (DLEC bits).
> 
> Prepare is_lec_err() to be called with the (D)LEC value only instead of
the
> whole PSR register. While there rename LEC_UNUSED to LEC_NO_CHANGE
> to match the latest M_CAN reference manual.
> 
Looks good to me, 
Reviewed-by: Chandrasekar Ramakrishnan <rcsekar@samsung.com>

> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> changes since RFC: https://lore.kernel.org/all/20221012074205.691384-1-
> mkl@pengutronix.de
> - add proper patch description
> 
>  drivers/net/can/m_can/m_can.c | 15 ++++++++-------
> drivers/net/can/m_can/m_can.h |  2 +-
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c
> b/drivers/net/can/m_can/m_can.c index dcb582563d5e..ebdd3c164d7b
> 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -816,11 +816,9 @@ static void m_can_handle_other_err(struct
> net_device *dev, u32 irqstatus)
>  		netdev_err(dev, "Message RAM access failure occurred\n");
> }
> 
> -static inline bool is_lec_err(u32 psr)
> +static inline bool is_lec_err(u8 lec)
>  {
> -	psr &= LEC_UNUSED;
> -
> -	return psr && (psr != LEC_UNUSED);
> +	return lec != LEC_NO_ERROR && lec != LEC_NO_CHANGE;
>  }
> 
>  static inline bool m_can_is_protocol_err(u32 irqstatus) @@ -875,9 +873,12
> @@ static int m_can_handle_bus_errors(struct net_device *dev, u32
> irqstatus,
>  		work_done += m_can_handle_lost_msg(dev);
> 
>  	/* handle lec errors on the bus */
> -	if ((cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
> -	    is_lec_err(psr))
> -		work_done += m_can_handle_lec_err(dev, psr &
> LEC_UNUSED);
> +	if (cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
> +		u8 lec = FIELD_GET(PSR_LEC_MASK, psr);
> +
> +		if (is_lec_err(lec))
> +			work_done += m_can_handle_lec_err(dev, lec);
> +	}
> 
>  	/* handle protocol errors in arbitration phase */
>  	if ((cdev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
> diff --git a/drivers/net/can/m_can/m_can.h
> b/drivers/net/can/m_can/m_can.h index 4c0267f9f297..52563c048732
> 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -38,7 +38,7 @@ enum m_can_lec_type {
>  	LEC_BIT1_ERROR,
>  	LEC_BIT0_ERROR,
>  	LEC_CRC_ERROR,
> -	LEC_UNUSED,
> +	LEC_NO_CHANGE,
>  };
> 
>  enum m_can_mram_cfg {
> --
> 2.35.1
> 


