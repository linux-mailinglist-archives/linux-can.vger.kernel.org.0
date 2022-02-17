Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC7B4BA9DA
	for <lists+linux-can@lfdr.de>; Thu, 17 Feb 2022 20:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242787AbiBQTc0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Feb 2022 14:32:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245202AbiBQTcZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Feb 2022 14:32:25 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2A25FF9
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 11:32:10 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220217193208epoutp046085f56c171bb2061846485be78bba8a~Uqa35HxPL2175421754epoutp04e
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 19:32:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220217193208epoutp046085f56c171bb2061846485be78bba8a~Uqa35HxPL2175421754epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645126328;
        bh=NY8dPegT3p3SoZAnOoagwO6e5zSIV3FcaqVC/e2EpXM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=hy3WgAFPJ1PsWCtHy2XXXe14deTOoBu0uHA+C+u86K/rRrWOduPGSE7q3tDYLcVFr
         tH/6Si6ctAxeYprp+Ov2EDMCeZLvUy2VVC+YGtoDdfrJbI5Fl5uNvUx4g8+ZeHQtF1
         t80sgjsmvmvx5eZKd2+2sdJiw/Uv6C9xyNw7mwXc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220217193207epcas5p1a5ca83e8726002bf61af4c44539a2dd1~Uqa2ziSiI0582405824epcas5p1C;
        Thu, 17 Feb 2022 19:32:07 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4K04hd6QHFz4x9Pr; Thu, 17 Feb
        2022 19:32:01 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.FF.05590.1B2AE026; Fri, 18 Feb 2022 04:32:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220217160525epcas5p409986b670a5c6006f9bd0ad023a39266~UnmYY9C212726927269epcas5p43;
        Thu, 17 Feb 2022 16:05:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220217160525epsmtrp248b0de572bdcc32e6096f5714a0df446~UnmYYZ5KR0750307503epsmtrp2b;
        Thu, 17 Feb 2022 16:05:25 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-ea-620ea2b1b8ec
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.A3.29871.5427E026; Fri, 18 Feb 2022 01:05:25 +0900 (KST)
Received: from rcsekar03 (unknown [107.122.12.252]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220217160524epsmtip24cc61aec208a9f38d04016c359db5d62~UnmXg56sC1826018260epsmtip20;
        Thu, 17 Feb 2022 16:05:23 +0000 (GMT)
From:   "Chandrasekar R" <rcsekar@samsung.com>
To:     "'Marc Kleine-Budde'" <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
Cc:     "'Rob Herring'" <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
In-Reply-To: <20220124215642.3474154-4-mkl@pengutronix.de>
Subject: RE: [PATCH 3/9] dt-binding: can: m_can: include common CAN
 controller bindings
Date:   Thu, 17 Feb 2022 21:35:22 +0530
Message-ID: <007001d82418$2c5fcac0$851f6040$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQIBOa1BJYFCEtyuigOwIf740Wy2WAI/uCi5AcDzkb2sJbXc8A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmuu7GRXxJBguPmFjMP3KO1WLV96nM
        FusXTWGxaN17hN2BxWPTqk42j/6/Bh6fN8kFMEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8eb
        mhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYALVNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2Cql
        FqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGf83HOLuWA+d8WWWX8ZGxi3cnYxcnJICJhI
        PNzyg62LkYtDSGA3o8TmrTvYIZxPjBJ9yy4xQzjfGCXWfpvFDNOy8VMPK0RiL6PEgUerWSCc
        F4wSVxc0soFUsQnoSLzv+wZkc3CICHhLNP9RBwkzC7hJ7Lh9EGwQp4CVxNFZv1hBSoQFIiVW
        3sgFCbMIqErsP3yeESTMK2Ap8WI/F0iYV0BQ4uTMJywQU+Qltr+dA3WOgsTPp8tYIeLiEkd/
        9oDFRQScJOZ9XwH2jITAV3aJbWd/sEI0uEi0PutmgbCFJV4d38IOYUtJfH63lw2ioZlRYu+R
        a1BFExglup4oQNj2EgeuzGEBOY5ZQFNi/S59iLCsxNRT65ggjuCT6P39hAkiziuxYx6MrSgx
        betMsFYJoEOPzAuZwKg0C8lrs5C8NgvJO7MQli1gZFnFKJlaUJybnlpsWmCcl1oOj+7k/NxN
        jOCUqOW9g/HRgw96hxiZOBgPMUpwMCuJ8H44yJskxJuSWFmVWpQfX1Sak1p8iNEUGNwTmaVE
        k/OBSTmvJN7QxNLAxMzMzMTS2MxQSZz3VPqGRCGB9MSS1OzU1ILUIpg+Jg5OqQYmt3Kv127R
        cascbtx5feJrl5fsLMOZ3Neqj3i1vhF16dqvJFht9SV7y4YVldnqG6UFjhrrLpzpH7UvQCth
        6dE1Omp9Mdq3zi8Jdll1MmCRRbTNSzYzFYZLG8VtF5q9Clgc+EXji7uEYm9n20HRygqVuQYb
        XT78/SS5/2Ppuj0lH7nqN83u0gu44Rt1X7cuRuKYs9QaqzJf1rZJt7M8nBY1h/TalU7iTuTd
        wrvRfUfYGmlpCbW5mg4ROeHl7qFajs9alTuOliw3mRTrvtkkIGp9mnfKsfl/LCcc2NQi2B3b
        uLd+U5jNofz9IZNaFvNoMC2wLGjl7d7ttcSneEVHefz0qm1tO2I3HZsUNzH9vBJLcUaioRZz
        UXEiAIyzz+sSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSvK5rEV+Swe15bBbzj5xjtVj1fSqz
        xfpFU1gsWvceYXdg8di0qpPNo/+vgcfnTXIBzFFcNimpOZllqUX6dglcGT/33GIumM9dsWXW
        X8YGxq2cXYycHBICJhIbP/WwdjFycQgJ7GaU+H3uIQtEQlxi7YcrbBC2sMTKf8/ZIYqeARWd
        WM4KkmAT0JF43/cNrEhEwFfifE8PM4jNLOAhcX7iOiaIhp2MEr0zJzGBJDgFrCSOzvoF1iws
        EC7xbeVesDiLgKrE/sPnGbsYOTh4BSwlXuznAgnzCghKnJz5hAUkzCygJ9G2kRFivLzE9rdz
        mCFuU5D4+XQZK0RcXOLoT4gTRAScJOZ9X8E+gVF4FpJJsxAmzUIyaRaS7gWMLKsYJVMLinPT
        c4sNCwzzUsv1ihNzi0vz0vWS83M3MYLjQktzB+P2VR/0DjEycTAeYpTgYFYS4f1wkDdJiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqZ1h42Ev8R8138o
        E7611S+hYnNjeeKVfw+uyWREZU7lOx8/70tsYHyerOrNernJLdM7W9vWCZxY55pr+K/m15MH
        sXPYdQLbvL5o/3L/56tTL/R33b/VR0viFgZuP3r8j4H3wtdHei4dKv8h4buCp4o3YuH5Pwyx
        Tx8KvbiePiH7ad2Z/0yvki4UvDbwOZk5d5f6oRmr2Np2FeqtdJohUfhioknhpJmlDo1x24ze
        ZRe7hxwualDmtA/vnapy1ZR9Zs3O6gPS/F8DmA51nC/dUl1abFloLTTnnM29q78Xv17UepT5
        3OL2u8tzdgQx7gm5vkDvlrjdpaCpN98v7Ld8u32BjqXhAYNFzJvNzJX2/ZBSYinOSDTUYi4q
        TgQAYN4EsvoCAAA=
X-CMS-MailID: 20220217160525epcas5p409986b670a5c6006f9bd0ad023a39266
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220217130709epcas5p4a339ca58cc485aa1732eaa3b4b0409cb
References: <20220124215642.3474154-1-mkl@pengutronix.de>
        <CGME20220217130709epcas5p4a339ca58cc485aa1732eaa3b4b0409cb@epcas5p4.samsung.com>
        <20220124215642.3474154-4-mkl@pengutronix.de>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Ccing Rob Herring and devicetree mailing list.

> -----Original Message-----
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Sent: 25 January 2022 03:27
> To: linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>; Chandrasekar Ramakrishnan
> <rcsekar@samsung.com>
> Subject: [PATCH 3/9] dt-binding: can: m_can: include common CAN controller
> bindings
> 
> Since commit
> 
> | 1f9234401ce0 ("dt-bindings: can: add can-controller.yaml")
> 
> there is a common CAN controller binding. Add this to the m_can binding.
> 
> Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
Reviewed-by: Chandrasekar Ramakrishnan <rcsekar@samsung.com>

>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> index fb547e26c676..710880dc7594 100644
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -11,6 +11,9 @@ description: Bosch MCAN controller for CAN bus
>  maintainers:
>    - Sriram Dash <sriram.dash@samsung.com>
> 
> +allOf:
> +  - $ref: can-controller.yaml#
> +
>  properties:
>    compatible:
>      const: bosch,m_can
> --
> 2.34.1
> 
> 


