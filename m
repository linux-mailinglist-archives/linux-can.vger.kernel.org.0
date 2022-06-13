Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBF8547F82
	for <lists+linux-can@lfdr.de>; Mon, 13 Jun 2022 08:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiFMGad (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Jun 2022 02:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiFMGab (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Jun 2022 02:30:31 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581631C927
        for <linux-can@vger.kernel.org>; Sun, 12 Jun 2022 23:30:29 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220613063026epoutp023ad43a0a0fa29678564aab7ce8b170a9~4Glei13vB1823418234epoutp02T
        for <linux-can@vger.kernel.org>; Mon, 13 Jun 2022 06:30:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220613063026epoutp023ad43a0a0fa29678564aab7ce8b170a9~4Glei13vB1823418234epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655101826;
        bh=rpnKUXn/lY7mrTbraTel5qFdZrns9SZJqfedDdpwOag=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=BkqDdYtsWXw4Pf/Gvvho/cfzcSaVIaXjE1JKS0nfeYQZtGQCUWFfcZEkrv50Eqqef
         Klblbbs/0H72XxGhxezqLzY4zPeCmPho0w6BQH71PKMp5sf5XubrspAJ6rhYVVWtw9
         P9RNKjiF36Zb3bm7NsXycgTebIvy9VEj4fZ1o6og=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220613063026epcas5p27c46fc265c5add6897ca79ad4cc51c81~4GleYp51e2959929599epcas5p2Y;
        Mon, 13 Jun 2022 06:30:26 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LM1sD4V9qz4x9Q1; Mon, 13 Jun
        2022 06:30:24 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.DC.09762.F79D6A26; Mon, 13 Jun 2022 15:30:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220613063003epcas5p47b648b64ddf5bfb8a8dcec90dcbff801~4GlJTdqCl1479614796epcas5p4y;
        Mon, 13 Jun 2022 06:30:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220613063003epsmtrp24af87ef84c85b7267c558a48d81d001c~4GlJSwyfI2546425464epsmtrp2k;
        Mon, 13 Jun 2022 06:30:03 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-76-62a6d97f357c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.1D.08924.B69D6A26; Mon, 13 Jun 2022 15:30:03 +0900 (KST)
Received: from rcsekar06 (unknown [107.122.12.252]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220613063003epsmtip200c72486c9a83f0c20ee714c70bd00b4~4GlInKrdz0365503655epsmtip2f;
        Mon, 13 Jun 2022 06:30:03 +0000 (GMT)
From:   "Chandrasekar R" <rcsekar@samsung.com>
To:     "'Marc Kleine-Budde'" <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
Cc:     <kernel@pengutronix.de>,
        "'Torin Cooper-Bennun'" <torin@maxiluxsystems.com>
In-Reply-To: <20220612212708.4081756-1-mkl@pengutronix.de>
Subject: RE: [PATCH] can: m_can: m_can_chip_config(): actually enable
 internal timestamping
Date:   Mon, 13 Jun 2022 12:00:01 +0530
Message-ID: <001101d87eef$040a0a40$0c1e1ec0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEDJGc4OjnXBct3OMeNJssZL55XdgIPB++Frucc1yA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmum79zWVJBk8mqFusmrqTxWLV96nM
        FusXTWGxmPM9xoHFY/6X72we/X8NPD5vkgtgjsq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1
        MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHapaRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUot
        SMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzvh0oLTgN3/Fs6vP2RoY1/F2MXJySAiYSEx5
        d5uli5GLQ0hgN6PE+ZMN7BDOJ0aJ19+XM0E4nxklFvdOZIdpWXDlJ1TLLkaJt/93s0E4Lxgl
        Jr9ZwAhSxSagI/G+7xtQgoNDRMBbovmPOkiYWSBQYtvzBiYQm1PASmLat3esICXCArESrbeZ
        QcIsAqoSjQuvg3XyClgCnWcMEuYVEJQ4OfMJC8QUeYntb+cwQ5yjIPHz6TJWiEVWEttfFUKU
        iEu8PHoE7BcJga/sEn233jFB1LtIXF/SwQJhC0u8Or4F6i0pic/v9rJB2MUSr75PhrJrJPZt
        Xg21y17iwJU5LCC7mAU0Jdbv0ocIy0pMPbWOCWIvn0Tv7ydQq3gldsyDsRUlpm2dCdYqAXTb
        kXkhExiVZiF5bBaSx2Yh+WAWwrIFjCyrGCVTC4pz01OLTQuM81LL4XGdnJ+7iRGcCrW8dzA+
        evBB7xAjEwfjIUYJDmYlEd7JF5clCfGmJFZWpRblxxeV5qQWH2I0BQb2RGYp0eR8YDLOK4k3
        NLE0MDEzMzOxNDYzVBLnFfjfmCQkkJ5YkpqdmlqQWgTTx8TBKdXANOODjc8ixZA6JYW/9zQ9
        t00W6sra8K3MuPbCQbn533UYbi7mebNPfrb89bibV0szngVbShr9lQvfs312XV/Vq6AtktLP
        LkyXu5P+lT2CO+vEsfe+Eh+iDZcWvrzjGXrg484FW6f32S7UWqP93/RQpEDWfzMHqegVwi8D
        xG8pHp7UXrZnl/Z2tZJt+6QuTHx9eKObcWnpwsk/9RaJxa+f1/lzh0WicMWTtX4PZEIUA67z
        z1j0YA97hb/fhAu53J+NWZ7pr565b/NSD/7SMJX1IoKxa+K2v7AWtE7aOTmYO6DljqVUxu2/
        BYrvjiy+/OxgQfX221XbJzIlOr7XcL62rClfvr/cU3i/oNNPM7mjM5RYijMSDbWYi4oTAUp4
        DVsOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvG72zWVJBouvm1msmrqTxWLV96nM
        FusXTWGxmPM9xoHFY/6X72we/X8NPD5vkgtgjuKySUnNySxLLdK3S+DK+HSgtOA3f8Wzq8/Z
        GhjX8XYxcnJICJhILLjyk6WLkYtDSGAHo8S6oxNZIRLiEms/XGGDsIUlVv57zg5iCwk8Y5S4
        /dIIxGYT0JF43/cNrEZEwFfifE8PM4jNLBAocXbGRzaIod2MEn+ndLOAJDgFrCSmfXsHtkBY
        IFri5sujjCA2i4CqROPC60ANHBy8ApYSU94Zg4R5BQQlTs58wgISZhbQk2jbyAgxXl5i+9s5
        zBCnKUj8fLqMFaREBGj69leFECXiEi+PHmGfwCg8C8mgWQiDZiEZNAtJxwJGllWMkqkFxbnp
        ucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMHxoKW1g3HPqg96hxiZOBgPMUpwMCuJ8E6+uCxJiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqZOlksW8k9uzuvR
        OVkrzrpb7PaVibIB7YL+m7hUulaXB5p5hqtfO/Bw7e7u1VxP9X+tPGiznN1IvGKa/OopSm8Z
        Ty9RvO939OXEl6mO37fUWPEWcU7/Xndki176vdKrS9WEnqxQDzU9mLrzYckvmce3F0ll6556
        /8zkWe2RxG/VETN+Hes8Xh3in19x8/S+jctNOy9aJvvfelJn53d+/UrBfQdlpF6cmuPNtW//
        wcDZlT2/nmyPSfYV/3LE/PO+f81VPnk5Sy/YnZ7JuuT3vQfXNhi1bq9JrTwz9bWSxq/FM3ql
        2pUeegrNaMw4tNK++s3Z7RMOOf1WM7H7Y6PZtjO1+tSbp95vbmpPSNh9qvj1KSWW4oxEQy3m
        ouJEAJ4tiX72AgAA
X-CMS-MailID: 20220613063003epcas5p47b648b64ddf5bfb8a8dcec90dcbff801
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220612212736epcas5p4bf1d5ea94666f176dd1ec3b0e61f37bf
References: <CGME20220612212736epcas5p4bf1d5ea94666f176dd1ec3b0e61f37bf@epcas5p4.samsung.com>
        <20220612212708.4081756-1-mkl@pengutronix.de>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



> -----Original Message-----
> From: Marc Kleine-Budde [mailto:mkl@pengutronix.de]
> Sent: Monday, June 13, 2022 2:57 AM
> To: linux-can@vger.kernel.org
> Cc: kernel@pengutronix.de; Marc Kleine-Budde <mkl@pengutronix.de>;
> Torin Cooper-Bennun <torin@maxiluxsystems.com>; Chandrasekar
> Ramakrishnan <rcsekar@samsung.com>
> Subject: [PATCH] can: m_can: m_can_chip_config(): actually enable internal
> timestamping
> 
> In commit df06fd678260 ("can: m_can: m_can_chip_config(): enable and
> configure internal timestamps") the timestamping in the m_can core should
> be enabled. In peripheral mode, the RX'ed CAN frames, TX compete frames
> and error events are sorted by the timestamp.
> 
> The above mentioned commit however forgot to enable the timestamping.
> This patch adds the missing bits to the write of the Timestamp Counter
> Configuration register.
> 
> Fixes: df06fd678260 ("can: m_can: m_can_chip_config(): enable and
> configure internal timestamps")
> Cc: Torin Cooper-Bennun <torin@maxiluxsystems.com>
> Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Changes looks fine, 
Reviewed-by: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
> ---
>  drivers/net/can/m_can/m_can.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c
> b/drivers/net/can/m_can/m_can.c index 5d0c82d8b9a9..03a22d493cf6
> 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1351,7 +1351,9 @@ static void m_can_chip_config(struct net_device
> *dev)
>  	/* enable internal timestamp generation, with a prescalar of 16. The
>  	 * prescalar is applied to the nominal bit timing
>  	 */
> -	m_can_write(cdev, M_CAN_TSCC, FIELD_PREP(TSCC_TCP_MASK,
> 0xf));
> +	m_can_write(cdev, M_CAN_TSCC,
> +		    FIELD_PREP(TSCC_TCP_MASK, 0xf) |
> +		    FIELD_PREP(TSCC_TSS_MASK, TSCC_TSS_INTERNAL));
> 
>  	m_can_config_endisable(cdev, false);
> 
> --
> 2.35.1
> 


